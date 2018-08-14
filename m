Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF0BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9019320C0D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9019320C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbeHNMNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:13:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40596 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbeHNMNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:13:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5560180D;
        Tue, 14 Aug 2018 02:26:59 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 928803F5D0;
        Tue, 14 Aug 2018 02:26:57 -0700 (PDT)
Subject: Re: [PATCH RESEND RFC 2/4] drivers: pinctrl: qcom: add wakeup gpio
 map for sdm845
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-3-ilina@codeaurora.org>
 <8636vyxyub.wl-marc.zyngier@arm.com> <20180801200405.GB6422@codeaurora.org>
 <20180813194152.GG5081@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <91ca518e-3906-9790-a27d-a06d15105655@arm.com>
Date:   Tue, 14 Aug 2018 10:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813194152.GG5081@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/18 20:41, Lina Iyer wrote:
> On Wed, Aug 01 2018 at 14:04 -0600, Lina Iyer wrote:
>> On Wed, Aug 01 2018 at 02:42 -0600, Marc Zyngier wrote:
>>> On Wed, 01 Aug 2018 03:00:19 +0100,
>>> Lina Iyer <ilina@codeaurora.org> wrote:
>>>>
>>>> Add GPIO to PDC pin map for the SDM845 SoC.
>>>>
>>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>>> ---
>>>> drivers/pinctrl/qcom/pinctrl-sdm845.c | 76 +++++++++++++++++++++++++++
>>>> 1 file changed, 76 insertions(+)
>>>>
>>>> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>>>> index 2ab7a8885757..e93660922dc2 100644
>>>> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
>>>> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>>>> @@ -1277,6 +1277,80 @@ static const struct msm_pingroup sdm845_groups[] = {
>>>> 	UFS_RESET(ufs_reset, 0x99f000),
>>>> };
>>>>
>>>> +static struct msm_pinctrl_pdc_map sdm845_wakeup_gpios[] = {
>>>
>>> [huge array]
>>>
>>>> +};
>>>
>>> Why isn't that array part of the DT? I'd expect other SoCs to
>>> eventually use a similar mechanism, no?
>>>
>> I agree and it should be.
>>
>> One place I am thinking is to add it to the DT definition of PDC
>> controller as a data argument -
>>
>> 	tlmm: pinctrl@000000{
>> 	[...]
>> 		interrupts-extended = <&pdc 30 IRQ_TYPE_LEVEL_HIGH 1>,
>>                     <&pdc 31 IRQ_TYPE_LEVEL_HIGH 3>,
>> 		      <&pdc 32 IRQ_TYPE_LEVEL_HIGH 5>,
>> 						   ^
>> 						   |--- Provide the GPIO
>> 						   for the PDC pin here.
>> 	};
>>
>> 	pdc: interrupt-controller@b220000 {
>> 		compatible = "qcom,sdm845-pdc";
>> 		reg = <0xb220000 0x30000>;
>> 		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
>> 		#interrupt-cells = <3>; <-------- Increase this from 2 ?
>> 		interrupt-parent = <&intc>;
>> 		interrupt-controller;
>> 	};
>>
>> Would that be acceptable?
>>
> Any ideas on how to do this better?

I don't think adding an extra argument to the PDC interrupt specifier is
that great. I'd rather see some associated array in the PDC binding
mapping an interrupt to a pin on which special treatment must be applied.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
