Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C394C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1477E2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfBOCZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:25:58 -0500
Received: from mx.socionext.com ([202.248.49.38]:42781 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbfBOCZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:25:53 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Feb 2019 11:25:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id BB1F6180B51;
        Fri, 15 Feb 2019 11:25:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 Feb 2019 11:25:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 28C961A15B7;
        Fri, 15 Feb 2019 11:25:51 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0C5EA120459;
        Fri, 15 Feb 2019 11:25:51 +0900 (JST)
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-soc@vger.kernel.org
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
 <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
Date:   Fri, 15 Feb 2019 11:25:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2019/02/15 0:18, Arnd Bergmann wrote:
> On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 13/02/2019 11:34, Sugaya, Taichi wrote:
>>> Hi,
>>>
>>> On 2019/02/12 18:06, Daniel Lezcano wrote:
>>>> On 08/02/2019 13:26, Sugaya Taichi wrote:
>>>>> Add timer driver for Milbeaut SoCs series.
>>>>>
>>>>> The timer has two 32-bit width down counters, one of which is configured
>>>>> as a clockevent device and the other is configured as a clock source.
>>>>>
>>>>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>>>>
>>>> Do want me to take it through my tree?
>>>>
>>>
>>> Yes, please.
>>>
>>> By the way, the patch series includes other sub-system drivers, so
>>> should it be splitted into each driver patch ?
>>
>> Well usually changes are per sub-systems but in case of first submission
>> you may ask linux-soc@ team to take all the patches together with the
>> acked-by tags from those subsystems maintainer.
>>
>> Added in Cc: Arnd@ and linux-soc@
>>
>> I'll wait a bit before applying the patch you clarify this.
> 
> Yes, I think merging them all together is best here.
> 
> I saw the patches fly past but did not do a complete review,
> but if all other review comments are addressed, I'd suggest
> sending the entire series for inclusion to linux-soc@vger.kernel.org
> with the Acked-by/Reviewed-by tags from subsystem maintainers
> added in.
> 
>       Arnd
> 

Thank you for suggestion.
OK. I will send the series to the ML with the Acked-by/Reviewed-by tags.

Thanks,
Sugaya Taichi

