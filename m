Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D08C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E843D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/nPruvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E843D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeJZQ7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:59:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:59:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q8ECPh007754;
        Fri, 26 Oct 2018 08:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=EJyN2mtKG+sv9RRW0g4ZLibJeXyZVJl0L0lWbJGzzes=;
 b=I/nPruvz09lGUcuZYDh8mQEEdWwXZcBnGXYW7qFfzhqpb3CzoZD2UM1G+rmehRfVdNnU
 27NC/Hcr+z6vGVh0bfETXkPs0NYVQOsv4ORk0fUdeYB63QQn/fDSXAUML66Pqx0/VJuZ
 /eZh3uvliUbo/bGIJszKol7wSkUhn5ONVbv0FolIEJ4cWRc6PfiFjX/biJzc0BgEabpE
 kf2PV69hp2fCP60uZVotWqcyH3Rbb/4bRiSfgNJ0COwmSIsq1LaBwTOddAPk/Yuc/o3K
 a+YmDAETG/Lk8CzA2uM8IBID6tNe9qI3tMU9PmbJFwC4dJdAoVNYTODF42RILJycNojF Ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaqdtup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:22:56 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q8MtVv020993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:22:56 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q8MsCf003634;
        Fri, 26 Oct 2018 08:22:55 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 01:22:54 -0700
Subject: Re: [PATCH V3] block: fix the DISCARD request merge
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
 <52d2e36c-ed62-151d-e070-7edd06bfc24d@oracle.com>
 <20181026080710.GA6495@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8a35dbc5-f879-25ce-fa8b-2b53c85b9ec9@oracle.com>
Date:   Fri, 26 Oct 2018 16:22:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026080710.GA6495@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/18 4:07 PM, Christoph Hellwig wrote:
> On Fri, Oct 26, 2018 at 04:05:00PM +0800, jianchao.wang wrote:
>> Would anyone please take a look at this ?
> 
> I did take a look and reply to it..

Oh sorry, I missed it in my email client.
Got it from the https://lkml.org/lkml/2018/10/24/491
And we could also have a blk_merge_req_ok there. :)

Thanks
Jianchao
> 
>>
>> Thanks in advance.
>> Jianchao
>>
>> On 10/24/18 11:07 AM, Jianchao Wang wrote:
>>> There are two cases when handle DISCARD merge.
>>> If max_discard_segments == 1, the bios/requests need to be contiguous
>>> to merge. If max_discard_segments > 1, it takes every bio as a range
>>> and different range needn't to be contiguous.
>>>
>>> But now, attempt_merge screws this up. It always consider contiguity
>>> for DISCARD for the case max_discard_segments > 1 and cannot merge
>>> contiguous DISCARD for the case max_discard_segments == 1, because
>>> rq_attempt_discard_merge always returns false in this case.
>>> This patch fixes both of the two cases above.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>
>>> V3:
>>>  - Introduce blk_discard_mergable into attempt_merge and
>>>    blk_try_merge.
>>>  - Some comment changes.
>>>
>>> V2:
>>>  - Add max_discard_segments > 1 checking in attempt_merge.
>>>  - Change patch title and comment.
>>>  - Add more comment in attempt_merge
>>>
>>>  block/blk-merge.c | 34 ++++++++++++++++++++++++----------
>>>  1 file changed, 24 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>> index 42a4674..b258de0 100644
>>> --- a/block/blk-merge.c
>>> +++ b/block/blk-merge.c
>>> @@ -714,6 +714,22 @@ static void blk_account_io_merge(struct request *req)
>>>  		part_stat_unlock();
>>>  	}
>>>  }
>>> +/*
>>> + * Two cases of handling DISCARD merge:
>>> + * If max_discard_segments > 1, the driver takes every bio
>>> + * as a range and send them to controller together. The ranges
>>> + * needn't to be contiguous.
>>> + * Otherwise, the bios/requests will be handled as same as
>>> + * others which should be contiguous.
>>> + */
>>> +static inline bool blk_discard_mergable(struct request *req)
>>> +{
>>> +	if (req_op(req) == REQ_OP_DISCARD &&
>>> +	    queue_max_discard_segments(req->q) > 1)
>>> +		return true;
>>> +	else
>>> +		return false;
>>> +}
>>>  
>>>  /*
>>>   * For non-mq, this has to be called with the request spinlock acquired.
>>> @@ -731,12 +747,6 @@ static struct request *attempt_merge(struct request_queue *q,
>>>  	if (req_op(req) != req_op(next))
>>>  		return NULL;
>>>  
>>> -	/*
>>> -	 * not contiguous
>>> -	 */
>>> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
>>> -		return NULL;
>>> -
>>>  	if (rq_data_dir(req) != rq_data_dir(next)
>>>  	    || req->rq_disk != next->rq_disk
>>>  	    || req_no_special_merge(next))
>>> @@ -760,11 +770,16 @@ static struct request *attempt_merge(struct request_queue *q,
>>>  	 * counts here. Handle DISCARDs separately, as they
>>>  	 * have separate settings.
>>>  	 */
>>> -	if (req_op(req) == REQ_OP_DISCARD) {
>>> +
>>> +	if (blk_discard_mergable(req)) {
>>>  		if (!req_attempt_discard_merge(q, req, next))
>>>  			return NULL;
>>> -	} else if (!ll_merge_requests_fn(q, req, next))
>>> +	} else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
>>> +		if (!ll_merge_requests_fn(q, req, next))
>>> +			return NULL;
>>> +	} else {
>>>  		return NULL;
>>> +	}
>>>  
>>>  	/*
>>>  	 * If failfast settings disagree or any of the two is already
>>> @@ -888,8 +903,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>>>  
>>>  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>>>  {
>>> -	if (req_op(rq) == REQ_OP_DISCARD &&
>>> -	    queue_max_discard_segments(rq->q) > 1)
>>> +	if (blk_discard_mergable(rq))
>>>  		return ELEVATOR_DISCARD_MERGE;
>>>  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>>>  		return ELEVATOR_BACK_MERGE;
>>>
> ---end quoted text---
> 
