Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B481C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52546218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AUBuTw6h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o/iZX2iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391126AbeLUR7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:59:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbeLUR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:59:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB85D608FF; Fri, 21 Dec 2018 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545415148;
        bh=ToaKA+6kwMe5bmJIcLqmQ8j2a69VMR6t5WiM4eu5240=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AUBuTw6hAl5yAWrjM9s8pNSDxl71r+Y0aAJVwfqYyuTV9PPWTFcVhjwW3P1rAaqHB
         VOGhKGjAjpnkJNGkEfNyRJ5aIcMldjG7s3vdhuTc0in5quDhioN8l5pi9wYEV1UJ3h
         9alN4pZcleKDBbUgiUHram7xocu7GNgXe06znOSk=
Received: from [192.168.225.247] (unknown [49.32.116.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74724606CF;
        Fri, 21 Dec 2018 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545415143;
        bh=ToaKA+6kwMe5bmJIcLqmQ8j2a69VMR6t5WiM4eu5240=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o/iZX2iWacHywN+CVwHpV3qK4M02LmP9sUwTINPTn+7g7wZ4v1k6QSxEDj0o39C56
         76IkKiXK8V/Oe371klqyc91BTYPGTURQzeIOMxskE6yGEhuQKovh4WGF5h2N45l/PH
         ywD4bEIOBFtO0fi/4cjob7yQHHHmgGJzCzTZ2riM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74724606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
Date:   Fri, 21 Dec 2018 23:28:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/21/2018 6:06 PM, Jorge Ramirez wrote:
> On 12/21/18 12:19, Taniya Das wrote:
>>
>>
>> On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
>>> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
>>> specifications.
>>>
>>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> ---
>>>   drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/gcc-qcs404.c 
>>> b/drivers/clk/qcom/gcc-qcs404.c
>>> index 64da032..833436a 100644
>>> --- a/drivers/clk/qcom/gcc-qcs404.c
>>> +++ b/drivers/clk/qcom/gcc-qcs404.c
>>> @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
>>>       },
>>>   };
>>>   +static const struct pll_vco gpll0_ao_out_vco[] = {
>>> +    { 800000000, 800000000, 0 },
>>> +};
>>> +
>>>   static struct clk_alpha_pll gpll0_ao_out_main = {
>>>       .offset = 0x21000,
>>>       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>>>       .flags = SUPPORTS_FSM_MODE,
>>> +    .vco_table = gpll0_ao_out_vco,
>>> +    .num_vco = ARRAY_SIZE(gpll0_ao_out_vco),
>>
>> Could you please help as to why this is required? This is a fixed PLL 
>> and we do not require a VCO table for it.
> 
> Hi Taniya,
> 
> this patch - the additional information that it provides about the 
> hardware - helps to select the right parent clock for a given frequency.
> 
> On the qcs404 this clock is one of the two parent clocks of the apcs 
> clock controller (the other one being the high frequency pll)
> When cpufreq sets a target frequency, there is an iteration through the 
> list of parents to select the one that delivers the best match.
> 
> When attempting to set the clock for an alpha_pll, the operation does a 
> sanity check to validate that the requested frequency is in fact 
> reachable using the vco range: trying to set a value that is not in 
> range will fail.
> 
> This patch makes sure that its range is explicitly defined.
> 
> It also helps making sure there are no rounding issues when setting its 
> value: without it the clock was being read at 799MHz
> 
> 

If the PLL is being read as 799MHz it would because not all the 40 bits 
of the ALPHA_VAL being programmed by the bootloaders(which are the 
original owners of this PLL). So we should go with the way they are 
being set by bootloaders and read by HLOS driver.

And a VCO range you have considered is wrong from a PLL perspective. As 
these are fixed PLLs and VCO range really does not matter here, so 
please drop this change.

>>
>>>       .clkr = {
>>>           .enable_reg = 0x45000,
>>>           .enable_mask = BIT(0),
>>>
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
