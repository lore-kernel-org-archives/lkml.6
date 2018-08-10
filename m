Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5082C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7332240F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7332240F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeHJOfw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:35:52 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:35192 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeHJOfw (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:9:1>);
        Fri, 10 Aug 2018 10:35:52 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 10 Aug 2018 06:06:13 -0600
Message-Id: <5B6D7FB402000078001DCF30@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Fri, 10 Aug 2018 06:06:12 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "Linux Virtualization" <virtualization@lists.linux-foundation.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        "Alok Kataria" <akataria@vmware.com>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH 04/10] x86/paravirt: use a single ops
 structure
References: <20180810115252.18213-1-jgross@suse.com>
 <20180810115252.18213-5-jgross@suse.com>
In-Reply-To: <20180810115252.18213-5-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 10.08.18 at 13:52, <jgross@suse.com> wrote:
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -228,9 +228,9 @@ void hyperv_setup_mmu_ops(void)
>  
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
>  		pr_info("Using hypercall for remote TLB flush\n");
> -		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
> +		pv_ops.pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;

Taking just this as example, why not

		pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;

? Both pv_ and _ops are redundant on the field names.

Jan


