Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbeCLR3g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:29:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41422 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932624AbeCLR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:29:34 -0400
X-Google-Smtp-Source: AG47ELu0RzZID11N/ZjgEvA+xnvdBpMlz6AS+wkTU4KlLU2ZZ2XpfRkQdPVyMi8lJV4T7K3024TADZ/XUqGcKTxo4zM=
MIME-Version: 1.0
In-Reply-To: <5AA6AA84.6040001@gmail.com>
References: <fa970be78de11dee1a217c9a75ab0850f1780e0c.1520591977.git.arvind.yadav.cs@gmail.com>
 <20180312.104323.14368638452528082.davem@davemloft.net> <5AA6AA84.6040001@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 12 Mar 2018 18:29:32 +0100
Message-ID: <CAFLxGvw1U2OZn4kU1O6uJ17yWYf1deE=+Cr56Foffdq7Q=5u3A@mail.gmail.com>
Subject: Re: [PATCH] net: hns: use put_device() if device_register fail
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: David Miller <davem@davemloft.net>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, linyunsheng@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 5:27 PM, arvindY <arvind.yadav.cs@gmail.com> wrote:
>
>
> On Monday 12 March 2018 08:13 PM, David Miller wrote:
>>
>> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> Date: Fri,  9 Mar 2018 16:11:17 +0530
>>
>>> if device_register() returned an error! Always use put_device()
>>> to give up the reference initialized.
>>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>
>> I do not see anything giving cls_dev an initial non-zero reference
>> count before this device_register() call.
>
> Yes,  you are correct there is nothing to release (hnae_release).

Wait, this is not what DaveM said.
Since you sent also patches to MTD I care about this too.

Do we have to call put_device() in any case after a failure of
device_register() or not?
In this case the release function is empty, so nothing is going to released.
But technically a put_device() is needed and correct according to your
change log.

I have to admit I don't know all details of the driver core, maybe you
can help me.
device_register() calls device_initialize() followed by device_add().
device_initialize() does a kobject_init() which again sets the
reference counter to 1 via kref_init().
In the next step device_add() does a get_device() --> reference
counter goes up to 2.
But in the exit path of the function a put_device() is done, also in
case of an error.
So device_register() always returns with reference count 1.

If I understand this correctly a put_device() is mandatory.
Also in this driver.
Can you please enlighten me? :-)

-- 
Thanks,
//richard
