Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A99C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCDA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oDK6xB3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCDA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJaBWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:22:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJaBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:22:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UGQBmP055112;
        Tue, 30 Oct 2018 16:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SM7mBkCODtz4FAhzP8nKJCqWAmrCM/Nl3VpN4x3IKfg=;
 b=oDK6xB3BGSiilZDq7q4BX1rtquy8nHJ89yOGuGtObV+PxKiimbh+70e2Oxvy0OUzXAUb
 /qCtIiIWAx4dwWM0nZEclges4OqTNq+FcGrcs8IRH2PPHhO8hkbhzd5n8ZckUqMmqKaw
 RiATVstsTuW4PVBdBuqlv7BjACyRZgPaXGGoFj+hnU1Fdn/kj+UbZkvx/+GH0RzLU9te
 nEtLF1hpLoNvZ3nFXnhzqS/Kt1CkCRQO9hhMqhj7zH1mjiBmgAhby5RqnIZ13lV6O9Vv
 M/EcgBtfo9dwbg+hOSbLRkUvvnAks1HfqS+asRkW5pk1F3SmVYvGHFz6xojS0miHaLpI JQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nducm26ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 16:27:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9UGRj1X003460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 16:27:45 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9UGRjwm029126;
        Tue, 30 Oct 2018 16:27:45 GMT
Received: from [10.211.46.57] (/10.211.46.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 09:27:45 -0700
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: fix kernel panic with
 negotiate_mq error path
To:     Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     axboe@kernel.dk, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540837916-14356-1-git-send-email-manjunath.b.patil@oracle.com>
 <65b5d648-d9dc-9248-751c-b6e15109b52e@suse.com>
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
Organization: Oracle Corporation
Message-ID: <bffbe7ff-afc9-c1b6-698f-fe3228a38760@oracle.com>
Date:   Tue, 30 Oct 2018 09:27:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <65b5d648-d9dc-9248-751c-b6e15109b52e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Thank you Juergen for your comments.

I will soon send v2 patch.

-Thanks,
Manjunath
On 10/30/2018 12:04 AM, Juergen Gross wrote:
> On 29/10/2018 19:31, Manjunath Patil wrote:
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
> Please us the correct format for specifying another commit.
>
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> Can you please add a "Fixes:" tag and "Cc: stable@vger.kernel.org" ?
>
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
> I'd drop this change.
>
>>   
>>   	kfree(info->rinfo);
>>   	info->rinfo = NULL;
>> @@ -1919,6 +1921,7 @@ static int negotiate_mq(struct blkfront_info *info)
>>   			      GFP_KERNEL);
>>   	if (!info->rinfo) {
>>   		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
>> +		info->nr_rings = 0;
>>   		return -ENOMEM;
>>   	}
>
> Juergen
>

