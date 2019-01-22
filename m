Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F873C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452F9217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfAVRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:00:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:21649 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbfAVRAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:00:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 09:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="127979830"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2019 09:00:45 -0800
Date:   Tue, 22 Jan 2019 09:00:45 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: Fix vm entry failure caused by invalid vmexit
 controls
Message-ID: <20190122170045.GD28513@linux.intel.com>
References: <20190122152952.8011-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152952.8011-1-changbin.du@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:29:52PM +0800, Changbin Du wrote:
> The commit c73da3f ("KVM: VMX: Properly handle dynamic VM Entry/Exit
> controls") has a typo that cause invalid vmexit controls. The
> VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL is against _vmentry_control.
> 
> KVM: entry failed, hardware error 0x7
> EAX=00000000 EBX=00000000 ECX=00000000 EDX=000206c2
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 00000000 0000ffff 00009300
> CS =f000 ffff0000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT= 00000000 0000ffff
> IDT= 00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> DR3=0000000000000000 DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> 
> Fixes: c73da3f ("KVM: VMX: Properly handle dynamic VM Entry/Exit controls")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Patch already submitted[1].

Paolo/Radim, the VM-Exit fix needs to be queued asap.  The fix for the
objtool warning[2] should also go into v5.0.

[1] https://patchwork.kernel.org/patch/10763351/
[2] https://patchwork.kernel.org/patch/10765309/



> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f6915f10e584..0762fcab8fc9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2344,7 +2344,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  		case 37: /* AAT100 */
>  		case 44: /* BC86,AAY89,BD102 */
>  		case 46: /* BA97 */
> -			_vmexit_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> +			_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
>  			_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
>  			pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
>  					"does not work properly. Using workaround\n");
> -- 
> 2.19.1
> 
