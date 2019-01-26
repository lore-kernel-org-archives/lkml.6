Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A523C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C485F218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfAZBly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:41:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfAZBlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:41:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 772169D18DB991E6A9FA;
        Sat, 26 Jan 2019 09:41:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 09:41:39 +0800
Subject: Re: [PATCH] ipmi_si: fix use-after-free of resource->name
To:     <cminyard@mvista.com>
References: <1548383459-38420-1-git-send-email-yangyingliang@huawei.com>
 <20190125203524.GA20851@minyard.net>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <qiaonuohan@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5C4BBAD1.5050207@huawei.com>
Date:   Sat, 26 Jan 2019 09:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190125203524.GA20851@minyard.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/26 4:35, Corey Minyard wrote:
> On Fri, Jan 25, 2019 at 10:30:59AM +0800, Yang Yingliang wrote:
>> When we excute the following commands, we got oops
>> rmmod ipmi_si
>> cat /proc/ioports
>>
> snip...
>
>> If io_setup is called successful in try_smi_init() but try_smi_init()
>> goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
>> will not be called while removing module. It leads to the resource that
>> allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
>> resource is freed while removing the module. It causes use-after-free
>> when cat /proc/ioports.
>>
>> Fix this by calling shutdown_smi() while removing the module and don't
>> call release_region() if request_region() is not called to avoid error
>> prints.
>>
>> Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
>> Cc: stable@vger.kernel.org
>> Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/char/ipmi/ipmi_si_intf.c    | 2 ++
>>   drivers/char/ipmi/ipmi_si_port_io.c | 3 +++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>> index dc8603d..635e98a 100644
>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -2235,6 +2235,8 @@ static void cleanup_one_si(struct smi_info *smi_info)
>>   
>>   	if (smi_info->intf)
>>   		ipmi_unregister_smi(smi_info->intf);
>> +	else
>> +		shutdown_smi(smi_info);
> This is completely the wrong way to fix this.  The general principle is
> that a function cleans up for itself if it returns an error.  If you
> add hacks other places for a function failing you end up with a mess.
>
> I think the right way to fix this is to add something like:
>
> 	if (rv && new_smi->io.io_size && smi_info->io.io_cleanup) {
> 		smi_info->io.io_cleanup(&smi_info->io);
> 		smi_info->io.io_cleanup = NULL;
> 	}
>
> at the end of try_smi_init().
>
> -corey
OK, I will do some test, and send v2 later.

Thanks,
Yang
>>   
>>   	if (smi_info->pdev) {
>>   		if (smi_info->pdev_registered)
>> diff --git a/drivers/char/ipmi/ipmi_si_port_io.c b/drivers/char/ipmi/ipmi_si_port_io.c
>> index ef6dffc..0c46a3f 100644
>> --- a/drivers/char/ipmi/ipmi_si_port_io.c
>> +++ b/drivers/char/ipmi/ipmi_si_port_io.c
>> @@ -53,6 +53,9 @@ static void port_cleanup(struct si_sm_io *io)
>>   	unsigned int addr = io->addr_data;
>>   	int          idx;
>>   
>> +	if (io->regsize != 1 && io->regsize != 2 && io->regsize != 4)
>> +		return;
>> +
>>   	if (addr) {
>>   		for (idx = 0; idx < io->io_size; idx++)
>>   			release_region(addr + idx * io->regspacing,
>> -- 
>> 1.8.3
>>
>>
> .
>


