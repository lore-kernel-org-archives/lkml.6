Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B3C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8882B20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4E/lmG4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8882B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeIFSav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:30:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53350 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIFSav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:30:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86Dmi8J086823;
        Thu, 6 Sep 2018 13:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SHwC4gFiBR9oL2bQhEYndf0K0ioWACrbe84zjfgML1M=;
 b=4E/lmG4pPMLb4VCuRQjpw3lFzuhxfyN2JGkJhR4sOUXAg5ywp2D9XifImLQAddm/iwte
 hzfyuJ3dewy8tsjdFVlTUhgHR21cjBT575G9vi9XSzEKWKbdtBrcehSGG2e3fidBT7eD
 63jGfBK3uuqimkCJhPmM6x+q3yL4iywApD1/XQrUz9ibmtWNxFH+USOaeZ5q15gZ1K5g
 +IJaeX67SkxNX7YviBWuy0vIUWO+Y17o/UnwRL+uIVU0W3ZU4MM3VaHYpi8ccFx/AfJb
 Kl+IywUT9kUI89uyArqg4mN/AksgVqHMTYuHctRp937jSh89CrAJzzyf1pyHvqjTXXOf 7A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m7j6tva5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 13:54:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86DsWbI021689
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 13:54:32 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w86DsW5R006790;
        Thu, 6 Sep 2018 13:54:32 GMT
Received: from [10.191.31.201] (/10.191.31.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 06:54:32 -0700
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, keith.busch@intel.com, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        jthumshirn@suse.de, bart.vanassche@wdc.com
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180905212659.GB21352@ming.t460p>
 <b7074098-ab79-53b2-5cc6-25f859c4c666@oracle.com>
 <20180906125659.GA31250@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <51b4019b-8773-b76d-ee00-4399a86dbf16@oracle.com>
Date:   Thu, 6 Sep 2018 21:55:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906125659.GA31250@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 08:57 PM, Ming Lei wrote:
> On Thu, Sep 06, 2018 at 09:51:43AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/06/2018 05:27 AM, Ming Lei wrote:
>>> On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
>>>> Dear all
>>>>
>>>> As we know, queue freeze is used to stop new IO comming in and drain
>>>> the request queue. And the draining queue here is necessary, because
>>>> queue freeze kills the percpu-ref q_usage_counter and need to drain
>>>> the q_usage_counter before switch it back to percpu mode. This could
>>>> be a trouble when we just want to prevent new IO.
>>>>
>>>> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
>>>> nvme_reset_work will unfreeze and wait to drain the queues. However,
>>>> if IO timeout at the moment, no body could do recovery as nvme_reset_work
>>>> is waiting. We will encounter IO hang.
>>>
>>> As we discussed this nvme time issue before, I have pointed out that
>>> this is because of blk_mq_unfreeze_queue()'s limit which requires that
>>> unfreeze can only be done when this queue ref counter drops to zero.
>>>
>>> For this nvme timeout case, we may relax the limit, for example,
>>> introducing another API of blk_freeze_queue_stop() as counter-pair of
>>> blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
>>> from atomic mode inside the new API.
>>
>> Looks like we cannot switch a percpu-ref to percpu mode directly w/o drain it.
>> Some references maybe lost.
>>
>> static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
>> {
>> 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
>> 	int cpu;
>>
>> 	BUG_ON(!percpu_count);
>>
>> 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
>> 		return;
>>
>> 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
>>
>> 	/*
>> 	 * Restore per-cpu operation.  smp_store_release() is paired
>> 	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
>> 	 * zeroing is visible to all percpu accesses which can see the
>> 	 * following __PERCPU_REF_ATOMIC clearing.i
>> 	 */
>> 	for_each_possible_cpu(cpu)
>> 		*per_cpu_ptr(percpu_count, cpu) = 0;
>>
>> 	smp_store_release(&ref->percpu_count_ptr,
>> 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
> 
> Before REF_ATOMIC is cleared, all counting is done on the atomic type
> of &ref->count, and it is easy to keep the reference counter at
> ATOMIC mode. Also the reference counter can only be READ at atomic mode.
> 
> So could you explain a bit how the lost may happen? And it is lost at
> atomic mode or percpu mode?

I just mean __percpu_ref_switch_percpu just zeros the percpu_count.
It doesn't give the original values back to the percpu_count from atomic count

> 
>> }
>>
>>>
>>>>
>>>> So introduce a light-weight queue close feature in this patch set
>>>> which could prevent new IO and needn't drain the queue.
>>>
>>> Frankly speaking, IMO, it may not be an good idea to mess up the fast path
>>> just for handling the extremely unusual timeout event. The same is true
>>> for doing the preemp only stuff, as you saw I have posted patchset for
>>> killing it.
>>>
>>
>> In normal case, it is just a judgment like 
>>
>> 	if (unlikely(READ_ONCE(q->queue_gate))
>>
>> It should not be a big deal.> 
> Adding this stuff in fast path is quite difficult to verify its correctness
> because it is really lockless, or even barrier-less.
> 
> Not to mention, READ_ONCE() implies one barrier of smp_read_barrier_depends().

The checking is under rcu lock, the write side could use synchonize_rcu to ensure
the updating is globally visible.t
As for the READ_ONCE, it could be discarded.

Thanks
Jianchao
> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=BQVCMSSS6lYwogr6CE82oIlpLu5ReP8c4lHGgnvswV4&s=rZLfbqzKKXjlCpY1Sy6ocaQjAKZoJq_A49gvSucohNk&e=
> 
