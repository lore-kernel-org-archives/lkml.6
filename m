Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeBBRqB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:46:01 -0500
Received: from vern.gendns.com ([206.190.152.46]:47920 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753532AbeBBRpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:45:44 -0500
Subject: Re: [PATCH v6 04/41] clk: davinci: Add platform information for TI
 DA850 PLL
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-5-git-send-email-david@lechnology.com>
 <7d7e0522-30d5-6232-853e-7ab32fadfe48@lechnology.com>
 <ceec9849-e3fb-0e9b-4000-aab3ca2f5a43@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <4a1d3a2f-128a-b6ff-3675-2ff0bf290dcd@lechnology.com>
Date: Fri, 2 Feb 2018 11:45:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ceec9849-e3fb-0e9b-4000-aab3ca2f5a43@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 02:37 AM, Sekhar Nori wrote:
> On Friday 02 February 2018 12:52 AM, David Lechner wrote:
> 
>>> +static const char * const da850_pll1_obsclk_parent_names[]
>>> __initconst = {
>>> +    "oscin",
>>
>> Re: the issue of "ref_clk" vs. "oscin"...
>>
>> This is one of the places where having the otherwise unnecessary "oscin"
>> clock
>> really helps out. The PLL driver doesn't control "ref_clk" - it comes
>> from somewhere
>> else. And in the case of DT, it may not even be named "ref_clk", so we
>> really
>> don't want to hard-code the name "ref_clk" here.
> 
> TBH, I don't really see what is wrong with mandating the name "ref_clk"
> as the reference clock name to be provided. And for all board-files and
> DTs to supply the same name.
> 
>> If we have to allow a variable name here, it just makes more work in the
>> driver
>> shuffling names around.
>>
>> And the name "oscin" totally makes sense here because the TRM lists this
>> input to the
>> mux as "OSCIN".
> 
> Fine with me if you feel it simplifies implementation for you (and also
> because of the distinction you want to make between the external "before
> CLKMODE" clock and internal "after CLKMODE" clock). What I do care about
> though is:
> 
> a) In the DT case, ability for different boards to provide different
>     ref_clk frequencies. We never really had this in the legacy board
>     file way (except some rudimentary support on DM6467T). And its fine
>     to continue with status quo for board files.

You can do this now. You would just add something like this to the board's
.dts file:

	& ref_clk {
		clock-frequency = <30000000>; /* 30 MHz */
	};

> 
> b) In the DT case, ability for board to specify whether it uses the
>     on-chip oscillator or has an external clean clock provider.

Boards with an oscillator don't need to do anything since that is the
default. Boards with clock will need to do this:

	&pll0 {
		ti,clkmode-square-wave;
	};

> 
>>> +void __init da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1)
>>> +{
>>> +    const struct davinci_pll_sysclk_info *info;
>>> +
>>> +    davinci_pll_clk_register(&da850_pll0_info, "ref_clk", pll0);
>>
>> And really, we probably shouldn't be hard-coding "ref_clk" here either.
>> Basically, we are making the assumption that the board file has registered
>> a clock named "ref_clk". It would probably be better to pass the name
>> as a parameter.
> 
> As I noted before, I am not sure if this level of naming flexibility is
> needed. Every board needs to have one anyway. They might as well call it
> by the same name.
> 
> That said, I wont oppose it either if you decide to have that flexibility.
> 

I'll sleep on it. Like you, I could go either way. I'm temped to just leave
it as-is though (with some added comments for clarification, of course).
