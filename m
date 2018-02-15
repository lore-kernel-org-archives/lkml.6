Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710620-2-13904800030596932451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710620; b=C/B+psbn/MJ16dv+6XoQLTUK5mz7qI3LQOdOBQPScPec1AW
    dDmK3yhWVELtGyRyr9/HLFbRD92bvZoY3Wf3FCR1pHFo8Ze6HxlMb21/CKUfMU6V
    OFePrEjCx+Yo+fbWhshS4BrMxzPqZm5+yHMd2EAzN23R3PZNR8H4LTHnGSGuLiV3
    BMQ1N+LqPFWPhgPGiKNQIf/3/b85aDhyBB/UHMwoqVa5hzo6eG7VhbNB1J0lMCMx
    iUJwRD3j5Q+lahqSWpXdLR08Mh9xrPn6sR0ur4uTcfpmhbsDe6Ckr8QNAYjUm85+
    RwmcsMlonQtnZgSIk0HvRmhPrW5KCAE9P8AL/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710620; bh=kqZ7jxm9xXEoJSAbIWwowPulwE
    Gc2IYKJH9zPYCgz7g=; b=Y/4gkBy0JuZnovDh2CaAjAgMJCMdUm1S3YMTS+KsKz
    UI9WQ13jSqbZ2Y4ejAYjhoBaQSy6xUPSa/h0K5oJL8cQucL5D4RuLz4xA5kxAi2d
    xrNOeFXeCOzdjKjLyN6e4D7WQP0RuOLu94wO9E7bo1cr/2GDPBV2EOFfxYZ4wGrI
    dHd6eftI4l3TMn1a7m2FyqaSiOdnYwOolLRoGOGM0MrBoSqHvyMWcBA5M5oTQRWn
    Hw2AkDd7VtTT3IWmX2NGV4GxDGTvb26lG4bW7zO7tiLkM/qtif8ifP4Ne+XR6qWd
    Qs3QZajafyu2aMncAqJrFCK8W8Z9TfuP6um8kIswLcTQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424668AbeBOPq0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424630AbeBOPqY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.15 133/202] KVM: PPC: Book3S HV: Make sure we dont re-enter guest without XIVE loaded
Date: Thu, 15 Feb 2018 16:17:13 +0100
Message-Id: <20180215151720.117639469@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit 43ff3f65234061e08d234bdef5a9aadc19832b74 upstream.

This fixes a bug where it is possible to enter a guest on a POWER9
system without having the XIVE (interrupt controller) context loaded.
This can happen because we unload the XIVE context from the CPU
before doing the real-mode handling for machine checks.  After the
real-mode handler runs, it is possible that we re-enter the guest
via a fast path which does not load the XIVE context.

To fix this, we move the unloading of the XIVE context to come after
the real-mode machine check handler is called.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1423,6 +1423,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	blt	deliver_guest_interrupt
 
 guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
+	/* Save more register state  */
+	mfdar	r6
+	mfdsisr	r7
+	std	r6, VCPU_DAR(r9)
+	stw	r7, VCPU_DSISR(r9)
+	/* don't overwrite fault_dar/fault_dsisr if HDSI */
+	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
+	beq	mc_cont
+	std	r6, VCPU_FAULT_DAR(r9)
+	stw	r7, VCPU_FAULT_DSISR(r9)
+
+	/* See if it is a machine check */
+	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
+	beq	machine_check_realmode
+mc_cont:
+#ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
+	addi	r3, r9, VCPU_TB_RMEXIT
+	mr	r4, r9
+	bl	kvmhv_accumulate_time
+#endif
 #ifdef CONFIG_KVM_XICS
 	/* We are exiting, pull the VP from the XIVE */
 	lwz	r0, VCPU_XIVE_PUSHED(r9)
@@ -1460,26 +1480,6 @@ guest_exit_cont:		/* r9 = vcpu, r12 = tr
 	eieio
 1:
 #endif /* CONFIG_KVM_XICS */
-	/* Save more register state  */
-	mfdar	r6
-	mfdsisr	r7
-	std	r6, VCPU_DAR(r9)
-	stw	r7, VCPU_DSISR(r9)
-	/* don't overwrite fault_dar/fault_dsisr if HDSI */
-	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
-	beq	mc_cont
-	std	r6, VCPU_FAULT_DAR(r9)
-	stw	r7, VCPU_FAULT_DSISR(r9)
-
-	/* See if it is a machine check */
-	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
-	beq	machine_check_realmode
-mc_cont:
-#ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
-	addi	r3, r9, VCPU_TB_RMEXIT
-	mr	r4, r9
-	bl	kvmhv_accumulate_time
-#endif
 
 	mr 	r3, r12
 	/* Increment exit count, poke other threads to exit */
