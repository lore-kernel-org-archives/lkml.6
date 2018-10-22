Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF4AC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BFF20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PiS/zCYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BFF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeJVSbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:31:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeJVSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:31:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MA8Wv2085343;
        Mon, 22 Oct 2018 10:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ja2u3ezTd0ZE8K2VbeQu3n7Zb41Kv++55ivRBkC0/zI=;
 b=PiS/zCYh6LpiVHeH5jbgyXgYIln/6TwvZcVI9l3u2W4rO6eyvseOq2dLCjI65lCOvBAw
 +uTjw6XumzHSm1WbIxjFbxtmfpXLXpCNV6MpWFzp2ofCVfSzx+2bPChLvHD5IBq++EM2
 fu5Szi4CdK3lbckciFIJfMB70WU0i+LlS+6QaLPvKnWaOgwRlYYW5UXx5hNpuIMD6lUq
 L247ky8oZhaOp6m76PASFpKl3CJ1JMmpp83hjXBRR0BhZ+dBlv0XpJecuRO7IT78vrAW
 udtxJhF9LNwJo8LQV4G3Ge6rUhcYzfu2h+PwBwW3rBCkEY6rqwICDg7aTYTZeLU8dbjb XQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n7ustwjvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 10:13:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MADLrt010361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 10:13:21 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MADLub002601;
        Mon, 22 Oct 2018 10:13:21 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 03:13:21 -0700
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
 <20181022090058.GF18755@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ebc24279-1a26-1560-a810-4e51545e7a91@oracle.com>
Date:   Mon, 22 Oct 2018 18:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022090058.GF18755@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/18 5:00 PM, Christoph Hellwig wrote:
> On Sat, Oct 20, 2018 at 10:29:37PM +0800, Jianchao Wang wrote:
>> There are two cases when handle DISCARD merge
>>  - max_discard_segments == 1
>>    bios need to be contiguous
>>  - max_discard_segments > 1
>>    Only nvme right now. It takes every bio as a range and different
>>    range needn't to be contiguous.
>>
>> But now, attempt_merge screws this up. It always consider contiguity
>> for DISCARD for the case max_discard_segments > 1 and cannot merge
>> contiguous DISCARD for the case max_discard_segments == 1, because
>> rq_attempt_discard_merge always returns false in this case.
>> This patch fixes both of the two cases above.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>
>> V2:
>>   - Add max_discard_segments > 1 checking in attempt_merge
>>   - Change patch title and comment
>>   - Add more comment in attempt_merge
>>
>>  block/blk-merge.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 42a4674..8f22374 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -734,8 +734,15 @@ static struct request *attempt_merge(struct request_queue *q,
>>  	/*
>>  	 * not contiguous
>>  	 */
>> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
>> -		return NULL;
>> +	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)) {
>> +		/*
>> +		 * When max_discard_segments is bigger than 1 (only nvme right
>> +		 * now), needn't consider the contiguity.
>> +		 */
>> +		if (!(req_op(req) == REQ_OP_DISCARD &&
>> +		      queue_max_discard_segments(q) > 1))
>> +			return NULL;
> 
> Why not:
> 
> 		if (req_op(req) != REQ_OP_DISCARD ||
> 		    queue_max_discard_segments(q) == 1)> 
> which would be a lot more obvious?

OK, I will change it

> 
>> +	 * counts here.
>> +	 * Two cases of Handling DISCARD:
>> +	 *  - max_discard_segments == 1
>> +	 *    The bios need to be contiguous.
>> +	 *  - max_discard_segments > 1
>> +	 *    Only nvme right now. It takes every bio as a
>> +	 *    range and send them to controller together. The ranges
>> +	 *    needn't to be contiguous.
> 
> The formatting looks odd.  Also I don't think we should mention the
> users here, as others might grow (virtio is in the pipe, SCSI could
> be supported easily if someone did the work).
> 

Yes, I will change the format and discard the users here.

Thanks
Jianchao
