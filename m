Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22AEC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE8F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfA1Bxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 20:53:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbfA1Bxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 20:53:41 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC982CF592FDD882AF67;
        Mon, 28 Jan 2019 09:53:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 09:53:31 +0800
Subject: Re: [Openipmi-developer] [PATCH v2] ipmi_si: fix use-after-free of
 resource->name
To:     <minyard@acm.org>
References: <1548494094-14356-1-git-send-email-yangyingliang@huawei.com>
 <20190126150809.GA11354@minyard.net>
CC:     <cminyard@mvista.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <qiaonuohan@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5C4E609A.7050609@huawei.com>
Date:   Mon, 28 Jan 2019 09:53:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190126150809.GA11354@minyard.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/26 23:08, Corey Minyard wrote:
> On Sat, Jan 26, 2019 at 05:14:54PM +0800, Yang Yingliang wrote:
>> When we excute the following commands, we got oops
>> rmmod ipmi_si
>> cat /proc/ioports
>>
> snip..
>
>> If io_setup is called successful in try_smi_init() but try_smi_init()
>> goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
>> will not be called while removing module. It leads to the resource that
>> allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
>> resource is freed while removing the module. It causes use-after-free
>> when cat /proc/ioports.
>>
>> Fix this by calling io_cleanup() while try_smi_init() goes to out_err
>> and don't call release_region() if request_region() is not called to
>> avoid error prints.
>>
>> Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
>> Cc: stable@vger.kernel.org
>> Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
>> Suggested-by: Corey Minyard <cminyard@mvista.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/char/ipmi/ipmi_si_intf.c    | 5 +++++
>>   drivers/char/ipmi/ipmi_si_port_io.c | 3 +++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>> index dc8603d..f1b9fda 100644
>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -2085,6 +2085,11 @@ static int try_smi_init(struct smi_info *new_smi)
>>   	WARN_ON(new_smi->io.dev->init_name != NULL);
>>   
>>    out_err:
>> +	if (rv && new_smi->io.io_cleanup) {
>> +		new_smi->io.io_cleanup(&new_smi->io);
>> +		new_smi->io.io_cleanup = NULL;
>> +	}
>> +
>>   	kfree(init_name);
>>   	return rv;
>>   }
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
> Why do you need this part?  I can't see the reason for it.  The addr
> part below should handle that, especially with the above change.
>
> -corey
If ipmi_si_port_setup() returns in default case, request_region() won't 
be called,
so we don't need to call release_region() or it will prints some warning 
messages like
this "Trying to free nonexistent resource...".

We don't need call io_cleanup() until the io_setup() returns successful.
How about change this part like this:

diff --git a/drivers/char/ipmi/ipmi_si_port_io.c 
b/drivers/char/ipmi/ipmi_si_port_io.c
index ef6dffc..03924c3 100644
--- a/drivers/char/ipmi/ipmi_si_port_io.c
+++ b/drivers/char/ipmi/ipmi_si_port_io.c
@@ -68,8 +68,6 @@ int ipmi_si_port_setup(struct si_sm_io *io)
         if (!addr)
                 return -ENODEV;

-       io->io_cleanup = port_cleanup;
-
         /*
          * Figure out the actual inb/inw/inl/etc routine to use based
          * upon the register size.
@@ -109,5 +107,8 @@ int ipmi_si_port_setup(struct si_sm_io *io)
                         return -EIO;
                 }
         }
+
+       io->io_cleanup = port_cleanup;
+
         return 0;
  }

Thanks,
Yang
>
>>   	if (addr) {
>>   		for (idx = 0; idx < io->io_size; idx++)
>>   			release_region(addr + idx * io->regspacing,
>> -- 
>> 1.8.3
>>
>>
>>
>>
>> _______________________________________________
>> Openipmi-developer mailing list
>> Openipmi-developer@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
> .
>


