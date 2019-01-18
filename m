Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AE020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfARM61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:58:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfARM6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:58:25 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA99FFEEA03D4D70EFD3;
        Fri, 18 Jan 2019 20:58:21 +0800 (CST)
Received: from [127.0.0.1] (10.57.115.182) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 20:58:12 +0800
Subject: Re: [PATCH rdma-rc 1/3] RDMA/hns: Fix the Oops during rmmod or insmod
 ko when reset occurs
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1547128663-69220-1-git-send-email-xavier.huwei@huawei.com>
 <1547128663-69220-2-git-send-email-xavier.huwei@huawei.com>
 <20190111213411.GA22310@ziepe.ca> <5C399D73.5000902@huawei.com>
 <20190114220655.GD1208@ziepe.ca> <5C3D3BD1.4000508@huawei.com>
 <20190115220259.GH22045@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <liudongdong3@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5C41CD63.60506@huawei.com>
Date:   Fri, 18 Jan 2019 20:58:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190115220259.GH22045@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/16 6:02, Jason Gunthorpe wrote:
> On Tue, Jan 15, 2019 at 09:48:01AM +0800, Wei Hu (Xavier) wrote:
>>
>> On 2019/1/15 6:06, Jason Gunthorpe wrote:
>>> On Sat, Jan 12, 2019 at 03:55:31PM +0800, Wei Hu (Xavier) wrote:
>>>> On 2019/1/12 5:34, Jason Gunthorpe wrote:
>>>>> On Thu, Jan 10, 2019 at 09:57:41PM +0800, Wei Hu (Xavier) wrote:
>>>>>> +	/* Check the status of the current software reset process, if in
>>>>>> +	 * software reset process, wait until software reset process finished,
>>>>>> +	 * in order to ensure that reset process and this function will not call
>>>>>> +	 * __hns_roce_hw_v2_uninit_instance at the same time.
>>>>>> +	 * If a timeout occurs, it indicates that the network subsystem has
>>>>>> +	 * encountered a serious error and cannot be recovered from the reset
>>>>>> +	 * processing.
>>>>>> +	 */
>>>>>> +	if (ops->ae_dev_resetting(handle)) {
>>>>>> +		dev_warn(dev, "Device is busy in resetting state. waiting.\n");
>>>>>> +		end = msecs_to_jiffies(HNS_ROCE_V2_RST_PRC_MAX_TIME) + jiffies;
>>>>>> +		while (ops->ae_dev_resetting(handle) &&
>>>>>> +		       time_before(jiffies, end))
>>>>>> +			msleep(20);
>>>>> Really? Does this have to be so ugly? Why isn't there just a simple
>>>>> lock someplace that is held during reset?
>>>>>
>>>>> I'm skeptical that all this strange looking stuff is properly locked
>>>>> and concurrency safe.
>>>> Hi, Jason
>>>>
>>>> The hns3 NIC driver notifies the hns RoCE driver to perform
>>>> reset related processing by calling the .reset_notify() interface
>>>> registered by the RoCE driver.
>>>>
>>>> There is a constraint on the hip08 chip, the NIC driver needs to
>>>> stop the flow before hardware startup reset, otherwise the chip
>>>> may hang up.
>>>>
>>>> We've also thought about using locks, but found using locks can
>>>> lead to more serious problems because of that restriction of the
>>>> chip.
>>>> If using locks here, reset processing may wait for uninstallation
>>>> to complete, this may lead that NIC driver fails to stop the flow
>>>> in time in the reset process, thus causing the chip to hang up.
>>> If you are sleeping then I'm sure a lock can be used instead, how
>>> would it be any different?
>> Hi, Jason
>>     If using locks here, reset process may wait until uninstallation to
>> complete,
>>         it may trigger the chip constraint, causing chip to hang up.
>>     But if using sleeping here, there will notthe case that reset
>> process wait until
>>        uninstallation to complete, then will not trigger the chip
>> constraint.
> But how is this even right? If ops->ae_dev_resetting can change at any
> time, and you need to wait for it here, without locks can't it just
> change instantly after the if statement?
>
> I think it shows the concurrancy & locking is not done right when I
> see loops reading shared data and spinning on them with msleep.
Hi, Jason

    Thanks for your comments,
    We will modify the related process in hns NIC driver and delete checking
    whether in the reset state and waiting for the reset to complete in
    hns_roce_hw_v2_uninit_instance function, and will send patch V2 for
    rdma-next branch. Thanks

    Regards
Xavier
> Jason
>
> .
>


