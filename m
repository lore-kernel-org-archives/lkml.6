Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD475C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC320222E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfBOWPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfBOWPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:15:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7E7222D7;
        Fri, 15 Feb 2019 22:15:40 +0000 (UTC)
Date:   Fri, 15 Feb 2019 17:15:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190215171539.4682f0b4@gandalf.local.home>
In-Reply-To: <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 09:55:32 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Feb 15, 2019 at 9:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > From: Changbin Du <changbin.du@gmail.com>
> >
> > The userspace can ask kprobe to intercept strings at any memory address,
> > including invalid kernel address.  
> 
> Again, this is not about a "kernel address" at all.
> 
> It's neither a kernel address _nor_ a user address.  It's an invalid
> address entirely, and there is nothing that makes it "kernel".
> 
> Please don't talk about "invalid kernel addresses" when it is no such thing.
> 

Ah, I see what you are saying. The example of the bug that the patch
fixed used a non-canonical address, which is "garbage", and not kernel
or user space. Point taken.

But the issue is deeper than that. This code never bugged until the
following commit was added:

9da3f2b7405 "x86/fault: BUG() when uaccess helpers fault on kernel addresses"

Before that commit, this worked fine.

In fact, we can trigger the same bug (with a slightly different
message), if we use a kernel space address.

To test this, I added the following variable somewhere in the code:

 void *sdr_ptr = 0xffffffff70112200;

And then did the following:

# echo 'p:fault do_sys_open arg=+0(@sdr_ptr):string' > /debug/tracing/kprobe_events

Which will read the sdr_ptr variable just like the example did with +0(+0(%si)):string.
But this time I control the what address it is triggered on.

And it crashed with:

[ 1447.876799] BUG: pagefault on kernel address 0xffffffff70112200 in non-whitelisted uaccess

The above message in the bug in the patch was:
"BUG: GPF in non-whitelisted uaccess (non-canonical address?)"

[ 1447.885053] BUG: unable to handle kernel paging request at ffffffff70112200
[ 1447.891997] #PF error: [normal kernel read fault]
[ 1447.896695] PGD 8a212067 P4D 8a212067 PUD 0 
[ 1447.900679] BUG: pagefault on kernel address 0xffffffff70112200 in non-whitelisted uaccess
[ 1447.900967] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1447.913394] CPU: 7 PID: 1688 Comm: cat Not tainted 5.0.0-rc5-test+ #28
[ 1447.919905] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[ 1447.928843] RIP: 0010:process_fetch_insn+0x1a0/0x470
[ 1447.933804] Code: ff f0 80 48 03 80 83 80 18 1a 00 00 01 31 c9 eb 10 48 83 c2 01 85 c0 75 1f 81 f9 ff 0f 00 00 7f 17 0f 1f 00 0f ae e8 44 89 e0 <40> 8a 32 0f 1f 00 83 c1 01 40 84 f6 75 d9 65 48 8b 14 25 00 5c 01
[ 1447.952520] RSP: 0018:ffffb77b80673d08 EFLAGS: 00010246
[ 1447.957736] RAX: 0000000000000000 RBX: ffff91bfb7ab2c30 RCX: 0000000000000000
[ 1447.964857] RDX: ffffffff70112200 RSI: ffffffff97267a80 RDI: 00007ffffffff000
[ 1447.971981] RBP: 0000000000000000 R08: ffffffff70112200 R09: ffff91c014518000
[ 1447.979105] R10: ffff91c01451801c R11: ffff91c0185e5800 R12: 0000000000000000
[ 1447.986226] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1447.993342] FS:  0000000000000000(0000) GS:ffff91c01a9c0000(0000) knlGS:0000000000000000
[ 1448.001417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1448.007157] CR2: ffffffff70112200 CR3: 00000000b3f32004 CR4: 00000000001606e0
[ 1448.014280] Call Trace:
[ 1448.016737]  kprobe_trace_func+0x278/0x360
[ 1448.020834]  ? preempt_count_sub+0x98/0xe0
[ 1448.024931]  ? do_sys_open+0x5/0x220
[ 1448.028503]  kprobe_dispatcher+0x36/0x50
[ 1448.032426]  ? do_sys_open+0x1/0x220
[ 1448.036002]  kprobe_ftrace_handler+0xb5/0x120
[ 1448.040356]  ftrace_ops_assist_func+0x87/0x110
[ 1448.044797]  0xffffffffc06a30bf
[ 1448.047939]  ? __ia32_sys_open+0x20/0x20
[ 1448.051860]  ? do_syscall_64+0x1c/0x160
[ 1448.055694]  ? do_sys_open+0x1/0x220
[ 1448.059268]  do_sys_open+0x5/0x220
[ 1448.062672]  do_syscall_64+0x60/0x160
[ 1448.066335]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Which triggered on the address: 0xffffffff70112200

