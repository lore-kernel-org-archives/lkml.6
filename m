Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeCMHI2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:08:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeCMHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:08:27 -0400
Date: Tue, 13 Mar 2018 00:07:45 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f2d6fdbfd2389a38598d448cb8dc09d946c1b87e@git.kernel.org>
Cc: tglx@linutronix.de, dmitry.torokhov@gmail.com,
        sergey.senozhatsky@gmail.com, mingo@kernel.org, prarit@redhat.com,
        john.stultz@linaro.org, hpa@zytor.com, torvalds@linux-foundation.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org, salyzyn@android.com,
        peterz@infradead.org, mtk.manpages@gmail.com, pmladek@suse.com,
        kevin@guarana.org, rostedt@goodmis.org
Reply-To: john.stultz@linaro.org, prarit@redhat.com, mingo@kernel.org,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de,
        dmitry.torokhov@gmail.com, rostedt@goodmis.org, kevin@guarana.org,
        pmladek@suse.com, mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, salyzyn@android.com, corbet@lwn.net,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180301165150.155899327@linutronix.de>
References: <20180301165150.155899327@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] Input: Evdev - unify MONOTONIC and BOOTTIME clock
 behavior
Git-Commit-ID: f2d6fdbfd2389a38598d448cb8dc09d946c1b87e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f2d6fdbfd2389a38598d448cb8dc09d946c1b87e
Gitweb:     https://git.kernel.org/tip/f2d6fdbfd2389a38598d448cb8dc09d946c1b87e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:34 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:22 +0100

Input: Evdev - unify MONOTONIC and BOOTTIME clock behavior

Now that the MONOTONIC and BOOTTIME clocks are indentical, remove all the
special casing.

The user space visible interfaces still support both clocks, but their behavior
is identical.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-input@vger.kernel.org
Link: http://lkml.kernel.org/r/20180301165150.155899327@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/input/evdev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d01d93..46115a392098 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -31,7 +31,6 @@
 enum evdev_clock_type {
 	EV_CLK_REAL = 0,
 	EV_CLK_MONO,
-	EV_CLK_BOOT,
 	EV_CLK_MAX
 };
 
@@ -198,12 +197,10 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	case CLOCK_REALTIME:
 		clk_type = EV_CLK_REAL;
 		break;
+	case CLOCK_BOOTTIME:
 	case CLOCK_MONOTONIC:
 		clk_type = EV_CLK_MONO;
 		break;
-	case CLOCK_BOOTTIME:
-		clk_type = EV_CLK_BOOT;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -314,8 +311,6 @@ static void evdev_events(struct input_handle *handle,
 
 	ev_time[EV_CLK_MONO] = ktime_get();
 	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
-	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
-						 TK_OFFS_BOOT);
 
 	rcu_read_lock();
 
