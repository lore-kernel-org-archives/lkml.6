Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71470C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EA12154D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mu9ej5LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA12154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbeIUHcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:32:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:32:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L1iITg050842;
        Fri, 21 Sep 2018 01:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DS5mFuT8Dw6JT4X16jq625KjbPbNoLSdAn2WyrJ3jfw=;
 b=mu9ej5LYW+MjDIyKpZsPzIH+AqrGtZWtC8ffQLZVGlQarJrHPYvxn+5Z59sxHWsBQzLy
 +VC5Q8vZV2kXujWS/uJJPe0moiGGWdA8JuvCrnnjHvS8LQZLvNmjziaYpsU9QANhBiN8
 GlhA++zB7ycEp5dV1lciJDESFGSyAzRwNMJpKtg9RQiPgNoWdaf4citwCeiV9Q9E4+/g
 11BOTGsXefICx8YxpIfcclgg7mqLKM+I/7GdJUkblavKK6J9eaV/m0sv3PSZhk6BS+YK
 ZgDgYwe3lNSCCec3yD2rm/iqC//yT5FIql1PawHK6arh42/qi7f6CRACWg6lkEwgIPPF aA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mmkm20jnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 01:45:41 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8L1jaun027608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 01:45:36 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8L1jZZ1012094;
        Fri, 21 Sep 2018 01:45:35 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 18:45:34 -0700
Subject: Re: [PATCH 1/3] percpu_ref: add a new helper interface
 __percpu_ref_get_many
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, kent.overstreet@gmail.com, ming.lei@redhat.com,
        bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180920205333.GF902964@devbig004.ftw2.facebook.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <2659fd02-fc20-cada-c43e-fac12827d1ad@oracle.com>
Date:   Fri, 21 Sep 2018 09:45:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920205333.GF902964@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun

Thanks for your kindly response.

On 09/21/2018 04:53 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 20, 2018 at 06:18:21PM +0800, Jianchao Wang wrote:
>> -static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>> +static inline void __percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>>  {
>>  	unsigned long __percpu *percpu_count;
>>  
>> -	rcu_read_lock_sched();
> 
> So, if we're gonna do this (please read below tho), please add the
> matching assertion

Yes, I will.

> 
>>  	if (__ref_is_percpu(ref, &percpu_count))
>>  		this_cpu_add(*percpu_count, nr);
>>  	else
>>  		atomic_long_add(nr, &ref->count);
>> +}
>>  
>> +/**
>> + * percpu_ref_get_many - increment a percpu refcount
>> + * @ref: percpu_ref to get
>> + * @nr: number of references to get
>> + *
>> + * Analogous to atomic_long_add().
>> + *
>> + * This function is safe to call as long as @ref is between init and exit.
>> + */
>> +static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>> +{
>> +	rcu_read_lock_sched();
>> +	__percpu_ref_get_many(ref, nr);
>>  	rcu_read_unlock_sched();
>>  }
> 
> And add the matching variant for get/put with and without _many.

Yes.

> 
> Ming, so, if we make locking explicit like above, I think it should be
> fine to share the locking.  However, please note that percpu_ref and
> blk_mq are using different types of RCU, at least for now, and I'm not
> really sure that unifying that and taking out one rcu read lock/unlock
> is a meaningful optimization.
> 

Essentially, I want to rework the current queue freeze which depends on
percpu_ref_kil/reinit. We implement our own condition checking instead of
using the __PERCPU_REF_DEAD checking in percpu_ref_tryget_live. And use
percpu with percpu_ref_switch_to_atomic/percpu to switch the percpu ref
mode between percpu and atimic directly. Then it will be more convenient
to implement:
 - unfreeze the queue without draining requests.
 - check whether q->q_usage_counter is zero
 - add other gate conditions into blk_queue_enter, such as preempt-only

So I want to put the condition checking and percpu_ref_get_many into a
same sched rcu critical section.
 rcu_read_lock_sched()
   if condition check true
     percpu_ref_get_many(&q->q_usage_counter, 1)
   else
     goto wait
   rcu_read_unlock_sched()

Then we could freeze the queue like:
  set FROZEN flag on q
  percpu_ref_put(1)
  percpu_ref_switch_to_atomic
Otherwise, we may need a synchronize_rcu.
It is not for performance.

Is there any reason that why blk_queue_enter only could use rcu lock instead of
the sched rcu lock ?


> Let's please first do something straight-forward.  If somebody can
> show that this actually impacts performance, we can optimize it but
> right now all these seem premature to me.

Adding this interface is just for saving an extra rcu_read_lock/unlock_sched pair.
If it doesn't make any sense, It is OK for me to discard it. :)

Thanks
Jianchao
