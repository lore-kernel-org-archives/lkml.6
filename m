Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D4F2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D4F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI2Uwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:52:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:38077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbeI2Uwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:52:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2018 07:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,320,1534834800"; 
   d="scan'208";a="77136234"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.9.142]) ([10.251.9.142])
  by orsmga007.jf.intel.com with ESMTP; 29 Sep 2018 07:23:55 -0700
Subject: Re: [PATCH V5 0/6] perf and x86/intel_rdt: Fix lack of coordination
 with perf
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, tony.luck@intel.com, mingo@redhat.com,
        acme@kernel.org, gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1537377064.git.reinette.chatre@intel.com>
 <20180920141150.GY24124@hirez.programming.kicks-ass.net>
 <77383a1e-f343-7529-24cf-874f0999507d@intel.com>
 <alpine.DEB.2.21.1809272123440.8118@nanos.tec.linutronix.de>
 <20180928065830.GE3439@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <42c2b375-dbb9-11a3-8e2f-bec744e73b10@intel.com>
Date:   Sat, 29 Sep 2018 07:23:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928065830.GE3439@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 11:58 PM, Peter Zijlstra wrote:
> On Thu, Sep 27, 2018 at 10:39:01PM +0200, Thomas Gleixner wrote:
>> On Fri, 21 Sep 2018, Reinette Chatre wrote:
>>
>>> Dear Maintainers,
>>
>> Sorry for replying late.
>>
>>> On 9/20/2018 7:11 AM, Peter Zijlstra wrote:
>>>> On Wed, Sep 19, 2018 at 10:29:05AM -0700, Reinette Chatre wrote:
>>>>> Reinette Chatre (6):
>>>>>   perf/core: Add sanity check to deal with pinned event failure
>>>>>   perf/x86: Add helper to obtain performance counter index
>>>>>   x86/intel_rdt: Remove local register variables
>>>>>   x86/intel_rdt: Create required perf event attributes
>>>>>   x86/intel_rdt: Use perf infrastructure for measurements
>>>>>   x86/intel_rdt: Re-enable pseudo-lock measurements
>>>>>
>>>>>  Documentation/x86/intel_rdt_ui.txt          |  22 +-
>>>>>  arch/x86/events/core.c                      |  21 ++
>>>>>  arch/x86/include/asm/perf_event.h           |   1 +
>>>>>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 372 ++++++++++++--------
>>>>>  kernel/events/core.c                        |   6 +
>>>>>  5 files changed, 261 insertions(+), 161 deletions(-)
>>>>
>>>> Yeah, these look good, thanks!
>>>>
>>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>
>>>
>>> Could you please consider this series for inclusion into v4.19?
>>
>> So in principle I'm having no objections as this really is mostly a RDT
>> only issue.
>>
>> Peter, any objections against the Perf part of it, aside the core patch
>> which is an obvious fix?
> 
> Nope, look up a few lines to observe my Ack ;-)
> 

I interpreted Thomas and Peter's responses to mean that there are no
objections for this to be included in v4.19 as a fix.

If I understand the tip branches correctly the core patch seems to be
headed to v4.19 while the rest (excluding the final patch
"x86/intel_rdt: Re-enable pseudo-lock measurements") are headed to v4.20.

Have you decided against including this into v4.19 or did I
misunderstand the responses and/or branches?

Thank you for helping me to sort this out

Reinette
