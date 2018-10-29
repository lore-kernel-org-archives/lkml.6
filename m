Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2432EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EA120657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EA120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeJ2WfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:35:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:6142 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeJ2WfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:35:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 06:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="82425017"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2018 06:46:21 -0700
Received: from [10.251.20.185] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8E27F580332;
        Mon, 29 Oct 2018 06:46:20 -0700 (PDT)
Subject: Re: perf synthesized mmap timeouts
To:     David Miller <davem@davemloft.net>, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com
References: <20181027.214102.1558835285408950686.davem@davemloft.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <61d0538b-fdd4-933d-397b-4bbe339bb517@linux.intel.com>
Date:   Mon, 29 Oct 2018 09:46:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181027.214102.1558835285408950686.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2018 12:41 AM, David Miller wrote:
> 
> If I understand the commit message for:
> 
> commit 8cc42de736b617827a4e7664fb8d7a325bc125bc
> Author: Kan Liang <kan.liang@intel.com>
> Date:   Thu Jan 18 13:26:32 2018 -0800
> 
>      perf top: Check the latency of perf_top__mmap_read()
> 
> properly, the problem is that a malicious or out of control
> app can be doing endless mmaps causing perf to loop forever
> processing the /proc/$PID/maps file.
>

NO, the perf_top__mmap_read() is used to read and process all available 
samples on each ringbuffer. It will be called repeatedly until perf top 
exit.

If it is a fully loaded system, the processing time of the function will 
be very long. Even much longer than refresh time for display thread. If 
so, it means that only stale data can be shown, or even worse, nothing 
can be shown.
For example, in the Knights Landing/Mill platform, the processing time 
could be tens of minutes if there is a heavy load (kernel building).
Because for the Knights Landing/Mill platform, the CPU# is big (> 200), 
but the computational capabilities for each core is weak (Atom core).
There is nothing shown on the screen during this period.
That's why we add a warning here to give user a hint.

If it's annoying for your case, I think you encountered the similar 
problem. You may want to follow the hint, and have the latest data 
refreshed. On the other hand, I agree that we need a more decent way to 
deliver the hint.

Thanks,
Kan

> But that is not what this commit is handling at all.
> 
> It is instead applying a large hammer which quits if it is taking a
> long time to process the maps, not if the process's mmap list is
> growing endlessly while we process it.
> 
> This triggers any time I run perf top on a fully loaded system making
> perf less useful than it should be.
> 
> And it triggers simply because the perf synthesize threads have to
> share the cpu with the workload already running.
> 
> So it takes more than half a second to process emacs's 527 maps when
> the number of running processes is ~NCPUS?  Big deal.  We should let
> it finish....
> 
> The tradeoff choosen here is really bad.
> 
> Guess what happens if you don't have maps for a given process?
> 
> What happens is that for every single sample we get within that range,
> we get a completely unique histogram entry.
> 
> This means potentially millions and millions of histogram entries
> where there should only be a few hundred.
> 
> This makes the histogram rbtree huge, and slow to process.
> 
> So not only is top unable to provide correct histogram output, it is
> also running sluggishly.
> 
> A way to mitigate the actual problem would be to snapshot the maps
> file into a large buffer, if possible.  We can get the full contents
> faster than the process in question can make more maps.  At most we
> will do one additional read at the end if they were able to sneak in
> one new mmap during the initial read.
> 
> No timeout necessary.  We have the complete maps file, our processing
> time is therefore bounded.
> 
> Thanks.
> 
