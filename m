Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeEaEOj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:14:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeEaEOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:14:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB9A9602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 1/6] soc: qcom: rpmpd: Add a powerdomain driver to
 model corners
To: Rob Herring <robh@kernel.org>
Cc: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        collinsd@codeaurora.org
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-2-rnayak@codeaurora.org>
 <20180531032709.GA13554@rob-hp-laptop>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <bae910b7-2bc4-2984-9f5e-2b618b6b652b@codeaurora.org>
Date: Thu, 31 May 2018 09:44:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180531032709.GA13554@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/31/2018 08:57 AM, Rob Herring wrote:
> On Fri, May 25, 2018 at 03:31:16PM +0530, Rajendra Nayak wrote:
>> The powerdomains for corners just pass the performance state set by the
>> consumers to the RPM (Remote Power manager) which then takes care
>> of setting the appropriate voltage on the corresponding rails to
>> meet the performance needs.
>>
>> We add all powerdomain data needed on msm8996 here. This driver can easily
>> be extended by adding data for other qualcomm SoCs as well.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  .../devicetree/bindings/power/qcom,rpmpd.txt  |  55 ++++
>>  drivers/soc/qcom/Kconfig                      |   9 +
>>  drivers/soc/qcom/Makefile                     |   1 +
>>  drivers/soc/qcom/rpmpd.c                      | 299 ++++++++++++++++++
>>  4 files changed, 364 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>  create mode 100644 drivers/soc/qcom/rpmpd.c
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> new file mode 100644
>> index 000000000000..68f620a2af0d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> @@ -0,0 +1,55 @@
>> +Qualcomm RPM Powerdomains
>> +
>> +* For RPM powerdomains, we communicate a performance state to RPM
>> +which then translates it into a corresponding voltage on a rail
>> +
>> +Required Properties:
>> + - compatible: Should be one of the following
>> +	* qcom,msm8996-rpmpd: RPM Powerdomain for the msm8996 family of SoC
>> + - power-domain-cells: number of cells in power domain specifier
>> +	must be 1.
>> + - operating-points-v2: Phandle to the OPP table for the power-domain.
>> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
>> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
>> +
>> +Example:
>> +
>> +	rpmpd: power-controller {
>> +		compatible = "qcom,msm8996-rpmpd";
>> +		#power-domain-cells = <1>;
>> +		operating-points-v2 = <&rpmpd_opp_table>,
>> +				      <&rpmpd_opp_table>,
>> +				      <&rpmpd_opp_table>,
>> +				      <&rpmpd_opp_table>,
>> +				      <&rpmpd_opp_table>,
>> +				      <&rpmpd_opp_table>,
>> +				      <&rpmpd_opp_table>;
>> +	};
>> +
>> +	rpmpd_opp_table: opp-table {
>> +		compatible = "operating-points-v2-qcom-level", "operating-points-v2";
>> +
>> +		rpmpd_opp1: opp@1 {
> 
> unit-address without reg property is not valid.
> 
>> +			qcom,level = <1>;
> 
> Is this the only property? If so, I don't see the point in trying to use 
> operating-points-v2 here.

Thanks, I'll drop the unit address above and the compatible here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
