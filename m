Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4008F218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfABSJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:09:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:35841 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfABSJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:09:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 10:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,431,1539673200"; 
   d="scan'208";a="106453125"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2019 10:09:39 -0800
Date:   Wed, 2 Jan 2019 10:09:39 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v1 1/8] kvm:vmx  Introduce CET related VMCS field
 definitions.
Message-ID: <20190102180939.GA7460@linux.intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-2-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226081532.30698-2-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 04:15:25PM +0800, Yang Weijiang wrote:
> VMX relies on these fields to save/restore CET states for
> guest and host. They are added here as VMCS placeholders
> for the function.

The changelog needs a lot more detail on what is saved where and when,
e.g. hardware unconditionally saves the guest MSRs to the VMCS fields
on exit, hence there is no VM_EXIT_SAVE_GUEST_CET_STATE control bit.

It's also worth calling out that the other CET MSRs are saved/loaded
via XSAVES/XRSTORS.

> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/vmx.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index ade0f153947d..db745a1d49ae 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -98,6 +98,7 @@
>  #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
>  #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
>  #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
> +#define VM_EXIT_LOAD_HOST_CET_STATE             0x10000000
>  
>  #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
>  
> @@ -109,6 +110,7 @@
>  #define VM_ENTRY_LOAD_IA32_PAT			0x00004000
>  #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
>  #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
> +#define VM_ENTRY_LOAD_GUEST_CET_STATE           0x00100000
>  
>  #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
>  
> @@ -325,6 +327,9 @@ enum vmcs_field {
>  	GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
>  	GUEST_SYSENTER_ESP              = 0x00006824,
>  	GUEST_SYSENTER_EIP              = 0x00006826,
> +	GUEST_IA32_S_CET                = 0x00006828,
> +	GUEST_SSP                       = 0x0000682a,
> +	GUEST_INT_SSP_TABL              = 0x0000682c,

Dropping a single letter from "TABLE" seems pointless, "INTERRUPT" is
usually "INTR", and the docs I've seen list the name as
IA32_INTERRUPT_SSP_TABLE_ADDR.  So maybe?

    {GUEST,HOST}_INTR_SSP_TABLE_ADDR


Also, the SSP and INTERRUPT_SSP_TABL_ADDR fields are 64-bit fields, we
we should define the _HIGH variations.


>  	HOST_CR0                        = 0x00006c00,
>  	HOST_CR3                        = 0x00006c02,
>  	HOST_CR4                        = 0x00006c04,
> @@ -337,6 +342,9 @@ enum vmcs_field {
>  	HOST_IA32_SYSENTER_EIP          = 0x00006c12,
>  	HOST_RSP                        = 0x00006c14,
>  	HOST_RIP                        = 0x00006c16,
> +	HOST_IA32_S_CET                 = 0x00006c18,
> +	HOST_SSP                        = 0x00006c1a,
> +	HOST_INT_SSP_TABL               = 0x00006c1c
>  };
>  
>  /*
> -- 
> 2.17.1
> 
