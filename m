Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A5C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535EF20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535EF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeIMNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:55:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeIMNzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8238C049D7F;
        Thu, 13 Sep 2018 08:47:12 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-220.brq.redhat.com [10.40.204.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59BBA5D6AA;
        Thu, 13 Sep 2018 08:47:10 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
References: <20180912161119.2692-1-vkuznets@redhat.com>
        <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
Date:   Thu, 13 Sep 2018 10:47:08 +0200
In-Reply-To: <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
        (Rafael J. Wysocki's message of "Thu, 13 Sep 2018 09:06:49 +0200")
Message-ID: <875zz9ainn.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Sep 2018 08:47:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> It is possible to observe hung_task complaints when system goes to
>> suspend-to-idle state:
>>
>>  PM: Syncing filesystems ... done.
>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>  OOM killer disabled.
>>  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>>  sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>  INFO: task bash:1569 blocked for more than 120 seconds.
>>        Not tainted 4.19.0-rc3_+ #687
>>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>  bash            D    0  1569    604 0x00000000
>>  Call Trace:
>>   ? __schedule+0x1fe/0x7e0
>>   schedule+0x28/0x80
>>   suspend_devices_and_enter+0x4ac/0x750
>>   pm_suspend+0x2c0/0x310
>
> This actually is a good catch, but the problem is related to what
> happens to the monotonic clock during suspend to idle.
>
> The clock issue needs to be addressed anyway IMO and then this problem
> will go away automatically.

Do I understand it correctly that the suggestion is to fully suspend
monothonic clock in s2idle (and don't advance it after resume)?

>
>> Register a PM notifier to disable the detector on suspend and re-enable
>> back on wakeup.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> RFC: It really makes me wonder why nobody reported this before, makes
>>  me think I'm missing something.
>> ---
>>  kernel/hung_task.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index b9132d1269ef..d75f288c016f 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/lockdep.h>
>>  #include <linux/export.h>
>>  #include <linux/sysctl.h>
>> +#include <linux/suspend.h>
>>  #include <linux/utsname.h>
>>  #include <linux/sched/signal.h>
>>  #include <linux/sched/debug.h>
>> @@ -242,6 +243,24 @@ void reset_hung_task_detector(void)
>>  }
>>  EXPORT_SYMBOL_GPL(reset_hung_task_detector);
>>
>> +static bool hung_detector_suspended;
>> +
>> +static int hungtask_pm_notify(struct notifier_block *self,
>> +                             unsigned long action, void *hcpu)
>> +{
>> +       switch (action) {
>> +       case PM_SUSPEND_PREPARE:
>
> You'd want PM_HIBERNATION_PREPARE here too I think.
>
>> +               hung_detector_suspended = true;
>> +               break;
>> +       case PM_POST_SUSPEND:
>
> And PM_POST_HIBERNATION here for consistency.
>

Sure, will do in v1.

>> +               hung_detector_suspended = false;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +       return NOTIFY_OK;
>> +}
>> +
>>  /*
>>   * kthread which checks for tasks stuck in D state
>>   */
>> @@ -261,7 +280,8 @@ static int watchdog(void *dummy)
>>                 interval = min_t(unsigned long, interval, timeout);
>>                 t = hung_timeout_jiffies(hung_last_checked, interval);
>>                 if (t <= 0) {
>> -                       if (!atomic_xchg(&reset_hung_task, 0))
>> +                       if (!atomic_xchg(&reset_hung_task, 0) &&
>> +                           !hung_detector_suspended)
>>                                 check_hung_uninterruptible_tasks(timeout);
>>                         hung_last_checked = jiffies;
>>                         continue;
>> @@ -275,6 +295,10 @@ static int watchdog(void *dummy)
>>  static int __init hung_task_init(void)
>>  {
>>         atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>> +
>> +       /* Disable hung task detector on suspend */
>> +       pm_notifier(hungtask_pm_notify, 0);
>> +
>>         watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
>>
>>         return 0;
>> --
>> 2.14.4
>>

-- 
  Vitaly
