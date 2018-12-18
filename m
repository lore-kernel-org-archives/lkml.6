Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72046C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A06F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRMsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:48:42 -0500
Received: from mail5.windriver.com ([192.103.53.11]:52214 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeLRMsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:48:42 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBICjod7022973
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Dec 2018 04:46:00 -0800
Received: from [128.224.162.162] (128.224.162.162) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 18 Dec
 2018 04:45:39 -0800
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of memory
 allocated in cpu hotplug prepare state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <acme@kernel.org>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <jolsa@kernel.org>, <jolsa@redhat.com>,
        <kan.liang@linux.intel.com>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
 <20181218113700.GC16284@hirez.programming.kicks-ass.net>
 <20181218114708.p6fpz447brob4kzz@linutronix.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <b8f1f75c-bb8e-3b07-b113-32d1ff70fd3e@windriver.com>
Date:   Tue, 18 Dec 2018 20:45:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218114708.p6fpz447brob4kzz@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.162]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/18 19:47, Sebastian Andrzej Siewior wrote:
> On 2018-12-18 12:37:00 [+0100], Peter Zijlstra wrote:
>> On Tue, Dec 18, 2018 at 12:31:19PM +0100, Peter Zijlstra wrote:
>>> On Tue, Dec 18, 2018 at 12:16:37PM +0100, Sebastian Andrzej Siewior wrote:
>>>> On 2018-12-18 12:02:09 [+0100], Peter Zijlstra wrote:
>>>>> On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
>>>>>> Besides, in preempt-rt full mode, the freeing can happen in atomic context and
>>>>>> thus cause the following BUG.
>>>>> Hurm, I though we fixed all those long ago..
>>>>>
>>>>> And no, the patch is horrible; that's what we have things like
>>>>> x86_pmu::cpu_dead() for.
>>>> ehm, you say we keep memory allocation +free on CPU up/down?
>>> Sure, why not?
> It does not seem to be useful to allocate & free memory which you need
> anyway. So you could avoid the refcnt for instance.
> Also I doubt the memory will remain unallocated for a longer period of
> time (like you would remove the CPU for good and not boot it again a
> minute later).
> *Maybe* it is different in cloud environment where you attach vcpus
> depending on guest load at runtime but still…
>
>> I suspect the below is all we really need.
> Zhe, could you please have a look?

This works in my environment, taking CPUs offline and online many times.

Zhe

>
> Sebastian
>

