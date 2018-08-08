Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1692C21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BG4JKTmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1692C21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHHLvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:51:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:51:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w789Nwfk136843;
        Wed, 8 Aug 2018 09:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vV/ygFLXVfQzGvrnxOa+Uvi98X6LzDzR5vwnqkvtdtA=;
 b=BG4JKTmnp+P8AqFWPC1MlPp+Mm2QAvQvV+AGkY1N7UlFVzvmHsdgOXdTIASfxQ9Se3Bz
 dmBbzWZ9umDjn7iQa1GJhGR6CRw0u/434cdTkv8PEI7/xc+6i8hl4cSu4ZnWfikL7gyk
 87/qxu578L3DIjuI6BrfcOzSfoBNRqe35Ou9YfAqBwTxae6FLvq5HBtPmeru3/9s95M5
 ZCdqsccEledJSLeUkGR9LU38MHyR+8WlqeWWVocLsTzhugthC+0PPmucJQl1kZa38TPw
 Nw2tqeUPK/o5nNHYu1VRrIdBXMaIcoZPHk2xonbbtqzyBUZ8upEnCGre/diWjkS15OYc zA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2kn43nw146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 09:32:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w789WR8G031233
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 09:32:27 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w789WPRr031258;
        Wed, 8 Aug 2018 09:32:27 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 02:32:24 -0700
Subject: Re: [PATCH] blk-mq: count the hctx as active before allocate tag
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMKQRT5_gyikVAPMKY_KPmQ2_w+VnZhKKCK9Sm4WphqQw@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b1092ee3-3d59-b01f-b42b-5610918c1bb8@oracle.com>
Date:   Wed, 8 Aug 2018 17:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVMKQRT5_gyikVAPMKY_KPmQ2_w+VnZhKKCK9Sm4WphqQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2018 05:24 PM, Ming Lei wrote:
> On Wed, Aug 8, 2018 at 4:22 PM, Jianchao Wang
> <jianchao.w.wang@oracle.com> wrote:
>> Currently, we count the hctx as active after allocate tag
>> successfully. The other shared-tags users could exhaust the tags
>> and starve a non-active and waiting-tag hctx. Count the hctx as
>> active before try to allocate tag to fix this.
> 
> This patch looks fine.
> 
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index ae44e85..acd40eb 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -369,6 +369,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>>                         e->type->ops.mq.limit_depth(op, data);
>>         }
>>
>> +       blk_mq_tag_busy(data.hctx);
>> +
> 
> blk_mq_tag_busy is only required for driver tag.
> 

Yes, I will change it and post the V2.

Thanks
Jianchao
