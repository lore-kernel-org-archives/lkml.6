Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbkDYqHjX0BJeWQ7ZCp/QULcqtpmTXtMDXMiK6bofS86yY/TU7vx9QSdsFmjMLx9IlZ7F4
ARC-Seal: i=1; a=rsa-sha256; t=1521484017; cv=none;
        d=google.com; s=arc-20160816;
        b=rpM+2STyiAjQL3PIAgiS6fczm61DbzAIJjjOF1MhBUm6gO7pvIXduqvlPf56v3Lxjo
         Du6df7arL5hN/xfVarnySw4YJ1brOkJWfjhpSi5bLB+g2+YTNssOuvczNAievJBi/K+1
         dVBdRFMQagjcc/rV440HSzj7kp0EGC3hc8IeS0t/W5qxtfAz7ZLx17InREQeCjeqQ7Bl
         ti5Yjn+PxnDXQVqDb4Bd/MWM8ZkTqOw7TgI1DfFyKefV9YctdmiPbGKwyTiE5Zi2F5Vz
         EGAOP/o+jUarOZp7OwMOh3usjF4eqpqgkLVT5fGf8lo6jYdDa8hvf6hu87agLxIEGNFJ
         wVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z0UzZ5f8qH4TrSdNis7AXNzMMu7IdaZPv0vS8xnPW3I=;
        b=QVVNiTpliHFG3QXWutBSuBFPhNcftSlXrNTiWDs6LZolCCIJJZrW5SryK+f4odriQl
         VjL2/5SEnw/wVe2UnJUN9APmjh1Mku1qXAmXPMqv5g5tqpv4wkbvMgxGKq+N2SEbxykp
         EZqU8fssjVc/agG2qycJLjoST9HL4D892jral6/dxW3E6HZD6mHsyn3ZrnPj5CxYLqL+
         W6S7nJkcOHZtdgi7iCRqLydtcesHGMm3BYwYV0HaLuT5MotT0xRkdo/ViDQDLYG18e2J
         k/eFp6NcE8o1jZPfPfWsNek6RX/5Lg1Z76t5CN5SmDMlUWMvciErjozBPvXYgizdlCHO
         U0Lg==
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
Subject: [PATCH 4.9 201/241] powerpc/modules: Dont try to restore r2 after a sibling call
Date: Mon, 19 Mar 2018 19:07:46 +0100
Message-Id: <20180319180759.506954903@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391625449125176?=
X-GMAIL-MSGID: =?utf-8?q?1595391625449125176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -30,6 +30,7 @@ int patch_branch(unsigned int *addr, uns
 int patch_instruction(unsigned int *addr, unsigned int instr);
 
 int instr_is_relative_branch(unsigned int instr);
+int instr_is_relative_link_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
 unsigned long branch_target(const unsigned int *instr);
 unsigned int translate_branch(const unsigned int *dest,
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -494,7 +494,17 @@ static bool is_early_mcount_callsite(u32
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
@@ -95,6 +95,11 @@ int instr_is_relative_branch(unsigned in
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
