Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvkJyZL7BPSTqOkYLmxFI3qiFLDIp2wLJpksLQor/EgoKGTOjxKaNVZix/lAST4yTbsylqB
ARC-Seal: i=1; a=rsa-sha256; t=1520824086; cv=none;
        d=google.com; s=arc-20160816;
        b=ayUZaMm7IvlmVu24XWy+B4C/Z1i7CDMJFume4VeYDLxllTbIz9V2sL9ZhalvdTM7+G
         +E5du1QmWm5CV31kIDJzp7vp3UVuNxGQZfqUrfUE55MWYK5aDxeAU1/CS4HCEaJMQ+Yc
         +cKNcyI10FtNOHCE0ixQrAhEnj5TBb7RLxnobj+6cd7u0HXa86EoBIctUGU7c6Gp+xpL
         EFuPhWtnJTxgxw1Rr6X+Tc8I5FzwMOOOz29XADgd6/nCbrPpXb0aNB54c6nhmrt8cCZp
         lY7u0Qij1m3Q/rgiBajPNfSqed9brM8ChQ/qPrKhzeYdS2QPjmASg1xGoR1eyzi1K0TW
         tPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=K0yvTCT/7zo60RwOquuDRuow9Y1anGe4ABKOcCdZeUo=;
        b=HRIShyayTJEJtPnJRyJwXp1sslmEW7LI8QDp55DVklODvNo+jYj4mse6EGrQxh5Eqi
         0K0LdVZbjLICpKE52vXnSSmwM3gMT/+46sxleH76kWJKfrKKY8YfTQVDA/k/AniBdzoV
         5qxCllA+bxP3IpKMcM9kDeuAFlHkcI/zJ7Lq1THI0wiR6O+416V6lm4ilj8KnKq05sU6
         Ekd2QKdR7EnZAezgpoFyfb2tj4HLq/ZHPr5vTYKkFg5DYsB+SIsmbePmgkIbd7Xio9BJ
         zglvmCWCFskNAmiVG3DLnafXPKnQo59thKjrnrdPXxjDc1aogZQNYnxzEzYlCMVnoZeX
         +fhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ananth N Mavinakayanahalli" <ananth@linux.vnet.ibm.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.792574092@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 071/104] kprobes/x86: Disable optimizing on the
 function jumps to indirect thunk
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699636667812144?=
X-GMAIL-MSGID: =?utf-8?q?1594699636667812144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit c86a32c09f8ced67971a2310e3b0dda4d1749007 upstream.

Since indirect jump instructions will be replaced by jump
to __x86_indirect_thunk_*, those jmp instruction must be
treated as an indirect jump. Since optprobe prohibits to
optimize probes in the function which uses an indirect jump,
it also needs to find out the function which jump to
__x86_indirect_thunk_* and disable optimization.

Add a check that the jump target address is between the
__indirect_thunk_start/end when optimizing kprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/151629212062.10241.6991266100233002273.stgit@devbox
[bwh: Backported to 3.2:
 - Include  __kprobes in both function declarations
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/kprobes.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes.c
+++ b/arch/x86/kernel/kprobes.c
@@ -58,6 +58,7 @@
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/debugreg.h>
+#include <asm/nospec-branch.h>
 
 void jprobe_return_end(void);
 
@@ -1256,7 +1257,7 @@ static int __kprobes copy_optimized_inst
 }
 
 /* Check whether insn is indirect jump */
-static int __kprobes insn_is_indirect_jump(struct insn *insn)
+static int __kprobes __insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] == 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) == 4) || /* Jump */
@@ -1290,6 +1291,26 @@ static int insn_jump_into_range(struct i
 	return (start <= target && target <= start + len);
 }
 
+static int __kprobes insn_is_indirect_jump(struct insn *insn)
+{
+	int ret = __insn_is_indirect_jump(insn);
+
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
+	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
+	 * older gcc may use indirect jump. So we add this check instead of
+	 * replace indirect-jump check.
+	 */
+	if (!ret)
+		ret = insn_jump_into_range(insn,
+				(unsigned long)__indirect_thunk_start,
+				(unsigned long)__indirect_thunk_end -
+				(unsigned long)__indirect_thunk_start);
+#endif
+	return ret;
+}
+
 /* Decode whole function to ensure any instructions don't jump into target */
 static int __kprobes can_optimize(unsigned long paddr)
 {
