Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gS4QM6w5GVtNCwAAmS7hNA
	; Thu, 07 Jun 2018 13:57:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BCD53607DC; Thu,  7 Jun 2018 13:57:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F6CF601B4;
	Thu,  7 Jun 2018 13:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F6CF601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeFGN46 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:56:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:14882 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753421AbeFGN44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:56:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 06:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="54811932"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2018 06:56:50 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fQvPE-0004rJ-Ic; Thu, 07 Jun 2018 16:56:48 +0300
Date: Thu, 7 Jun 2018 16:56:48 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, chao.p.peng@linux.intel.com,
        thomas.lendacky@amd.com, bp@suse.de, Kan.liang@intel.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org
Subject: Re: [PATCH v9 09/12] KVM: x86: Introduce a function to initialize
 the PT configuration
Message-ID: <20180607135648.mkciyfrd2wgvdxze@um.fi.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-10-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526964735-16566-10-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:52:12PM +0800, Luwei Kang wrote:
> Initialize the Intel PT configuration when cpuid update.

Is it the CPUID configuration? Is it the MSR configuration? Is it both?
Kind of looks like both. Not sure what is the cpuid update, though.

> Include cpuid inforamtion, rtit_ctl bit mask and the number of
> address ranges.
>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 11fb90a..952ddf4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10411,6 +10411,72 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
>  #undef cr4_fixed1_update
>  }
>  
> +static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct kvm_cpuid_entry2 *best = NULL;
> +	int i;
> +
> +	for (i = 0; i < PT_CPUID_LEAVES; i++) {
> +		best = kvm_find_cpuid_entry(vcpu, 0x14, i);
> +		if (!best)
> +			return;
> +		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
> +		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
> +		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
> +		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
> +	}
> +
> +	/* Get the number of configurable Address Ranges for filtering */
> +	vmx->pt_desc.addr_range = pt_cap_decode(vmx->pt_desc.caps,
> +						PT_CAP_num_address_ranges);
> +
> +	/* Initialize and clear the no dependency bits */
> +	vmx->pt_desc.ctl_bitmask = ~0ULL;

This looks redundant, doesn't it?

> +	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
> +			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC);
> +
> +	/* If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set */

This comment makes it less clear than it would have been otherwise.

> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
> +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
> +
> +	/*
> +	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
> +	 * PSBFreq can be set
> +	 */
> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_psb_cyc))
> +		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
> +			RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
> +
> +	/*
> +	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn BranchEn and
> +	 * MTCFreq can be set
> +	 */
> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_mtc))
> +		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
> +			RTIT_CTL_BRANCH_EN | RTIT_CTL_MTC_RANGE);
> +
> +	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_ptwrite))
> +		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
> +						RTIT_CTL_PTW_EN);
> +
> +	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_power_event_trace))
> +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
> +
> +	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_topa_output))
> +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;

If you want to be thorough, there's also PT_CAP_single_range_output, which
tells us if RTIT_CTL_TOPA can be *unset*. Otherwise it's required.

> +	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
> +	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_output_subsys))
> +		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;

Are we sure we want to virtualize this and that it's safe?

> +
> +	/* unmask address range configure area */
> +	for (i = 0; i < vmx->pt_desc.addr_range; i++)
> +		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i * 4));

So, the ctl_bitmask is all the bits that are not allowed?

Regards,
--
Alex
