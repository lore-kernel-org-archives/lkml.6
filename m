Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4662720894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LOd8N7SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4662720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbeHAPXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:23:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389274AbeHAPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:23:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71DXuBK078392;
        Wed, 1 Aug 2018 13:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KuIu9GviHXk2GtCgYVKtfn/HUf0SqS9t3fmtTcMOeYg=;
 b=LOd8N7SUCSboj7qjQg5Vy6Vr53c9tk6dvgrZhrIykDzNNK2pmw1SeQTJI728j18tw3tE
 Gd0vcxe16MrZ3F65cD3iBceq0knP74HjLDS8wvOJxRQZSKNDRqaL6CgcV6W/EFLl2zqR
 Dcso1fNhfoDRLuFOuTLsDiIa/WofCBvZESbGF9imqVujQsAG45rfEHmeKeTLijTSQhx4
 hIP9ldDaTf2yRbeK2rYlrmYWUPfoAXYnXArDC+qWYP02e0PWWrYvKBHatEL20Q/PHyrD
 bItWIH6EGsOc9E5DZZgMK6Fd58vlmSWpPVPDbYlan/TG96a/9dtfDnCIIqX6WWSz6GBk zQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kgh4q5kmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 13:37:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w71DbAKE012951
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 13:37:10 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71Db9c8031902;
        Wed, 1 Aug 2018 13:37:09 GMT
Received: from [10.191.20.18] (/10.191.20.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 06:37:09 -0700
Subject: Re: [RFC] blk-mq: clean up the hctx restart
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <dee91f9a-e681-b2d4-342b-5bf085464558@oracle.com>
Date:   Wed, 1 Aug 2018 21:37:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801085841.GA27962@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 08/01/2018 04:58 PM, Ming Lei wrote:
> On Wed, Aug 01, 2018 at 10:17:30AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> Thanks for your kindly response.
>>
>> On 07/31/2018 02:16 PM, Ming Lei wrote:
>>> On Tue, Jul 31, 2018 at 01:19:42PM +0800, jianchao.wang wrote:
>>>> Hi Ming
>>>>
>>>> On 07/31/2018 12:58 PM, Ming Lei wrote:
>>>>> On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
>>>>>> Currently, we will always set SCHED_RESTART whenever there are
>>>>>> requests in hctx->dispatch, then when request is completed and
>>>>>> freed the hctx queues will be restarted to avoid IO hang. This
>>>>>> is unnecessary most of time. Especially when there are lots of
>>>>>> LUNs attached to one host, the RR restart loop could be very
>>>>>> expensive.
>>>>>
>>>>> The big RR restart loop has been killed in the following commit:
>>>>>
>>>>> commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
>>>>> Author: Ming Lei <ming.lei@redhat.com>
>>>>> Date:   Mon Jun 25 19:31:48 2018 +0800
>>>>>
>>>>>     blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
>>>>>
>>>>>
>>>>
>>>> Oh, sorry, I didn't look into this patch due to its title when iterated the mail list,
>>>> therefore I didn't realize the RR restart loop has already been killed. :)
>>>>
>>>> The RR restart loop could ensure the fairness of sharing some LLDD resource,
>>>> not just avoid IO hung. Is it OK to kill it totally ?
>>>
>>> Yeah, it is, also the fairness might be improved a bit by the way in
>>> commit 97889f9ac24f8d2fc, especially inside driver tag allocation
>>> algorithem.
>>>
>>
>> Would you mind to detail more here ?
>>
>> Regarding the driver tag case:
>> For example:
>>
>> q_a         q_b        q_c       q_d
>> hctx0       hctx0      hctx0     hctx0
>>
>>                  tags
>>
>> Total number of tags is 32
>> All of these 4 q are active.
>>
>> So every q has 8 tags.
>>
>> If all of these 4 q have used up their 8 tags, they have to wait.
>>
>> When part of the in-flight requests q_a are completed, tags are freed.
>> but the __sbq_wake_up doesn't wake up the q_a, it may wake up q_b.
> 
> 1) in case of IO scheduler
> q_a should be waken up because q_a->hctx0 is added to one wq of the tags if
> no tag is available, see blk_mq_mark_tag_wait().
> 
> 2) in case of none scheduler
> q_a should be waken up too, see blk_mq_get_tag().
> 
> So I don't understand why you mentioned that q_a can't be waken up.

There are multiple sbq_wait_states in one sbitmap_queue and __sbq_wake_up
will only wake up the waiters on one of them one time. Please refer to __sbq_wake_up.

> 
>> However, due to the limits in hctx_may_queue, q_b still cannot get the
>> tags. The RR restart also will not wake up q_a.
>> This is unfair for q_a.
>>
>> When we remove RR restart fashion, at least, the q_a will be waked up by
>> the hctx restart.
>> Is this the improvement of fairness you said in driver tag allocation ?
> 
> I mean the fairness is totally covered by the general tag allocation
> algorithm now, which is sort of FIFO style because of waitqueue, but RR
> restart wakes up queue in the order of request queue.

Yes, I got your point.

> 
>>
>> Think further, it seems that it only works for case with io scheduler.
>> w/o io scheduler, tasks will wait in blk_mq_get_request. restart hctx will
>> not work there.
> 
> When one tag is freed, the sbitmap queue will be waken up, then some of
> allocation may be satisfied, this way works for both IO sched and none.
> 
> Thanks, 
> Ming
> 
