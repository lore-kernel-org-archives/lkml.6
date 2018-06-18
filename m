Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D90C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F45520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F45520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966841AbeFRJVv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:21:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966708AbeFRJVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:21:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0FE91596;
        Mon, 18 Jun 2018 02:21:46 -0700 (PDT)
Received: from [10.1.210.28] (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20E63F25D;
        Mon, 18 Jun 2018 02:21:43 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Taniya Das <tdas@codeaurora.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
Date:   Mon, 18 Jun 2018 10:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 18:40, Taniya Das wrote:
> 
> 
> On 6/15/2018 5:29 PM, Amit Kucheria wrote:

[...]

>> A future version of the HW engine, or more likely, a firmware
>> revision, will make more functionality available. Say, this needs
>> access to another register or two. This will require changing the DT
>> bindings. Instead, if you map the entire address space, you can just
>> add offsets to the new registers.
>>
>> So in this case, I think you should define the following addresses
>> (size 0x1400) for the two frequency domains
>>
>> 0x17d43000, 0x1400 (power cluster)
>> 0x17d45800, 0x1400 (perf cluster)
>>
>> And in the driver simply add offsets as follows:
>>
>> #define ENABLE_OFFSET               0x0
>> #define LUT_OFFSET                      0x110
>> #define PERF_DESIRED_OFFSET 0x920
>>
> 
> The offsets could vary across versions of this IP and that is the reason
> to provide them through the DT and not define any such offsets.
> 

Just get compatibles to identify the version of the hardware if it can't
be probed and detected. Please don't use DT to get the addresses of each
register you use in the driver. That's neither scalable nor nice
solution to the problem.

-- 
Regards,
Sudeep
