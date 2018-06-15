Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EFCAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A633208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A633208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936284AbeFON1W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:27:22 -0400
Received: from foss.arm.com ([217.140.101.70]:42380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933771AbeFON1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:27:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FAF980D;
        Fri, 15 Jun 2018 06:27:20 -0700 (PDT)
Received: from [10.1.210.28] (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E673F59D;
        Fri, 15 Jun 2018 06:27:17 -0700 (PDT)
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
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Taniya Das <tdas@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <ce75662b-20ee-a879-5004-57d6cc2c29a5@arm.com>
Date:   Fri, 15 Jun 2018 14:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 12:59, Amit Kucheria wrote:
> On Thu, Jun 14, 2018 at 9:24 PM, Taniya Das <tdas@codeaurora.org> wrote:
> 

[...]

>>
>> Yes I do understand the intent of mapping the whole register space, but as
>> per the HW specs these 3 registers would be the only ones required for now.
>> I do not think this hardware engine has any information on the power
>> numbers.
> 
> "For now" - I think this is exactly the point that Sudeep is trying to make.
> 
> A future version of the HW engine, or more likely, a firmware
> revision, will make more functionality available. Say, this needs
> access to another register or two. This will require changing the DT
> bindings. Instead, if you map the entire address space, you can just
> add offsets to the new registers.
> 
> So in this case, I think you should define the following addresses
> (size 0x1400) for the two frequency domains
> 
> 0x17d43000, 0x1400 (power cluster)
> 0x17d45800, 0x1400 (perf cluster)
> 
> And in the driver simply add offsets as follows:
> 
> #define ENABLE_OFFSET               0x0
> #define LUT_OFFSET                      0x110
> #define PERF_DESIRED_OFFSET 0x920
> 
> This will allow you add any new registers in the future w/o modifying
> the DT binding and reduce qcom_cpu_resources_init() to a handful of
> lines since you no longer need so many OF string matches, and
> devm_ioremap()s.
> 

Thanks Amit for such nice and detailed explanation. I was lazy to write
in such details, but was hoping Taniya to understand the point. Anyways
thanks again for doing this.

-- 
Regards,
Sudeep
