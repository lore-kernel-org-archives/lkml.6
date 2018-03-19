Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvp8sz3zmvwblDbKLb++s0kGJzVBwx9l5bC13tlmYcZSiFoix19Y2Ehe8Mt0bGLrP9zXIEx
ARC-Seal: i=1; a=rsa-sha256; t=1521483180; cv=none;
        d=google.com; s=arc-20160816;
        b=fvB1YMYbyQ/lKpf0R9+BeD+0d6g96iGM+vDPvkDTSGfS5YSPJqeMY37s15m1OBub1v
         D8iXUy4yUHKizjhmhyGw2L0zNC/7xgE3wRVX69xVYKsdMzQfyt0GcpjpFXkXJwvHwXoy
         Mfyje9ydFlDMeu8/jwPhjL/tTIUbopl9Q8j2byhaxBo67uxah+JTKg+vB8tBmhqUKWnl
         4PntXIS6sFZx/X2aFpsA4B/nRjOCO5B8inCEw5m+tiEZ1IwC2aoplSj+zblOZMW6mgjZ
         0JmMjqbcXrA35RakirKd3eJkAqcF8nEQ+9KZvhwj0VrgzGS5004git9f80UsGRVAM4Ha
         0nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N+at5ppSPd3FQ83ZSPXaraLQ/2/NKEfmCu7Ri2WuBpk=;
        b=S57nVTqV9ruCYrrclgdv/TjAsiDO+J70bMMmZORcgB2cg3davpGk3OB49XPcFcBs+i
         tTGhHNnsAbXCzSsYwhGbKLGm8x14oJ7MLV2TMZuUGIx7tpg9lwwuPJvk/JO0M2Gx41RU
         9qkAsxomTqL+0ucDuXSqvioSuvV9IB2jJXLs2v8IiN9mP8QmyUsRZEHocdyOUCvpTfGP
         zC1Czy3lFoD7zDSC7eHiemioDKUFZDFEa2VSd/KDiQUHzA9KPD2QSlXhctLEHu4pIAld
         PhFhwtSGZbMq2bCOWaYxzz0UFW3tBTs9aSByLerDs+WmBnP5MKKQ9JD4WhNtofHwoZRq
         vdpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Hromatka <tom.hromatka@oracle.com>,
	Rob Gardner <rob.gardner@oracle.com>,
	John Stultz <john.stultz@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 028/134] sysrq: Reset the watchdog timers while displaying high-resolution timers
Date: Mon, 19 Mar 2018 19:05:11 +0100
Message-Id: <20180319171853.307322482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390747005815237?=
X-GMAIL-MSGID: =?utf-8?q?1595390747005815237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Hromatka <tom.hromatka@oracle.com>


[ Upstream commit 0107042768658fea9f5f5a9c00b1c90f5dab6a06 ]

On systems with a large number of CPUs, running sysrq-<q> can cause
watchdog timeouts.  There are two slow sections of code in the sysrq-<q>
path in timer_list.c.

1. print_active_timers() - This function is called by print_cpu() and
   contains a slow goto loop.  On a machine with hundreds of CPUs, this
   loop took approximately 100ms for the first CPU in a NUMA node.
   (Subsequent CPUs in the same node ran much quicker.)  The total time
   to print all of the CPUs is ultimately long enough to trigger the
   soft lockup watchdog.

2. print_tickdevice() - This function outputs a large amount of textual
   information.  This function also took approximately 100ms per CPU.

Since sysrq-<q> is not a performance critical path, there should be no
harm in touching the nmi watchdog in both slow sections above.  Touching
it in just one location was insufficient on systems with hundreds of
CPUs as occasional timeouts were still observed during testing.

This issue was observed on an Oracle T7 machine with 128 CPUs, but I
anticipate it may affect other systems with similarly large numbers of
CPUs.

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timer_list.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/nmi.h>
 
 #include <asm/uaccess.h>
 
@@ -96,6 +97,9 @@ print_active_timers(struct seq_file *m,
 
 next_one:
 	i = 0;
+
+	touch_nmi_watchdog();
+
 	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
 
 	curr = timerqueue_getnext(&base->active);
@@ -207,6 +211,8 @@ print_tickdevice(struct seq_file *m, str
 {
 	struct clock_event_device *dev = td->evtdev;
 
+	touch_nmi_watchdog();
+
 	SEQ_printf(m, "Tick Device: mode:     %d\n", td->mode);
 	if (cpu < 0)
 		SEQ_printf(m, "Broadcast device\n");
