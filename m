Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C27D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeL1GjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:39:05 -0500
Received: from mx.socionext.com ([202.248.49.38]:9170 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbeL1GjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:39:03 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Dec 2018 15:38:59 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 0D8C21800F6;
        Fri, 28 Dec 2018 15:39:00 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 28 Dec 2018 15:38:59 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B1C6C40221;
        Fri, 28 Dec 2018 15:38:59 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 95260121BF2;
        Fri, 28 Dec 2018 15:38:59 +0900 (JST)
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
 <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <0c8db56a-6738-e003-5088-0c13588f695a@socionext.com>
Date:   Fri, 28 Dec 2018 15:38:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2018/12/28 9:39, Stephen Boyd wrote:
> Quoting Sugaya, Taichi (2018-12-25 17:35:27)
>> Hi
>>
>> On 2018/11/30 17:31, Stephen Boyd wrote:
>>>> +       init.num_parents = parents;
>>>> +       init.parent_names = parent_names;
>>>> +
>>>> +       mcm->cname = clk_name;
>>>> +       mcm->parent = 0;
>>>> +       mcm->hw.init = &init;
>>>> +
>>>> +       clk = clk_register(NULL, &mcm->hw);
>>>> +       if (IS_ERR(clk))
>>>> +               goto err_clk;
>>>> +
>>>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>>> +       return;
>>>> +
>>>> +err_clk:
>>>> +       kfree(mcm);
>>>> +err_mcm:
>>>> +       kfree(parent_names);
>>>> +}
>>>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>>>> +                       m10v_clk_mux_setup);
>>>
>>> Any chance you can use a platform driver?
>>>
>>
>> Excuse me to re-ask you.
>> Why do you recommend to use a platform driver? Is that current fad?
> 
> Not exactly a fad. We've been doing it for some time now. From an older
> email on the list:
> 
> Reasons (in no particular order):
> 
>    1. We get a dev pointer to use with clk_hw_register()
> 
>    2. We can handle probe defer if some resource is not available
> 
>    3. Using device model gets us a hook into power management frameworks
>       like runtime PM and system PM for things like suspend and hibernate
> 
>    4. It encourages a single DT node clk controller style binding
>       instead of a single node per clk style binding
> 
>    5. We can use non-DT specific functions like devm_ioremap_resource() to map
>       registers and acquire other resources, leading to more portable and
>       generic code
> 
>    6. We may be able to make the device driver a module, which will
>       make distros happy if we don't have to compile in all
>       these clk drivers to the resulting vmlinux
> 

Great thanks for answering. I strongly understand.
#It takes a bit of time to send v2.

Best Regards,
Sugaya Taichi

