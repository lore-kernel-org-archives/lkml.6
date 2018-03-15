Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeCORmE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:42:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40020 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeCORmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:42:03 -0400
X-Google-Smtp-Source: AG47ELv6sbr8HoCa0dMDzCoby39o2eUB+1clTQiLSGXmJuPQ62qRTXRMgJRJahBiF7+ehWi7NLJDRw==
Subject: Re: [PATCH 2/2 v2] mtd: ubi: use put_device() if device_register fail
To: Richard Weinberger <richard@nod.at>
References: <1521098431-29565-1-git-send-email-arvind.yadav.cs@gmail.com>
 <5296799.FRhcbj8Hd9@blindfold>
 <11250cfc-f092-b299-1044-50334c518bf1@gmail.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AAAB066.90900@gmail.com>
Date: Thu, 15 Mar 2018 23:11:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <11250cfc-f092-b299-1044-50334c518bf1@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 15 March 2018 02:17 PM, Arvind Yadav wrote:
>
>
> On Thursday 15 March 2018 01:25 PM, Richard Weinberger wrote:
>> Am Donnerstag, 15. März 2018, 08:20:31 CET schrieb Arvind Yadav:
>>> if device_register() returned an error! Always use put_device()
>>> to give up the reference initialized.
>> Like DaveM said, there is no need to shout and use "!".
>
> I will fix this and send you update patch.
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>> change in v2:
>>>          Fix use-after-free bug. move put_device() after cdev_del().
>>>
>>>   drivers/mtd/ubi/vmt.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
>>> index 3fd8d7f..93c6163 100644
>>> --- a/drivers/mtd/ubi/vmt.c
>>> +++ b/drivers/mtd/ubi/vmt.c
>>> @@ -610,6 +610,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct
>>> ubi_volume *vol)
>>>
>>>   out_cdev:
>>>       cdev_del(&vol->cdev);
>>> +    put_device(&vol->dev);
>>>       return err;
>> The more I dig into device code, the more questions I have.
>> Why is cdev_del() not part of the release function?
>>
>> Thanks,
>> //richard
>
> Yes, It's should be a part release function.
>
> ~arvind

I was wrong, We can not add cdev_del() in release(vol_release)
function.
Function's ubi_create_volume and ubi_add_volume both are using
same release function to release a volume devices.
ubi_add_volume is registering character device for the volume.
So we will have to release character device here.

~arvind
