Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB54C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000120823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RR+iPN6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1000120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJ3V5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:57:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37126 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeJ3V5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:57:10 -0400
Received: by mail-io1-f65.google.com with SMTP id k17-v6so7165041ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L50WYu95ZsTrfqeq0D2iAQvToMiptoqOy+m+FvITWuQ=;
        b=RR+iPN6nso7Mm3txF22VsmBNh2A7p/7TURzel3tpjqrtx9HPYkMgIjBk7MY2xngl+I
         3xD0a+W0Nq/yVMbOv3mRxfCgTkmMztJJTLWTGBlvwn4uqbuRM8Iw28YL60AH+Bbx/SHb
         fOdUWBDz18w2mjszHEyOKwCQY8pUf1IGhLOiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L50WYu95ZsTrfqeq0D2iAQvToMiptoqOy+m+FvITWuQ=;
        b=NUIS3IshrUNNPMKn7JVrdLo3MNoQqklxds7ErdVbFIO0GhNylv5CzJXJseY2uEwj7C
         lvrtp8cMo5wRJ3ihS+yvheZrVr/QAN13NRWEEaBsS0c1sX7uI40moh5yaqtw3q+qMBmP
         NcPsNdXGSEPmBqkv1+Q60rYCtI/EodMF1X82SZmG7RJNt3/fx8/jXodx+5uiuUvjvQ1N
         LxR8y1iihQ6Okw+1ftDubWob4FZa/WuA88Z4bvyTQ6j1FWZ4KsF0cu2YdDicGamjbLPM
         nUSXLgssXxlu/CeD5XyElw0LHiAAC39bYiOgu1G6xD/IsBh//Ie00p13zx165Eiu5p2G
         FtMg==
X-Gm-Message-State: AGRZ1gJZVjhveJiZclfZFIFQXcDRyKRuLgJDOtRIZqoi/C+l5Bh1eNlb
        kR7SkmyuHuVRfEMCZj4h9xiEkfUkIETQgeJXFT5ODA==
X-Google-Smtp-Source: AJdET5eLs12An0YAFv/5JvsxJhp6mgkSXNw7LDd1DJDAA4Wh5azi5ntjQa1arvf0rds5QUi7VrnteX5Gk6Cs45Xe6EA=
X-Received: by 2002:a6b:8fca:: with SMTP id r193-v6mr11802789iod.266.1540904628656;
 Tue, 30 Oct 2018 06:03:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 06:03:08 -0700 (PDT)
In-Reply-To: <E8BC3191-E48C-423C-B704-929F7FAC4930@canonical.com>
References: <20181024084958.4627-1-kai.heng.feng@canonical.com>
 <20181024084958.4627-3-kai.heng.feng@canonical.com> <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
 <E8BC3191-E48C-423C-B704-929F7FAC4930@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Oct 2018 14:03:08 +0100
Message-ID: <CAPDyKFrNBH5jrfF9M_BcTr9JfzAxj0doaQU7V4o5sJRp1=7P4w@mail.gmail.com>
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

On 29 October 2018 at 17:31, Kai Heng Feng <kai.heng.feng@canonical.com> wr=
ote:
>
>
>> On Oct 29, 2018, at 20:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 24 October 2018 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com>=
 wrote:
>>> We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
>>> helpers to let memstick host support runtime pm.
>>>
>>> There's a small window between memstick_detect_change() and its queued
>>> work, memstick_check(). In this window the rpm count may go down to zer=
o
>>> before the memstick host powers on, so the host can be inadvertently
>>> suspended.
>>>
>>> Increment rpm count before calling memstick_check(), and decrement rpm
>>> count afterward, as now we are sure the memstick host should be
>>> suspended or not.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> drivers/memstick/core/memstick.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/m=
emstick.c
>>> index 76382c858c35..5f16a8826401 100644
>>> --- a/drivers/memstick/core/memstick.c
>>> +++ b/drivers/memstick/core/memstick.c
>>> @@ -18,6 +18,7 @@
>>> #include <linux/delay.h>
>>> #include <linux/slab.h>
>>> #include <linux/module.h>
>>> +#include <linux/pm_runtime.h>
>>>
>>> #define DRIVER_NAME "memstick"
>>>
>>> @@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_dev=
 *card)
>>>  */
>>> void memstick_detect_change(struct memstick_host *host)
>>> {
>>> +       pm_runtime_get_noresume(host->dev.parent);
>>>        queue_work(workqueue, &host->media_checker);
>>> }
>>> EXPORT_SYMBOL(memstick_detect_change);
>>> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work=
)
>>>                host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF=
);
>>>
>>>        mutex_unlock(&host->lock);
>>> +
>>> +       pm_runtime_put(host->dev.parent);
>>>        dev_dbg(&host->dev, "memstick_check finished\n");
>>> }
>>>
>>
>> I am not sure this works, sorry.
>>
>> More precisely, I don't think there is a guarantee that the calls to
>> pm_runtime_get|put*() becomes properly balanced. In principle
>> memstick_detect_change() could be called, without actually causing a
>> new work to be scheduled if there is already such a work in the queue
>> (depends on the workqueue configuration). Isn't it so?
>
> You are right.
>
> We can use test_and_set_bit() or alike to properly balance pm_runtime
> helpers, but the most straightforward solution in my mind is to merge
> memstick_detect_change() and memstick_check() as one function.
>
> memstick_detect_change() it=E2=80=99s the only user of memstick_check() a=
nyway.

I suspect memstick_detect_change() is supposed to be called by host
drivers, when they receive some kind of notification due to a card
being inserted or removed. I guess that happen (at least
hypothetically) also from atomic (IRQ) context.

As memstick_check() is doing hole bunch of operations, I am not sure
bypassing the work-queue is a good idea, if that is what you are
proposing.

>
> Or is there a better way in your mind?

I don't know.

Well, I am not sure I understand why you need to call
pm_runtime_get_noresume() from memstick_detect_change() in the first
place. Could you explain that in more detail?

Kind regards
Uffe
