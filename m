Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D83C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21F121873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J7rr6IOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeLSEd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:33:26 -0500
Received: from ozlabs.org ([203.11.71.1]:56729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLSEdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:33:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KMTF3rvWz9sCV;
        Wed, 19 Dec 2018 15:33:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545194001;
        bh=Y4qohUq0uL+oGHn6JSj6sXdf/FTPexHn8FyWjyrguy4=;
        h=Date:From:To:Cc:Subject:From;
        b=J7rr6IOT+QqN3knaJ6YSSQmoIbVg2QVf52HrQySE3Hah8MxGd3/c8mPtURQYyUkSs
         TG4mEXjzgdA5KBRQhw4/ZpeqvFcxH0XnLmCHPcGL23YRtbFWr8iM6IEqScA4EIIuGx
         gWMtSHMYypeH7LW1zVLAbeovM4/2NdrlvxKYII6z+qG4Ta6EjTTuyQfsovryhvYxqD
         XYCxK50EWzuvP3W+HfB5Bo0eXPx7yUu7D7LpxSOoCoKdaWR/NE0FrigMBNmFCL+YOy
         xq2QFwWCK40dGxD7UGyyupKlYPTbpC9pGdUSxQwIG8Rp8fyDL5NE0t10ixHnmaSuBI
         5ZXAioiyJNObw==
Date:   Wed, 19 Dec 2018 15:33:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: linux-next: build failure after merge of the kvm tree
Message-ID: <20181219153320.2ef0e07b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2YVOyfxLi21RRL3WYN0sacM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2YVOyfxLi21RRL3WYN0sacM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

arch/x86/kvm/vmx/nested.c: In function 'prepare_vmcs02_full':
arch/x86/kvm/vmx/nested.c:2242:6: error: implicit declaration of function '=
kvm_mpx_supported'; did you mean 'vmx_mpx_supported'? [-Werror=3Dimplicit-f=
unction-declaration]
  if (kvm_mpx_supported()) {
      ^~~~~~~~~~~~~~~~~
      vmx_mpx_supported

Caused by commit

  55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")

interacting with commit

  eb012ef3b4e3 ("x86: Remove Intel MPX")

from the tip tree.

I applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 19 Dec 2018 15:28:31 +1100
Subject: [PATCH] kvm: tidy up from MPX removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/kvm/vmx/nested.c | 13 -------------
 arch/x86/kvm/vmx/vmx.c    | 40 +++------------------------------------
 2 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3f019aa63341..59e6da4171a8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2238,14 +2238,6 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx=
, struct vmcs12 *vmcs12)
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
=20
 	set_cr4_guest_host_mask(vmx);
