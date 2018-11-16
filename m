Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAD820858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAD820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbeKQCpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:45:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:1220 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeKQCpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:45:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 08:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="108733819"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2018 08:32:39 -0800
Received: from [10.251.9.118] (kliang2-mobl1.ccr.corp.intel.com [10.251.9.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 20755580475;
        Fri, 16 Nov 2018 08:32:38 -0800 (PST)
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix client IMC events return huge
 result
To:     Sasha Levin <sashal@kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, stable@vger.kernel.org
References: <20181116131945.5480-1-kan.liang@linux.intel.com>
 <20181116161235.GF1706@sasha-vm>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d40e2e0b-61fc-06fb-693b-132d94a2b149@linux.intel.com>
Date:   Fri, 16 Nov 2018 11:32:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116161235.GF1706@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 11:12 AM, Sasha Levin wrote:
> On Fri, Nov 16, 2018 at 05:19:45AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The client IMC bandwidth events return very huge result.
>>  perf stat -e uncore_imc/data_reads/ -e uncore_imc/data_writes/ -I
>> 10000 -a
>>  10.000117222 34,788.76 MiB uncore_imc/data_reads/
>>  10.000117222 8.26 MiB uncore_imc/data_writes/
>>  20.000374584 34,842.89 MiB uncore_imc/data_reads/
>>  20.000374584 10.45 MiB uncore_imc/data_writes/
>>  30.000633299 37,965.29 MiB uncore_imc/data_reads/
>>  30.000633299 323.62 MiB uncore_imc/data_writes/
>>  40.000891548 41,012.88 MiB uncore_imc/data_reads/
>>  40.000891548 6.98 MiB uncore_imc/data_writes/
>>  50.001142480 1,125,899,906,621,494.75 MiB uncore_imc/data_reads/
>>  50.001142480 6.97 MiB uncore_imc/data_writes/
>>
>> The client IMC events are freerunning counters. They still use the
>> old event encoding format (0x1 for data_read and 0x2 for data write).
>> The counter bit width is calculated by common code, which assume that
>> the standard encoding format is used for the freerunning counters.
>> Error bit width information is calculated.
>>
>> The event->attr.config, which directly from user space, should not be
>> used by the functions of freerunning counters.
>> For client IMC events, the attr.config needs to be converted to the
>> standard encoding format. The modified event config will be stored in
>> event->hw.config.
>> For other freerunning counters, the attr.config has the correct format.
>> Just save it in event->hw.config.
>> Using event->hw.config to replace event->attr.config for the functions
>> of freerunning counters.
>>
>> Fix: commit 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client IMC
>> uncore")
> 
> Please use a "fixes" (vs "fix") tag here, a few folks have automation
> around this. It should look something like this:
> 
>      Fixes: commit 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client 
> IMC uncore")
> 
> Also, if you intend for this to go in stable trees, please add a stable
> tag rather than just cc it to the stable mailing list. Something like
> this:
> 
>      Cc: stable@kernel.org
>

Thanks Sasha for the review. I have sent a V2 patch to address the 
format issue.

Thanks,
Kan
