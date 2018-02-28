Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932066AbeB1Lpd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:45:33 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:54030 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeB1Lpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:45:31 -0500
X-Google-Smtp-Source: AG47ELvv+cLDUzi6bRqN6wH8pYGF39LP7alR9hit4EsT5MnBesCQfyIIY+lBqvgEZy2MHZ7ImT1HeA==
Subject: Re: [PATCH] net: iucv: Free memory obtained by kzalloc
To: Cornelia Huck <cohuck@redhat.com>
References: <6fbfc0b8aa75852c4eed4d05e4c165a493304ced.1519811528.git.arvind.yadav.cs@gmail.com>
 <20180228113042.6a2f5177.cohuck@redhat.com>
Cc: jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <e4784c9b-380f-4dad-6883-b6350a9e0614@gmail.com>
Date: Wed, 28 Feb 2018 17:14:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180228113042.6a2f5177.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 28 February 2018 04:00 PM, Cornelia Huck wrote:
> On Wed, 28 Feb 2018 15:24:16 +0530
> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>
>> Free memory, if afiucv_iucv_init is not successful and
>> removing a IUCV driver.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   net/iucv/af_iucv.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index 1e8cc7b..eb0995a 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
>>   	af_iucv_dev->driver = &af_iucv_driver;
>>   	err = device_register(af_iucv_dev);
>>   	if (err)
>> -		goto out_driver;
>> +		goto out_iucv_dev;
>>   	return 0;
>>   
>> +out_iucv_dev:
>> +	kfree(af_iucv_dev);
>>   out_driver:
>>   	driver_unregister(&af_iucv_driver);
>>   out_iucv:
>> @@ -2496,6 +2498,7 @@ static void __exit afiucv_exit(void)
>>   {
>>   	if (pr_iucv) {
>>   		device_unregister(af_iucv_dev);
>> +		kfree(af_iucv_dev);
>>   		driver_unregister(&af_iucv_driver);
>>   		pr_iucv->iucv_unregister(&af_iucv_handler, 0);
>>   		symbol_put(iucv_if);
> No, you must not use kfree() after you called device_register() (even
> if it was not successful!) -- see the comment for device_register().
Yes, Your are right. First we need to call put_device() then kfree().
I will send updated patch.
~arvind
