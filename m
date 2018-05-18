Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeERPgF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:36:05 -0400
Received: from vern.gendns.com ([206.190.152.46]:54186 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeERPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:35:58 -0400
Subject: Re: [PATCH v10 25/27] ARM: davinci: add device tree support to timer
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-26-david@lechnology.com>
 <8fa98514-7651-58cb-595e-6c7f713540b8@ti.com>
 <1162de58-00bc-fdfa-eef1-48a094834ac3@lechnology.com>
 <c7064bee-d385-4496-c19e-1b72853b01f1@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <9bc3fb8f-ca03-9cfd-1e9d-51f8c9347da7@lechnology.com>
Date: Fri, 18 May 2018 10:35:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c7064bee-d385-4496-c19e-1b72853b01f1@ti.com>
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

On 05/18/2018 01:05 AM, Sekhar Nori wrote:
> On Thursday 17 May 2018 08:39 PM, David Lechner wrote:
>> On 05/17/2018 09:35 AM, Sekhar Nori wrote:
>>> Hi David,
>>>
>>> On Wednesday 09 May 2018 10:56 PM, David Lechner wrote:
>>>> This adds device tree support to the davinci timer so that when clocks
>>>> are moved to device tree, the timer will still work.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>> ---
>>>
>>>> +static int __init of_davinci_timer_init(struct device_node *np)
>>>> +{
>>>> +    struct clk *clk;
>>>> +
>>>> +    clk = of_clk_get(np, 0);
>>>> +    if (IS_ERR(clk)) {
>>>> +        struct of_phandle_args clkspec;
>>>> +
>>>> +        /*
>>>> +         * Fall back to using ref_clk if the actual clock is not
>>>> +         * available. There will be problems later if the real clock
>>>> +         * source is disabled.
>>>> +         */
>>>> +
>>>> +        pr_warn("%s: falling back to ref_clk\n", __func__);
>>>> +
>>>> +        clkspec.np = of_find_node_by_name(NULL, "ref_clk");
>>>> +        if (IS_ERR(clkspec.np)) {
>>>> +            pr_err("%s: No clock available for timer!\n", __func__);
>>>> +            return PTR_ERR(clkspec.np);
>>>> +        }
>>>> +        clk = of_clk_get_from_provider(&clkspec);
>>>> +        of_node_put(clkspec.np);
>>>> +    }
>>>
>>> Do we need this error path now?
>>>
>>> Thanks,
>>> Sekhar
>>>
>>
>> No, not really.
> 
> Then lets just print an error and return the error number.
> 

OK. FYI, timer_probe() prints the error if we return and error, so
I will just return the error.
