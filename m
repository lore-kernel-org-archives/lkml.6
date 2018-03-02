Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeCBVmu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:42:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752432AbeCBVmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:42:49 -0500
Date: Fri, 2 Mar 2018 22:42:12 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
Message-ID: <20180302214212.GB13606@flask>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com>
 <20180301213205.GB29001@flask>
 <ccead1df-ba70-f365-c816-7892834a290c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccead1df-ba70-f365-c816-7892834a290c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 10:36+0100, Paolo Bonzini:
> On 01/03/2018 22:39, Radim Krčmář wrote:
> > [Resent after removing g@char.us.oracle.com.]
> > 
> > 2018-02-26 17:13-0500, Konrad Rzeszutek Wilk:
> >> On Sat, Feb 24, 2018 at 01:52:26AM +0100, Paolo Bonzini wrote:
> >>> Use the new MSR feature framework to expose the ARCH_CAPABILITIES MSR to
> >>> userspace.  This way, userspace can access the capabilities even if it
> >>> does not have the permissions to read MSRs.
> >>
> >> ... That is good but could you expand a bit of why it would want this?
> >>
> >> I am 99% sure it is due to the lovely spectre_v2 mitigation but
> >> could you include that in the commit message so that in say a year
> >> folks would know what this is?
> > 
> > Userspace can currently get the MSR by creating a VCPU and reading its
> > MSR_IA32_ARCH_CAPABILITIES, because it is set from the hardware MSR.
> > 
> > I thought that "permissions to read MSRs" talked about hardware MSRs, so
> > the purpose of this patch would be a better interface, but I don't see
> > how if we keep the auto-setting on VCPU creation.
> 
> Yeah, it's mostly about a better interface and being able to do checks
> before creating the VCPU.  The commit message was written before I
> noticed the auto-setting on VCPU creation, and I failed to update it.

Ok, sounds good.  I've deferred it to rc5 as I think we'll want to use
this to replace the auto setting:  I would not bet that it is going to
be safe to expose future bits, so having the userspace always sanitize
the capabilities would be safer (and more in line with what we do with
other MSRs).  i.e. this patch would also

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 051dab74e4e9..86ea4a83af1f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5740,9 +5740,6 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		++vmx->nmsrs;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
-
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
 	/* 22.2.1, 20.8.1 */
