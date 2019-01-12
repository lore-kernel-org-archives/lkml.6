Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C813020836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 07:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfALHzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 02:55:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfALHzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 02:55:45 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A1232ACA499D25C5CAB1;
        Sat, 12 Jan 2019 15:55:42 +0800 (CST)
Received: from [127.0.0.1] (10.57.115.182) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 12 Jan 2019
 15:55:32 +0800
Subject: Re: [PATCH rdma-rc 1/3] RDMA/hns: Fix the Oops during rmmod or insmod
 ko when reset occurs
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1547128663-69220-1-git-send-email-xavier.huwei@huawei.com>
 <1547128663-69220-2-git-send-email-xavier.huwei@huawei.com>
 <20190111213411.GA22310@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <liudongdong3@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5C399D73.5000902@huawei.com>
Date:   Sat, 12 Jan 2019 15:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190111213411.GA22310@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/12 5:34, Jason Gunthorpe wrote:
> On Thu, Jan 10, 2019 at 09:57:41PM +0800, Wei Hu (Xavier) wrote:
>> +	/* Check the status of the current software reset process, if in
>> +	 * software reset process, wait until software reset process finished,
>> +	 * in order to ensure that reset process and this function will not call
>> +	 * __hns_roce_hw_v2_uninit_instance at the same time.
>> +	 * If a timeout occurs, it indicates that the network subsystem has
>> +	 * encountered a serious error and cannot be recovered from the reset
>> +	 * processing.
>> +	 */
>> +	if (ops->ae_dev_resetting(handle)) {
>> +		dev_warn(dev, "Device is busy in resetting state. waiting.\n");
>> +		end = msecs_to_jiffies(HNS_ROCE_V2_RST_PRC_MAX_TIME) + jiffies;
>> +		while (ops->ae_dev_resetting(handle) &&
>> +		       time_before(jiffies, end))
>> +			msleep(20);
> Really? Does this have to be so ugly? Why isn't there just a simple
> lock someplace that is held during reset?
>
> I'm skeptical that all this strange looking stuff is properly locked
> and concurrency safe.
Hi, Jason

The hns3 NIC driver notifies the hns RoCE driver to perform
reset related processing by calling the .reset_notify() interface
registered by the RoCE driver.

There is a constraint on the hip08 chip, the NIC driver needs to
stop the flow before hardware startup reset, otherwise the chip
may hang up.

We've also thought about using locks, but found using locks can
lead to more serious problems because of that restriction of the
chip.
If using locks here, reset processing may wait for uninstallation
to complete, this may lead that NIC driver fails to stop the flow
in time in the reset process, thus causing the chip to hang up.

Regards
Xavier
> Also, this series seems a bit big for -rc
>
> Jason
>
> .
>


