Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F23F253A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsjC9Lvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F23F253A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeFYBkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:40:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57778 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeFYBkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:40:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5P1e8JR134840;
        Mon, 25 Jun 2018 01:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=IcWEY2ISOW9QUaFgQYEdXX5jRRAOQiHrNAoy2nR0UqY=;
 b=gsjC9LviEYwv80JAkCUXRNpBFZUZuSxH6KIo9baFY4MR5M0j4a6WomNl03U/ol5jEVs+
 x0rTi4/I2yfZpQAtyEUsk+pODQTSn0ng00n7jIxu7VVaqHAd1FQJ//1ZtEzjLafvTVlS
 5O3PLmfE7BYnnDuYos/tIIKXnQa/MBycjCiHhF36Gms9G6I8yLfnYdkKyY81Vypvun/s
 XlHEkDrnDIKGJ/iU15w9NzcnDEvOTvay36kvcVi6Yj+dVEvOLO+YVG4iWe+tnKZTRupR
 RSWJv0V8Ky+/gq2tFq6jl9R78doi3iGvAt9CrkZSVs4MDFSqO+N/h2kp6gUQQRTABEEZ Lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jt7mp8txa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 01:40:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5P1e7Nu020554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 01:40:07 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5P1e651018024;
        Mon, 25 Jun 2018 01:40:06 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Jun 2018 18:40:06 -0700
Subject: Re: [PATCH 5/5] nvme: use __blk_mq_complete_request in timeout path
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, keith.busch@intel.com,
        josef@toxicpanda.com, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
 <20180620143956.GA20950@lst.de>
 <42583ee2-fe9d-39da-b82a-38a27b03fdb3@oracle.com>
 <1817441e-6810-ed40-a8fd-403742818aae@grimberg.me>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <cc93effe-8e97-d4a8-851e-33208cf837a7@oracle.com>
Date:   Mon, 25 Jun 2018 09:40:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1817441e-6810-ed40-a8fd-403742818aae@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 02:07 AM, Sagi Grimberg wrote:
> 
>> Hi Christoph
>>
>> Thanks for your kindly response.
>>
>> On 06/20/2018 10:39 PM, Christoph Hellwig wrote:
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index 73a97fc..2a161f6 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -1203,6 +1203,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>>>           nvme_warn_reset(dev, csts);
>>>>           nvme_dev_disable(dev, false);
>>>>           nvme_reset_ctrl(&dev->ctrl);
>>>> +        __blk_mq_complete_request(req);
>>>>           return BLK_EH_DONE;
>>>>       }
>>>>   @@ -1213,6 +1214,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>>>           dev_warn(dev->ctrl.device,
>>>>                "I/O %d QID %d timeout, completion polled\n",
>>>>                req->tag, nvmeq->qid);
>>>> +        /*
>>>> +         * nvme_end_request will invoke blk_mq_complete_request,
>>>> +         * it will do nothing for this timed out request.
>>>> +         */
>>>> +        __blk_mq_complete_request(req);
>>>
>>> And this clearly is bogus.  We want to iterate over the tagetset
>>> and cancel all requests, not do that manually here.
>>>
>>> That was the whole point of the original change.
>>>
>>
>> For nvme-pci, we indeed have an issue that when nvme_reset_work->nvme_dev_disable returns, timeout path maybe still
>> running and the nvme_dev_disable invoked by timeout path will race with the nvme_reset_work.
>> However, the hole is still there right now w/o my changes, but just narrower.
> 
> Given the amount of fixes (and fixes of fixes) we had in the timeout handler, maybe it'd be a good idea to step back and take a another look?
> 
> Won't it be better to avoid disabling the device and return
> BLK_EH_RESET_TIMER if we are not aborting in the timeout handler?
> 

Yes, that would be an ideal status for nvme-pci.
But we have to depend on the timeout handler to handle the timed out request from nvme_reset_work.

Thanks
Jianchao
