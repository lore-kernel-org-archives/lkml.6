Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1326C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C392080A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfBOFzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:55:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:7405 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfBOFzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:55:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 21:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,371,1544515200"; 
   d="scan'208";a="275245723"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2019 21:55:17 -0800
Date:   Fri, 15 Feb 2019 13:56:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v4] panic: Avoid the extra noise dmesg
Message-ID: <20190215055654.gelhlfni5wboftdx@shbuild888>
References: <1544176279-77828-1-git-send-email-feng.tang@intel.com>
 <20181210131729.04b8e0d3@gandalf.local.home>
 <CAGXu5jJrC5J7YNJ24JNNkNTRr7qRfQa+x+dePC0OOrpcEJFwaA@mail.gmail.com>
 <20181211083230.x6s44wsgfgijl4ws@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211083230.x6s44wsgfgijl4ws@pathway.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Dec 11, 2018 at 09:32:30AM +0100, Petr Mladek wrote:
> On Mon 2018-12-10 10:49:22, Kees Cook wrote:
> > On Mon, Dec 10, 2018 at 10:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri,  7 Dec 2018 17:51:19 +0800
> > > Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > > When kernel panic happens, it will first print the panic call stack,
> > > > then the ending msg like:
> > > >
> > > > [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> > > > [   35.749975] ------------[ cut here ]------------
> > > >
> > > > The above message are very useful for debugging.
> > > >
> > > > But if system is configured to not reboot on panic, say the "panic_timeout"
> > > > parameter equals 0, it will likely print out many noisy message like
> > > > WARN() call stack for each and every CPU except the panic one, messages
> > > > like below:
> > >
> > >
> > > > Keeping the interrupt disabled will avoid the noisy message.
> > > >
> > > > When code runs to this point, it means user has chosed to not reboot, or
> > > > do any special handling by using the panic notifier method, the only reason
> > > > to enable the interrupt may be sysrq migic key and panic_blink function
> > > > (though may not work even with irq enabled).
> > > >
> > > > So make the irq disabled by default and add a cmdline parameter
> > > > "panic_keep_irq_on" to turn it on when needed.
> > > >
> > > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > >
> > >
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > I'm fine with the new boot param, but I think we need to leave it how
> > it was by default: systems that want to see the blinking aren't going
> > to have a screen to read about what boot param they need to add.
> > Currently, we'll blink and spew extra warnings. With this patch we'll
> > not blink and not spew: a headless machine will have no indication
> > that a panic happened.
> 
> Just to be sure, in case, you did not follow the other long
> discussion.
> 
> I had an alternative approach to switch printk() into nop at
> this panic() stage. It can be restored when sysrq is triggered.
> This approach allows to keep blinking and sysrq working. People
> debugging the blinking would need to block this change but it
> should be rare.
> 
> I do not resist on my solution. It looks a bit hacky. But it
> is simple and rather straightforward.
 
Sorry for the late response.

So currently, there are 2 proposals:
1. this v4 patch of "panic_keep_irq_on" flag (default off to be same
   as the current kernel behavior)
2. Petr's suggestion of adding a flag to suppress printk after enterring
   late panic phase (blinking time), while keeping the sysrq printk
   working.

Following is the draft patch based on Petr's suggestion:

Please review, thanks. I'm fine with both solutions.

- Feng

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078..8921fed 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -528,6 +528,11 @@ void __handle_sysrq(int key, bool check_mask)
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
 	int i;
+	int old_val;
+
+	/* save the old panic printk flag */
+	old_val = panic_suppress_printk;
+	panic_suppress_printk = 1;
 
 	rcu_sysrq_start();
 	rcu_read_lock();
@@ -574,6 +579,8 @@ void __handle_sysrq(int key, bool check_mask)
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();
+
+	panic_suppress_printk = old_val;
 }
 
 void handle_sysrq(int key)
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e..4120f3a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -534,6 +534,7 @@ extern int panic_on_io_nmi;
 extern int panic_on_warn;
 extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_panic_on_stackoverflow;
+extern int panic_suppress_printk;
 
 extern bool crash_kexec_post_notifiers;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index f121e6b..0cd3a1b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -46,6 +46,8 @@ int panic_on_warn __read_mostly;
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
+int panic_suppress_printk;
+
 #define PANIC_PRINT_TASK_INFO		0x00000001
 #define PANIC_PRINT_MEM_INFO		0x00000002
 #define PANIC_PRINT_TIMER_INFO		0x00000004
@@ -326,6 +328,7 @@ void panic(const char *fmt, ...)
 	}
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+	panic_suppress_printk = 1;
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d1703..c27bbf5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1987,6 +1987,9 @@ asmlinkage __visible int printk(const char *fmt, ...)
 	va_list args;
 	int r;
 
+	if (unlikely(panic_suppress_printk))
+		return 0;
+
 	va_start(args, fmt);
 	r = vprintk_func(fmt, args);
 	va_end(args);
