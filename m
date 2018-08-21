Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D06C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7524921581
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j8WXgwZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7524921581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeHUKgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:36:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47560 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:36:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7L7EI3x060279;
        Tue, 21 Aug 2018 07:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=t/TthygHuB5vcQaBCdvDGh7YmGWB1WHjRAhPrMG/A/s=;
 b=j8WXgwZIqgv5Le5FaNNTHl77QCyfeY4hEHlSg89lWYec72vjAd7M912xHvQqlYkv2FSO
 CU3JkI5xmdI0Ec/vrrLV1a5QrXXEDBqxtwIqIdOgjpKtRnctJ4FRZeN1lFrZiQhkG99U
 Msps73FEmoGYO6e/UGxTeUIE4DzoeO2Ctxl3ELLJr8qciq/8rnziIM2hkYtv11PnGsvt
 d59TNSOb19NlYbhYIGYNeBDj1DP7JMwIDw0wz9VAeKuv9kcIHDatKhaboPixlnZygjyI
 cupxov8pZw8QlVvMfPwdKYuJkKWZQVXOhxhp6ejumQyY5RhiUqL+G2qLN2tA5OjzcYYc hA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kxc3qjgbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:17:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7L7HpnD006634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:17:52 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7L7Hpf9023881;
        Tue, 21 Aug 2018 07:17:51 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 00:17:51 -0700
Subject: Re: [PATCH V3 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534749606-7311-2-git-send-email-jianchao.w.wang@oracle.com>
 <048cdf08-6c9e-f54a-1e5c-f1d40fb2ecdb@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a9379a69-cfaf-56b5-9c2b-b4c4e35f6a67@oracle.com>
Date:   Tue, 21 Aug 2018 15:18:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <048cdf08-6c9e-f54a-1e5c-f1d40fb2ecdb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 08/20/2018 10:45 PM, Jens Axboe wrote:
> On 8/20/18 1:20 AM, Jianchao Wang wrote:
>> @@ -2913,6 +2906,29 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>  		blk_mq_freeze_queue(q);
>>  
>> +	/*
>> +	 * switch io scheduler to NULL to clean up the data in it.
>> +	 * will get it back after update mapping between cpu and hw queues.
>> +	 */
> 
> "Switch IO scheduler to 'none', cleaning up the data associated with
> the previous scheduler. We'll switch back once we're done updating
> the new sw to hw queue mappings.
> 
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +		if (!q->elevator) {
>> +			q->elv_type = NULL;
>> +			continue;
>> +		}
>> +		q->elv_type = q->elevator->type;
>> +		mutex_lock(&q->sysfs_lock);
>> +		/*
>> +		 * After elevator_switch_mq, the previous elevator_queue will be
>> +		 * released by elevator_release. The reference of the io scheduler
>> +		 * module get by elevator_get will also be put. So we need to get
>> +		 * a reference of the io scheduler module here to prevent it to be
>> +		 * removed.
>> +		 */
>> +		__module_get(q->elv_type->elevator_owner);
>> +		elevator_switch_mq(q, NULL);
>> +		mutex_unlock(&q->sysfs_lock);
>> +	}
> 
> I don't hate this, but I also find it pretty annoying to put local state
> into the queue itself. It would be much nicer _not_ to have ->elv_type
> in the queue itself. That would need an allocation, however...
> 
> Apart from those two things, looks fine to me.
> 

Thanks very much for your comment.
I have reworked this patch based on your kindly suggestion and posted the V4.

Thanks
Jianchao
