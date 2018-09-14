Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8706AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0F120671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0F120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeINTem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINTel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:34:41 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 164C2307D855;
        Fri, 14 Sep 2018 14:19:59 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E962308BDA6;
        Fri, 14 Sep 2018 14:19:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
References: <20180913160851.18169-1-vkuznets@redhat.com>
        <4793718.OcKebjM5bH@aspire.rjw.lan>
Date:   Fri, 14 Sep 2018 16:19:52 +0200
In-Reply-To: <4793718.OcKebjM5bH@aspire.rjw.lan> (Rafael J. Wysocki's message
        of "Fri, 14 Sep 2018 13:26:13 +0200")
Message-ID: <87d0tg88l3.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 14 Sep 2018 14:19:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
...

>> +static int hungtask_pm_notify(struct notifier_block *self,
>> +			      unsigned long action, void *hcpu)
>> +{
>> +	switch (action) {
>> +	case PM_SUSPEND_PREPARE:
>> +	case PM_HIBERNATION_PREPARE:
>> +		hung_detector_suspended = true;
>> +		break;
>> +	case PM_POST_SUSPEND:
>> +	case PM_POST_HIBERNATION:
>> +		hung_detector_suspended = false;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>>  /*
>>   * kthread which checks for tasks stuck in D state
>>   */
>> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
>>  		interval = min_t(unsigned long, interval, timeout);
>>  		t = hung_timeout_jiffies(hung_last_checked, interval);
>
> Since you are adding the notifier anyway, what about designing it to make
> the thread wait on _PREPARE until the notifier kicks it again on exit
> fron suspend/hibernation?
>

We can either park the kthread (kthread_park/unpark) or make it go away
completely by doing kthread_stop/kthread_run(). I'm leaning toward
parking, what do you think?

-- 
  Vitaly
