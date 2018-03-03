Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520107256; cv=none;
        d=google.com; s=arc-20160816;
        b=aT68aCVpzuubTqoh2Fg+TgsoWvGp053PSFcp9HAYeDrs+Zonkduchz/xPlNZ8dtTFB
         teyJBmTF6xKBKZC9LiuG3ETje7JwvLDI7jJpMwPqlyAGfqjRDUswT8spC09OVw4LYsfp
         osMn1Om/LwgKdKXXsrH4zE7EoU2DgZydk+LU8NTilZPZm6dWhYKkKUFxqkHPkHsJjwSw
         FFPPIN/PqYxrfxkZfpqRHNBQO3cD2w1t4YIc3eurivEh2nSLs48NMOSfrMmVy4syE24v
         5x65kBWZMqwc4EEMFHeguwZd9fnwGMhvQQQ/2xKIQ2XTI+wd4qhzOlGLeSSIA/0XlxvU
         kgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=8xTH0Qn4FJjVArEZhiC6i5hOYrV8Y7yi6fh09pqZCmU=;
        b=htHYWbxNaMQ96cu/L6PlAGpfoUiH8kRa+0dozGi5q4X0ZspnZZ39T0JB1z5Hqx/4/K
         xSO4nVHojLrJ8YUx//PBwlTlieDZwGwUJrQIaCJ4a4AijCkCDB2A5oU6lyH5J9DfAY8v
         LXeyL4O9hqoHAAdTNSkKd+Bl4KoxZHSMFYPrqqDo1Vkw4dd0Ka4eV3sQpqZvgMUTHbHN
         pWdeutikh7hipSmAMbdb8jptBl8ZwzWnTsd49IgfJW3Wgeg9Ffeobo+NmZmgfgbFckcr
         4kmd9vYKRQgywN0H63n7ZsUQMTnFokHijpqy3kJZp2V1z6Wgru26TmrJgTDAiKjzHvPQ
         T0UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AG47ELuIj0Ui2Y+kadCiozi136we21nmNlr3UWy1DHDDri0FybDbykBc5OOMJXOsUT5IOqpHQb+1dw==
From: Alexander Popov <alex.popov@linux.com>
To: kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	alex.popov@linux.com
Subject: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
Date: Sat,  3 Mar 2018 23:00:29 +0300
Message-Id: <1520107232-14111-5-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1593947986518331727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Make STACKLEAK erase kernel stack after ptrace/seccomp/auditing
not to leave any sensitive information on the stack for the syscall code.

This code is modified from Brad Spengler/PaX Team's code in the last
public patch of grsecurity/PaX based on our understanding of the code.
Changes or omissions from the original code are ours and don't reflect
the original grsecurity/PaX code.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 arch/x86/entry/common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 74f6eee..b4be776 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -46,6 +46,12 @@ __visible inline void enter_from_user_mode(void)
 static inline void enter_from_user_mode(void) {}
 #endif
 
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+asmlinkage void erase_kstack(void);
+#else
+static void erase_kstack(void) {}
+#endif
+
 static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
 {
 #ifdef CONFIG_X86_64
@@ -128,6 +134,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	do_audit_syscall_entry(regs, arch);
 
+	erase_kstack();
 	return ret ?: regs->orig_ax;
 }
 
-- 
2.7.4
