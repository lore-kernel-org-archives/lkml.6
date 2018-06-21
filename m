Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tzOkclnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeFUCJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:09:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeFUCJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:09:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L28tNe172702;
        Thu, 21 Jun 2018 02:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=62UuZQUCvTsZldJFUGRDXkct1+vF/UY+BIuwekRbX4w=;
 b=tzOkclndad9+z2+Jmc30p/9oj/ejFPdae8cVoyZsBq37X+DZIJUEWeK02b6azuWBnqeR
 AZcEoQDaX9hEOHgym2d1v0ymjGVH/wOulaBDbFnDZv2wPTS2tuLnTbRQextzoAk4xIWz
 ZBea692NdAqruuiAWpb7TQBCo72RpiMMC7XIsEonuWIR7MS0V6TshL5I/CF4LkYJ8zxR
 OW7RMoMDnu5gjLMejZ+yOX+g9q0c++cU3qIhMfN4TWKuaIutrqTyurigkUEW385G+WBn
 bvURz7PY0uLvMRsMYfQZLK3CZ7n2LHGaDoxjy7911huTVJOVxwJUokP8E9JiVY6N5m6m sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jmt01pw23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 02:09:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L2938b018541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 02:09:03 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5L292sr006775;
        Thu, 21 Jun 2018 02:09:02 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 19:09:02 -0700
Subject: Re: [PATCH 5/5] nvme: use __blk_mq_complete_request in timeout path
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, keith.busch@intel.com,
        josef@toxicpanda.com, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
 <20180620143956.GA20950@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <42583ee2-fe9d-39da-b82a-38a27b03fdb3@oracle.com>
Date:   Thu, 21 Jun 2018 10:09:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620143956.GA20950@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

Thanks for your kindly response.

On 06/20/2018 10:39 PM, Christoph Hellwig wrote:
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 73a97fc..2a161f6 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1203,6 +1203,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>  		nvme_warn_reset(dev, csts);
>>  		nvme_dev_disable(dev, false);
>>  		nvme_reset_ctrl(&dev->ctrl);
>> +		__blk_mq_complete_request(req);
>>  		return BLK_EH_DONE;
>>  	}
>>  
>> @@ -1213,6 +1214,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>  		dev_warn(dev->ctrl.device,
>>  			 "I/O %d QID %d timeout, completion polled\n",
>>  			 req->tag, nvmeq->qid);
>> +		/*
>> +		 * nvme_end_request will invoke blk_mq_complete_request,
>> +		 * it will do nothing for this timed out request.
>> +		 */
>> +		__blk_mq_complete_request(req);
> 
> And this clearly is bogus.  We want to iterate over the tagetset
> and cancel all requests, not do that manually here.
> 
> That was the whole point of the original change.
> 

For nvme-pci, we indeed have an issue that when nvme_reset_work->nvme_dev_disable returns, timeout path maybe still
running and the nvme_dev_disable invoked by timeout path will race with the nvme_reset_work.
However, the hole is still there right now w/o my changes, but just narrower. 

Thanks
Jianchao
