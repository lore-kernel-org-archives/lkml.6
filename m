Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519838530-2-13085808940267550993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838529; b=bRL2cu3DLuGw14tbgTNCqs/fvNhJ4v2Fb0sFlPIwVZRn2hd
    TP6ah+/RPHWyaaXgDDp6TAbsXDLzyeZp0qaZjqc4r+VKqdjV+oSTO+iWu2EDLg+e
    Vub7LYM+g3cv71k4Im+CfXahnuYrmKNAYdw2ZsIvCbPogvCD2Lrash8MCyUwjpcy
    2vp5pIU/+R/jwE6qttnzzgldtN/16JnEHSIvoLj8jxeJJm3jpdoAFRruoZ04p5d3
    xAlFWOTwNWH9Y06ECnTyU9zqbxHJt7ZxZU06FDBbYrZcMq8aZAnD6I+E+wh4ooeq
    pk7qt1lbkGWfK/6CjfMMedaxH+NGygdItoIAjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838529; bh=j5B6b6c2PKkPTh5z9fi
    E9h1oq2a2TBVr8DzPNOsxVcw=; b=PdONNPbaRBlres1zT5dV/wK1u55lpMp2L2A
    OSc2neK5w5S9dmngiEZMgW9w1LfmnC/5GAxpQfaX2ORa234tbsXE/PghNOWdrUNV
    vW/h3yc03GmJGhWaV9RJvSXnql6G5jpWoZLhnyMoP16OVO+DE92F06ALUI9gUUhZ
    VN2fHFwqsKL5gQmXghR1m8lAEj1peRKMylXAD/IO7KIDjHIWFXC53VRoBGcI00pT
    Ar+jaM9DX0ixwrlcPXQP1JbP86wZQ1weTDmoF5yxMVYI/9ZAAryGYWNJ58ryE/f2
    CX4ie7LgMCXgCM9Aq/B/MLiRGExxeg9mLDo1gWkwMDVkX6wHZKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeB1PWQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:22:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33081 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932437AbeB1PWL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Gleb Natapov" <gleb@redhat.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.481945703@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 002/140] KVM: VMX: do not try to reexecute failed
 instruction while emulating invalid guest state
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Gleb Natapov <gleb@redhat.com>

commit 991eebf9f8e523e7ff1e4d31ac80641582b2e57a upstream.

During invalid guest state emulation vcpu cannot enter guest mode to try
to reexecute instruction that emulator failed to emulate, so emulation
will happen again and again.  Prevent that by telling the emulator that
instruction reexecution should not be attempted.

Signed-off-by: Gleb Natapov <gleb@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -694,6 +694,7 @@ enum emulation_result {
 #define EMULTYPE_NO_DECODE	    (1 << 0)
 #define EMULTYPE_TRAP_UD	    (1 << 1)
 #define EMULTYPE_SKIP		    (1 << 2)
+#define EMULTYPE_NO_REEXECUTE	    (1 << 4)
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
 			    int emulation_type, void *insn, int insn_len);
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4891,7 +4891,7 @@ static int handle_invalid_guest_state(st
 		    && (kvm_get_rflags(&vmx->vcpu) & X86_EFLAGS_IF))
 			return handle_interrupt_window(&vmx->vcpu);
 
-		err = emulate_instruction(vcpu, 0);
+		err = emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
 
 		if (err == EMULATE_DO_MMIO) {
 			ret = 0;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4888,10 +4888,14 @@ static int handle_emulation_failure(stru
 	return r;
 }
 
-static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t gva)
+static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t gva,
+				  int emulation_type)
 {
 	gpa_t gpa;
 
+	if (emulation_type & EMULTYPE_NO_REEXECUTE)
+		return false;
+
 	if (tdp_enabled)
 		return false;
 
@@ -4942,7 +4946,7 @@ int x86_emulate_instruction(struct kvm_v
 		if (r != EMULATION_OK)  {
 			if (emulation_type & EMULTYPE_TRAP_UD)
 				return EMULATE_FAIL;
-			if (reexecute_instruction(vcpu, cr2))
+			if (reexecute_instruction(vcpu, cr2, emulation_type))
 				return EMULATE_DONE;
 			if (emulation_type & EMULTYPE_SKIP)
 				return EMULATE_FAIL;
@@ -4969,7 +4973,7 @@ restart:
 		return EMULATE_DONE;
 
 	if (r == EMULATION_FAILED) {
-		if (reexecute_instruction(vcpu, cr2))
+		if (reexecute_instruction(vcpu, cr2, emulation_type))
 			return EMULATE_DONE;
 
 		return handle_emulation_failure(vcpu);
