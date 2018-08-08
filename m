Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98DC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EF0216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EF0216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeHHFJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:09:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:15831 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeHHFJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:09:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 19:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="79454475"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.39]) ([10.226.38.39])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2018 19:51:52 -0700
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
To:     Rob Herring <robh+dt@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <57bea045-628b-2dad-2492-dadd9947cbe9@linux.intel.com>
Date:   Wed, 8 Aug 2018 10:51:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2018 11:19 PM, Rob Herring wrote:
> On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> This driver provides PLL clock registration as well as various clock
>> branches, e.g. MUX clock, gate clock, divider clock and so on.
>>
>> PLLs that provide clock to DDR, CPU and peripherals are shown below:
>>
>>                   +---------+
>>              |--->| LCPLL3 0|--PCIe clk-->
>>     XO       |    +---------+
>> +-----------|
>>              |    +---------+
>>              |    |        3|--PAE clk-->
>>              |--->| PLL0B  2|--GSWIP clk-->
>>              |    |        1|--DDR clk-->DDR PHY clk-->
>>              |    |        0|--CPU1 clk--+   +-----+
>>              |    +---------+            |--->0    |
>>              |                               | MUX |--CPU clk-->
>>              |    +---------+            |--->1    |
>>              |    |        0|--CPU0 clk--+   +-----+
>>              |--->| PLLOA  1|--SSX4 clk-->
>>                   |        2|--NGI clk-->
>>                   |        3|--CBM clk-->
>>                   +---------+
>>
>> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2:
>> - Rewrite clock driver, add platform clock description details in
>>    clock driver.
>>
>>   drivers/clk/Kconfig                          |   1 +
>>   drivers/clk/Makefile                         |   3 +
>>   drivers/clk/intel/Kconfig                    |  20 ++
>>   drivers/clk/intel/Makefile                   |   7 +
>>   drivers/clk/intel/clk-cgu-pll.c              | 166 ++++++++++
>>   drivers/clk/intel/clk-cgu-pll.h              |  34 ++
>>   drivers/clk/intel/clk-cgu.c                  | 470 +++++++++++++++++++++++++++
>>   drivers/clk/intel/clk-cgu.h                  | 259 +++++++++++++++
>>   drivers/clk/intel/clk-grx500.c               | 168 ++++++++++
>>   include/dt-bindings/clock/intel,grx500-clk.h |  69 ++++
> This belongs with the clk binding patch.
>
> Rob
Thanks for review.
Will move it to clock binding patch.

>

