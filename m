Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583CCC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170A92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3fORnA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170A92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJaA7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:59:14 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37645 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeJaA7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:59:13 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so14328277ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NPVWYEJRQQKNVCb5tkmbpUkncCOOz9lvepIVk2pGNqo=;
        b=i3fORnA4nVEeeq5wjOfbNOb2RcYwRihBBEzQPKfw64OQabZY/zDgOvbAk4EsYHrgBC
         ZYlm4YxX+7fJrx0HG7TqZNKLnBd1AQX420WbrSP+Oeh8wfRn2XBM73Po91PyvD3+dMXI
         m+gu0aowYY+Foz/JQbQN1jfWecHPLr6DJNU/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NPVWYEJRQQKNVCb5tkmbpUkncCOOz9lvepIVk2pGNqo=;
        b=ploztvtRBMSNNsheT/6I2eaNx4mptUjSGdaZG64UGJijtoZ5FbjN1I6OLtxA4QJMdk
         t3kVp1edteY0n9AQnWyIJzz64KgS0HNV3k2QwTxVRvWEHfYzj+mhi8kcse5ECx3xzE6J
         t/0069PJNnHLOBV5EW6JzfLOe2yhj/lh4aQb5qwkslrhRR5WTQYAp5M2pt9GUNJPzjEM
         JHMDn7/DgLMRWTcZ/uOAy7nzzsbkr9VNSEGoKcVq0/H9NCFrgpOm1+qzSw0l1oU0qRpJ
         Mcg1R4muiNJE2xvLCHBT9eQDTdcNUU/DRTclx695KbL/lWizChUvLaHoQlABJp9MmetU
         cxlA==
X-Gm-Message-State: AGRZ1gLbNCcBy1KuAX0SNTaQDEtrDcSPObHqz9RsTmcyys36CmiMZloD
        C+Sh3xQQjqol3SXqu0tt/JxvS/Ze8VeRxngJl+UzNA==
X-Google-Smtp-Source: AJdET5d2R51CV518ziAaIqXvpXERz795a/FDPPeV2vzjYBaJCkfyXwBTZVEJb2lLljXjqudOosnY6OdrGJAS7VHvCxA=
X-Received: by 2002:a02:2b29:: with SMTP id h41-v6mr13267565jaa.12.1540915509326;
 Tue, 30 Oct 2018 09:05:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 09:04:28 -0700 (PDT)
In-Reply-To: <3881A95A-CDDE-4C69-859F-C1F92F0C5724@canonical.com>
References: <20181024084958.4627-1-kai.heng.feng@canonical.com>
 <20181024084958.4627-3-kai.heng.feng@canonical.com> <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
 <E8BC3191-E48C-423C-B704-929F7FAC4930@canonical.com> <CAPDyKFrNBH5jrfF9M_BcTr9JfzAxj0doaQU7V4o5sJRp1=7P4w@mail.gmail.com>
 <3881A95A-CDDE-4C69-859F-C1F92F0C5724@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Oct 2018 17:04:28 +0100
Message-ID: <CAPDyKFqQiT=mSw3yo_0nx0mpXCWC0tggxvWYMtEqatB-U=b9yQ@mail.gmail.com>
Subject: Re: [PATCH 2/4 v5] memstick: Prevent memstick host from getting
 runtime suspended during card detection
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 October 2018 at 16:23, Kai Heng Feng <kai.heng.feng@canonical.com> wr=
ote:
>
>
>> On Oct 30, 2018, at 21:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 29 October 2018 at 17:31, Kai Heng Feng <kai.heng.feng@canonical.com>=
 wrote:
>>>
>>>
>>>> On Oct 29, 2018, at 20:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>
>>>> On 24 October 2018 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.co=
m> wrote:
>>>>> We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
>>>>> helpers to let memstick host support runtime pm.
>>>>>
>>>>> There's a small window between memstick_detect_change() and its queue=
d
>>>>> work, memstick_check(). In this window the rpm count may go down to z=
ero
>>>>> before the memstick host powers on, so the host can be inadvertently
>>>>> suspended.
>>>>>
>>>>> Increment rpm count before calling memstick_check(), and decrement rp=
m
>>>>> count afterward, as now we are sure the memstick host should be
>>>>> suspended or not.
>>>>>
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>> drivers/memstick/core/memstick.c | 4 ++++
>>>>> 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core=
/memstick.c
>>>>> index 76382c858c35..5f16a8826401 100644
>>>>> --- a/drivers/memstick/core/memstick.c
>>>>> +++ b/drivers/memstick/core/memstick.c
>>>>> @@ -18,6 +18,7 @@
>>>>> #include <linux/delay.h>
>>>>> #include <linux/slab.h>
>>>>> #include <linux/module.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>
>>>>> #define DRIVER_NAME "memstick"
>>>>>
>>>>> @@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_d=
ev *card)
>>>>> */
>>>>> void memstick_detect_change(struct memstick_host *host)
>>>>> {
>>>>> +       pm_runtime_get_noresume(host->dev.parent);
>>>>>       queue_work(workqueue, &host->media_checker);
>>>>> }
>>>>> EXPORT_SYMBOL(memstick_detect_change);
>>>>> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *wo=
rk)
>>>>>               host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OF=
F);
>>>>>
>>>>>       mutex_unlock(&host->lock);
>>>>> +
>>>>> +       pm_runtime_put(host->dev.parent);
>>>>>       dev_dbg(&host->dev, "memstick_check finished\n");
>>>>> }
>>>>>
>>>>
>>>> I am not sure this works, sorry.
>>>>
>>>> More precisely, I don't think there is a guarantee that the calls to
>>>> pm_runtime_get|put*() becomes properly balanced. In principle
>>>> memstick_detect_change() could be called, without actually causing a
>>>> new work to be scheduled if there is already such a work in the queue
>>>> (depends on the workqueue configuration). Isn't it so?
>>>
>>> You are right.
>>>
>>> We can use test_and_set_bit() or alike to properly balance pm_runtime
>>> helpers, but the most straightforward solution in my mind is to merge
>>> memstick_detect_change() and memstick_check() as one function.
>>>
>>> memstick_detect_change() it=E2=80=99s the only user of memstick_check()=
 anyway.
>>
>> I suspect memstick_detect_change() is supposed to be called by host
>> drivers, when they receive some kind of notification due to a card
>> being inserted or removed. I guess that happen (at least
>> hypothetically) also from atomic (IRQ) context.
>>
>> As memstick_check() is doing hole bunch of operations, I am not sure
>> bypassing the work-queue is a good idea, if that is what you are
>> proposing.
>
> Okay, it=E2=80=99s better to keep it that way.
>
>>
>>>
>>> Or is there a better way in your mind?
>>
>> I don't know.
>>
>> Well, I am not sure I understand why you need to call
>> pm_runtime_get_noresume() from memstick_detect_change() in the first
>> place. Could you explain that in more detail?
>
> I guess it didn=E2=80=99t explain it well enough in the log, let me add s=
ome detail:
> There's a small window between memstick_detect_change() and its queued
> work, memstick_check(). In this window the rpm count may go down to zero
> before the memstick host powers on, where I use
> pm_runtime_get_noresume() to increment the rpm count.
>
> memstick_check() uses some functions in rtsx_usb_ms that have
> pm_runtime_put*() so the rpm count may go down to zero, before the
> memstick host powers on.

So then, why doesn't memstick_check() early on calls
pm_runtime_get_sync() and when it has finished with probing for a
card, balance that with a call pm_runtime_put()?

Kind regards
Uffe
