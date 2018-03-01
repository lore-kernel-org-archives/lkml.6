Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033306AbeCAQw2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:52:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033014AbeCAQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:24 -0500
Message-Id: <20180301165150.155899327@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:34 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org
Subject: [RFC/RFT patch 3/7] Input: evdev - Conflate clock MONOTONIC and
 BOOTTIME
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=Input--evdev---Conflate-clock-MONOTONIC-and-BOOTTIME.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clock MONOTONIC and BOOTTIME are indentical remove all the special
casing. The user space visible interfaces still support both clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/evdev.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -31,7 +31,6 @@
 enum evdev_clock_type {
 	EV_CLK_REAL = 0,
 	EV_CLK_MONO,
-	EV_CLK_BOOT,
 	EV_CLK_MAX
 };
 
@@ -198,12 +197,10 @@ static int evdev_set_clk_type(struct evd
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
@@ -314,8 +311,6 @@ static void evdev_events(struct input_ha
 
 	ev_time[EV_CLK_MONO] = ktime_get();
 	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
-	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
-						 TK_OFFS_BOOT);
 
 	rcu_read_lock();
 
