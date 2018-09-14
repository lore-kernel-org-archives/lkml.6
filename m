Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD504ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FDE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FDE20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeINUM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:12:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:47909 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeINUM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:12:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 07:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,373,1531810800"; 
   d="scan'208";a="90494483"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2018 07:57:33 -0700
Received: from [10.251.9.37] (kliang2-mobl1.ccr.corp.intel.com [10.251.9.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7217058053F;
        Fri, 14 Sep 2018 07:57:32 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/lbr: Optimize context switches for LBR
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel-owner@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, namhyung@kernel.org
References: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
 <dec78c67-0631-c4a7-95e1-4b931ce9ecd7@linux.intel.com>
 <20180914085409.GA27886@tassilo.jf.intel.com>
 <529b2498-0515-e33c-ebcc-af2a5ca7d974@linux.intel.com>
 <b82d59b2-71bf-2c91-869c-0068760c9ed3@linux.intel.com>
 <20180914142733.GB27886@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c9f2436a-f996-026d-5fee-557e6d91c613@linux.intel.com>
Date:   Fri, 14 Sep 2018 10:57:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914142733.GB27886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2018 10:27 AM, Andi Kleen wrote:
> On Fri, Sep 14, 2018 at 08:39:36AM -0400, Liang, Kan wrote:
>>
>>
>> On 9/14/2018 5:22 AM, Alexey Budankov wrote:
>>>
>>> Hi Andi,
>>>
>>> On 14.09.2018 11:54, Andi Kleen wrote:
>>>>>> In principle the LBRs need to be flushed between threads. So does
>>>>>> current code.
>>>>>
>>>>> IMHO, ideally, LBRs stack would be preserved and restored when
>>>>> switching between execution stacks. That would allow implementing
>>>>> per-thread statistical call graph view in Perf tools, fully based
>>>>> on HW capabilities. It could be advantageous for some cases, in
>>>>> comparison with traditional dwarf based call graph.
>>>>
>>>> This is already supported when you use LBR call stack mode
>>>> (perf record --call-graph lbr)
>>>
>>> Which kernel versions does it make sense to try?
>>>
>>
>> The optimization for LBR call stack has been merged into 4.19.
>> commit id: 8b077e4a69bef5c4121426e99497975860191e53
>> perf/x86/intel/lbr: Optimize context switches for the LBR call stack
> 
> I think he mean support for LBR call stack in general. This has been there
> for a long time (since Haswell) Any reasonable kernel version should
> support it.
>

Oh I see. Yes, the feature of LBR call stack was added long time ago.
But I still recommend 4.19. Because it includes a recent bug fix for LBR 
call stack.

commit id: 0592e57b24e7e05ec1f4c50b9666c013abff7017
perf/x86/intel/lbr: Fix incomplete LBR call stack

Thanks,
Kan
