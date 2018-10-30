Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48566C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05952080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cvhqsfIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05952080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJaBXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:23:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41428 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeJaBXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:23:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UGQ1qG055015;
        Tue, 30 Oct 2018 16:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RACsy7TlQ5ePWekmihqOWNZt6NL2kOPSYk0UbgDXCdc=;
 b=cvhqsfIBD7p6EExXWGNh9fN5wi0GJF0P1+5KRcYx20rKvIOqXlPc/b29Vjf7DjWmiJ+1
 6bEMLhJnPzoS0I2upxT6vUUEHv2SN3Hf0CJXZAq1Uabgfmz0ouJzhrsjXQ1qsv7B0qkR
 rlYnNoL4cWGBB9Thy6PLj89NU25Ra635DVC+nn7juaBPfpDcSOQP9sqmhocRmNcXKPhQ
 rYLc2bKCGfV8c/cYqGWVOIpAksdIndpS1s0ZWxr48z/RbSWUnFBInTrWB5mWvNkmf0dJ
 nWlNoz3PyXy9BRCTvhe7Ehy4HzuLJufa7bMjLb2fuQzAgl1DGrh9qREYED24UedEStF0 1Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nducm26pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 16:29:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UGT3Wr022025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 16:29:03 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9UGT3xT029872;
        Tue, 30 Oct 2018 16:29:03 GMT
Received: from [10.211.46.57] (/10.211.46.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 09:29:02 -0700
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: fix kernel panic with
 negotiate_mq error path
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, axboe@kernel.dk,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540837916-14356-1-git-send-email-manjunath.b.patil@oracle.com>
 <20181030103956.hew7gifjvpjviw7u@mac.citrite.net>
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
Organization: Oracle Corporation
Message-ID: <f8b9a166-e844-018d-2186-b49f54fc6fbb@oracle.com>
Date:   Tue, 30 Oct 2018 09:29:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030103956.hew7gifjvpjviw7u@mac.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 3:39 AM, Roger Pau Monné wrote:

> On Mon, Oct 29, 2018 at 11:31:56AM -0700, Manjunath Patil wrote:
>> info->nr_rings isn't adjusted in case of ENOMEM error from
>> negotiate_mq(). This leads to kernel panic in error path.
>>
>> Typical call stack involving panic -
>>   #8 page_fault at ffffffff8175936f
>>      [exception RIP: blkif_free_ring+33]
>>      RIP: ffffffffa0149491  RSP: ffff8804f7673c08  RFLAGS: 00010292
>>   ...
>>   #9 blkif_free at ffffffffa0149aaa [xen_blkfront]
>>   #10 talk_to_blkback at ffffffffa014c8cd [xen_blkfront]
>>   #11 blkback_changed at ffffffffa014ea8b [xen_blkfront]
>>   #12 xenbus_otherend_changed at ffffffff81424670
>>   #13 backend_changed at ffffffff81426dc3
>>   #14 xenwatch_thread at ffffffff81422f29
>>   #15 kthread at ffffffff810abe6a
>>   #16 ret_from_fork at ffffffff81754078
>>
>> Though either of my changes avoid the panic, I included both the
>> changes. This issue got introduced with "7ed8ce1 xen-blkfront: move
>> negotiate_mq to cover all cases of new VBDs"
>>
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> ---
>>   drivers/block/xen-blkfront.c |    7 +++++--
>>   1 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index 429d201..dc8fe25 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -1350,8 +1350,10 @@ static void blkif_free(struct blkfront_info *info, int suspend)
>>   	if (info->rq)
>>   		blk_mq_stop_hw_queues(info->rq);
>>   
>> -	for (i = 0; i < info->nr_rings; i++)
>> -		blkif_free_ring(&info->rinfo[i]);
>> +	if (info->rinfo) {
>> +		for (i = 0; i < info->nr_rings; i++)
>> +			blkif_free_ring(&info->rinfo[i]);
>> +	}
> I don't see the point in the if case here, you already fixed it by
> setting the nr_rings value which I think it's the correct way of
> fixing it.
>
> Thanks, Roger.
Thank you Roger for your comments.
I will exclude this change and send for review again.

-Thanks,
Manjunath
