Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeEVSap (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:30:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeEVSan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:30:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A33CB604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5B0461D1.1050900@codeaurora.org>
Date: Tue, 22 May 2018 11:30:41 -0700
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM / devfreq: Add support for QCOM devfreq firmware
References: <1526629965-28729-1-git-send-email-skannan@codeaurora.org> <20180522180838.GA13423@rob-hp-laptop>
In-Reply-To: <20180522180838.GA13423@rob-hp-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 11:08 AM, Rob Herring wrote:
> On Fri, May 18, 2018 at 12:52:40AM -0700, Saravana Kannan wrote:
>> The firmware present in some QCOM chipsets offloads the steps necessary for
>> changing the frequency of some devices (Eg: L3). This driver implements the
>> devfreq interface for this firmware so that various governors could be used
>> to scale the frequency of these devices.
>>
>> Each client (say cluster 0 and cluster 1) that wants to vote for a
>> particular device's frequency (say, L3 frequency) is represented as a
>> separate voter device (qcom,devfreq-fw-voter) that's a child of the
>> firmware device (qcom,devfreq-fw).
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>   .../bindings/devfreq/devfreq-qcom-fw.txt           |  41 +++
>>   drivers/devfreq/Kconfig                            |  14 +
>>   drivers/devfreq/Makefile                           |   1 +
>>   drivers/devfreq/devfreq_qcom_fw.c                  | 330 +++++++++++++++++++++
>>   4 files changed, 386 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>   create mode 100644 drivers/devfreq/devfreq_qcom_fw.c
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>> new file mode 100644
>> index 0000000..f882a0b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>> @@ -0,0 +1,41 @@
>> +QCOM Devfreq firmware device
>> +
>> +Some Qualcomm Technologies, Inc. (QTI) chipsets have a firmware that
>> +offloads the steps for frequency switching. It provides a table of
>> +supported frequencies and a register to request one of the supported
>> +freqencies.
>> +
>> +The qcom,devfreq-fw represents this firmware as a device. Sometimes,
>> +multiple entities want to vote on the frequency request that is sent to the
>> +firmware. The qcom,devfreq-fw-voter represents these voters as child
>> +devices of the corresponding qcom,devfreq-fw device.
>> +
>> +Required properties:
>> +- compatible:		Must be "qcom,devfreq-fw" or "qcom,devfreq-fw-voter"
>
> No versions of firmware?

Sure, I can add a v1. Right now the interface has always been identical. 
I thought if it changed in the future I'll add -v2.

>
>> +Only for qcom,devfreq-fw:
>> +- reg:			Pairs of physical base addresses and region sizes of
>> +			memory mapped registers.
>
> Registers? Is this firmware or h/w block?

It's a HW block that has its own firmware.

>
>> +- reg-names:		Names of the bases for the above registers.
>> +			Required register regions are:
>> +			- "en-base": address of register to check if the
>> +			  firmware is enabled.
>> +			- "ftbl-base": address region for the frequency
>> +			  table.
>> +			- "perf-base": address of register to request a
>> +			  frequency.
>> +
>> +Example:
>> +
>> +	qcom,devfreq-l3 {
>> +		compatible = "qcom,devfreq-fw";
>> +		reg-names = "en-base", "ftbl-base", "perf-base";
>> +		reg = <0x18321000 0x4>, <0x18321110 0x600>, <0x18321920 0x4>;
>> +
>> +		qcom,cpu0-l3 {
>> +			compatible = "qcom,devfreq-fw-voter";
>
> There's no point in these nodes. They don't have any properties or
> resources.

These nodes decide how many voters this device supports. Each voter 
would be a devfreq node that will have its own governor set. For 
example, one of them would use this governor:
http://lkml.iu.edu/hypermail/linux/kernel/1805.2/02474.html

You can also attach different devfreq-event devices to each one of these 
voter devices based on what events you want to use for scaling each 
voter. So, the devices are definitely needed in the larger context.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
