Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsWN5XDT9ps/et0i1x3f4354ByvCfDRVDzWoBbdfkck1PcNQo2DDn9V3LJuV/a2THOJptNi
ARC-Seal: i=1; a=rsa-sha256; t=1520824100; cv=none;
        d=google.com; s=arc-20160816;
        b=X4pZ+t/v6UjJA2oGHPGGp00luaMcEa3vkKKyIwYOnwX7ADw/juvlMMTbi1oljx+Li0
         jm/5HBLmHgMjAUbjEzHkq2N++Ow4DQOGZxBvcwkDKvPx4ZpbeVGg4DrQS/AI+Ba0trga
         zOjlx/rTHspz2+g6nrIQuDjOmLom7lsbwfmFjJg/TYGWFanCGRymzBVULqfWdv38+pj9
         B68+9vEXoFQHrY/abnfA0Rk5xs3EIQfK4pHJ1QEtRDzwIoG/74qObQluPEJaLFxFnsFi
         3qbyaRxW98ZSbi0lp+ChVGdhuUrUUazpPrrjLKjFmXeXLs85yv5jF+ijVwgD7L5ZfMEm
         Udmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=eBeF187xS0fwJXMpoHAETTT1R5OHy+/bAoREht6BTy4=;
        b=ZlKtlm9MZ9Y2RUH6cd6QTy2ChdlLjO53TpEfp72S4Ylnx9cUf68BALnQ5h9knVQMkE
         CREPnEch3muehyErLjTIXgVh/1BeRPZfgZGhX1M2cncyYGBx5Ly2iyqzrpdSFZzhdNvC
         Ee1CikxkrTGvXtP9yju/m85/qW3FxyqP+ezIjKAk4Yo5BvWlHaK4Kjw3/sZFHzMBD866
         XFR41YapyVLWm/NLxbptrvIKXNxINPbKJbNys1saSsyumCLEwhm8szNyn0JaqRImFyBO
         5BeFAZ0P7jyKEMjZTrvu+4HBzJez9KsSKMrOWKoRMqFbmETJDM+MdhpQte8GqVIQrUtY
         Bk7Q==
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
 "Ananth N Mavinakayanahalli" <ananth@linux.vnet.ibm.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.709477170@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 37/76] kprobes/x86: Disable optimizing on the
 function jumps to indirect thunk
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699636667812144?=
X-GMAIL-MSGID: =?utf-8?q?1594699651821223578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/kprobes/opt.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -36,6 +36,7 @@
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/debugreg.h>
+#include <asm/nospec-branch.h>
 
 #include "common.h"
 
@@ -191,7 +192,7 @@ static int copy_optimized_instructions(u
 }
 
 /* Check whether insn is indirect jump */
-static int insn_is_indirect_jump(struct insn *insn)
+static int __insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] == 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) == 4) || /* Jump */
@@ -225,6 +226,26 @@ static int insn_jump_into_range(struct i
 	return (start <= target && target <= start + len);
 }
 
+static int insn_is_indirect_jump(struct insn *insn)
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
 static int can_optimize(unsigned long paddr)
 {
