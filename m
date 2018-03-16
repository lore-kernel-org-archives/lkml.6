Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvhROllq4Jtwmb4qFD/JRv2LHQaiH1F8TqAwS5UbZdpGc4ZswjSR1KZAPWuNyEAPRMsB5l2
ARC-Seal: i=1; a=rsa-sha256; t=1521214689; cv=none;
        d=google.com; s=arc-20160816;
        b=tE0ixxb9XUv9XFWQIgd8uUg4KfUA+PuhSSY/O1DR+JuWuN9SRDH3wbM4CJjdQUkhIi
         5ONoIAUs7xPdvR5qfwYicfFd6YQ2kkki+7FwnEbS63uSG7/oP3ZekvlwH9002WlsKVET
         P/1yDC0BzWOkq7QlX0LW5VnpbLeseIFecD04xpHvouWdzXu2hj3UhqFna3FHxuG0AZOH
         mxygwFOsZ4n9ZrHtpS3UgEWJ4Bc0cGKbK8KiLs8YIUQzxBdRLsJpxSkTeNUd7yO6IVSr
         BGep17I07JmThmjJfZfNacQoS1kyKOrowSGMBp0dOCanuTGE1HVMqfQfMPng14thMB+i
         WaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6TW5MAXvNYXwelzG6rgACMqpjrGkLbgeh69SckMcyuo=;
        b=jWg/h8Za0kc0E519waEIBSktT1aBrTe6D25IyRbkeFxgps6g3OgLdlUT8cXR6iPzEc
         RaPvi344ubvfFzmOofEG/t0ztDu3T9or6K4BnGczTXghTYkGFQK07/7Vlzp/hCuIAYTh
         tcbd3vKDzJRcmHcnH/whWzT54xBAw1OtykmyKDFGw+CAVSnXo26sLBDPUvFPSk3ZmIUq
         4rUIgx9ZR1QmSD6V7hN1zxov3Tj5dpQ/6Si1HugUBuLmUuk6yvHkmvtX15zBY9IiHTDy
         HElk0SVjRAoZArfcO71/dfhK8jXtzhsKC3RqQlu1D3uYvv9WnyUScxbuUx7zVxVz8wqE
         QBiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 093/109] powerpc/modules: Dont try to restore r2 after a sibling call
Date: Fri, 16 Mar 2018 16:24:02 +0100
Message-Id: <20180316152334.964491242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109214413990117?=
X-GMAIL-MSGID: =?utf-8?q?1595109214413990117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -486,7 +486,17 @@ static bool is_early_mcount_callsite(u32
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
