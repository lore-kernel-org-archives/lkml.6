Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zaQ4B+WXH6yC1luYG/ODb1qGDAIVzzejqo+tPjND4/BWmpd2DDGmgJAaxjUIDiHrHua9Y
ARC-Seal: i=1; a=rsa-sha256; t=1523021289; cv=none;
        d=google.com; s=arc-20160816;
        b=DEjIrlA9WlNCZgKMflWMD4wajJSVk9fKh/2oERt9X8wZZ8dmP1dZ2+9B7etGRsoZh2
         Zv8tLyNOIUJlB4Ssv01PFNH5Y5g8NONrHA0YndqRIraHrO6eugPYZARgMuyaMdCTULH3
         F3TflQqWJkCHiy0LygXAQ06DRLKgxP2rhQPXxNPesJL9n3qlz6sJobU9MzBbk1TXyJ8+
         DLy6H/TiDxmqWipla6ZSrNNWMI6zIGh4ylukH328IEAW8NcKP8YTdgBFDVfZ6J8OVASx
         H4TWYUdA8O97PbrkqZlaRC9EWzEhC6bKLxpD5MmSLu+OuXAWOhmXZKDl+ptzV/DjXphO
         6rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=33KV6FZ5MFWUHAakCNm83YHPzvWDNHY9CuZaX97+zzo=;
        b=thrxGOZA6K3+vP4LxD9bzgKImuHf3UbkX7D521dNcwmzZP+mWaCJI8bUXjHYZ6RKbW
         4aU55nrucjS6/YwVMnodDconPynKu6wPSsZGwdpsNLgHI9l35K8ydZ21oduMBVLoWnJX
         KSjvEwrQhYpeQy9TwxlLBs5QKKf+HoiKRyuoMRzTwbrA5EWP+r2/5DrHm9/CB1uCUS90
         DbmugKUEsr17K51asV21f0mpud5GD+0ZCDM3H52UbcX3hzFtsXurS2POS3nh1khC62IG
         aTfKRV808NWPdONK3Vfm6l+7u1gT4Er+oUYmcSoUM0pClQ1xwyYp9x5sgGS+WECBTPON
         vcRw==
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
Subject: [PATCH 3.18 49/93] kprobes/x86: Fix to set RWX bits correctly before releasing trampoline
Date: Fri,  6 Apr 2018 15:23:18 +0200
Message-Id: <20180406084227.057494571@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003572131830119?=
X-GMAIL-MSGID: =?utf-8?q?1597003572131830119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -374,6 +375,14 @@ int __copy_instruction(u8 *dest, u8 *src
 	return length;
 }
 
+/* Recover page to RW mode before releasing it */
+void free_insn_page(void *page)
+{
+	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
+	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
+	vfree(page);
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
 	module_free(NULL, page);
 }
