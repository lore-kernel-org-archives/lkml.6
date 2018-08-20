Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D90C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0DB21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VfrqvgVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0DB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeHTIfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 04:35:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57180 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeHTIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 04:35:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K5L1dY021464;
        Mon, 20 Aug 2018 05:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9/G57toJvyMsG8K7DDN2Ah+ez0/+wGxHTC6l4pRCreI=;
 b=VfrqvgVmLsfTgoqxNUXf9h3rgs9dz8JAsNE8wPQFy2a4eFm+4VESGl0TkBV+x3DxaOBk
 HmV3S/ZpbDV5lH4fQX5fN9+qvvohsz4xYmlAT1e+YVJXeDGsaAJQ/P52gnITvlVIaa+R
 +Up+a5PjbtpxyPyjGou20nG4qbsPXoBzWWpAT8LeoibyyCZS4ZN2RYlGp/ogQJpBG+nk
 K6KR9BQF5CRTFLMjbH4hzNT/+psZeR1jZmsVuNHyVax3oF5p03/j2OZEXCnHwUNrpx1Y
 UuHZooTb/Bt/gNTm/bv1UJRmc6Lu/vZ7jEdezqFxAmEba+Jr+PXr0hA+X1Z8zsPH51bu Rw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtc780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 05:21:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K5L7ng026762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 05:21:07 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7K5L6Cf013569;
        Mon, 20 Aug 2018 05:21:06 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 19 Aug 2018 22:21:05 -0700
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
 <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
 <CACVXFVMqjiSmzL2JeLUV2Q4bXqy2WRNHahg-fusFYjHeCX3gng@mail.gmail.com>
 <3ce9f249-4c2f-89a6-727f-9bc449a4fdf4@oracle.com>
 <20180820041833.GB21600@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <edbed43c-8470-c803-02b4-8d55fed781a9@oracle.com>
Date:   Mon, 20 Aug 2018 13:21:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820041833.GB21600@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/20/2018 12:18 PM, Ming Lei wrote:
> On Mon, Aug 20, 2018 at 11:57:52AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 08/20/2018 10:24 AM, Ming Lei wrote:
>>>> The code path is:
>>>>
>>>> elevator_release
>>>>   -> elevator_put(e->type)
>>>>     -> module_put(e->elevator_owner)
>>>>
>>>> In normal elevator switch path, elevator_get will hold a reference counter of the
>>>> elevator_owner.
>>>> In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
>>>> is removed, we need to hold a reference of the module.
>>> Yeah, I agree that the module reference need to be held, but it need to be
>>> released too.
>>>
>>> My concern is that this introduced getting module reference in your patch
>>> isn't released. The module reference is a counter too, so the get and
>>> put operation should be matched.
>>
>> elevator_switch_mq
>>   -> elevator_exit
>> it will put a reference count of the elevator_queue associated with the request_queue.
>> and the elevator_release will be invoked when the reference count of elevator_queue->kobj reaches zero.
>> elevator_release will put the reference count of the io scheduler module.
>>
>> the elevator_queue structure will be allocated and freed every time when we switch io scheduler.
>> so the elevator_release will always be invoked.
>>
>> This is the put ref corresponding to the get one in this patch.
> 
> OK, got it, the added __module_get() is just like what elevator_get()
> does from __elevator_change(). Sorry for the noise.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Thanks very much for your reviewing.

I will add more comment to describe the added __module_get() in the V3.

Thanks
Jianchao
 

> Thanks,
> Ming
> 
