Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708688-2-4777908597165350342
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
    t=1518708688; b=t8JPKUI3/MpuuZb9Ua4yJ5oDjX/u0YaMZoNnWl9PfuUVioH
    bkVQ5LUE4EGK3zXvh9Pozjm9EH3QAp4x9iHoHXomJ2z3a39Gs3V1+pK4uR2lf0DA
    SsA03dBFOJ7S0+/WkmL3SI8UrElrllBOfmFrvof2xuhq+zX36ecEhSk9w5YN8glt
    hainyts5OprWbFYoz964f2hpU5ZMLoP9tCDcMS/Rkt5CHM9ZxT99spVPW8+IwDEV
    H1vBBNWG6xzZ+XiZ6CBpKLqH0/YnZC7eNKxZXBghp2IQDLbddUc+KRPXe+lUg92N
    eGwl0czZ6I3B7frUB0aAyanLrOMWMQkpdzLvB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708688; bh=dXGPX1lI+25t7CwWTf/xJUheyJ
    7jsLhzQksHpJNs1dc=; b=kJlKOVsmMTGXmyHO/+MSXPlIN4xzwZs59oitqiQvKp
    sLI7evDBCRwRCG+QZoD1rXUnwN4YJBatsqy4S8ewRq3FADb9xpBBrs+xVe8M71zW
    9PRUmWWRqz+sMz5E1/nCisYaZEIVqA19A+vX7vdMkszgGhOQnyCT1MXcofZvR8se
    GAJeZW1vTfPh4jfOGG8Ug38Ix1rtixjB2hDpo1HcjtSEJrJbdakH5FgiRIpuQf7Z
    h/WkHKTNKWk/fzCyjwxpzhIeKuEorns9PqGBPm1OvpJtBvrHMKrWpDMoxD0jwRQK
    I1EwH7zmtZXsLEdxFppvcsE7ZttatiTUvIkXkmTPEusg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164404AbeBOPbY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:31:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164304AbeBOPbX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:31:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 041/195] [Variant 3/Meltdown] arm64: use RET instruction for exiting the trampoline
Date: Thu, 15 Feb 2018 16:15:32 +0100
Message-Id: <20180215151707.797592511@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit be04a6d1126b upstream.

Speculation attacks against the entry trampoline can potentially resteer
the speculative instruction stream through the indirect branch and into
arbitrary gadgets within the kernel.

This patch defends against these attacks by forcing a misprediction
through the return stack: a dummy BL instruction loads an entry into
the stack, so that the predicted program flow of the subsequent RET
instruction is to a branch-to-self instruction which is finally resolved
as a branch to the kernel vectors with speculation suppressed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -981,6 +981,14 @@ alternative_else_nop_endif
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
+	/*
+	 * Defend against branch aliasing attacks by pushing a dummy
+	 * entry onto the return stack and using a RET instruction to
+	 * enter the full-fat kernel vectors.
+	 */
+	bl	2f
+	b	.
+2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
 	adr	x30, tramp_vectors + PAGE_SIZE
@@ -993,7 +1001,7 @@ alternative_insn isb, nop, ARM64_WORKARO
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
 	isb
-	br	x30
+	ret
 	.endm
 
 	.macro tramp_exit, regsize = 64
