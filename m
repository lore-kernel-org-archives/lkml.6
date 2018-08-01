Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC172C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972B320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJkbndeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972B320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeHAEAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 00:00:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeHAEAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 00:00:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w712E94M012935;
        Wed, 1 Aug 2018 02:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZUoP2wAB7EnfwZubhaVMr3U3AWDwooqrrf6XVae3gog=;
 b=CJkbndeEQ9gxV3jL+i7oOpUrwbjmlBZnr/+7LaEWGdJNiKTTeZeswQFpxx5lcPO8KYnL
 I3/VukGCXhmFL95BD0KWg3X8TrBtkjGlkIUB/XYfPNC5iacmbNQgfYiEE/1Trp1LUU4r
 ltjpw17vUuesLm4qaclpWCI7LxU+bzrU6T2pwOS5OFciIqERTkEbahNZf2I38RCsn1Rc
 nTu0JTmok/NBKjRGf+cqKdrEgsFjx4ZxVSntPEfVrbQsm7r7XLkn59HCf8wATuZUziHy
 yHAV8uHww6jvA4pBJBRaQm95pKKTqudKf5M2BSfUrIRWYEjsXCJRE+ZWoA07lbzhvnpt OA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kggep3gnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 02:17:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w712HUDF006216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 02:17:31 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w712HTUI029207;
        Wed, 1 Aug 2018 02:17:30 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 19:17:29 -0700
Subject: Re: [RFC] blk-mq: clean up the hctx restart
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
Date:   Wed, 1 Aug 2018 10:17:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731061616.GF15701@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your kindly response.

On 07/31/2018 02:16 PM, Ming Lei wrote:
> On Tue, Jul 31, 2018 at 01:19:42PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 07/31/2018 12:58 PM, Ming Lei wrote:
>>> On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
>>>> Currently, we will always set SCHED_RESTART whenever there are
>>>> requests in hctx->dispatch, then when request is completed and
>>>> freed the hctx queues will be restarted to avoid IO hang. This
>>>> is unnecessary most of time. Especially when there are lots of
>>>> LUNs attached to one host, the RR restart loop could be very
>>>> expensive.
>>>
>>> The big RR restart loop has been killed in the following commit:
>>>
>>> commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
>>> Author: Ming Lei <ming.lei@redhat.com>
>>> Date:   Mon Jun 25 19:31:48 2018 +0800
>>>
>>>     blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
>>>
>>>
>>
>> Oh, sorry, I didn't look into this patch due to its title when iterated the mail list,
>> therefore I didn't realize the RR restart loop has already been killed. :)
>>
>> The RR restart loop could ensure the fairness of sharing some LLDD resource,
>> not just avoid IO hung. Is it OK to kill it totally ?
> 
> Yeah, it is, also the fairness might be improved a bit by the way in
> commit 97889f9ac24f8d2fc, especially inside driver tag allocation
> algorithem.
> 

Would you mind to detail more here ?

Regarding the driver tag case:
For example:

q_a         q_b        q_c       q_d
hctx0       hctx0      hctx0     hctx0

                 tags

Total number of tags is 32
All of these 4 q are active.

So every q has 8 tags.

If all of these 4 q have used up their 8 tags, they have to wait.

When part of the in-flight requests q_a are completed, tags are freed.
but the __sbq_wake_up doesn't wake up the q_a, it may wake up q_b.
However, due to the limits in hctx_may_queue, q_b still cannot get the
tags. The RR restart also will not wake up q_a.
This is unfair for q_a.

When we remove RR restart fashion, at least, the q_a will be waked up by
the hctx restart.
Is this the improvement of fairness you said in driver tag allocation ?

Think further, it seems that it only works for case with io scheduler.
w/o io scheduler, tasks will wait in blk_mq_get_request. restart hctx will
not work there.

Thanks
Jianchao

