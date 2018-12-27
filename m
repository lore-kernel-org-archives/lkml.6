Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F918C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97BE21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeL0DgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:36:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:44755 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeL0DgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:36:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 19:36:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,403,1539673200"; 
   d="scan'208";a="112281486"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.36.8])
  by fmsmga008.fm.intel.com with ESMTP; 26 Dec 2018 19:36:10 -0800
Date:   Thu, 27 Dec 2018 11:35:45 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Luwei Kang <luwei.kang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: x86: Fix bit shifting in update_intel_pt_cfg
Message-ID: <20181227033545.GA15607@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20181226204059.GA11391@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226204059.GA11391@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 02:40:59PM -0600, Gustavo A. R. Silva wrote:
>ctl_bitmask in pt_desc is of type u64. When an integer like 0xf is
>being left shifted more than 32 bits, the behavior is undefined.
>
>Fix this by adding suffix ULL to integer 0xf.
>
>Addresses-Coverity-ID: 1476095 ("Bad bit shift operation")
>Fixes: 6c0f0bba85a0 ("KVM: x86: Introduce a function to initialize the PT configuration")
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks good.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> arch/x86/kvm/vmx/vmx.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index cbd55e7aeae5..251c68a74bbe 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -7012,7 +7012,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> 
> 	/* unmask address range configure area */
> 	for (i = 0; i < vmx->pt_desc.addr_range; i++)
>-		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i * 4));
>+		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
> }
> 
> static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
