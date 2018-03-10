Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs83HdRDatRTPl6Bab7yXhxbHcZAR/DKucHFo18fu1LFmYgRtW6BR1eKYg7sQxxPIFK3rVM
ARC-Seal: i=1; a=rsa-sha256; t=1520641261; cv=none;
        d=google.com; s=arc-20160816;
        b=V35mM4MxGlNWjup4ZIdvyQfcB65LTYu93Yw1dRKANUVzIZhyEf5cCeQwabp9nEe/uZ
         Hr3joAb2iso/09wl8/5ltmpou34IUEB8uo0qV3U1cGnYEdmG4Y0knxLFxf8meVgQHt67
         9qHq0LkzC3gvZVV0k9UlA1AiB3QjhF4tJzC4SNjQyuUepr3+ZKxRZ/BnkYwKN6LVQIhU
         ks8fd4Vxh4MDrqXTNQtj/Og9dd5Wvup9DHZ2dIwSKn7gFD/Ah0If1FKHESsnwSchU8h/
         Y/d2Zqs5YKBDqgIDBXtuJ5Ukdulm38cb9pZML7ngOPKxOp8NArKbnFljj6hkNl3ADW8g
         ZMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RYNECrt1jIGILlQjCQIVmDA3Cdehq3a7NLidrQqqOAg=;
        b=cO6ke4hLD35YCs4MB/YrUbEmRvWo2bI00tny7LoFSqBEnmKRl/FgCuR1xeesNEUW7v
         GN8f0m4G5HZoiHipG+yrCwT1APp5dpEq0Pyl9ls5Ruuf1/nSC+On9ZLwnYpwnX22b+Be
         /eML2CXXSUE2JO6TLg7r6Aobsx7UX9y1yNwUv5VefxW5zUWdXEWO7CWH5WMJdOwNfdIT
         MKGCuLFiDgwD7nCATiTFt18ueOWaIcOC2e499a6mwrthgCo2tZCVjMI8vglbehVmDWQy
         6dW5JVLjeUInVw3K64gSXXlaflEloOh3BPcNeLmbahgzZDj5631qApAUfOXkuFfpCzZR
         OLig==
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
Subject: [PATCH 4.9 11/65] timers: Forward timer base before migrating timers
Date: Fri,  9 Mar 2018 16:18:11 -0800
Message-Id: <20180310001825.831610645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507931699146337?=
X-GMAIL-MSGID: =?utf-8?q?1594507931699146337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1884,6 +1884,12 @@ int timers_dead_cpu(unsigned int cpu)
 		spin_lock_irq(&new_base->lock);
 		spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
+		/*
+		 * The current CPUs base clock might be stale. Update it
+		 * before moving the timers over.
+		 */
+		forward_timer_base(new_base);
+
 		BUG_ON(old_base->running_timer);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
