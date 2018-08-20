Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6F21534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B6F21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeHTLy7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:54:59 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:36904 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeHTLy6 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 20 Aug 2018 07:54:58 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 20 Aug 2018 02:40:15 -0600
Message-Id: <5B7A7E6C02000078001DFD15@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Mon, 20 Aug 2018 02:40:12 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH 2/2] x86/pae: use 64 bit atomic xchg
 function in native_ptep_get_and_clear
References: <20180820051456.20779-1-jgross@suse.com>
 <20180820051456.20779-3-jgross@suse.com>
In-Reply-To: <20180820051456.20779-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 20.08.18 at 07:14, <jgross@suse.com> wrote:
> @@ -148,14 +150,14 @@ static inline void pud_clear(pud_t *pudp)
>  #ifdef CONFIG_SMP
>  static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
>  {
> -	pte_t res;
> +	union {
> +		pte_t pte;
> +		long long val;
> +	} res;

Why the union? pte_t already is one, with the pte field being what
you're after ...

> -	/* xchg acts as a barrier before the setting of the high bits */
> -	res.pte_low = xchg(&ptep->pte_low, 0);
> -	res.pte_high = ptep->pte_high;
> -	ptep->pte_high = 0;
> +	res.val = arch_atomic64_xchg((atomic64_t *)ptep, 0);

... here.

Jan


