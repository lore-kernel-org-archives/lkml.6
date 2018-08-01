Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC597C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70115208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fh7n09AW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DWKekog8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70115208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHAWDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:03:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeHAWDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:03:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 788A760714; Wed,  1 Aug 2018 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533154572;
        bh=zhqD3on1ElNtPRwFYUhYiQEPukuMr+WwZ2Llmjz4Igw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fh7n09AWFhQ4MDnOH6J7kjlE6eg26N5lx6eR3QXoyyZCFogTqmhRiPvF+G28avhF2
         NAc9B4NkzUDnfQbuw9K3VGiNn8AmPM6YSmAUo1BjaRFpGGH3ulC8Vcbk1M0vNsDvNu
         KFcru4+IC5+Z08CPHYfl8wv71HDySkalPLpzfRjM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D1BBD6035F;
        Wed,  1 Aug 2018 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533154571;
        bh=zhqD3on1ElNtPRwFYUhYiQEPukuMr+WwZ2Llmjz4Igw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DWKekog8nLbWmxoMRcESPbIc1jvUBQsYLKKmhvcCqtNEBDGFDNuzYG0uT8NkwYr5E
         u1DEm4SMjmr1iWzTQSbrKMDt5OrkGfyGhhxNYEhp7pDefgcZ5E2nVf2iP1imONN6V7
         tKRMnvw6FqPaNrWQLpCPqJ4ykeInJ7TirAZffd58=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 13:16:11 -0700
From:   skannan@codeaurora.org
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
In-Reply-To: <2a9bfa53-31b2-b44a-0bd5-07bcc344a466@arm.com>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <2a9bfa53-31b2-b44a-0bd5-07bcc344a466@arm.com>
Message-ID: <07f57aced47960cf48f273d6446b4221@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 09:03, Sudeep Holla wrote:
> On 28/07/18 04:56, Saravana Kannan wrote:
>> Many CPU architectures have caches that can scale independent of the 
>> CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is 
>> not
>> a performance bottleneck that leads to poor performance and power. The 
>> same
>> idea applies for RAM/DDR.
>> 
>> To achieve this, this patch adds a generic devfreq governor that can 
>> listen
>> to the frequency transitions of each CPU frequency domain and then 
>> adjusts
>> the frequency of the cache (or any devfreq device) based on the 
>> frequency
>> of the CPUs.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
>> 
>> * Uses a CPU frequency to device frequency mapping table
>>   - Either one mapping table used for all CPU freq policies (typically 
>> used
>>     for system with homogeneous cores/clusters that have the same 
>> OPPs.
>>   - One mapping table per CPU freq policy (typically used for ASMP 
>> systems
>>     with heterogeneous CPUs with different OPPs)
>> 
>> OR
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>   the CPUs are running at their max frequency, the device runs at its 
>> max
>>   frequency.  If the CPUs are running at their min frequency, the 
>> device
>>   runs at its min frequency. And interpolated for frequencies in 
>> between.
>> 
> 
> Is this solution for the old generation of SDM ?

This code isn't even specific to Qualcomm chips. Let alone a specific 
generation of SDM.

> I have seen newer ones have some kind of firmware interface/hardware to
> deal with CPUFreq. Do you need this solution for them too ?

You are confusing two completely unrelated drivers. This is generic 
*devfreq* *governor* code. I'll be renaming the commit text like Rafael 
suggested.

Something like: CPU frequency to devfreq mapping governor.

> If yes, why ?

Read the commit text.

> IMO firmware can arbitrate various requests for frequency
> scaling and do the *right thing* for the platform.

Firmware (if any) can arbitrate HW that it controls. DDR and 
interconnect is not something a firmware might control (or should 
control).

> Having OSPM sending
> separate requests for such bus/interconnect might end up with 
> conflicts.
> No ?

If some chips have firmware that takes care of everything, then you 
obviously won't be enabling any power management code.

Thanks,
Saravana


