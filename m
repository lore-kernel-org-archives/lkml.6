Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsFeYduDu/bBFplBzy4abxSNjCE+pPA6oMVc7G6UN2y9x+eM9txaD+7bpXGcOx+FAB2x0xS
ARC-Seal: i=1; a=rsa-sha256; t=1520451621; cv=none;
        d=google.com; s=arc-20160816;
        b=EEbSU+m0R4AEI/KcIwRKbyQV9Jgc8E+jj5fuJ1ZBI2aWJBNd8CvT+b8akWYBG/5v6X
         qo9BJn5eu+FP6Zz0iDDesF1z7Qu4ROyXAPv/LAmB5hmyk7TS844RnLsbc6VQcIIP1ST0
         yMYDv7yfC/2aQ480twfLFabGe3JnuJGNlZ5yDoLPlm7YC35C8MCjg0bv/lV6oYnT55Fz
         +cHAcm6+2qY19Sc74aJgga3iGlh4bzbQlB2GGmP9cKmT1KvhCrdHuMrc/Cnrug0PZXj0
         VKuuvrSPeLyE9de/CLOMXxxy+sdlu4JXsYrCq0EWmxMieAruw76dv6BO52704DkCsolj
         6Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NmLXz9TWVlREB/XBud/nVBsZ/1ZbLKQlLecrVLzWbF4=;
        b=t4qKQDD5QiSckO73FfRM7jMXj1XI1jtO6nRU6TCLArOKfDB5qXvu+Cpq98pqZF9cxa
         gEzf322ljtitLwnEzgFT+utuk83qJfA8jEzOm+lLKqs/UoCLFFjQUsl/h70ycO4jWyre
         RpfiUMYXIcF/+bf+5/Zxaj/rdA1zOsvlX83OHzU+sZxFtquj+wskNSo+YVlTlWCCOoVB
         atACI9XFZLb8oDF35yqUSar7psReUtilylu6BrsZ/fxs5HNQKLGIufAo/gkV8Wq20Ypw
         o77yKYZ8M/D+XmNtzwkLaKgyuvAWAVn9yXXa4bN1CtRadSZlkF+JwSbfSntazLAidz/j
         GuVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Neeraj Upadhyay <neeraju@codeaurora.org>,
	Lingutla Chandrasekhar <clingutla@codeaurora.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 4.15 023/122] timers: Forward timer base before migrating timers
Date: Wed,  7 Mar 2018 11:37:15 -0800
Message-Id: <20180307191732.694358714@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309079274815920?=
X-GMAIL-MSGID: =?utf-8?q?1594309079274815920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

commit c52232a49e203a65a6e1a670cd5262f59e9364a0 upstream.

On CPU hotunplug the enqueued timers of the unplugged CPU are migrated to a
live CPU. This happens from the control thread which initiated the unplug.

If the CPU on which the control thread runs came out from a longer idle
period then the base clock of that CPU might be stale because the control
thread runs prior to any event which forwards the clock.

In such a case the timers from the unplugged CPU are queued on the live CPU
based on the stale clock which can cause large delays due to increased
granularity of the outer timer wheels which are far away from base:;clock.

But there is a worse problem than that. The following sequence of events
illustrates it:

 - CPU0 timer1 is queued expires = 59969 and base->clk = 59131.

   The timer is queued at wheel level 2, with resulting expiry time = 60032
   (due to level granularity).

 - CPU1 enters idle @60007, with next timer expiry @60020.

 - CPU0 is hotplugged at @60009

 - CPU1 exits idle and runs the control thread which migrates the
   timers from CPU0

   timer1 is now queued in level 0 for immediate handling in the next
   softirq because the requested expiry time 59969 is before CPU1 base->clk
   60007

 - CPU1 runs code which forwards the base clock which succeeds because the
   next expiring timer. which was collected at idle entry time is still set
   to 60020.

   So it forwards beyond 60007 and therefore misses to expire the migrated
   timer1. That timer gets expired when the wheel wraps around again, which
   takes between 63 and 630ms depending on the HZ setting.

Address both problems by invoking forward_timer_base() for the control CPUs
timer base. All other places, which might run into a similar problem
(mod_timer()/add_timer_on()) already invoke forward_timer_base() to avoid
that.

[ tglx: Massaged comment and changelog ]

Fixes: a683f390b93f ("timers: Forward the wheel clock whenever possible")
Co-developed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180118115022.6368-1-clingutla@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/timer.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1886,6 +1886,12 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_irq(&new_base->lock);
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
+		/*
+		 * The current CPUs base clock might be stale. Update it
+		 * before moving the timers over.
+		 */
+		forward_timer_base(new_base);
+
 		BUG_ON(old_base->running_timer);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
