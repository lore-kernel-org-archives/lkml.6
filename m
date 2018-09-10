Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221BCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87C920894
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87C920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeIJTP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:15:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:36784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbeIJTP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:15:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 07:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="261352151"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2018 07:21:03 -0700
Message-ID: <1536589263.11460.59.camel@intel.com>
Subject: Re: [PATCH 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Date:   Mon, 10 Sep 2018 07:21:03 -0700
In-Reply-To: <20180910083806.65177-2-Tianyu.Lan@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
         <20180910083806.65177-2-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 08:38 +0000, Tianyu Lan wrote:
> Add flush range call back in the kvm_x86_ops and platform can use it
> to register its associated function. The parameter "kvm_tlb_range"
> accepts a single range and flush list which contains a list of ranges.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e12916e7c2fb..dcdf8cc16388 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -402,6 +402,12 @@ struct kvm_mmu {
>  	u64 pdptrs[4]; /* pae */
>  };
>  
> +struct kvm_tlb_range {
> +	u64 start_gfn;
> +	u64 end_gfn;

IMO this struct and all functions should pass around the number of pages
instead of end_gfn to avoid confusion as to whether end_gfn is inclusive
or exlusive.

> +	struct list_head *flush_list;
> +};
> +
>  enum pmc_type {
>  	KVM_PMC_GP = 0,
>  	KVM_PMC_FIXED,
> @@ -991,6 +997,8 @@ struct kvm_x86_ops {
>  
>  	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
>  	int  (*tlb_remote_flush)(struct kvm *kvm);
> +	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
> +			struct kvm_tlb_range *range);
>  
>  	/*
>  	 * Flush any TLB entries associated with the given GVA.
