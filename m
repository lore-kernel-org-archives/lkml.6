Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8762148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GqIDM8LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8762148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390432AbeHPMTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:19:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeHPMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:19:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7G9IpLT012350;
        Thu, 16 Aug 2018 09:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=N6UNoeuLUqBzuX6fo923I1SNsCQl1mjHmLxlcaQghrw=;
 b=GqIDM8LKxFCotAR1V6tbBV7eh48rk5RVR6i/8yppXkCWhfQ6Vp1t/YbVmMqtlYqaKJjO
 lKJsZ54aqqd1SLHaKJQDBoon4ORLPVtLSTC5mIQVP8Tf9ilXpr8bm2j7YygMSDP1tkrq
 VZg5WaP7zKhI7OsBK3nI8GVZdBEAFwqfOe7Aa0vWbvNMQ4FEohT0gDtIDO4kbXBimmD4
 AOpe68yCyOiZdg39itYcQ9v0y+axA2jIhSEM+VCtt5zDNs+So/oL7mmklG83UR3NDvOP
 3D8pcshb/sRC5XAKilJAQCEyIMLj3GO4FTGNQavqc1zxffHvPW6n5AoVaAdjB39XAV50 TA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ksreq99c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Aug 2018 09:20:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7G9KfWI012343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Aug 2018 09:20:41 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7G9Kfps026095;
        Thu, 16 Aug 2018 09:20:41 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Aug 2018 02:20:40 -0700
Subject: Re: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with
 part_in_flight
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVO+g2ACx9XYx4XtwRkpSC9bCYeSFEj07Z==6r7nT-HxkQ@mail.gmail.com>
 <8cd103e6-0986-2c45-00f2-8a2a540a2eb5@oracle.com>
 <20180816090334.GA7144@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f3fad2f5-9ab5-438a-d5a6-93c637921378@oracle.com>
Date:   Thu, 16 Aug 2018 17:20:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816090334.GA7144@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8986 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808160098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 08/16/2018 05:03 PM, Ming Lei wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b42a2c9ba00e..fbc5534f8178 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -113,6 +113,10 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>  	struct mq_inflight mi = { .part = part, .inflight = inflight, };
>  
>  	inflight[0] = inflight[1] = 0;
> +
> +	if (percpu_ref_is_dying(&q->q_usage_counter))
> +		return;
> +
>  	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
>  }

That's a good idea to use q->q_usage_counter.
But I think we could do following modification:
1. use percpu_ref_is_zero, then we will not miss any in-flight request here.
2. use rcu to ensure the user of blk_mq_in_flight has gone out of the critical section.

Like following patch:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 89904cc..cd9878e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -113,7 +113,12 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 
        inflight[0] = inflight[1] = 0;
 
+       rcu_read_lock();
+       if (percpu_ref_is_zero(&q->q_usage_counter))
+               return;
+
        blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+       rcu_read_unlock();
 }
 
 static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
@@ -2907,6 +2912,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
        list_for_each_entry(q, &set->tag_list, tag_set_list)
                blk_mq_freeze_queue(q);
 
+       synchronize_rcu();
        /*
         * switch io scheduler to NULL to clean up the data in it.
         * will get it back after update mapping between cpu and hw queues.

And also, some comment is needed to describe them. ；）

Thanks
Jianchao
