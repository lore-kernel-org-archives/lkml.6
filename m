Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF171C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2A620880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBTOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:36:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:40426 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfBTOgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:36:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:36:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="117669931"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2019 06:36:53 -0800
Received: from [10.254.81.39] (kliang2-mobl1.ccr.corp.intel.com [10.254.81.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 93CE858019B;
        Wed, 20 Feb 2019 06:36:52 -0800 (PST)
Subject: Re: [PATCH 01/10] perf/x86/intel: Introduce a concept "domain" as the
 scope of counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
        jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
 <1550606411-5313-2-git-send-email-kan.liang@linux.intel.com>
 <20190220111226.GG32494@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9631a92f-5b24-26a6-e160-4e4c0b4697c1@linux.intel.com>
Date:   Wed, 20 Feb 2019 09:36:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220111226.GG32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2019 6:12 AM, Peter Zijlstra wrote:
> On Tue, Feb 19, 2019 at 12:00:02PM -0800, kan.liang@linux.intel.com wrote:
>> It's very useful to abstract several common topology related codes for
>> these modules to reduce the code redundancy.
> 
>>   3 files changed, 96 insertions(+), 1 deletion(-)
> 
> So you add 100 lines, so we can remove lines when we start to use this.
> 
> Except all 3 follow up patches that employ this, all add more lines
> still:

The previous implementation assumes that there is only one or two types 
of counters (per core or per package). The proposed solution breaks the 
assumption and can support more types of counters. The new 
infrastructure needs more lines. But with more and more types 
introduced, we can expect less lines in total with the proposed solution.

>   1 file changed, 184 insertions(+), 157 deletions(-)

This is cstate which supports two types of counters (per core and per 
package) now.

>   3 files changed, 164 insertions(+), 80 deletions(-)
>   1 file changed, 224 insertions(+), 82 deletions(-)
> 

They are uncore and rapl which only supports one type of counters (per 
package) now.

When there is only one type, the proposed solution has more lines.
But when there are two types, the proposed solution has similar number 
of lines as previous implementation.
In this trend, I expect that the proposed solution has less lines when 
there are three or more types.

With die introduced, there are at least two types of counters for rapl 
and uncore, and three types for cstate. In total, we should see less lines.

There may be more types of counters added later. In 8.9.1 Hierarchical 
Mapping of Shared Resources of SDM vol3A, it document 7 APIC_ID fields 
(cluster, package, die, tile, module, core and SMT). There are only 4 
types of counters for now.


Thanks,
Kan
