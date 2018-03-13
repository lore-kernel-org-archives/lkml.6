Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCMC5R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 22:57:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33862 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeCMC5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 22:57:16 -0400
X-Google-Smtp-Source: AG47ELtyiyae4fMKQTrGbYVRE1/LLUyIacZmtenMIhC+Zb+pEgt+wFDIS2H3nWijvTl7KRdN74+hBg==
Subject: Re: [PATCH] net: hns: use put_device() if device_register fail
To: Richard Weinberger <richard.weinberger@gmail.com>
References: <fa970be78de11dee1a217c9a75ab0850f1780e0c.1520591977.git.arvind.yadav.cs@gmail.com>
 <20180312.104323.14368638452528082.davem@davemloft.net>
 <5AA6AA84.6040001@gmail.com>
 <CAFLxGvw1U2OZn4kU1O6uJ17yWYf1deE=+Cr56Foffdq7Q=5u3A@mail.gmail.com>
Cc: David Miller <davem@davemloft.net>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, linyunsheng@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-mtd@lists.infradead.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AA73E06.1050604@gmail.com>
Date: Tue, 13 Mar 2018 08:27:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw1U2OZn4kU1O6uJ17yWYf1deE=+Cr56Foffdq7Q=5u3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 12 March 2018 10:59 PM, Richard Weinberger wrote:
> On Mon, Mar 12, 2018 at 5:27 PM, arvindY <arvind.yadav.cs@gmail.com> wrote:
>>
>> On Monday 12 March 2018 08:13 PM, David Miller wrote:
>>> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> Date: Fri,  9 Mar 2018 16:11:17 +0530
>>>
>>>> if device_register() returned an error! Always use put_device()
>>>> to give up the reference initialized.
>>>>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> I do not see anything giving cls_dev an initial non-zero reference
>>> count before this device_register() call.
>> Yes,  you are correct there is nothing to release (hnae_release).
> Wait, this is not what DaveM said.
> Since you sent also patches to MTD I care about this too.
>
> Do we have to call put_device() in any case after a failure of
> device_register() or not?
> In this case the release function is empty, so nothing is going to released.
> But technically a put_device() is needed and correct according to your
> change log.
>
> I have to admit I don't know all details of the driver core, maybe you
> can help me.
> device_register() calls device_initialize() followed by device_add().
> device_initialize() does a kobject_init() which again sets the
> reference counter to 1 via kref_init().
> In the next step device_add() does a get_device() --> reference
> counter goes up to 2.
> But in the exit path of the function a put_device() is done, also in
> case of an error.
> So device_register() always returns with reference count 1.
>
> If I understand this correctly a put_device() is mandatory.
> Also in this driver.
> Can you please enlighten me? :-)
>
Oh, I just miss understood david question.

But what ever you are telling that is correct.
device_initialize() will call kref_init() which is setting
refcount 1 by refcount_set(&kref->refcount, 1).
and device_add() will call kref_get() to increment refcount
by calling refcount_inc(&kref->refcount).
So we need put_device() to decrement and release the
kboject.
Internally it'll call kref_put() -> refcount_dec_and_test(&kref->refcount)
to decrement refcount.

~arvind
