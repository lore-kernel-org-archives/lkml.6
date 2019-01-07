Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19639C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89AA206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAGM2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:28:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:50323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfAGM2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:28:52 -0500
Received: from homer.simpson.net ([185.191.219.245]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSIf1-1gqdH51Snb-00TQFL; Mon, 07
 Jan 2019 13:28:36 +0100
Message-ID: <1546864114.26963.5.camel@gmx.de>
Subject: Re: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Tom Putzeys <tom.putzeys@be.atlascopco.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 07 Jan 2019 13:28:34 +0100
In-Reply-To: <20190107102613.GC2861@worktop.programming.kicks-ass.net>
References: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
         <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
         <20190107102613.GC2861@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i2OVe3B7igDtX6NP4GE5vpkEDrlu9BtHrNyKf7wt0CjhiXalQIy
 4wmmpO8x3fnvv4eHvatLaHV9TjA8fIOsg1U4sAjv1bzfv/GxU9CLVdFRO9J2NhmqCoZ7MHV
 YtoSvm0PRZXSbxCoQPdLLnvi/M5UupTKw4XMbqHsSv3zi64AX/YnI10lTO1Czxx8f+QSaIj
 cEqT61kiVD6LHtuy3C1Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dui2zXgoigM=:w+T0s0yvQ5qi89zeUKTbtm
 MmXP2V4pAUYs3x9NxKIv8moX9HgBf7QFfQeRa5uUC/tIBhb11vziFiXdwkdbthsJ+uYCJiUXG
 e5cwzTfykAE/Zmd+vjagVzUPhwZfWjwWw1Q1U8w+gtYQnZ0V7LRDnt94nOIYhDjwqDuBgcYj8
 NdIg9RnMhWZGdov+VlDW623E+Ej9hAHM4DrefAJQcAbdbZkN2h579jr42BtCBzKVcdAYmW/WV
 1JPbw2SPDhPlpARxePeeHP9ic95XOEKixL/4FDM1bN3PrJ543Ed9OhkOMIDsd6E+Hq8VkbIxL
 x6QVD49HfvhDRsjj2XQ3NE24CbYwrObJluRW0pZxtH4wr4TNQihvuaw2Hh49XQZFAGvIlcHW8
 8yHp4Tg/1QcoZopT+m2eE523Mga2kQnWWGI9adjQs/rDqwi5ZYSvfjGyCpPKVZqYyKp2N5CfZ
 MBG9u+XhjrfN/8ZPOqoV4MlaRYBWsIT2GhNVjLhA8ibkUXFdVl0zbo89Bp1PsS5B6cvkzfrMs
 T2YU3Ui9mNzKDeSy+9T0WllefANYB51sHzQrNZSSc1Ntpkb7OdmfL0nYVb4FnYpYc3gqMy26g
 Oo7J+uJAtd7EdUUOlhMy5GRnTJnoe5HUaViNkFKNEcxaEHXWKIc5VC6FSnFbCjFAjdDnIBSoP
 vUZvnFtuHXMKaHoLq8k7pOSBpd7+Lfz2FnkW5RGNtVBHmHnF42ZROgUdD/fZQjsb6tgdAC0kr
 OlFer2dHa965cX08FaJX7XCZ6wyP2dcnJxwCzX8cm348N/TLLXs2WormT2ftdM5Iu2VQbzlnd
 pJ0M7xtmHN+SV3ycCOUEQZEMHzc29QjJZ+nA+suKm6bqGykYA6IXnrEevH7UP3LLalk+gFRuu
 9zX/nzTzj17REV6cvbntZ/TpZzxPXMC/UoSJsWtzmefLi6WV5FBUyt8Pk8ZEaU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 11:26 +0100, Peter Zijlstra wrote:
> 
> I would expect lockdep you also complain about this...

And grumble it did.

commit df7e8acc0c9a84979a448d215b8ef889efe4ac5a
Author: Mike Galbraith <efault@gmx.de>
Date:   Fri May 4 08:14:38 2018 +0200

    sched/fair: Fix CFS bandwidth control lockdep DEADLOCK report
    
    CFS bandwidth control yields the inversion gripe below, moving
    handling quells it.
    
    |========================================================
    |WARNING: possible irq lock inversion dependency detected
    |4.16.7-rt1-rt #2 Tainted: G            E
    |--------------------------------------------------------
    |sirq-hrtimer/0/15 just changed the state of lock:
    | (&cfs_b->lock){+...}, at: [<000000009adb5cf7>] sched_cfs_period_timer+0x28/0x140
    |but this lock was taken by another, HARDIRQ-safe lock in the past: (&rq->lock){-...}
    |and interrupts could create inverse lock ordering between them.
    |other info that might help us debug this:
    | Possible interrupt unsafe locking scenario:
    |       CPU0                    CPU1
    |       ----                    ----
    |  lock(&cfs_b->lock);
    |                               local_irq_disable();
    |                               lock(&rq->lock);
    |                               lock(&cfs_b->lock);
    |  <Interrupt>
    |    lock(&rq->lock);
    
    Cc: stable-rt@vger.kernel.org
    Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Signed-off-by: Mike Galbraith <efault@gmx.de>
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 960ad0ce77d7..420624c49f38 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5007,9 +5007,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 }
 
