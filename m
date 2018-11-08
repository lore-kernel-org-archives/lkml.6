Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DFFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE1E2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE1E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKHXiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:38:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:40165 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHXiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:38:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 06:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="106531013"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2018 06:03:07 -0800
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
 <20181108063246.GA13233@gmail.com>
 <20181108101729.GP9761@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <977bf7ee-deb3-0c9f-def5-7bb04d2e78ae@linux.intel.com>
Date:   Thu, 8 Nov 2018 22:03:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20181108101729.GP9761@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/8 18:17, Peter Zijlstra wrote:
> On Thu, Nov 08, 2018 at 07:32:46AM +0100, Ingo Molnar wrote:
>>
>> * Aubrey Li <aubrey.li@intel.com> wrote:
>>
>>> Expose the per-task cpu specific thread state value, it's helpful
>>> for userland to classify and schedule the tasks by different policies
>>
>> That's pretty vague - what exactly would use this information? I'm sure 
>> you have a usecase in mind - could you please describe it?
> 
> Yeah, "thread_state" is a pretty terrible name for this.

task_struct has a CPU specific element "thread", I quote it to here to 
create a generic interface to expose CPU specific state of the task.
Like /proc/<pid>/stat, I plan to use this "thread_state" to host any CPU
specific state, including AVX state(now only), and any other states(may come
soon). So this interface may be extended in future like the following:

#cat /proc/<pid>/thread_state
1 0 0


>
 The use-case is
> detectoring which tasks use AVX3 such that a userspace component (think
> job scheduler) can cluster them together.> 
> The 'problem' is that running AVX2+ code drops the max clock, because
> you light up the massive wide (and thus large area) paths.

Thanks to explain this.

> 
> So maybe something like "simd_active" is a better name, dunno.

As above, maybe the name can be hidden by thread_state?

> 
> Or maybe "simd_class" and we can write out 0,1,2,3 depending on the AVX
> class being used, dunno. It might make sense to look at what other arch
> SIMD stuff looks like to form this interface.
> 
A task may use 1,2,3 simultaneously, as a scheduler hint, it's just cluster
or not, so 0/1 may be good enough.

Thanks,
-Aubrey
