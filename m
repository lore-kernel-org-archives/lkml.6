Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93900C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E820848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1EPthW2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6E820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJZKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:13:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53448 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeJZKN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:13:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q1YMAb118678;
        Fri, 26 Oct 2018 01:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3L79xviSoZSr2TiIr3IYZkVsV3jsznh0blZqspQc2P4=;
 b=1EPthW2Xgam2KgDTxLdV2HtpWrnXJZUhzDjGMLXcW0qBs5ee4X+7zFggA7bgIJVigegm
 4LOxoHHHUtSDUatCerkmG0O13XFf1LFg0pvkIL7RHq/XYrwr/h1tMW/f1URF8QCsf5kp
 UIoifnf9cYkN+wRJitdJ01h/oOa+UyltPuqnQOrHdVUIkXPoli1eSfjrYA7PoKK9QFAM
 w/1naJQFSV2Df3SUw/2fDfSSREqv142XXyXQ7naC6jAl3FyXKoeXgWTzXFVxRcHnwmQw
 0JMSQQpbc/CessSxqRaEQV6Ak0eJvMocOgv4ACBv+hr+R0a7Xv7VeI3mR7LiTfFcUeDa 5g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaqcng8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 01:38:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q1cNol025157
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 01:38:23 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q1cNQH013356;
        Fri, 26 Oct 2018 01:38:23 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 18:38:23 -0700
Subject: Re: [PATCH] blk-mq: ensure hctx to be ran on mapped cpu when issue
 directly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
 <a25dbb6a-2ffe-a843-abc4-1a6608c17a49@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ab0ee728-ed8f-7f9e-4318-e07200d936ac@oracle.com>
Date:   Fri, 26 Oct 2018 09:38:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a25dbb6a-2ffe-a843-abc4-1a6608c17a49@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 10/26/18 12:25 AM, Jens Axboe wrote:
> On 10/24/18 9:20 AM, Jianchao Wang wrote:
>> When issue request directly and the task is migrated out of the
>> original cpu where it allocates request, hctx could be ran on
>> the cpu where it is not mapped. To fix this, insert the request
>> if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
>> to the hctx and invoke __blk_mq_issue_directly under preemption
>> disabled.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e3c39ea..0cdc306 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1717,6 +1717,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  {
>>  	struct request_queue *q = rq->q;
>>  	bool run_queue = true;
>> +	blk_status_t ret;
>> +
>> +	if (hctx->flags & BLK_MQ_F_BLOCKING) {
>> +		bypass_insert = false;
>> +		goto insert;
>> +	}
> 
> I'd do a prep patch that moves the insert logic out of this function,
> and just have the caller do it by return BLK_STS_RESOURCE, for instance.
> It's silly that we have that in both the caller and inside this function.

Yes.

> 
>> @@ -1734,6 +1740,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  	if (q->elevator && !bypass_insert)
>>  		goto insert;
>>  
>> +	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
>> +		bypass_insert = false;
>> +		goto insert;
>> +	}
> 
> Should be fine to just do smp_processor_id() here, as we're inside
> hctx_lock() here.
> 

If the rcu is preemptible, smp_processor_id will not enough here.

Thanks
Jianchao
