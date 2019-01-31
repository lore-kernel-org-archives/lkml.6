Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A819FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CA5218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CVHCH361"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfAaT3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:29:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37638 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbfAaT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:29:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so1783696pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWChR7F0A4W4AZDg/y9+mR/BGhN5+3zmASBqt7KIKCo=;
        b=CVHCH361Hzk6Oo+z0ojJCfK8qTMcMvTvLaWBx+1y7/r+EdWqRjX+QpM/ZhfELfNiza
         ej/mEuQS6Ai7vdacf65cmOWMrEZzGq21+HF3IrG2pm+QGQ2QPrIfDq7uWK2wUuq8Xu9X
         0IrAqRsK/Wmy0KZdyiHLg8m/CuHQrsDJUzpCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWChR7F0A4W4AZDg/y9+mR/BGhN5+3zmASBqt7KIKCo=;
        b=Is5k/8YPCnvOjTWrkV7gRbRpCcydPVXEvlrJVN6cGtD4cROD8ruWAKrta+6/Rm4FRs
         flijGqEAL2wsCo+1CqOnPIMgDGL+IIh8v1pUDzAavOmcqcSyO3ZjMci4AMk1KWam2w5g
         8eWehjLz+86sNnYQ16yqasu/57ROxPH/ykN6ijhBCNkKymTRHebpzOum5ygupTPCSxFF
         WbNcZ2PlTj20HNPQ/dAngOwFOV3TXU9k6xUfIdpQDEH1LfWSb5oJBm9RR7vuRw14GJkz
         3rqs1YEeGpa2rxGVMm6y15m7T4PE26oSysDM+AVwKKITdz5to2DW6OMJU7M0V4T48vp5
         WVZg==
X-Gm-Message-State: AJcUukdA4WebwIMgmLAZU/AYUuzcQOWcODs3SFpi3XsjxghHBW/hc5Fd
        EJisEarAfa7buaC805D/RuqTuQ==
X-Google-Smtp-Source: ALg8bN74o0ggzc/P0iSwfgNR6YNr2NZQekzoOvQ13BxsOsZTsAWEnE+xK+EWKCusU588USTRUjGpyw==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr32101599pga.157.1548962941290;
        Thu, 31 Jan 2019 11:29:01 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:29:00 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/27] kvm: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:26 -0800
Message-Id: <20190131192533.34130-20-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. The new __ASM_MOVABS macro is used to
get the address of a symbol on both 32 and 64-bit with PIE support.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++--
 arch/x86/kernel/kvm.c           | 6 ++++--
 arch/x86/kvm/svm.c              | 4 ++--
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4660ce90de7f..fdb3307d5fe1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1498,9 +1498,13 @@ asmlinkage void kvm_spurious_fault(void);
 	".pushsection .fixup, \"ax\" \n" \
 	"667: \n\t" \
 	cleanup_insn "\n\t"		      \
-	"cmpb $0, kvm_rebooting \n\t"	      \
+	"cmpb $0, kvm_rebooting" __ASM_SEL(, (%%rip)) " \n\t" \
 	"jne 668b \n\t"      		      \
-	__ASM_SIZE(push) " $666b \n\t"	      \
+	__ASM_SIZE(push) "$0 \n\t"		\
+	__ASM_SIZE(push) "%%" _ASM_AX " \n\t"		\
+	_ASM_MOVABS " $666b, %%" _ASM_AX "\n\t"	\
+	_ASM_MOV " %%" _ASM_AX ", " __ASM_SEL(4, 8) "(%%" _ASM_SP ") \n\t" \
+	__ASM_SIZE(pop) "%%" _ASM_AX " \n\t"		\
 	"jmp kvm_spurious_fault \n\t"	      \
 	".popsection \n\t" \
 	_ASM_EXTABLE(666b, 667b)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5c93a65ee1e5..f6eb02004e43 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -826,8 +826,10 @@ asm(
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
-"movq	__per_cpu_offset(,%rdi,8), %rax;"
-"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
+"leaq	__per_cpu_offset(%rip), %rax;"
+"movq	(%rax,%rdi,8), %rax;"
+"addq	" __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rax;"
+"cmpb	$0, (%rax);"
 "setne	%al;"
 "ret;"
 ".popsection");
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f13a3a24d360..26abb82b1b67 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -706,12 +706,12 @@ static u32 svm_msrpm_offset(u32 msr)
 
 static inline void clgi(void)
 {
-	asm volatile (__ex("clgi"));
+	asm volatile (__ex("clgi") : :);
 }
 
 static inline void stgi(void)
 {
-	asm volatile (__ex("stgi"));
+	asm volatile (__ex("stgi") : :);
 }
 
 static inline void invlpga(unsigned long addr, u32 asid)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4341175339f3..3275761a7375 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2161,7 +2161,7 @@ static void vmclear_local_loaded_vmcss(void)
  */
 static void kvm_cpu_vmxoff(void)
 {
-	asm volatile (__ex("vmxoff"));
+	asm volatile (__ex("vmxoff") :::);
 
 	intel_pt_handle_vmx(0);
 	cr4_clear_bits(X86_CR4_VMXE);
-- 
2.20.1.495.gaa96b0ce6b-goog

