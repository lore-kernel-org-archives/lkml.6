Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2840F20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2840F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKAWCD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:02:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeKAWCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:02:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78E4C3082AEE;
        Thu,  1 Nov 2018 12:59:10 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E65125D9C9;
        Thu,  1 Nov 2018 12:59:08 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
To:     Yi Sun <yi.y.sun@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, chao.p.peng@intel.com,
        chao.gao@intel.com, isaku.yamahata@intel.com,
        michael.h.kelley@microsoft.com, tianyu.lan@microsoft.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
 <20181023085127.GG3109@worktop.c.hoisthospitality.com>
 <20181023093328.GA15378@yi.y.sun> <20181031015417.GC15378@yi.y.sun>
 <20181031141030.GB13219@hirez.programming.kicks-ass.net>
 <fc0bf563-b1ae-4d4b-1341-11c44b759b8a@redhat.com>
 <20181031171538.GC13219@hirez.programming.kicks-ass.net>
 <20181101032020.GE15378@yi.y.sun>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a6f6590e-bc46-f8d7-f6dc-5464e37a8f52@redhat.com>
Date:   Thu, 1 Nov 2018 08:59:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181101032020.GE15378@yi.y.sun>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 01 Nov 2018 12:59:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2018 11:20 PM, Yi Sun wrote:
> On 18-10-31 18:15:39, Peter Zijlstra wrote:
>> On Wed, Oct 31, 2018 at 11:07:22AM -0400, Waiman Long wrote:
>>> On 10/31/2018 10:10 AM, Peter Zijlstra wrote:
>>>> On Wed, Oct 31, 2018 at 09:54:17AM +0800, Yi Sun wrote:
>>>>> On 18-10-23 17:33:28, Yi Sun wrote:
>>>>>> On 18-10-23 10:51:27, Peter Zijlstra wrote:
>>>>>>> Can you try and explain why vcpu_is_preempted() doesn't work for you?
>>>>>> I thought HvSpinWaitInfo is used to notify hypervisor the spin number
>>>>>> which is different with vcpu_is_preempted. So I did not consider
>>>>>> vcpu_is_preempted.
>>>>>>
>>>>>> But HvSpinWaitInfo is a quite simple function and could be combined
>>>>>> with vcpu_is_preempted together. So I think it is OK to use
>>>>>> vcpu_is_preempted to make codes clean. I will have a try.
>>>>> After checking codes, there is one issue to call vcpu_is_preempted.
>>>>> There are two spin loops in qspinlock_paravirt.h. One loop in
>>>>> 'pv_wait_node' calls vcpu_is_preempted. But another loop in
>>>>> 'pv_wait_head_or_lock' does not call vcpu_is_preempted. It also does
>>>>> not call any other ops of 'pv_lock_ops' in the loop. So I am afraid
>>>>> we have to add one more ops in 'pv_lock_ops' to do this.
>>>> Why? Would not something like the below cure that? Waiman, can you have
>>>> a look at this; I always forget how that paravirt crud works.
>>> There are two major reasons why the vcpu_is_preempt() test isn't done at
>>> pv_wait_head_or_lock(). First of all, we may not have a valid prev
>>> pointer after all if it is the first one to enter the queue while the
>>> lock is busy. Secondly, because of lock stealing, the cpu number pointed
>>> by a valid prev pointer may not be the actual cpu that is currently
>>> holding the lock. Another minor reason is that we want to minimize the
>>> lock transfer latency and so don't want to sleep too early while waiting
>>> at the queue head.
>> So Yi, are you actually seeing a problem? If so, can you give details?
> Where does the patch come from? I cannot find it through google.
>
> Per Waiman's comment, it seems not suitable to call vcpu_is_preempted()
> in pv_wait_head_or_lock(). So, we cannot make HvSpinWaitInfo notification
> through vcpu_is_preempted() for such case. Based on that, I suggest to
> add one more callback function in pv_lock_ops.

I am hesitant to add any additional check at the spinning loop in
pv_wait_head_or_lock() especially one that is a hypercall or a callback
that will take time to execute. The testing that I had done in the past
indicated that it would slow down locking performance especially if the
VM wasn't overcommitted at all.

Any additional slack in pv_wait_node() can be mitigated by the lock
stealing that can happen. Slack in pv_wait_head_or_lock(), on the other
hand, will certainly increase the lock transfer latency and impact
performance. So you need performance data to show that it is worthwhile
to do so.

As for performance test, the kernel has a builtin locktorture test if
you configured it in. So show us the performance data with and without
the patch.

Cheers,
Longman

