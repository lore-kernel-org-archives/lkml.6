Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D281EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8979021532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8979021532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390591AbeIUVHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390420AbeIUVHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 428CE792BB;
        Fri, 21 Sep 2018 15:18:29 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 907132010D0D;
        Fri, 21 Sep 2018 15:18:24 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
References: <20180913160851.18169-1-vkuznets@redhat.com>
        <4793718.OcKebjM5bH@aspire.rjw.lan>
        <87d0tg88l3.fsf@vitty.brq.redhat.com>
        <20180914162103.GA11171@redhat.com>
        <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
        <20180917165518.GA25931@redhat.com>
        <87d0t70zdn.fsf@vitty.brq.redhat.com>
        <CAJZ5v0jumjrJN2YgeuXK9eZ-JM2Vv73SFoH_71qZxyax24C+-Q@mail.gmail.com>
Date:   Fri, 21 Sep 2018 17:18:23 +0200
In-Reply-To: <CAJZ5v0jumjrJN2YgeuXK9eZ-JM2Vv73SFoH_71qZxyax24C+-Q@mail.gmail.com>
        (Rafael J. Wysocki's message of "Fri, 21 Sep 2018 15:15:40 +0200")
Message-ID: <878t3u281s.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 21 Sep 2018 15:18:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Fri, Sep 21, 2018 at 3:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > On 09/17, Rafael J. Wysocki wrote:
>> >>
>> >> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
>> >> >
>> >> > > > Since you are adding the notifier anyway, what about designing it to make
>> >> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
>> >> > > > fron suspend/hibernation?
>> >> >
>> >> > Well. I agree that freezable kthreads are not nice, but it seems you are
>> >> > going to add another questionable interface ;)
>> >>
>> >> Why would it be questionable?
>> >>
>> >> The watchdog needs to be disarmed somehow before tasks are frozen and
>> >> re-armed after they have been thawed or it may report false-positives
>> >> on the way out.  PM notifiers can be used for that.
>> >
>> > Or watchdog() can simply use set_freezable/freezing interface we already
>> > have, without additional complications.
>> >
>> > Yes, this is not "before tasks are frozen", but probably should work?
>> >
>> > OK, I won't argue.
>>
>> I was hoping you and Rafael will come to an agreement but the discussion
>> just died ... so where do we stand on this? I see the following options:
>>
>> 1) The v1 patch is good, no freezing/disabling/parking required.
>
> This would work IMO, but it also is somewhat wasteful to run this
> thread when "suspended", because it doesn't do anything then.
>
> Maybe you could simply force "timeout" to be zero for the "suspension"
> time?  That should effectively make the thread sleep then, right?
>

Right, we'll have to zero both interval and timeout (if we want to keep
the current logic picking the minimum of two). The following patch seems
to be working for me, I'll send it out as v2 if there're no objections:

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1269ef..ac6e8c9306bd 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/export.h>
 #include <linux/sysctl.h>
+#include <linux/suspend.h>
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
@@ -242,12 +243,14 @@ void reset_hung_task_detector(void)
 }
 EXPORT_SYMBOL_GPL(reset_hung_task_detector);
 
+static unsigned long hung_last_checked;
+
 /*
  * kthread which checks for tasks stuck in D state
  */
 static int watchdog(void *dummy)
 {
-	unsigned long hung_last_checked = jiffies;
+	hung_last_checked = jiffies;
 
 	set_user_nice(current, 0);
 
@@ -272,9 +275,40 @@ static int watchdog(void *dummy)
 	return 0;
 }
 
+static int hungtask_pm_notify(struct notifier_block *self,
+			      unsigned long action, void *hcpu)
+{
+	static unsigned long saved_timeout, saved_interval;
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+		saved_timeout = sysctl_hung_task_timeout_secs;
+		saved_interval = sysctl_hung_task_check_interval_secs;
+		sysctl_hung_task_timeout_secs = 0;
+		sysctl_hung_task_check_interval_secs = 0;
+		wake_up_process(watchdog_task);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+		sysctl_hung_task_timeout_secs = saved_timeout;
+		sysctl_hung_task_check_interval_secs = saved_interval;
+		hung_last_checked = jiffies;
+		wake_up_process(watchdog_task);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 static int __init hung_task_init(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+
+	/* Disable hung task detector on suspend */
+	pm_notifier(hungtask_pm_notify, 0);
+
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
 
 	return 0;

-- 
  Vitaly
