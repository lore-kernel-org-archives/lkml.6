Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeDQVlc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbeDQVlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:41:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526BE2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 17 Apr 2018 17:41:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180417174128.0f3457f0@gandalf.local.home>
In-Reply-To: <20180417181304.GA2895@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
        <20180417172236.GA17342@light.dominikbrodowski.net>
        <20180417180430.GF3625@kernel.org>
        <20180417181304.GA2895@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 15:13:04 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Apr 17, 2018 at 03:04:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Apr 17, 2018 at 07:22:36PM +0200, Dominik Brodowski escreveu:  
> > > >   Added back original compare to not miss 32bit kernel syscalls  
> > > 
> > > s/32bit/32bit and 0-parameter syscalls.  
> > 
> > So this should have covered 0-parameter syscalls, ok, I'm double
> > checking that the last patch is the one I have running... Because
> > 0-parameter syscalls are not working for me, i.e. no
> > syscalls:sys_enter_getppid, for instance.  
> 
> Yeah, failing:
> 
> [root@jouet ~]# strace -e openat -e file perf test -F -v "mmap interface" |& grep syscalls
> openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getsid/format", O_RDONLY) = 3
> openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format", O_RDONLY) = -1 ENOENT (No such file or directory)
> [root@jouet ~]# 
> 
> [root@jouet ~]# ls -la /sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format
> ls: cannot access '/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format': No such file or directory
> [root@jouet ~]#
> 
> With:
> 
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> +static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> +{
> +       /*
> +        * Compare the symbol name with the system call name. Skip the
> +        * "__x64_sys" prefix.
> +        */
> +       return !strcmp(sym + 9, name + 3) || !strcmp(sym + 3, name + 3);
> +}
> 
> in place.

It doesn't have to do with the number of parameters, not everything has
"__x64" on it.

Try this patch:

-- Steve

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 09ad88572746..15582648887f 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -31,6 +31,19 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	/*
+	 * Compare the symbol name with the system call name. Skip the
+	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
+	 */
+	return !strcmp(sym + 3, name + 3) ||
+		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
+		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
+
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 struct dyn_arch_ftrace {
