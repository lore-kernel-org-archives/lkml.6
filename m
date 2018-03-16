Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuxFB1nUScpKnoxiL58oVz4brgtNKgMVHsGblK/D18ODifUaV235tOzLFthxCV93tKcLj9n
ARC-Seal: i=1; a=rsa-sha256; t=1521214368; cv=none;
        d=google.com; s=arc-20160816;
        b=F0wHzQQuHDDzCLuYkvP1GEWTqeUFxpiQZoxnChFVE4V5IelCHeccUDxwwiD14rrPxN
         ulR+4S/kdu1tCCRuhqSR1FYz8Ctg/lK1CMbfOWBSwuSSzNC6vs0zICOBd4kz2kfWhUF5
         z9EQefanAD7GxmwWvdDJG+Y9CkQR+ZczoXyQiVMT7HYALR1NphCyMlSC4XcT0pBlV0ZV
         dTToj2llP5i47E0sMn/6/uEUxsKUtNvuz2JAZz3Q9ab42p/hDCyU/x6Tea0gc92OqqGC
         4y2PRhZ1EhUFSTI+qNUjg971E51MHGs2XZic7iBx18M57JDGdXmeejt6ez9weKc3Zd/N
         i3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UdpBa96UFw5E81eJ8tuxvYai6KGkacfNt1V4Oozds3E=;
        b=MGwmzB6TK74AvNyMe5HFYDJGvt0/qtRPlvynxrWtBgnGwT/iOVUn8xW929eyVeJyiG
         xjOj4+YEIgujRQ3ml48RS69xf/nEk6y1vBC6qXF/Zyqua1t8wfIfFz8otcDlXCRW7Epv
         A3u/keNa8Om7ke54PLLxKcBhzVZhZ/UbhJcSwU9LQSA138rC3cSidQKy8kS4eGNIe2t0
         HUGoSoThisr/UVkOoo0XlzN8b5tQ+fyqbYQfYRVlxhUr5f2DKLJCnVjQi0ErL6LpQnae
         Bj9R7GhWypmX1oB++7+trabs7Rrc3jcZD3LqdwIinh5/l6aB/d1NaooW3XvZqaK8uwvh
         tGOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	jeyu@kernel.org,
	live-patching@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.9 69/86] x86/module: Detect and skip invalid relocations
Date: Fri, 16 Mar 2018 16:23:32 +0100
Message-Id: <20180316152322.014506339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108487521219025?=
X-GMAIL-MSGID: =?utf-8?q?1595108878297148549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit eda9cec4c9a12208a6f69fbe68f72a6311d50032 upstream.

There have been some cases where external tooling (e.g., kpatch-build)
creates a corrupt relocation which targets the wrong address.  This is a
silent failure which can corrupt memory in unexpected places.

On x86, the bytes of data being overwritten by relocations are always
initialized to zero beforehand.  Use that knowledge to add sanity checks
to detect such cases before they corrupt memory.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jeyu@kernel.org
Cc: live-patching@vger.kernel.org
Link: http://lkml.kernel.org/r/37450d6c6225e54db107fba447ce9e56e5f758e9.1509713553.git.jpoimboe@redhat.com
[ Restructured the messages, as it's unclear whether the relocation or the target is corrupted. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/module.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -171,19 +171,27 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		case R_X86_64_NONE:
 			break;
 		case R_X86_64_64:
+			if (*(u64 *)loc != 0)
+				goto invalid_relocation;
 			*(u64 *)loc = val;
 			break;
 		case R_X86_64_32:
+			if (*(u32 *)loc != 0)
+				goto invalid_relocation;
 			*(u32 *)loc = val;
 			if (val != *(u32 *)loc)
 				goto overflow;
 			break;
 		case R_X86_64_32S:
+			if (*(s32 *)loc != 0)
+				goto invalid_relocation;
 			*(s32 *)loc = val;
 			if ((s64)val != *(s32 *)loc)
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+			if (*(u32 *)loc != 0)
+				goto invalid_relocation;
 			val -= (u64)loc;
 			*(u32 *)loc = val;
 #if 0
@@ -199,6 +207,11 @@ int apply_relocate_add(Elf64_Shdr *sechd
 	}
 	return 0;
 
+invalid_relocation:
+	pr_err("x86/modules: Skipping invalid relocation target, existing value is nonzero for type %d, loc %p, val %Lx\n",
+	       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
+	return -ENOEXEC;
+
 overflow:
 	pr_err("overflow in relocation type %d val %Lx\n",
 	       (int)ELF64_R_TYPE(rel[i].r_info), val);
