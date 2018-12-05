Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81554C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAFB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAFB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeLELmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:42:45 -0500
Received: from mx.socionext.com ([202.248.49.38]:22046 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLELmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:42:44 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Dec 2018 20:42:42 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8160F180B3E;
        Wed,  5 Dec 2018 20:42:42 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 5 Dec 2018 20:42:42 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 55CDA40377;
        Wed,  5 Dec 2018 20:42:42 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 38B13120455;
        Wed,  5 Dec 2018 20:42:42 +0900 (JST)
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
 <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
 <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <c0b37449-1221-9849-8014-13b3eeb43382@socionext.com>
Date:   Wed, 5 Dec 2018 20:42:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2018/12/05 3:15, Stephen Boyd wrote:
> Quoting Sugaya, Taichi (2018-12-04 00:26:16)
>> On 2018/11/30 17:31, Stephen Boyd wrote:
>>> Quoting Sugaya Taichi (2018-11-18 17:01:12)
>>>> +void __init m10v_clk_mux_setup(struct device_node *node)
>>>> +{
>>>> +       const char *clk_name = node->name;
>>>> +       struct clk_init_data init;
>>>> +       const char **parent_names;
>>>> +       struct m10v_mux *mcm;
>>>> +       struct clk *clk;
>>>> +       int i, parents;
>>>> +
>>>> +       if (!m10v_clk_iomap())
>>>> +               return;
>>>> +
>>>> +       of_property_read_string(node, "clock-output-names", &clk_name);
>>>> +
>>>> +       parents = of_clk_get_parent_count(node);
>>>> +       if (parents < 2) {
>>>> +               pr_err("%s: not a mux\n", clk_name);
>>>
>>> How is this possible?
>>
>> When the node has more than 1 clks...
>> Or I am misunderstanding your question?
> 
> This looks like code that's checking DT for correctness. We don't
> typically do that in the kernel because the kernel isn't a DT validator.
> That's all I'm saying. I think this comment is not useful if the driver
> design is done to specify parent linkages in C code instead of DT, so
> don't worry about this too much.

I understand.
Thank you for additional information.

Sugaya Taichi

> 

