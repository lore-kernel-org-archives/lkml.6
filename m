Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeCQJpx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 05:45:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37402 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeCQJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 05:45:51 -0400
X-Google-Smtp-Source: AG47ELuJ1sOb0qMVGUYdr8pyUPZ/z+CykFyLBoDvSoLq1XYvZmOhYJtvD6qOTX5bv6xy3REdyea0Cw==
Subject: Re: [PATCH 1/2] mtd: use put_device() if device_register fail
To: Boris Brezillon <boris.brezillon@bootlin.com>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
 <39c4af723ea37cd05976a17cb9c1fbc975496ffd.1520592440.git.arvind.yadav.cs@gmail.com>
 <20180314153600.458c0fe4@bbrezillon>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AACE3C9.9090602@gmail.com>
Date: Sat, 17 Mar 2018 15:15:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180314153600.458c0fe4@bbrezillon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 14 March 2018 08:06 PM, Boris Brezillon wrote:
> On Fri,  9 Mar 2018 16:20:48 +0530
> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>
>> if device_register() returned an error! Always use put_device()
>> to give up the reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/mtd/mtdcore.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> index 28553c8..4d77ca2 100644
>> --- a/drivers/mtd/mtdcore.c
>> +++ b/drivers/mtd/mtdcore.c
>> @@ -586,6 +586,7 @@ int add_mtd_device(struct mtd_info *mtd)
>>   	return 0;
>>   
>>   fail_added:
>> +	put_device(&mtd->dev);
> Not sure this is a good idea: the put_device() call will trigger
> an mtd_devtype->release(), which will in turn call device_destroy() on
> something that does not exist yet. Not sure if this is a real problem,
> but it does not look like the right thing to do.
>
yes, you are correct. No need to call put_device().
which can cause other problem.

>>   	of_node_put(mtd_get_of_node(mtd));
> You're referencing an object that is supposed to have been
> freed/released by the put_device() call. Again, it's not really a
> problem because in our case ->release() does not free the mtd object
> (as is usually done in other parts of the kernel), but it still looks
> wrong. It's probably better to move the of_node_put() and the below
> idr_remove() call in the ->release() hook if you want to use
> put_device().
>
>>   	idr_remove(&mtd_idr, i);
Sure, we can move put_device() below this. But need to check
how we can add hook in release.
>
>>   fail_locked:
>
>
~arvind
