Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02306C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AA32146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AA32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeK3Uc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:32:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49368 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeK3Uc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:32:26 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2565813F87C;
        Fri, 30 Nov 2018 10:23:23 +0100 (CET)
Subject: Re: [PATCH 1/3] clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at
 critical
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-2-bjorn.andersson@linaro.org>
 <154356151361.88331.1298482384404357982@swboyd.mtv.corp.google.com>
 <20181130072420.GG5278@tuxbook-pro>
 <154356557630.88331.15462727905875864666@swboyd.mtv.corp.google.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <ea03cff9-517f-f7ec-bc51-966393388c9f@free.fr>
Date:   Fri, 30 Nov 2018 10:23:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154356557630.88331.15462727905875864666@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 09:12, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-11-29 23:24:20)
>
>> On Thu 29 Nov 23:05 PST 2018, Stephen Boyd wrote:
>>
>>> Quoting Bjorn Andersson (2018-11-29 22:52:57)
>>>
>>>> Keep the two clocks enabled, so that the platform passes
>>>> clk_disable_unused().
>>>>
>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> ---
>>>>  drivers/clk/qcom/gcc-msm8998.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
>>>> index 9f0ae403d5f5..d89f8e7c2a59 100644
>>>> --- a/drivers/clk/qcom/gcc-msm8998.c
>>>> +++ b/drivers/clk/qcom/gcc-msm8998.c
>>>> @@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
>>>>                 .enable_mask = BIT(0),
>>>>                 .hw.init = &(struct clk_init_data){
>>>>                         .name = "gcc_hmss_dvm_bus_clk",
>>>> +                       .flags = CLK_IS_CRITICAL,
>>>
>>> Please add a comment about why they're critical. This is a temporary
>>> solution?
>>
>> Disabling them in clk_disable_unused() are bad, mkay...
> 
> Ugh sad.
> 
>> SDM845 marks the equivalent clocks as critical with a comment that they
>> must be on for system operation... I'm uncertain what the exact purpose
>> of these two clocks are, so I don't have a better explanation right now.
> 
> Ok. But does any driver ever want to use it? It may make more sense to
> just remove it entirely and not touch it.

FWIW, gcc_hmss_dvm_bus_clk is flagged "always on" downstream:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/clk/msm/clock-gcc-8998.c?h=LE.UM.1.3.r3.25#n1715


config REGULATOR_CPR3_HMSS
        bool "CPR3 regulator for HMSS"
        depends on OF
        select REGULATOR_CPR3
        help
          This driver supports Qualcomm Technologies, Inc. HMSS application
          processor specific features including memory array power mux (APM)
          switching, two CPR3 threads which monitor the two HMSS clusters that
          are both powered by a shared supply, and hardware closed-loop auto
          voltage stepping.  This driver reads both initial voltage and CPR
          target quotient values out of hardware fuses.

I wasn't able to find the meaning of the HMSS acronym via git grep, pdfgrep,
or a web search. It should be forbidden to use an undefined acronyms in
bindings documentation, IMHO.


I couldn't find gcc_lpass_at_clk in the downstream 4.4 kernel...
LPASS = Low Power Audio Subsystem

Regards.
