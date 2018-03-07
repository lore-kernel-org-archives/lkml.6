Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeCGRQY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:16:24 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41673 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCGRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:16:18 -0500
X-Google-Smtp-Source: AG47ELvKLkUgl0UMHn8Sjf8AhQvatl4fUxlPkRnnY92rJrPlZyYQ48wCwYbYLVPNiRZqRSItGOLxnw==
Subject: Re: [PATCH] ssb:: use put_device() if device_register fail
To: =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>
References: <bdd20c00cba68044d82e387072b39f0176448e97.1520416785.git.arvind.yadav.cs@gmail.com>
 <20180307174700.013e20ae@wiggum>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AA01E5E.8070002@gmail.com>
Date: Wed, 7 Mar 2018 22:46:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180307174700.013e20ae@wiggum>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 07 March 2018 10:17 PM, Michael Büsch wrote:
> On Wed,  7 Mar 2018 15:31:30 +0530
> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>
>> if device_register() returned an error! Always use put_device()
>> to give up the reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/ssb/main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
>> index 65420a9..c4449e0 100644
>> --- a/drivers/ssb/main.c
>> +++ b/drivers/ssb/main.c
>> @@ -521,6 +521,7 @@ static int ssb_devices_register(struct ssb_bus *bus)
>>   			ssb_err("Could not register %s\n", dev_name(dev));
>>   			/* Set dev to NULL to not unregister
>>   			 * dev on error unwinding. */
>> +			put_device(dev);
>>   			sdev->dev = NULL;
>>   			kfree(devwrap);
>>   			goto error;
>
> I don't think this is correct.
> The dev structure is allocated as part of devwrap, which is freed here.
>
> Why do you think we need put_device here?
>
Yes this patch is not correct, We must not use kfree() after you called 
device_register() (even
if it was not successful!) -- see the comment for device_register().
I will delete kfree() and send updated patch.

~arvind
