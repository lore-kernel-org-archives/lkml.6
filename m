Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iCEjmQnnLoBHyfoUwCKOh5iWH0Jm6PWvQCHtfZ0j7hZjKTNMRJc7twBazr0Y0xW1g4fr0
ARC-Seal: i=1; a=rsa-sha256; t=1523021485; cv=none;
        d=google.com; s=arc-20160816;
        b=sJHq2QQUHKno7UNS/igquJ+Y/rmozRISNcCAwFnxgGmczVNt+uRq+ZS5aLcVIXtVVa
         CBs8Yo8GqtoKWds6CqBadtC4JwsVNeXtt9RSktRsaiislYWRJp9s6LZT3x+PA5zRIaR3
         pG/AqGoHDS43FT35exU5oIs8GHVQwrDzNJIwxIMfF0E+6zaq07x6wfmAcKAfNpC0AhgP
         VPE9tnzftEH+FQpLxDfASlnVDg6G8jmybzZm2qVTVGb2ZujgDDAMiCQ7s0FGLEplCtYn
         CS3R2KtG3JPZk6Au5iMB8CEbA/pKlosvsUJ7UVS+Wm6+yEyKCHeR2KSi/opmggakS/xM
         1kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wtMYfwA80O6ciTfvO63952xRHRZ2JcpWT2gO1PGpvwk=;
        b=nrMom3HjAfX+jHroQqUbik8mXV6jtciHkqFrqpSB5jUW8s9GJDP/4VvWIflkINaae1
         cWSbbMCtDZMIdY3+xhN7dKrFHZngFFu8pT4MyHWzihH7RU1vNl0I8x1J+V768nxvJscn
         b1aDyh4Zo3bIeQCg5/TjMw2tpppVvFgJtDUFz3j6LHASZ4GHEirIyQaoeg8PEW56UiwF
         XVl3oJeqy5FHA1H8c8w4bFK9aBa5uVNu4WWQtvxGWiUaSlLOmbaRqlA4QtUA26Bhybl6
         iYykGgTpGrA60SCFa2XUcLlnW9ckJZK9d7sY6by3DONVxgfGim9tAuUr3yMK3OfbB8ac
         e84w==
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
Subject: [PATCH 4.4 11/72] kprobes/x86: Fix to set RWX bits correctly before releasing trampoline
Date: Fri,  6 Apr 2018 15:23:12 +0200
Message-Id: <20180406084306.028363826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003572131830119?=
X-GMAIL-MSGID: =?utf-8?q?1597003777272357973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -49,6 +49,7 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
+#include <linux/moduleloader.h>
 
 #include <asm/cacheflush.h>
 #include <asm/desc.h>
@@ -402,6 +403,14 @@ int __copy_instruction(u8 *dest, u8 *src
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
