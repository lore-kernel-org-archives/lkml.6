Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57780C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217212177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217212177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeHUTS0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:18:26 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:51099 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeHUTSZ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Tue, 21 Aug 2018 15:18:25 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Tue, 21 Aug 2018 09:57:43 -0600
Message-Id: <5B7C367002000078001E0987@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Tue, 21 Aug 2018 09:57:36 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH v2 2/2] x86/pae: use 64 bit atomic xchg
 function in native_ptep_get_and_clear
References: <20180821153755.30462-1-jgross@suse.com>
 <20180821153755.30462-3-jgross@suse.com>
In-Reply-To: <20180821153755.30462-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 21.08.18 at 17:37, <jgross@suse.com> wrote:
> Using only 32-bit writes for the pte will result in an intermediate
> L1TF vulnerable PTE. When running as a Xen PV guest this will at once
> switch the guest to shadow mode resulting in a loss of performance.
> 
> Use arch_atomic64_xchg() instead which will perform the requested
> operation atomically with all 64 bits.
> 
> Some performance considerations according to:
> 
> https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scal 
> able-Processor-throughput-latency.pdf
> 
> The main number should be the latency, as there is no tight loop around
> native_ptep_get_and_clear().
> 
> "lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
> memory operand) isn't mentioned in that document. "lock xadd" (with xadd
> having 3 cycles less latency than xchg) has a latency of 11, so we can
> assume a latency of 14 for "lock xchg".
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
with one further remark:

> @@ -150,10 +152,7 @@ static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
>  {
>  	pte_t res;
>  
> -	/* xchg acts as a barrier before the setting of the high bits */
> -	res.pte_low = xchg(&ptep->pte_low, 0);
> -	res.pte_high = ptep->pte_high;
> -	ptep->pte_high = 0;
> +	res.pte = (pteval_t)arch_atomic64_xchg((atomic64_t *)ptep, 0);

Is the cast on the return value really needed here?

Jan


