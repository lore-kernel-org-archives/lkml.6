Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D4BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B2F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B2F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeICTTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:19:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:35464 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:19:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 07:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="88600012"
Received: from speedy.fi.intel.com (HELO [10.237.72.71]) ([10.237.72.71])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2018 07:59:04 -0700
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, currojerez@riseup.net,
        ggherdovich@suse.cz, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
From:   Eero Tamminen <eero.t.tamminen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
Date:   Mon, 3 Sep 2018 18:10:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31.08.2018 20:28, Srinivas Pandruvada wrote:
...
> As per testing Eero Tamminen, the results are comparable to the patchset
> https://patchwork.kernel.org/patch/10312259/
> But he has to watch results for several days to check trend.

It's close, but there is some gap compared to Francisco's version.

(Because of the large variance on TDP limited devices, and factors 
causing extra perf differences e.g. between boots, it's hard to give 
exact number without having trends from several days / weeks.  I would 
also need new version of Fransisco's patch set that applies to latest 
kernel like yours does.)


> Since here boost is getting limited to turbo and non turbo, we need some
> ways to adjust the fractions corresponding to max non turbo as well. It
> is much easier to use the actual P-state limits for boost instead of
> fractions. So here P-state io boost limit is applied on top of the
> P-state limit calculated via current algorithm by removing current
> io_wait boost calculation using fractions.
> 
> Since we prefer to use common algorithm for all processor platforms, this
> change was tested on other client and sever platforms as well. All results
> were within the margin of errors. Results:
> https://bugzilla.kernel.org/attachment.cgi?id=278149

Good.

Francisco, how well the listed PTS tests cover latency bound cases you 
were concerned about?  [1]


	- Eero

[1] Fransisco was concerned that the patch:
* trade-off might regress latency bound cases (which I haven't tested, I 
tested only 3D throughput), and
* that it addressed only other of the sources of energy inefficiencies 
he had identified (which could explain slightly better 3D results from 
his more complex patch set).

