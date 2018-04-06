Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+NhFAy4Dsc9Lu8+Ingzx9kEn8XWunLj/bYD4NKP4rR18mIKEVCjT4hhApWlvwOXZFe1SSZ
ARC-Seal: i=1; a=rsa-sha256; t=1523021570; cv=none;
        d=google.com; s=arc-20160816;
        b=efy89sB7FYAmB+e2LyOBhnSTbS1ymel0LIXsHgVKQC/JyUrS+5995pTyQLVSedvxLm
         vw72QnJF88bmTthOhzZOM8qnWW/DlzTtFeIn6QmsnJLG6HE+fEmetAwzqFcVffe4tTzX
         7UbnUSxuogyCeersYcJbRidtUrwAIyHrjzOSSobZzTKFyQxTWtsS9Fc/oNmca7RtOLwj
         BSmgiQeJ52p5E8Rto7UgYOBRkTY71agd9nWiEFp5J6T0oLrNoi8XDzKFTRkn3bg0fE9e
         KTUIVwbij3DKomr3GWC7wYcpgUNqhXwz2x5HLJ3KpW+670aMukBIj7ktnZWvNskgPpGX
         U7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iYQmafe4lMDyyC+VtKJ8jXKLTjLwk4Ezbl8KAU49PgQ=;
        b=iY0cRG2J849olpDh/ip+0vxPcvlZvZkGEiuGTorjcRyZ4pIO+Z7JqDIfawL46yxoQC
         t9YQZOkmWIiSw/Gj6hNycnV8AScMjkoI1Yyep9IpP3XqNj8/xaT53Mz1PA1tmPiAiTJ5
         gk7oLuvwfWogkhfSnigpg9qR36NIZta2t5od+u1H14hkvPQdKpFgB16NJ6IHgGX/zC6u
         0C1zd+WZDvoYEUv0siZfaA17K11RGiTnmrAs+jfscICsfI2DEzPDLVRzUgCJFaDJPcSM
         j64d7s3HY7R4WDuTp9tHO84BzrIfnhQ+AFaBSh3Rba3Nic9raDWPMg3m8tOA9/T/fA94
         u3ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 012/102] kprobes/x86: Fix to set RWX bits correctly before releasing trampoline
Date: Fri,  6 Apr 2018 15:22:53 +0200
Message-Id: <20180406084333.316876044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003572131830119?=
X-GMAIL-MSGID: =?utf-8?q?1597003866305805855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit c93f5cf571e7795f97d49ef51b766cf25e328545 upstream.

Fix kprobes to set(recover) RWX bits correctly on trampoline
buffer before releasing it. Releasing readonly page to
module_memfree() crash the kernel.

Without this fix, if kprobes user register a bunch of kprobes
in function body (since kprobes on function entry usually
use ftrace) and unregister it, kernel hits a BUG and crash.

Link: http://lkml.kernel.org/r/149570868652.3518.14120169373590420503.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: d0381c81c2f7 ("kprobes/x86: Set kprobes pages read-only")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/core.c |    9 +++++++++
 kernel/kprobes.c               |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -51,6 +51,7 @@
 #include <linux/ftrace.h>
 #include <linux/frame.h>
 #include <linux/kasan.h>
+#include <linux/moduleloader.h>
 
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -405,6 +406,14 @@ int __copy_instruction(u8 *dest, u8 *src
 	return length;
 }
 
+/* Recover page to RW mode before releasing it */
+void free_insn_page(void *page)
+{
+	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
+	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
+	module_memfree(page);
+}
+
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	int ret;
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -125,7 +125,7 @@ static void *alloc_insn_page(void)
 	return module_alloc(PAGE_SIZE);
 }
 
-static void free_insn_page(void *page)
+void __weak free_insn_page(void *page)
 {
 	module_memfree(page);
 }
