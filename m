Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeBGE3F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:29:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeBGE3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:29:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5302C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 3/3] arm64: dts: sdm845: Add serial console support
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        evgreen@chromium.org
References: <20180131161941.29865-1-rnayak@codeaurora.org>
 <20180131161941.29865-4-rnayak@codeaurora.org>
 <CAD=FV=VwTZo2YOxw0W7JbuF_Dic8YHmQZ6_FAxiZG3BXiS_VEw@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <1696cf0f-dccc-3014-1c5f-70a7941bd8ff@codeaurora.org>
Date: Wed, 7 Feb 2018 09:58:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VwTZo2YOxw0W7JbuF_Dic8YHmQZ6_FAxiZG3BXiS_VEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[]..

>> @@ -10,4 +10,46 @@
>>  / {
>>         model = "Qualcomm Technologies, Inc. SDM845 MTP";
>>         compatible = "qcom,sdm845-mtp";
>> +
>> +       aliases {
>> +               serial0 = &qup_uart2;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0";
>> +       };
>> +
>> +       soc {
> 
> I don't know if there's an official position, but in general I'm seen
> people use the actual "soc" alias here.  AKA at the top level of this
> dts, just do:
> 
> &soc {
>   ...
> };
> 
> Normally doing stuff like that is useful so you don't need to
> replicate the whole hierarchy.  In this case that's not a huge
> savings, but it can be nice to be consistent.  In the very least it
> saves you a level of indentation.
> 
> 
>> +               serial@a84000 {
>> +                       status = "okay";
>> +               };
> 
> Similarly here you can use the alias from the sdm845.dtsi file to
> avoid replicating the hierarchy.  AKA at the top level do:
> 
> &qup_uart2 {
>   status = "okay";
> };
> 
> In this case it saves you 2 levels of indentation.

Right. Andy/Bjorn, are there any preferences here?
I see we don't do this for the other board files, and I not sure
theres a specific reasoning for how its currently done and if we
need to stick to it.

> 
>> +
>> +               pinctrl@3400000 {
>> +                       qup_uart2_default: qup_uart2_default {
> 
> I'm not sure how persnickety I should be, but according to
> <https://elinux.org/Device_Tree_Linux>:
> 
>   node names use dash "-" instead of underscore "_"
> 
> ...but, of course, labels can't use dashes (and the same page says to
> use underscore for labels).  This is why, in rk3288 for instance, you
> see:
> 
> i2c2_xfer: i2c2-xfer {
>   rockchip,pins = <6 9 RK_FUNC_1 &pcfg_pull_none>,
>   <6 10 RK_FUNC_1 &pcfg_pull_none>;
> };
> 
> AKA the label and the node name are the same but the label uses "_"
> and the node names use "-".

Sure, I'll fix these up.

[]
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 02520f19e4ca..c4ce70840acf 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -4,6 +4,7 @@
>>   */
>>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>>
>>  / {
>>         model = "Qualcomm Technologies, Inc. SDM845";
>> @@ -273,5 +274,25 @@
>>                         cell-index = <0>;
>>                 };
>>
>> +               qup_1: qcom,geni_se@ac0000 {
>> +                       compatible = "qcom,geni-se-qup";
>> +                       reg = <0xac0000 0x6000>;
> 
> I think you may have mentioned this in another context, but this
> doesn't match the current bindings.  Some clocks should be here.
> ...and it looks like the uart should be a subnode.

right, these were tested with the v1 set for serial. I will update them.

regards
Rajendra

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
