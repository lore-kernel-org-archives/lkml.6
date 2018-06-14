Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DFC1C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C57C208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57C208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeFNIBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:01:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:41583 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeFNIBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:01:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 01:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="66903627"
Received: from huama-mobl.gar.corp.intel.com (HELO [10.226.38.37]) ([10.226.38.37])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2018 01:01:33 -0700
Subject: Re: [PATCH 3/7] MIPS: intel: Add initial support for Intel MIPS SoCs
To:     Rob Herring <robh@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-4-songjun.wu@linux.intel.com>
 <20180612223153.GB2197@rob-hp-laptop>
From:   Hua Ma <hua.ma@linux.intel.com>
Message-ID: <821a2d72-da13-4dbe-4413-edc25f01e9fb@linux.intel.com>
Date:   Thu, 14 Jun 2018 16:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612223153.GB2197@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/13/2018 6:31 AM, Rob Herring wrote:
> On Tue, Jun 12, 2018 at 01:40:30PM +0800, Songjun Wu wrote:
>> From: Hua Ma <hua.ma@linux.intel.com>
>>
>> Add initial support for Intel MIPS interAptiv SoCs made by Intel.
>> This series will add support for the GRX500 family.
>>
>> The series allows booting a minimal system using a initramfs.
>>
>> Signed-off-by: Hua ma <hua.ma@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>>   arch/mips/Kbuild.platforms                         |   1 +
>>   arch/mips/Kconfig                                  |  36 ++++
>>   arch/mips/boot/dts/Makefile                        |   1 +
>>   arch/mips/boot/dts/intel-mips/Makefile             |   3 +
>>   arch/mips/boot/dts/intel-mips/easy350_anywan.dts   |  20 +++
>>   arch/mips/boot/dts/intel-mips/xrx500.dtsi          | 196 +++++++++++++++++++++
> Please split dts files to separate patch.
Thanks,
it will be split into separate patches: one for dts, one for mips codes 
and one for the document.
>> diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>> new file mode 100644
>> index 000000000000..40177f6cee1e
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/interrupt-controller/mips-gic.h>
>> +#include <dt-bindings/clock/intel,grx500-clk.h>
>> +
>> +#include "xrx500.dtsi"
>> +
>> +/ {
>> +	model = "EASY350 ANYWAN (GRX350) Main model";
> A board should have a board specific compatible, too.
The board compatible will be added.
>
>> +	chosen {
>> +		bootargs = "earlycon=lantiq,0x16600000 clk_ignore_unused";
>> +		stdout-path = "serial0";
>> +	};
>> +
>> +	memory@0 {
> memory@20000000
The memory address will be changed to @20000000.
>
>> +		device_type = "memory";
>> +		reg = <0x20000000 0x0e000000>;
>> +	};
>> +};
>> diff --git a/arch/mips/boot/dts/intel-mips/xrx500.dtsi b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
>> new file mode 100644
>> index 000000000000..04a068d6d96b
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "intel,xrx500";
> This needs to be documented.
The compatible will be updated in the document.