-
-	if (kvm_mpx_supported()) {
-		if (vmx->nested.nested_run_pending &&
-			(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
-			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
-		else
-			vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
-	}
 }
=20
 /*
@@ -2971,9 +2963,6 @@ int nested_vmx_enter_non_root_mode(struct kvm_vcpu *v=
cpu, bool from_vmentry)
=20
 	if (!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.vmcs01_debugctl =3D vmcs_read64(GUEST_IA32_DEBUGCTL);
-	if (kvm_mpx_supported() &&
-		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
-		vmx->nested.vmcs01_guest_bndcfgs =3D vmcs_read64(GUEST_BNDCFGS);
=20
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
=20
@@ -3496,8 +3485,6 @@ static void sync_vmcs12(struct kvm_vcpu *vcpu, struct=
 vmcs12 *vmcs12)
 	vmcs12->guest_sysenter_cs =3D vmcs_read32(GUEST_SYSENTER_CS);
 	vmcs12->guest_sysenter_esp =3D vmcs_readl(GUEST_SYSENTER_ESP);
 	vmcs12->guest_sysenter_eip =3D vmcs_readl(GUEST_SYSENTER_EIP);
-	if (kvm_mpx_supported())
-		vmcs12->guest_bndcfgs =3D vmcs_read64(GUEST_BNDCFGS);
 }
=20
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c90fffdc5a93..ccab822be9cd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1527,12 +1527,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
 		msr_info->data =3D vmcs_readl(GUEST_SYSENTER_ESP);
 		break;
 	case MSR_IA32_BNDCFGS:
-		if (!kvm_mpx_supported() ||
-		    (!msr_info->host_initiated &&
-		     !guest_cpuid_has(vcpu, X86_FEATURE_MPX)))
-			return 1;
-		msr_info->data =3D vmcs_read64(GUEST_BNDCFGS);
-		break;
+		return 1;
 	case MSR_IA32_MCG_EXT_CTL:
 		if (!msr_info->host_initiated &&
 		    !(vmx->msr_ia32_feature_control &
@@ -1610,15 +1605,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
 		vmcs_writel(GUEST_SYSENTER_ESP, data);
 		break;
 	case MSR_IA32_BNDCFGS:
-		if (!kvm_mpx_supported() ||
-		    (!msr_info->host_initiated &&
-		     !guest_cpuid_has(vcpu, X86_FEATURE_MPX)))
-			return 1;
-		if (is_noncanonical_address(data & PAGE_MASK, vcpu) ||
-		    (data & MSR_IA32_BNDCFGS_RSVD))
-			return 1;
-		vmcs_write64(GUEST_BNDCFGS, data);
-		break;
+		return 1;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
@@ -3868,8 +3855,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, boo=
l init_event)
 	vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 	vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, 0);
 	vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS, 0);
-	if (kvm_mpx_supported())
-		vmcs_write64(GUEST_BNDCFGS, 0);
=20
 	setup_msrs(vmx);
=20
@@ -6636,23 +6621,6 @@ static void nested_vmx_cr_fixed1_bits_update(struct =
kvm_vcpu *vcpu)
 #undef cr4_fixed1_update
 }
=20
-static void nested_vmx_entry_exit_ctls_update(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
-
-	if (kvm_mpx_supported()) {
-		bool mpx_enabled =3D guest_cpuid_has(vcpu, X86_FEATURE_MPX);
-
-		if (mpx_enabled) {
-			vmx->nested.msrs.entry_ctls_high |=3D VM_ENTRY_LOAD_BNDCFGS;
-			vmx->nested.msrs.exit_ctls_high |=3D VM_EXIT_CLEAR_BNDCFGS;
-		} else {
-			vmx->nested.msrs.entry_ctls_high &=3D ~VM_ENTRY_LOAD_BNDCFGS;
-			vmx->nested.msrs.exit_ctls_high &=3D ~VM_EXIT_CLEAR_BNDCFGS;
-		}
-	}
-}
-
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
@@ -6669,10 +6637,8 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits &=3D
 			~FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
=20
-	if (nested_vmx_allowed(vcpu)) {
+	if (nested_vmx_allowed(vcpu))
 		nested_vmx_cr_fixed1_bits_update(vcpu);
-		nested_vmx_entry_exit_ctls_update(vcpu);
-	}
 }
=20
 static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *ent=
ry)
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/2YVOyfxLi21RRL3WYN0sacM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwZyhAACgkQAVBC80lX
0GxAfwf/Te/ACBld9lZUJtTuVhqaD0qr11RhixqUzDF0w88mMAXeYrv2HhRupmdo
8ZJ1HEOkjm/uiacE7Q89wLB5xiUcNb+U5fImsJCMAzctLYPwmeOzh6v/Wz2hrCr1
9rtxt2cfkMzDQmFTCs8NJqmh33JVgmmbrc9MjBApwj7f2Y0vnxZ17m7uWM8CbTVI
t9OKob3QM8KLSxcApCLn161WRlIFFFNeXWyr7cOsZk+uCAMOZsTo07ILt/3efFZC
+XK0UENp6X3/cp/Wp/DrAsfUhfU5hqYvhDaZr3ZSE0NfGJF1TSLYJAAZCv7aXMCz
iR5mIQwRipzGTZTOfP0LKjkJSN6jZQ==
=cZND
-----END PGP SIGNATURE-----

--Sig_/2YVOyfxLi21RRL3WYN0sacM--
