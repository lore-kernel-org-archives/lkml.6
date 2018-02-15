Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720872-2-3518864141159355687
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
    t=1518720871; b=lZQPeG03CsTU4MSL/ovVAk96hd1b36jgzqcToTJaHfFb0IN
    Twk1kXdbNwtLmqINNvpYYnKDEDEygo7i+bfNCAx2EIH+j8Hdjj+IhE5oqLFl121y
    005JJSYsoFNWG25OgDMF8M45rFJWfhPY851bjo6eO6F2gwBtPUUc9s2CALvRVnTl
    N8MskrQynrcmLzvjgoOGqmbtvl5HaQ8C+IkOLAqhEO5g/Cawd6BYJEUxoWGomwm9
    v/ILpqb65ogoaDitJJ3lT214iJiF8HS7qNdR4Uve5B6/0KdT/QAOlWSIAyyvIlWt
    K1r7qd2U8cnSymiMshWLT9alUXLJ/gHOrHF2BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720871; bh=Kuuxx1fl/gXJyoybh1oNsbcC66
    D5l2efMy9kFJM3htA=; b=Ipa+vMf2yGM7SiB0SbbgmCrypfg33DtaX/0+tQ/gcK
    7jT49tlAhH+2TEwoqZqhrM0MLLZBldHv69+s0K6HYYNdVIrrzpQFNNM9R+RacwpW
    xHirVlU5S9E+k/v4kc4Tb6ncmwuA18XoGMhucbtAO4udLferiIR2O+TW3PrVizRa
    CT/+KSlb/w2kCx2G7gB5pQoqliflkjTycAPL7CuVoPmVnrTKTGzM0UvxIbWzR26S
    JcywBGIoburEjWDhP8GTuleApe6hr9ht48b2aPtUv9KxiCim/QOyhGK8++SCIS/k
    /FIMl26vs2XDbvXUPK+W6OYKz1iAQJKCsHezGAvijbKw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162237AbeBOSyP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:54:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161872AbeBOPUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 003/108] powerpc: Fix VSX enabling/flushing to also test MSR_FP and MSR_VEC
Date: Thu, 15 Feb 2018 16:16:00 +0100
Message-Id: <20180215151222.757273093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 5a69aec945d27e78abac9fd032533d3aaebf7c1e upstream.

VSX uses a combination of the old vector registers, the old FP
registers and new "second halves" of the FP registers.

Thus when we need to see the VSX state in the thread struct
(flush_vsx_to_thread()) or when we'll use the VSX in the kernel
(enable_kernel_vsx()) we need to ensure they are all flushed into
the thread struct if either of them is individually enabled.

Unfortunately we only tested if the whole VSX was enabled, not if they
were individually enabled.

Fixes: 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx() routine available")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[mpe: Backported due to changed context]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/process.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -209,7 +209,8 @@ void enable_kernel_vsx(void)
 	WARN_ON(preemptible());
 
 #ifdef CONFIG_SMP
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX))
+	if (current->thread.regs &&
+	    (current->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP)))
 		giveup_vsx(current);
 	else
 		giveup_vsx(NULL);	/* just enable vsx for kernel - force */
@@ -231,7 +232,7 @@ void flush_vsx_to_thread(struct task_str
 {
 	if (tsk->thread.regs) {
 		preempt_disable();
-		if (tsk->thread.regs->msr & MSR_VSX) {
+		if (tsk->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP)) {
 #ifdef CONFIG_SMP
 			BUG_ON(tsk != current);
 #endif
