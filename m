Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C096ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E520205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E520205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeGXNiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:38:51 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40013 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbeGXNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:38:51 -0400
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fhwUO-0002jo-Pk; Tue, 24 Jul 2018 13:32:28 +0100
Subject: Re: [PATCH 6/8] clk: tegra30: add 2d and 3d idle clocks
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, jonathanh@nvidia.co, thierry.reding@gmail.com,
        linux-kernel@lists.codethink.co.uk
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <20180720134532.13148-7-ben.dooks@codethink.co.uk>
 <6750449.onR3KBHYkZ@dimapc> <16130866.kpFhQUNOMP@dimapc>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <a4bd4ea0-ad7b-e942-c535-1ac5f9162beb@codethink.co.uk>
Date:   Tue, 24 Jul 2018 13:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <16130866.kpFhQUNOMP@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 12:31, Dmitry Osipenko wrote:
> On Monday, 23 July 2018 16:05:21 MSK Dmitry Osipenko wrote:
>> On Friday, 20 July 2018 16:45:30 MSK Ben Dooks wrote:
>>> The 2D and 3D clocks have an IDLE field in bits 15:8 so add these
>>> clocks by making a 2D and 3D mux, and split the divider into the
>>> standard 2D/3D ones and 2D/3D idle clocks.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>   drivers/clk/tegra/clk-id.h              |  4 ++++
>>>   drivers/clk/tegra/clk-tegra-periph.c    | 23 +++++++++++++++++++++--
>>>   drivers/clk/tegra/clk-tegra30.c         |  8 ++++++++
>>>   include/dt-bindings/clock/tegra30-car.h |  7 ++++++-
>>>   4 files changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
>>> index b616e33c5255..0d202a70ce66 100644
>>> --- a/drivers/clk/tegra/clk-id.h
>>> +++ b/drivers/clk/tegra/clk-id.h
>>> @@ -91,8 +91,12 @@ enum clk_id {
>>>   	tegra_clk_fuse_burn,
>>>   	tegra_clk_gpu,
>>>   	tegra_clk_gr2d,
>>> +	tegra_clk_gr2d_mux,
>>> +	tegra_clk_gr2d_idle,
>>>   	tegra_clk_gr2d_8,
>>>   	tegra_clk_gr3d,
>>> +	tegra_clk_gr3d_mux,
>>> +	tegra_clk_gr3d_idle,
>>>   	tegra_clk_gr3d_8,
>>>   	tegra_clk_hclk,
>>>   	tegra_clk_hda,
>>> diff --git a/drivers/clk/tegra/clk-tegra-periph.c
>>> b/drivers/clk/tegra/clk-tegra-periph.c index 47e5b1ac1a69..83967dac93f2
>>> 100644
>>> --- a/drivers/clk/tegra/clk-tegra-periph.c
>>> +++ b/drivers/clk/tegra/clk-tegra-periph.c
>>> @@ -263,6 +263,21 @@
>>>   		.flags = _flags,					\
>>>   	}
>>>
>>> +#define GATE_DIV(_name, _parent_name, _offset,				\
>>> +		 _div_shift, _div_width, _div_frac_width, _div_flags,	\
>>> +			     _clk_num, _gate_flags,  _clk_id, _flags)	\
>>> +	{								\
>>> +		.name = _name,						\
>>> +		.clk_id = _clk_id,					\
>>> +		.offset = _offset,					\
>>> +		.p.parent_name =  _parent_name,				\
>>> +		.periph = TEGRA_CLK_PERIPH(0, 0, 0,			\
>>> +					   _div_shift, _div_width,	\
>>> +					   _div_frac_width, _div_flags, \
>>> +				_clk_num, _gate_flags, NULL, NULL),	\
>>> +		.flags = _flags						\
>>> +	}
>>> +
>>>   #define PLLP_BASE 0xa0
>>>   #define PLLP_MISC 0xac
>>>   #define PLLP_MISC1 0x680
>>> @@ -646,8 +661,12 @@ static struct tegra_periph_init_data periph_clks[] = {
>>>   	MUX("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0,
>> tegra_clk_epp),
>>> MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0,
>>> tegra_clk_host1x), MUX("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60,
>>> 0, tegra_clk_mpe), -	MUX("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D,
>> 21,
>>> 0, tegra_clk_gr2d), -	MUX("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D,
>> 24,
>>> 0, tegra_clk_gr3d), +	MUX("2d_mux", mux_pllm_pllc_pllp_plla,
>> CLK_SOURCE_2D,
>>> 0, TEGRA_PERIPH_NO_DIV | TEGRA_PERIPH_NO_RESET | TEGRA_PERIPH_NO_GATE,
>>> tegra_clk_gr2d_mux), +	GATE_DIV("2d", "2d_mux", CLK_SOURCE_2D, 0, 8, 1,
>>> TEGRA_DIVIDER_ROUND_UP,21, 0, tegra_clk_gr2d, 0), +	GATE_DIV("2d_idle",
>>> "2d_mux", CLK_SOURCE_2D, 8, 8, 1, TEGRA_DIVIDER_ROUND_UP, 0,
>>> TEGRA_PERIPH_NO_GATE | TEGRA_PERIPH_NO_RESET, tegra_clk_gr2d_idle, 0),
>>> +	MUX("3d_mux", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 0,
>>
>> Now that the actual parent clock is specified by the "mux" clock, you have to
>> adjust the tegra_clk_init_table accordingly.
>>
>>
>>
>>
> 
> The 3d/2d clocks do not have a parent on T20 with these patches being applied.

Thanks, I need to extract the setup from some of the other changes that
we did for the tegra30a/20a devices.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
