Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B437C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DCF20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DCF20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbeHARt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:49:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390144AbeHARt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:49:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 710D980D;
        Wed,  1 Aug 2018 09:03:33 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63D033F5D0;
        Wed,  1 Aug 2018 09:03:31 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
To:     Saravana Kannan <skannan@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <2a9bfa53-31b2-b44a-0bd5-07bcc344a466@arm.com>
Date:   Wed, 1 Aug 2018 17:03:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/18 04:56, Saravana Kannan wrote:
> Many CPU architectures have caches that can scale independent of the CPUs.
> Frequency scaling of the caches is necessary to make sure the cache is not
> a performance bottleneck that leads to poor performance and power. The same
> idea applies for RAM/DDR.
> 
> To achieve this, this patch adds a generic devfreq governor that can listen
> to the frequency transitions of each CPU frequency domain and then adjusts
> the frequency of the cache (or any devfreq device) based on the frequency
> of the CPUs.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> 
> * Uses a CPU frequency to device frequency mapping table
>   - Either one mapping table used for all CPU freq policies (typically used
>     for system with homogeneous cores/clusters that have the same OPPs.
>   - One mapping table per CPU freq policy (typically used for ASMP systems
>     with heterogeneous CPUs with different OPPs)
> 
> OR
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its max
>   frequency.  If the CPUs are running at their min frequency, the device
>   runs at its min frequency. And interpolated for frequencies in between.
> 

Is this solution for the old generation of SDM ?
I have seen newer ones have some kind of firmware interface/hardware to
deal with CPUFreq. Do you need this solution for them too ?

If yes, why ? IMO firmware can arbitrate various requests for frequency
scaling and do the *right thing* for the platform. Having OSPM sending
separate requests for such bus/interconnect might end up with conflicts.
No ?

-- 
Regards,
Sudeep
