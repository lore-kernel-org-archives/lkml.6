Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215561-2-13046129765625891357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215555; b=HpRpjm1R9a00lrmley4HN/S4ZmfMQC5F+3u+qxASeSkgZmj
    g4rtB4BppwazAEu1E2BpGT1d9/axQ1MikfY1ZLfiM6TEA9AsgLSeNRu+VzYGUqnT
    fgsABq/71sPbsNikjRK2slhSz1LYg0i/dl4+4Gm6ezch06O2Tvr4r38PpePum1PD
    1qT19aaCKp17EYtjl+mzRMQpR0ygtp/7B5wl2ZU5kIYQATARWRG+ONh/0NyG2SX8
    v8vxdmncT5dV8dMjn8tdUFeaNNeZze8qvoMyPapsB4wTXi0a0xmSW6grInPgmTLl
    w7NLSByYhFLiP7mqcEhDlbKre0/5LakRLvNZSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215555; bh=hYrCcHsAuSekIHPgUBop8ma6R9
    rHSLomomX0f8c6EKs=; b=CaBA2CuxJUQJQcUtnSaUhHna6BQQA9HLvBmhI6ekQU
    W8ZThcdh6ZCOSuOSK7m50wkMg+v0HMvGkewGO4jPxmNezX7jHDlNTIju+HoQMYrv
    I/xTiE2jtGr9/1yQ7jt+oGYedA2nJfD9/XvKIIBMboACgwATVh7EPgpMZg4abP/J
    RVlIaFBjgH47gmC/XOKSGkC9haTfAcaqJKwbIgAvoZ6WN+29cLqjL6PrqpYQpDJB
    cl51cOYpsP7MOzbCqjl9E8Hi9v7OvXz1fW7K8PC42ckTMH4Dlui760F743jkiV+u
    nGl35afwgUlNxR4GKsxK32IQiLg35ajNyhQT7iqlQT9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeCPPwT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:52:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965406AbeCPPoU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 112/128] powerpc/modules: Dont try to restore r2 after a sibling call
Date: Fri, 16 Mar 2018 16:24:13 +0100
Message-Id: <20180316152342.100812759@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>


[ Upstream commit b9eab08d012fa093947b230f9a87257c27fb829b ]

When attempting to load a livepatch module, I got the following error:

  module_64: patch_module: Expect noop after relocate, got 3c820000

The error was triggered by the following code in
unregister_netdevice_queue():

  14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
                         14c: R_PPC64_REL24      net_set_todo
  150:   00 00 82 3c     addis   r4,r2,0

GCC didn't insert a nop after the branch to net_set_todo() because it's
a sibling call, so it never returns.  The nop isn't needed after the
branch in that case.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-and-tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/code-patching.h |    1 +
 arch/powerpc/kernel/module_64.c          |   12 +++++++++++-
 arch/powerpc/lib/code-patching.c         |    5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -33,6 +33,7 @@ int patch_branch(unsigned int *addr, uns
 int patch_instruction(unsigned int *addr, unsigned int instr);
 
 int instr_is_relative_branch(unsigned int instr);
+int instr_is_relative_link_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
 unsigned long branch_target(const unsigned int *instr);
 unsigned int translate_branch(const unsigned int *dest,
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -487,7 +487,17 @@ static bool is_early_mcount_callsite(u32
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
-	if (is_early_mcount_callsite(instruction - 1))
+	u32 *prev_insn = instruction - 1;
+
+	if (is_early_mcount_callsite(prev_insn))
+		return 1;
+
+	/*
+	 * Make sure the branch isn't a sibling call.  Sibling calls aren't
+	 * "link" branches and they don't return, so they don't need the r2
+	 * restore afterwards.
+	 */
+	if (!instr_is_relative_link_branch(*prev_insn))
 		return 1;
 
 	if (*instruction != PPC_INST_NOP) {
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -302,6 +302,11 @@ int instr_is_relative_branch(unsigned in
 	return instr_is_branch_iform(instr) || instr_is_branch_bform(instr);
 }
 
+int instr_is_relative_link_branch(unsigned int instr)
+{
+	return instr_is_relative_branch(instr) && (instr & BRANCH_SET_LINK);
+}
+
 static unsigned long branch_iform_target(const unsigned int *instr)
 {
 	signed long imm;
