Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375FECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68492154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6JQYyNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68492154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbeIUHib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:38:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42578 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIUHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:38:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L1mfu9087856;
        Fri, 21 Sep 2018 01:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=R1OsPXs2IChasZKAd3Ol0KhxnfXoOMvCbpEybs2m8ko=;
 b=T6JQYyNMoAQlE/SO4hYk7dgvIX5UUV9cAaeNFK29Gg+yQPev9WmrUrxiAsEA5q2Tw2YT
 xiinHXTdS4nkhMUakYyBpUgLSfq05/Fn8/g++2RR0MPr/WFzF3gOfQSeJccTxQklwv83
 75V4d7bL4xNFPWrIh8fpL2y4yn+FgXUJ4GLAIyutSCSeNufPPaLQaz3W3xpb0YcjvnEh
 xY6HKLpsFpPrTJLIb4Vfaia8OkxLkJJlP2puyMZ0D65AlzLvtzNLjZ5TUA6EFL3KmyfK
 //0+WOCIZyumAdcFqKOcWVEaaS6gYQBxKUIbr7evi+/BWEIjSATUZKYUG5W4E2vCKXj9 jA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mmkm20k7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 01:51:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8L1pfnR012786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 01:51:42 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8L1pftJ024707;
        Fri, 21 Sep 2018 01:51:41 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 18:51:41 -0700
Subject: Re: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        tj@kernel.org, kent.overstreet@gmail.com, ming.lei@redhat.com,
        bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537463217.224533.4.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0e6caed5-33eb-e645-f452-3dfc6c20206d@oracle.com>
Date:   Fri, 21 Sep 2018 09:51:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537463217.224533.4.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 09/21/2018 01:06 AM, Bart Van Assche wrote:
> On Thu, 2018-09-20 at 18:18 +0800, Jianchao Wang wrote:
>> The current queue freeze depending on percpu_ref_kil/reinit has a limit that
>> we have drain the requests before unfreeze the queue.
>>
>> Let's rework the queue freeze feature as following:
>> 1. introduce __percpu_ref_get_many.
>>    It is same with original percpu_ref_get_many, but just need callers to provide
>>    sched rcu critical section. We will put the __percpu_ref_get_many and our own
>>    condition checking under rcu_read_lock_sched. With this new helper interface,
>>    we could save an extra rcu_read_lock_sched.
>> 2. rework the blk_queue_enter as:
>>    
>>    rcu_read_lock_sched()
>>    if condition check true
>>      __percpu_ref_get_many(&q->q_usage_counter, 1)
>>    else
>>      goto wait
>>    rcu_read_unlock_sched()
>> 3. use percpu_ref_switch_to_atomic/percpu to switch mode directly.
>>
>> Then we could unfreeze the queue w/o draining requests.
>> In addition, preempt-only mode code could be simplified.
> Hello Jianchao,
>                                                                            =
> Thanks for having taken a look. However, the approach of this patch series
> may be more complicated than necessary. Had you considered something like
> the patch below?

This patch is just a trying that let our life easier w/o changing anything in percpu-ref code. :)
In fact, the 1st patch which introduces a new non-functional-changing helper interface in
percpu-ref code is not necessary.

This patchset just implement our own condition checking in blk_queue_enter instead of depending on
__PERCPU_REF_DEAD checking in percpu_ref_tryget_live.

Then we could do more thing here, like:
 - unfreeze the queue without draining requests.
 - check whether q->q_usage_counter is zero
 - add other gate conditions into blk_queue_enter, such as preempt-only, even any others.

So why not try it ?

Thanks
Jianchao
