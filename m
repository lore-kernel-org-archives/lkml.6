Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B2C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69D92083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDfYVtO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69D92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeFTBhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:37:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753917AbeFTBhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:37:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K1XNkF035750;
        Wed, 20 Jun 2018 01:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=cyfOJj/q4HDMe6/eFoIHL5prKv3ynLX42mHJdtwjUbk=;
 b=HDfYVtO2cbT9xy3yOLU2+cMsa6R18e3R35hx/B+nf41qHU+5ea+o8ZOZwXcUvE/DTG5M
 xE4R0EMrsouW8g2S+T4o2ufkINKcmlMpKkwR6mdoKH4PGlqR1l8jZwXl78LzTMR95srz
 yG/jIsCEzpqgcne9IWQlDZKpRkw8T1EuIFVoqi4fs7+dYAMqFTzIrdi1N5skl9juaBi7
 IrNFwSd+IXZBl+YzEPUiKWMXrQYKd9NQ9mAwkCzzFfQE4yMTyWmdnZyuh80hGmISfYWu
 DvsarjN3a+4tZ5Szp5V/fa3EQdyHpNsOrV7wzLMebljVjOyHFW4itT5TUZjzV+5nKKyv hA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgwtfdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 01:37:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K1b5nU009976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 01:37:05 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K1b57n020449;
        Wed, 20 Jun 2018 01:37:05 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 18:37:04 -0700
Subject: Re: [PATCH] blk-mq: use blk_mq_timeout_work to limit the max timeout
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391610-1654-1-git-send-email-jianchao.w.wang@oracle.com>
 <884a5cbb5622ca5c890585a8d5dff0e3a1d60cfe.camel@wdc.com>
 <dd0484f6-ad41-5607-107f-4c487a739478@oracle.com>
 <08b5a3e94f2265815a98abae7a8dde0894512d4e.camel@wdc.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e75238d6-aefb-3673-1ce8-991f7fedfea6@oracle.com>
Date:   Wed, 20 Jun 2018 09:37:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <08b5a3e94f2265815a98abae7a8dde0894512d4e.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 09:35 AM, Bart Van Assche wrote:
> On Wed, 2018-06-20 at 09:28 +0800, jianchao.wang wrote:
>> Hi Bart
>>
>> Thanks for your kindly response.
>>
>> On 06/19/2018 11:18 PM, Bart Van Assche wrote:
>>> On Tue, 2018-06-19 at 15:00 +0800, Jianchao Wang wrote:
>>>> blk_rq_timeout is needed to limit the max timeout value, otherwise,
>>>> a idle hctx cannot be deactivated timely in shared-tag case.
>>>>
>>>> Fixes: 12f5b931 (blk-mq: Remove generation seqeunce)
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>> ---
>>>>  block/blk-mq.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 70c65bb..ccebe7b 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -868,7 +868,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
>>>>  	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
>>>>  
>>>>  	if (next != 0) {
>>>> -		mod_timer(&q->timeout, next);
>>>> +		mod_timer(&q->timeout, blk_rq_timeout(round_jiffies_up(next)));
>>>>  	} else {
>>>>  		/*
>>>>  		 * Request timeouts are handled as a forward rolling timer. If
>>>
>>> Hello Jianchao,
>>>
>>> What makes you think that it would be necessary to call blk_rq_timeout() from
>>> blk_mq_timeout_work()? Have you noticed that blk_add_timer() already calls that
>>> function? I think it is not necessary to call blk_rq_timeout() from
>>> blk_mq_timeout_work() because it is guaranteed in that function that the next
>>> timeout is less than BLK_MAX_TIMEOUT jiffies in the future.
>>>
>>
>> blk_add_timer will not re-arm the timer if the timer's expire value is before the new rq's expire value.
>>
>> Let's look at the following scenario.
>>
>> 0                    +30s
>>> __________________|___|
>>
>> T0                T1   T2
>>
>> T1 = T2 - 1 jiffies 
>>
>> T0:  rq_a is issued and q->timer is armed and will expire at T2
>>      then rq_a is completed.
>> T1:  rq_b is issued and q->timer is not re-armed, because its next expire time is T2 < (T1 + 30s)
>>
>> T2:  if rq_b have not been completed when timer expires at T2, timer would be re-armed based on the rq_b 
>>      If we don't have blk_rq_timeout here, the next expire time is about T2 + 30s.
> 
> Hello Jianchao,
> 
> I disagree with the last sentence above. I think for your example blk_mq_req_expired()
> will set next to T1 + 30s instead of T2 + 30s.
> 

Would you please explain the reason ?

Thanks
Jianchao

> Bart.
> 
> 