Which is perfectly canonical.

The reason I use "kernel address" is because this became an issue after
"x86/fault: BUG() when uaccess helpers fault on kernel addresses" was
added and that explicitly states "kernel address".

That patch added:

+       /*
+        * This is a faulting memory access in kernel space, on a kernel
+        * address, in a usercopy function. This can e.g. be caused by improper
+        * use of helpers like __put_user and by improper attempts to access
+        * userspace addresses in KERNEL_DS regions.
+        * The one (semi-)legitimate exception are probe_kernel_{read,write}(),
+        * which can be invoked from places like kgdb, /dev/mem (for reading)
+        * and privileged BPF code (for reading).
+        * The probe_kernel_*() functions set the kernel_uaccess_faults_ok flag
+        * to tell us that faulting on kernel addresses, and even noncanonical
+        * addresses, in a userspace accessor does not necessarily imply a
+        * kernel bug, root might just be doing weird stuff.
+        */
+       if (current->kernel_uaccess_faults_ok)
+               return false;
+
+       /* This is bad. Refuse the fixup so that we go into die(). */
+       if (trapnr == X86_TRAP_PF) {
+               pr_emerg("BUG: pagefault on kernel address 0x%lx in non-whitelisted uaccess\n",
+                        fault_addr);
+       } else {
+               pr_emerg("BUG: GPF in non-whitelisted uaccess (non-canonical address?)\n");
+       }

Where this path triggered by the kprobe using copy_from_user(). So
yeah, it can happen if it triggered on a non-canonical address (which is
just garbage), but it can also trigger if it's a kernel address that
isn't mapped either.

So the comment in the code is not 100% accurate, because it isn't just
a kernel address, but also a non-canonical one. Something tells me that
the change log of the commit that checks this isn't written well
either. What exactly can't be done now with uaccess code? I'm guessing
that it should only be allowed to fault on user space addresses? So
should I change this commit log to:

 kprobe: Do not use uaccess function to access non-user address that can fault

And change all the "kernel address" mentions to "non-user address" as
non-user covers both kernel address and non-canonical?


-- Steve

This patch allows me to modify the sdr_ptr as well from the tracing directory:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2cf3c747a357..292fe2ef0a45 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7928,6 +7928,45 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
+void *sdr_ptr = 0xffffffff70112200;
+
+static ssize_t
+sdr_ptr_read(struct file *filp, char __user *ubuf,
+	       size_t cnt, loff_t *ppos)
+{
+	char buf[64];
+	int r;
+
+	r = sprintf(buf, "%px\n", sdr_ptr);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+sdr_ptr_write(struct file *filp, const char __user *ubuf,
+		size_t cnt, loff_t *ppos)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 0, &val);
+	if (ret)
+		return ret;
+
+	sdr_ptr = val;
+
+	(*ppos)++;
+
+	return cnt;
+}
+
+static const struct file_operations sdr_ptr_fops = {
+	.open		= tracing_open_generic,
+	.read		= sdr_ptr_read,
+	.write		= sdr_ptr_write,
+	.llseek		= default_llseek,
+};
+
 struct dentry *trace_instance_dir;
 
 static void
@@ -8188,6 +8227,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	struct trace_event_file *file;
 	int cpu;
 
+	trace_create_file("sdr_ptr", 0644, d_tracer,
+			NULL, &sdr_ptr_fops);
+
 	trace_create_file("available_tracers", 0444, d_tracer,
 			tr, &show_traces_fops);
 
