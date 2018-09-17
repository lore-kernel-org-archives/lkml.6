Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E462ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8427214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8427214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeIQWW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:22:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:53081 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQWW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:22:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 09:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="81132636"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2018 09:54:14 -0700
Subject: Re: [PATCH V3 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <e49f32d40c53839c31e1376f11059539afd08f23.1536685533.git.reinette.chatre@intel.com>
 <20180917085848.GQ24124@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <daeb5e60-de3e-4f08-0e06-25ab83bbe2fe@intel.com>
Date:   Mon, 17 Sep 2018 09:54:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917085848.GQ24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/17/2018 1:58 AM, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 10:14:36AM -0700, Reinette Chatre wrote:
>> +static int measure_l2_residency(void *_plr)
>> +{
> 
>> +	measure_residency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);
> 
>> +}
>> +
>> +static int measure_l3_residency(void *_plr)
>> +{
> 
>> +	measure_residency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);
> 
> Not sure it's important, but both sites loose the error return.
> 

measure_l2_residency() as well as measure_l3_residency() are thread
functions so this error does not propagate directly to the caller.

Even so, by not exiting the thread here if measure_residency_fn() fails
the tracepoints will be written with zeroes. If we exited here the
tracepoints will not be written and the trace buffer will be empty when
the user searches for the measurement data. Do you perhaps have an
inclination to which a user would prefer?

Reinette
