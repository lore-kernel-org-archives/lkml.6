Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C33DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051C2208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0pe5d6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051C2208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbeHPMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:50:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46840 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHPMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:50:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7G9iHrI051730;
        Thu, 16 Aug 2018 09:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lykrwNT7YoBl13p+klhUl2RXutNwLkSAZ98jXgkOY2k=;
 b=W0pe5d6ckBuFCQQH13ClLknGJ2Z97AiOUJaT1J/FublLgjIt1lTiJKKQw/yS777TNIBR
 0L/xOQ72M5y49Hj2/aQIwO99vzkFyd05wUgLTsnmW4+2w9XiWB0LECf23SAvTPigXErC
 sE0p44mQQEeVIYiEQEcMdWtShafP0VgOggBqNNsrI/GmUCgmuE2nuq/VgQvNDTvNIE2M
 /c+ZiSVFDwnPfhtsKY7oT2xxKMYNpKGh/vswBKInhEDTnXixxCtbvsgbrxQvfqNN4K+4
 BGPx5tFP2aAj7685+MdETrTTLbf3V319pi2sr2qY1NjMktDMgNaXd8oF6AcN84hDb749 cw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ksq7thhu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Aug 2018 09:51:58 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7G9pv79011922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Aug 2018 09:51:57 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7G9pvYs007862;
        Thu, 16 Aug 2018 09:51:57 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Aug 2018 09:51:57 +0000
Subject: Re: [PATCH 1/2] blk-mq: init hctx sched after update cpu &
 nr_hw_queues mapping
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534317915-5041-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVO+NoU2YcuhchYOzAbxu9CfY7VCE5moRrH47kWmX_JD7A@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3c8077f8-9793-3992-29f4-0cdbc7aafffc@oracle.com>
Date:   Thu, 16 Aug 2018 17:52:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVO+NoU2YcuhchYOzAbxu9CfY7VCE5moRrH47kWmX_JD7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8986 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808160103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/15/2018 07:32 PM, Ming Lei wrote:
> On Wed, Aug 15, 2018 at 3:25 PM, Jianchao Wang
> <jianchao.w.wang@oracle.com> wrote:
>> Kyber depends on the mapping between cpu and nr_hw_queues. When
>> update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
>> invoked before the mapping is adapted correctly, this would cause
>> terrible result. A simply way to fix this is switch the io scheduler
>> to none before update the nr_hw_queues, and then get it back after
>> update nr_hw_queues. To achieve this, we add a new member elv_type
>> in request_queue to save the original elevator and adapt and export
>> elevator_switch_mq.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c         | 37 +++++++++++++++++++++++++++++--------
>>  block/blk.h            |  2 ++
>>  block/elevator.c       | 20 ++++++++++++--------
>>  include/linux/blkdev.h |  3 +++
>>  4 files changed, 46 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 5efd789..89904cc 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -112,6 +112,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>>
>>         inflight[0] = inflight[1] = 0;
>> +
> 
> Not necessary to do that.

Yes, I will discard this.

> 
>>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
>>  }
>>
>> @@ -2147,8 +2148,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>>         if (set->ops->exit_request)
>>                 set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
>>
>> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
>> -
>>         if (set->ops->exit_hctx)
>>                 set->ops->exit_hctx(hctx, hctx_idx);
>>
>> @@ -2216,12 +2215,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>             set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
>>                 goto free_bitmap;
>>
>> -       if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
>> -               goto exit_hctx;
>> -
>>         hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
>>         if (!hctx->fq)
>> -               goto sched_exit_hctx;
>> +               goto exit_hctx;
>>
>>         if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
>>                 goto free_fq;
>> @@ -2235,8 +2231,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>
>>   free_fq:
>>         kfree(hctx->fq);
>> - sched_exit_hctx:
>> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
> 
> Seems both blk_mq_sched_init_hctx() and blk_mq_sched_exit_hctx() may be
> removed now.

Yes, I will remove them in V2.

Thanks
Jianchao

