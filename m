Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BEBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C623217BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C623217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbeHGRny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:43:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:6462 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732639AbeHGRny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:43:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 08:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="79283770"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2018 08:29:04 -0700
Received: from [10.254.74.167] (kliang2-mobl1.ccr.corp.intel.com [10.254.74.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 13F605801AB;
        Tue,  7 Aug 2018 08:29:02 -0700 (PDT)
Subject: Re: [PATCH 1/3] perf/x86/intel: Factor out common code of PMI handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <20180806182055.GQ2494@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3b2e234a-0c09-2c36-b555-54f3b9fd1e35@linux.intel.com>
Date:   Tue, 7 Aug 2018 11:29:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806182055.GQ2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2018 2:20 PM, Peter Zijlstra wrote:
> On Mon, Aug 06, 2018 at 10:23:41AM -0700, kan.liang@linux.intel.com wrote:
>> +	if (++loops > 100) {
>> +		static bool warned;
>> +
>> +		if (!warned) {
>> +			WARN(1, "perfevents: irq loop stuck!\n");
>> +			perf_event_print_debug();
>> +			warned = true;
>> +		}
> 
> Bah, that really reads like we want WARN_ONCE(), except for that
> perf_event_print_debug() thing :/
> 

Yes. I went though the log. To make the WARN text pair with 
perf_event_print_debug(), we open-coded WARN_ONCE()'s
one-time-only logic here since commit ae0def05ed85 ("perf/x86: Only 
print PMU state when also WARN()'ing")

I think I will still keep the logic here and just fix the complaint from 
checkpatch.pl.

Thanks,
Kan
