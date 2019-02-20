Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249D20449
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfBTHKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:10:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:51384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBTHKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:10:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 23:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="116304257"
Received: from zhangyu-optiplex-9020.bj.intel.com (HELO localhost) ([10.238.135.159])
  by orsmga007.jf.intel.com with ESMTP; 19 Feb 2019 23:10:52 -0800
Date:   Wed, 20 Feb 2019 15:06:21 +0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: MMU: record maximum physical address width in
 kvm_mmu_extended_role
Message-ID: <20190220070621.meka6jyjpdreh2ed@linux.intel.com>
References: <1548950963-18414-1-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548950963-18414-1-git-send-email-yu.c.zhang@linux.intel.com>
User-Agent: NeoMutt/20180622-66-b94505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo, any comments on this patch? And the other one(kvm: x86: Return
LA57 feature based on hardware capability )? :-)

On Fri, Feb 01, 2019 at 12:09:23AM +0800, Yu Zhang wrote:
> Previously, commit 7dcd57552008 ("x86/kvm/mmu: check if tdp/shadow
> MMU reconfiguration is needed") offered some optimization to avoid
> the unnecessary reconfiguration. Yet one scenario is broken - when
> cpuid changes VM's maximum physical address width, reconfiguration
> is needed to reset the reserved bits.  Also, the TDP may need to
> reset its shadow_root_level when this value is changed.
> 
> To fix this, a new field, maxphyaddr, is introduced in the extended
> role structure to keep track of the configured guest physical address
> width.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/mmu.c              | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4660ce9..be87f71 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -299,6 +299,7 @@ struct kvm_mmu_memory_cache {
>  		unsigned int cr4_smap:1;
>  		unsigned int cr4_smep:1;
>  		unsigned int cr4_la57:1;
> +		unsigned int maxphyaddr:6;
>  	};
>  };
>  
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index ce770b4..2b74505 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4769,6 +4769,7 @@ static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
>  	ext.cr4_pse = !!is_pse(vcpu);
>  	ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
>  	ext.cr4_la57 = !!kvm_read_cr4_bits(vcpu, X86_CR4_LA57);
> +	ext.maxphyaddr = cpuid_maxphyaddr(vcpu);
>  
>  	ext.valid = 1;
>  
> -- 
> 1.9.1
> 

Thanks
Yu
