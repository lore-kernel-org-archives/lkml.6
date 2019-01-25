Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9ACC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2992E218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfAYCPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:15:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbfAYCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:15:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2EC159BFEB1DFB5614FC;
        Fri, 25 Jan 2019 10:15:51 +0800 (CST)
Received: from [127.0.0.1] (10.57.115.182) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 10:15:41 +0800
Subject: Re: [PATCH V2 rdma-next 2/3] RDMA/hns: Fix the chip hanging caused by
 sending mailbox&CMQ during reset
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
 <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
 <20190123224041.GA11605@ziepe.ca> <5C492D59.8030707@huawei.com>
 <20190124183120.GD17167@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <liudongdong3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5C4A714C.2070109@huawei.com>
Date:   Fri, 25 Jan 2019 10:15:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190124183120.GD17167@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/25 2:31, Jason Gunthorpe wrote:
> On Thu, Jan 24, 2019 at 11:13:29AM +0800, Wei Hu (Xavier) wrote:
>>
>> On 2019/1/24 6:40, Jason Gunthorpe wrote:
>>> On Sat, Jan 19, 2019 at 11:36:06AM +0800, Wei Hu (Xavier) wrote:
>>>
>>>> +static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
>>>> +					unsigned long instance_stage,
>>>> +					unsigned long reset_stage)
>>>> +{
>>>> +	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
>>>> +	struct hnae3_handle *handle = priv->handle;
>>>> +	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
>>>> +	unsigned long end;
>>>> +
>>>> +	/* When hardware reset is detected, we should stop sending mailbox&cmq
>>>> +	 * to hardware, and wait until hardware reset finished. If now
>>>> +	 * in .init_instance() function, we should exit with error. If now at
>>>> +	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
>>>> +	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
>>>> +	 * operation like notifing hardware to free resources, HNAE3_INIT_CLIENT
>>>> +	 * related process will exit with error to notify NIC driver to
>>>> +	 * reschedule soft reset process once again.
>>>> +	 */
>>>> +	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
>>>> +	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
>>>> +		udelay(1);
>>> I thought you were getting rid of these loops?
>> Hi, Jason
>>
>>     Upper applications maybe notify driver to issue mailbox or CMD
>>     commands to hardware, some commands used to cancel resources,
>>     destory bt/destory cq/unreg mr/destory qp etc. when such
>>     commands are executed successfully, the hardware engine will
>>     no longer access some memory registered by the driver.
>>
>>     When reset occurs, it is possible for upper applications notify driver
>>     to issue mailbox or CMD commands, we need to wait until hardware
>>     reset finished to ensure that hardware no longer accesses related
>> memory.
> You should not wait for things using loops like the above.
Hi, Jason

    Are your comments foucsing on udelay? If not, thanks for your detail
information.
    In hns3 RoCE driver, some CMQ/mailbox operation are called inside
the lock,
    we can't use msleep in the lock, otherwise it will cause deadlock.
    When reset occurs, RDMA service cannot be provided normally, I think
in this
    case using udelay will not have a great impact.

    Regards
Xavier
> Jason
>
> .
>


