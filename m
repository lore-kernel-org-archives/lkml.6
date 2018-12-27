Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F615C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718A1214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeL0GD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:03:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:41400 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeL0GD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:03:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 22:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,404,1539673200"; 
   d="scan'208";a="133109305"
Received: from unknown (HELO localhost) ([10.239.13.104])
  by fmsmga001.fm.intel.com with ESMTP; 26 Dec 2018 22:03:24 -0800
Date:   Thu, 27 Dec 2018 14:07:59 +0800
From:   "Yang,Weijiang" <weijiang.yang@intel.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v1 3/8] kvm:vmx  Enable loading CET state bit while guest
 CR4.CET is being set.
Message-ID: <20181227060759.GB14329@localhost.localdomain>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-4-weijiang.yang@intel.com>
 <9307C088-C8F8-4587-ABB4-3CADF2CC3117@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9307C088-C8F8-4587-ABB4-3CADF2CC3117@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 04:52:38PM +0800, Liran Alon wrote:

Thanks Liran for pointing out the issues!
I'll fix them in next version.
> 
> 
> > On 26 Dec 2018, at 10:15, Yang Weijiang <weijiang.yang@intel.com> wrote:
> > 
> > This bit controls whether guest CET states will be loaded on guest entry.
> > 
> > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---
> > arch/x86/kvm/vmx.c | 19 +++++++++++++++++++
> > 1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 7bbb8b26e901..25fa6bd2fb95 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -1045,6 +1045,8 @@ struct vcpu_vmx {
> > 
> > 	bool req_immediate_exit;
> > 
> > +	bool vcpu_cet_on;
> > +
> > 	/* Support for PML */
> > #define PML_ENTITY_NUM		512
> > 	struct page *pml_pg;
> > @@ -5409,6 +5411,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
> > 			return 1;
> > 	}
> > 
> > +	/*
> > +	 * When CET.CR4 is being set, it means we're enabling CET for
> 
> You probably meant to write here CR4.CET.
> 
> > +	 * the guest, then enable loading CET state bit in entry control.
> > +	 * Otherwise, clear loading CET bit to disable guest CET.
> > +	 */
> > +	if (cr4 & X86_CR4_CET) {
> > +		if (!to_vmx(vcpu)->vcpu_cet_on) {
> > +			vmcs_set_bits(VM_ENTRY_CONTROLS,
> > +				      VM_ENTRY_LOAD_GUEST_CET_STATE);
> > +			to_vmx(vcpu)->vcpu_cet_on = 1;
> > +		}
> > +	} else if (to_vmx(vcpu)->vcpu_cet_on) {
> > +		vmcs_clear_bits(VM_ENTRY_CONTROLS,
> > +				VM_ENTRY_LOAD_GUEST_CET_STATE);
> > +		to_vmx(vcpu)->vcpu_cet_on = 0;
> > +	}
> > +
> > 	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
> > 		return 1;
> > 
> > -- 
> > 2.17.1
> > 
> 
> I haven’t seen a patch in the series that modifies kvm_set_cr4() to verify CR4.CET is not set when CET is not reported as supported by CPUID.
> I think that is missing from the series.
> 
> -Liran
> 
> 
