Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06CDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F2F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfAOCnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:43:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:22269 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfAOCnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:43:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="114715134"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2019 18:43:05 -0800
Date:   Mon, 14 Jan 2019 18:43:04 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Tom Roeder <tmroeder@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
Message-ID: <20190115024304.GD5141@linux.intel.com>
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
 <20190114234728.49239-1-tmroeder@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114234728.49239-1-tmroeder@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:47:28PM -0800, Tom Roeder wrote:
> This changes the allocation of cached_vmcs12 to use kzalloc instead of
> kmalloc. This removes the information leak found by Syzkaller (see
> Reported-by) in this case and prevents similar leaks from happening
> based on cached_vmcs12.

Is the leak specific to vmx_set_nested_state(), e.g. can we zero out
the memory if copy_from_user() fails instead of taking the hit on every
allocation?

> The email from Syszkaller led to a discussion about a patch in early
> November on the KVM list (I've made this a reply to that thread), but
> the current upstream kernel still has kmalloc instead of kzalloc for
> cached_vmcs12 and cached_shadow_vmcs12. This RFC proposes changing to
> kzalloc for defense in depth.
> 
> Tested: rebuilt but not tested, since this is an RFC
> 
> Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
> Signed-off-by: Tom Roeder <tmroeder@google.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 2616bd2c7f2c7..ad46667042c7a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4140,11 +4140,11 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
>  	if (r < 0)
>  		goto out_vmcs02;
>  
> -	vmx->nested.cached_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
> +	vmx->nested.cached_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
>  	if (!vmx->nested.cached_vmcs12)
>  		goto out_cached_vmcs12;

Obviously not your code, but why do we allocate VMCS12_SIZE instead of
sizeof(struct vmcs12)?  I get why we require userspace to reserve the
full 4k, but I don't understand why KVM needs to allocate the reserved
bytes internally.

> -	vmx->nested.cached_shadow_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
> +	vmx->nested.cached_shadow_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
>  	if (!vmx->nested.cached_shadow_vmcs12)
>  		goto out_cached_shadow_vmcs12;
>  
> -- 
> 2.20.1.97.g81188d93c3-goog
> 
