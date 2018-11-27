Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D93DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC2420817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC2420817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeK1C0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:26:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbeK1C0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:26:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA127364A;
        Tue, 27 Nov 2018 07:28:28 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A291A3F5A0;
        Tue, 27 Nov 2018 07:28:26 -0800 (PST)
Subject: Re: 'branches' perf event mapping differs on ARC and ARM
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
References: <1543329386.13651.13.camel@synopsys.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <48cfcbf3-0084-7b17-f30d-371bbb5cbdde@arm.com>
Date:   Tue, 27 Nov 2018 15:28:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543329386.13651.13.camel@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 14:36, Eugeniy Paltsev wrote:
> Hi,
> 
> While playing with perf tool on ARMv7 and ARCv2 processors and profiling the
> same application I got interesting results. Even if we got pretty
> similar total
> execution time and instructions number the number of branches on ARC is about
> three times more then on ARM.
> 
> I dug into architecture
> specific perf sources and found that we map different
> HW counters into generic 'branches' event on ARC and ARM.
> - We use "ijmp" event on ARC which
> counts all jump and branch instructions (regardless
> of real execution flow - even if no real jump happens)
> - We use "pc_write_retired" event on ARM
> which counts only taken branches (Instruction
> architecturally executed, condition check pass - software change of the PC)
> 
> So I was wondering do you know
> which approach is correct?
> 
> 
> 
> I guess counting all jump and branch instructions is correct because we use
> 'branches' event value to calculate relative value of 'branch-misses' using
> 
> following formula:
> ----------------------------8----------------------------
> branch-misses-ration = 'branch-misses' / 'branches' * 100.0
> ----------------
> ------------8----------------------------
> And using only taken branches here is incorrect IMHO. So I guess we should
> map 'br_immed_retired' instead of
> "pc_write_retired" into generic 'branches'
> event on ARM.

But register branches (including procedure returns) are also branches, 
so only counting immediate branches would be just as, if not more, 
misleading.

Robin.
