Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03976C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02032192B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfBPRF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:05:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:10208 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731907AbfBPRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 12:05:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,377,1544515200"; 
   d="scan'208";a="319608737"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2019 09:05:23 -0800
Subject: Re: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
References: <20190213023748.6614-1-aubrey.li@linux.intel.com>
 <20190213023748.6614-2-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de>
 <85b22e16-fffc-7ebe-2ab1-3b6fe7e036ab@linux.intel.com>
 <alpine.DEB.2.21.1902161340320.1683@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <fe178af9-3eb2-3b5d-6eab-23ebb50269c2@linux.intel.com>
Date:   Sun, 17 Feb 2019 01:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902161340320.1683@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/16 20:55, Thomas Gleixner wrote:
> On Fri, 15 Feb 2019, Li, Aubrey wrote:
>> On 2019/2/14 19:29, Thomas Gleixner wrote:
>> Under this scenario, the elapsed time becomes longer than normal indeed, see below:
>>
>> $ while [ 1 ]; do cat /proc/6985/status | grep AVX; sleep 1; done
>> AVX512_elapsed_ms:	3432
>> AVX512_elapsed_ms:	440
>> AVX512_elapsed_ms:	1444
>> AVX512_elapsed_ms:	2448
>> AVX512_elapsed_ms:	3456
>> AVX512_elapsed_ms:	460
>> AVX512_elapsed_ms:	1464
>> AVX512_elapsed_ms:	2468
>>
>> But AFAIK, google's Heracles do a 15s polling, so this worst case is still acceptable.?
> 
> I have no idea what Google's thingy does and you surely have to ask those
> people who want to use this whether they are OK with that. I personally
> think the numbers are largely useless, but I don't know the use case.
> 
>>> IOW, this needs crystal ball magic to decode because
>>> there is no correlation between that elapsed time and the time when the
>>> last context switch happened simply because that time is not available in
>>> /proc/$PID/status. Sure you can oracle it out from /proc/$PID/stat with
>>> even more crystal ball magic, but there is no explanation at all.
>>>
>>> There may be use case scenarios where this crystal ball prediction is
>>> actually useful, but the inaccuracy of that information and the possible
>>> pitfalls for any user space application which uses it need to be documented
>>> in detail. Without that, this is going to cause more trouble and confusion
>>> than benefit.
>>>
>> Not sure if the above experiment addressed your concern, please correct me if
>> I totally misunderstood.
> 
> The above experiment just confirms what I said: The numbers are inaccurate
> and potentially misleading to a large extent when the AVX using task is not
> scheduled out for a longer time.
> 
> So what I'm asking for is proper documentation which explains how this
> 'hint' is generated in the kernel and why it can be completely inaccurate
> and misleading. We don't want to end up in a situation where people start
> to rely on this information and then have to go and read kernel code to
> understand why the numbers do not make sense.
> 
> I'm not convinced that this interface in the current form is actually
> useful. Even if you ignore the single task example, then on a loaded
> machine where tasks are scheduled in and out by time slices, then the
> calculation is:
> 
> 	    delta = (long)(jiffies - timestamp);
> 
> delta is what you expose as elapsed_ms. Now assume that the task is seen as
> using AVX when being scheduled out. So depending on the time it is
> scheduled out, whether it's due lots of other tasks occupying the CPU or
> due to a blocking syscall, the result can be completely misleading. The job
> scheduler will see for example: 80ms ago was last AVX usage recorded and
> decide that this is just an occasional usage and migrate it away. Now the
> task gets on the other CPU and starts using AVX again, which makes the
> scheduler see a short delta and decide to move it back.

All in all AVX usage elapsed time threshold is the matter. I guess you'll be
more comfortable if the job scheduler decides to migrate task depends on the
condition if AVX512_elapsed_time > 10000 (10s), ;)

That is, every time the interface is queried, if AVX512 usage is recorded 
within 10s, the task is classified as an AVX512 task and should be grouped.
This is reasonable because usually the AVX512 using task is the long running
task, for example, I have an intern who trained a deep reinforcement learning
model for 21 days...

> 
> So interpreting the value is voodoo which becomes even harder when there is
> no documentation.

Sure, let me try to put more details in Documentation/filesystems/proc.txt

Thanks,
-Aubrey
