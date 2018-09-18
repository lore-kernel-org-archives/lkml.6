Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BEECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA60206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA60206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeIRUdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:33:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbeIRUdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:33:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EAF54B1DD756C;
        Tue, 18 Sep 2018 23:00:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 23:00:38 +0800
Message-ID: <5BA11315.4060908@huawei.com>
Date:   Tue, 18 Sep 2018 23:00:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <martin.petersen@oracle.com>, <Don.Brace@microchip.com>,
        <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: Use vmemdup_user to replace the open code
References: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com> <BYAPR11MB28555A88771594AA31AC7596E1390@BYAPR11MB2855.namprd11.prod.outlook.com> <5B7E9CCE.5010007@huawei.com>
In-Reply-To: <5B7E9CCE.5010007@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Greg

Can you pick up the patch?

Thanks,
zhong jiang

On 2018/8/23 19:38, zhong jiang wrote:
> On 2018/8/13 22:20, Don.Brace@microchip.com wrote:
>>> -----Original Message-----
>>> From: zhong jiang [mailto:zhongjiang@huawei.com]
>>> Sent: Monday, August 13, 2018 7:43 AM
>>> To: don.brace@microsemi.com; jejb@linux.vnet.ibm.com;
>>> martin.petersen@oracle.com
>>> Cc: linux-kernel@vger.kernel.org
>>> Subject: [PATCH v2] scsi: Use vmemdup_user to replace the open code
>>>
>>> EXTERNAL EMAIL
>>>
>>>
>>> EXTERNAL EMAIL
>>>
>>>
>>> vmemdup_user is better than duplicating its implementation, So just
>>> replace the open code.
>>>
>>> The issue is detected with the help of Coccinelle.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> Tested-by: Don Brace <don.brace@microsemi.com>
>> Acked-by: Don Brace <don.brace@microsemi.com>
>  Thanks Don for your test and ack.
>  
>  Martin ,  Can you pick up the patch, Thanks
>
>  Best wishes,
>  zhong jiang
>>> ---
>>>  drivers/scsi/hpsa.c | 12 ++++--------
>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
>>> index 58bb70b..666ba09e5 100644
>>> --- a/drivers/scsi/hpsa.c
>>> +++ b/drivers/scsi/hpsa.c
>>> @@ -6381,13 +6381,9 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info
>>> *h, void __user *argp)
>>>                 return -EINVAL;
>>>         if (!capable(CAP_SYS_RAWIO))
>>>                 return -EPERM;
>>> -       ioc = kmalloc(sizeof(*ioc), GFP_KERNEL);
>>> -       if (!ioc) {
>>> -               status = -ENOMEM;
>>> -               goto cleanup1;
>>> -       }
>>> -       if (copy_from_user(ioc, argp, sizeof(*ioc))) {
>>> -               status = -EFAULT;
>>> +       ioc = vmemdup_user(argp, sizeof(*ioc));
>>> +       if (IS_ERR(ioc)) {
>>> +               status = PTR_ERR(ioc);
>>>                 goto cleanup1;
>>>         }
>>>         if ((ioc->buf_size < 1) &&
>>> @@ -6505,7 +6501,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
>>> void __user *argp)
>>>                 kfree(buff);
>>>         }
>>>         kfree(buff_size);
>>> -       kfree(ioc);
>>> +       kvfree(ioc);
>>>         return status;
>>>  }
>>>
>>> --
>>> 1.7.12.4
>>
>
>
> .
>


