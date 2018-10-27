Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851EC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D0C2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uOe9VH2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D0C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJ0U05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:26:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeJ0U05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 16:26:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9RBiuJV132075;
        Sat, 27 Oct 2018 11:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UiiXUP4URBAv1LWDWA1H4hwlzq453peTTSNMGzdho3I=;
 b=uOe9VH2keplaQNl88Gmqc6gVdfaf12EJ03tRslgLnMhQmIS5lS2h+tIyV0zXBOu+HD01
 X093Ey7d76171ljce5vkDtgvyRSMO57HuOCc0qrVT5iYS2bfxzikdgr2imNFx3XptSz8
 JTU/hd4rBUvqb+XF3HLiYRO6+9uIe2pjJd4PiIcZftLO9wFasW3GCcGuFhdt/MHcyv+N
 KQkQ8gA92JBBf46qAseTh8/WNcq/tlu+Qe9C543egLdr6oLPm/pO+/H6kMUf6mA6/v6T
 1M8Toq3FeyVXGYiy9pwGZybimab/0ZvKLM2WkMJJlh03a/8qzyD9k9K7Gn4MtQSZz3pb YQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ncgnqgm94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Oct 2018 11:46:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9RBk88g020054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Oct 2018 11:46:08 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9RBk6j0006338;
        Sat, 27 Oct 2018 11:46:07 GMT
Received: from [10.191.16.102] (/10.191.16.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Oct 2018 04:46:06 -0700
Subject: Re: [PATCH V4] block: fix the DISCARD request merge
To:     Jens Axboe <axboe@kernel.dk>
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540546116-1620-1-git-send-email-jianchao.w.wang@oracle.com>
 <4ee51782-acbb-bcc9-6692-39e9b8df477f@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <303b4275-d310-d27a-2b92-cdd25e76cffe@oracle.com>
Date:   Sat, 27 Oct 2018 19:46:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4ee51782-acbb-bcc9-6692-39e9b8df477f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9058 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810270110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 10/26/18 10:25 PM, Jens Axboe wrote:
> On 10/26/18 3:28 AM, Jianchao Wang wrote:
>> There are two cases when handle DISCARD merge.
>> If max_discard_segments == 1, the bios/requests need to be contiguous
>> to merge. If max_discard_segments > 1, it takes every bio as a range
>> and different range needn't to be contiguous.
>>
>> But now, attempt_merge screws this up. It always consider contiguity
>> for DISCARD for the case max_discard_segments > 1 and cannot merge
>> contiguous DISCARD for the case max_discard_segments == 1, because
>> rq_attempt_discard_merge always returns false in this case.
>> This patch fixes both of the two cases above.
> 
> Looks good to me, but:
> 
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 42a4674..cf817c7a 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -714,6 +714,32 @@ static void blk_account_io_merge(struct request *req)
>>  		part_stat_unlock();
>>  	}
>>  }
>> +/*
>> + * Two cases of handling DISCARD merge:
>> + * If max_discard_segments > 1, the driver takes every bio
>> + * as a range and send them to controller together. The ranges
>> + * needn't to be contiguous.
>> + * Otherwise, the bios/requests will be handled as same as
>> + * others which should be contiguous.
>> + */
>> +static inline bool blk_discard_mergable(struct request *req)
>> +{
>> +	if (req_op(req) == REQ_OP_DISCARD &&
>> +	    queue_max_discard_segments(req->q) > 1)
>> +		return true;
>> +	else
>> +		return false;
>> +}
> 
> Please get rid of the redundant else.
> 

OK, I will change it and post next version.

Thanks
Jianchao
