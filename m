Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE47CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535F021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJZLEBwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535F021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbeIUILV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:11:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42274 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388834AbeIUILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:11:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L2IwFv130896;
        Fri, 21 Sep 2018 02:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dK7Wd4JjugwRyKk/c6Ov5RffKItQ9ulG6HAvmAfj8qo=;
 b=bJZLEBwQl+LyPh25lcORDQ3j3CneLhj/8sGZ58guaL3FaounXUXbI94iZ81etA8M1t4j
 HAG7MMxz0KVWq52pO7SGgwCZSerJnpeTvexKsvYD+G92zxt71EWk7vmj5xDa5z6FETwV
 75XsaPCHftAVJ29jjVYYTg2oEi3UcD6TD+8QEtFaJ7ysDwuEKmogZKK8sgO0eLgdulYZ
 JJ7kTlllLzJetpESJiV3bbrTxoMjg5qurW+KGITiIrhMi+M7/FFW+OfnpaeoE5rNHGdL
 f2RKnAy+jIgpsCBhsjTJGXIbhasoHLrGKE7Ht88ToTuDQDYf8skKvUXHeGar9E39jyvY lg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mmkm20mrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 02:24:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8L2OcFp009556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 02:24:39 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8L2Ocpi003351;
        Fri, 21 Sep 2018 02:24:38 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 19:24:38 -0700
Subject: Re: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        tj@kernel.org, kent.overstreet@gmail.com, ming.lei@redhat.com,
        bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537463217.224533.4.camel@acm.org>
 <0e6caed5-33eb-e645-f452-3dfc6c20206d@oracle.com>
 <4a6c3930-1f90-6a9b-ba25-882b1c9102e2@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a8faeb4a-549a-05b3-6bb9-5611a1cff850@oracle.com>
Date:   Fri, 21 Sep 2018 10:24:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4a6c3930-1f90-6a9b-ba25-882b1c9102e2@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart

On 09/21/2018 10:13 AM, Bart Van Assche wrote:
> On 9/20/18 6:51 PM, jianchao.wang wrote:
>> Hi Bart
>>
>> On 09/21/2018 01:06 AM, Bart Van Assche wrote:
>>> On Thu, 2018-09-20 at 18:18 +0800, Jianchao Wang wrote:
>>>> The current queue freeze depending on percpu_ref_kil/reinit has a limit that
>>>> we have drain the requests before unfreeze the queue.
>>>>
>>>> Let's rework the queue freeze feature as following:
>>>> 1. introduce __percpu_ref_get_many.
>>>>     It is same with original percpu_ref_get_many, but just need callers to provide
>>>>     sched rcu critical section. We will put the __percpu_ref_get_many and our own
>>>>     condition checking under rcu_read_lock_sched. With this new helper interface,
>>>>     we could save an extra rcu_read_lock_sched.
>>>> 2. rework the blk_queue_enter as:
>>>>         rcu_read_lock_sched()
>>>>     if condition check true
>>>>       __percpu_ref_get_many(&q->q_usage_counter, 1)
>>>>     else
>>>>       goto wait
>>>>     rcu_read_unlock_sched()
>>>> 3. use percpu_ref_switch_to_atomic/percpu to switch mode directly.
>>>>
>>>> Then we could unfreeze the queue w/o draining requests.
>>>> In addition, preempt-only mode code could be simplified.
>>> Hello Jianchao,
>>>                                                                             =
>>> Thanks for having taken a look. However, the approach of this patch series
>>> may be more complicated than necessary. Had you considered something like
>>> the patch below?
>>
>> This patch is just a trying that let our life easier w/o changing anything in percpu-ref code. :)
>> In fact, the 1st patch which introduces a new non-functional-changing helper interface in
>> percpu-ref code is not necessary.
>>
>> This patchset just implement our own condition checking in blk_queue_enter instead of depending on
>> __PERCPU_REF_DEAD checking in percpu_ref_tryget_live.
>>
>> Then we could do more thing here, like:
>>   - unfreeze the queue without draining requests.
>>   - check whether q->q_usage_counter is zero
>>   - add other gate conditions into blk_queue_enter, such as preempt-only, even any others.
>>
>> So why not try it ?
> 
> Hello Jianchao,
> 
> Some time ago Tejun wrote that he wants to keep the dependency of the percpu_ref implementation on rcu-sched inside the percpu_ref implementation because he would like to have the freedom to switch to regular RCU. Your patch series makes the dependency of percpu_ref counters on rcu-sched visible outside the percpu_ref implementation. I think that's a disadvantage of your approach. Tejun, please correct me if I misunderstood you.

It will be easy to fix this through adding some other interfaces like:

percpu_ref_lock/unlock
{
    rcu_read_lock/unlock_sched
}

But things is up to Tejun that whether he agrees to do like this.
 
Thanks
Jianchao
 
