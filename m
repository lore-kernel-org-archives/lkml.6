Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A50ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E319021523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E319021523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbeIUS75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeIUS75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:59:57 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79DA55F74A;
        Fri, 21 Sep 2018 13:11:08 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 608C1308BDB2;
        Fri, 21 Sep 2018 13:11:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Date:   Fri, 21 Sep 2018 15:11:00 +0200
In-Reply-To: <20180917165518.GA25931@redhat.com> (Oleg Nesterov's message of
        "Mon, 17 Sep 2018 18:55:18 +0200")
Message-ID: <87d0t70zdn.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 21 Sep 2018 13:11:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/17, Rafael J. Wysocki wrote:
>>
>> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > > > Since you are adding the notifier anyway, what about designing it to make
>> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
>> > > > fron suspend/hibernation?
>> >
>> > Well. I agree that freezable kthreads are not nice, but it seems you are
>> > going to add another questionable interface ;)
>>
>> Why would it be questionable?
>>
>> The watchdog needs to be disarmed somehow before tasks are frozen and
>> re-armed after they have been thawed or it may report false-positives
>> on the way out.  PM notifiers can be used for that.
>
> Or watchdog() can simply use set_freezable/freezing interface we already
> have, without additional complications.
>
> Yes, this is not "before tasks are frozen", but probably should work?
>
> OK, I won't argue.

I was hoping you and Rafael will come to an agreement but the discussion
just died ... so where do we stand on this? I see the following options:

1) The v1 patch is good, no freezing/disabling/parking required.
2) Make the kthread freezable (btw, I tested your patch and it seems to
work).
3) kthread_stop/kthread_run() (as you said 'no parking').
4) Drop the patch and wait for the root cause (increasing jiffies) to
dissolve.
5) ???

Ideas?

-- 
  Vitaly
