Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8309C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9276920856
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9276920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeH2Oap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:30:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:64353 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2Oap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:30:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 03:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="69990606"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2018 03:34:28 -0700
Received: from [10.226.39.0] (zhuyixin-mobl.gar.corp.intel.com [10.226.39.0])
        by linux.intel.com (Postfix) with ESMTP id 3BE57580335;
        Wed, 29 Aug 2018 03:34:27 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
To:     Stephen Boyd <sboyd@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com,
        qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
 <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
 <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
From:   "Zhu, Yi Xin" <yixin.zhu@linux.intel.com>
Message-ID: <65a8518b-8fd8-847b-f952-0370be3d786a@linux.intel.com>
Date:   Wed, 29 Aug 2018 18:34:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +}
>>>> +
>>>> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);
>>> Any reason a platform driver can't be used instead of CLK_OF_DECLARE()?
>> It provides CPU clock which is used in early boot stage.
>>
> Ok. What is the CPU clock doing in early boot stage? Some sort of timer
> frequency? If the driver can be split into two pieces, one to handle the
> really early stuff that must be in place to get timers up and running
> and the other to register the rest of the clks that aren't critical from
> a regular platform driver it would be good. That's preferred model if
> something is super critical.
>
Just to make sure my approach is same as you think.

In the driver, there's two clock registrations.

- One through CLK_OF_DECLARE for early stage clocks.

- The other via platform driver for the non-critical clocks.

In the device tree,  two clock device nodes are required.

e.g. device tree:

cgu: cgu@16200000 {
                 compatible = "intel,grx500-clk", "syscon";
                 reg = <0x16200000 0x200>;
                 #clock-cells = <1>;
};

clk: clk {
                 compatible = "intel,grx500-cgu";
                 #clock-cells = <1>;
                 intel,cgu-syscon = <&cgu>;
};

source code:

CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);

static const struct of_device_id of_intel_grx500_cgu_match[] = {
         { .compatible = "intel,grx500-clk" },
         {}
};

static struct platform_driver intel_grx500_clk_driver = {
         .probe  = intel_grx500_clk_probe,
         .driver = {
                 .name = "grx500-cgu",
                 .of_match_table = of_match_ptr(of_intel_grx500_cgu_match),
         },
};

static int __init intel_grx500_cgu_init(void)
{
         return platform_driver_register(&intel_grx500_clk_driver);
}
arch_initcall(intel_grx500_cgu_init);


