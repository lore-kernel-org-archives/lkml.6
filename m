Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BED2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tngvpnkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BED2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJZQlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:41:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57540 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:41:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q7wuP9191767;
        Fri, 26 Oct 2018 08:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=D5Yagcn33sTdWaG+JcjoP6IuMFXU6NPHli2REDhzIfQ=;
 b=TngvpnkqgYmfHFvyHJblUQIHWuNUXM1B5TiRQ/o1UfPWmJxf9I807VkqefDUbEhE8ViN
 c5ya74zpEHGsTB24pURstcLgWetyjA8BivRxz5ytCYcxlC+bExS06CHNBOXBay0x5nWj
 efVkhkYOLT/iPXAR+/iMC55bPtm84XqvMT2vAllN49jY392jcqx4XgoDDWDZziwI6+zd
 AvsNNCuDnvU2TB+Trp83oCr9nQFb8QTIaxZR480XzdM+SMmNUO1eqRCwkNRxB7Stl7uk
 fL5OCdPKCz/vodDIz7zZPcY8k29l3E6EGHozRtuq0BRiQQBU39b5zwjGDt8eOOeUQKhu qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaqdrqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:04:58 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q84vdb006801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:04:58 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q84vW5028434;
        Fri, 26 Oct 2018 08:04:57 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 01:04:56 -0700
Subject: Re: [PATCH V3] block: fix the DISCARD request merge
To:     axboe@kernel.dk
Cc:     martin.petersen@oracle.com, Ming Lei <ming.lei@redhat.com>,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <52d2e36c-ed62-151d-e070-7edd06bfc24d@oracle.com>
Date:   Fri, 26 Oct 2018 16:05:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please take a look at this ?

Thanks in advance.
Jianchao

On 10/24/18 11:07 AM, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge.
> If max_discard_segments == 1, the bios/requests need to be contiguous
> to merge. If max_discard_segments > 1, it takes every bio as a range
> and different range needn't to be contiguous.
> 
> But now, attempt_merge screws this up. It always consider contiguity
> for DISCARD for the case max_discard_segments > 1 and cannot merge
> contiguous DISCARD for the case max_discard_segments == 1, because
> rq_attempt_discard_merge always returns false in this case.
> This patch fixes both of the two cases above.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
> 
> V3:
>  - Introduce blk_discard_mergable into attempt_merge and
>    blk_try_merge.
>  - Some comment changes.
> 
> V2:
>  - Add max_discard_segments > 1 checking in attempt_merge.
>  - Change patch title and comment.
>  - Add more comment in attempt_merge
> 
>  block/blk-merge.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..b258de0 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -714,6 +714,22 @@ static void blk_account_io_merge(struct request *req)
>  		part_stat_unlock();
>  	}
>  }
> +/*
> + * Two cases of handling DISCARD merge:
> + * If max_discard_segments > 1, the driver takes every bio
> + * as a range and send them to controller together. The ranges
> + * needn't to be contiguous.
> + * Otherwise, the bios/requests will be handled as same as
> + * others which should be contiguous.
> + */
> +static inline bool blk_discard_mergable(struct request *req)
> +{
> +	if (req_op(req) == REQ_OP_DISCARD &&
> +	    queue_max_discard_segments(req->q) > 1)
> +		return true;
> +	else
> +		return false;
> +}
>  
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
> @@ -731,12 +747,6 @@ static struct request *attempt_merge(struct request_queue *q,
>  	if (req_op(req) != req_op(next))
>  		return NULL;
>  
> -	/*
> -	 * not contiguous
> -	 */
> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -		return NULL;
> -
>  	if (rq_data_dir(req) != rq_data_dir(next)
>  	    || req->rq_disk != next->rq_disk
>  	    || req_no_special_merge(next))
> @@ -760,11 +770,16 @@ static struct request *attempt_merge(struct request_queue *q,
>  	 * counts here. Handle DISCARDs separately, as they
>  	 * have separate settings.
>  	 */
> -	if (req_op(req) == REQ_OP_DISCARD) {
> +
> +	if (blk_discard_mergable(req)) {
>  		if (!req_attempt_discard_merge(q, req, next))
>  			return NULL;
> -	} else if (!ll_merge_requests_fn(q, req, next))
> +	} else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
> +		if (!ll_merge_requests_fn(q, req, next))
> +			return NULL;
> +	} else {
>  		return NULL;
> +	}
>  
>  	/*
>  	 * If failfast settings disagree or any of the two is already
> @@ -888,8 +903,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  
>  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>  {
> -	if (req_op(rq) == REQ_OP_DISCARD &&
> -	    queue_max_discard_segments(rq->q) > 1)
> +	if (blk_discard_mergable(rq))
>  		return ELEVATOR_DISCARD_MERGE;
>  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>  		return ELEVATOR_BACK_MERGE;
> 
