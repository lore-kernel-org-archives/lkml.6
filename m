Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF88C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C79120652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C79120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJDXIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:08:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38886 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbeJDXIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:08:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0812346|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01546;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.CzOm7Av_1538669673;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CzOm7Av_1538669673)
          by smtp.aliyun-inc.com(10.147.44.129);
          Fri, 05 Oct 2018 00:14:33 +0800
Date:   Fri, 5 Oct 2018 00:14:32 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V9 3/8] clocksource: add C-SKY SMP timer
Message-ID: <20181004161431.GA30844@guoren-Inspiron-7460>
References: <cover.1538355281.git.ren_guo@c-sky.com>
 <eee964dd57d12bc630280ab84235b5356799b1fb.1538355281.git.ren_guo@c-sky.com>
 <88e320f2-8cf0-fdb9-c9b0-ee25d7a4d00f@linaro.org>
 <20181002054024.GA12645@guoren>
 <49238cda-d12c-7d3f-9333-296527d94f12@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49238cda-d12c-7d3f-9333-296527d94f12@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 09:59:42AM +0200, Daniel Lezcano wrote:
> On 02/10/2018 07:40, Guo Ren wrote:
> [ ... ]
> 
> >>
> >> 	irq = irq_of_parse_and_map(np, 0);
> >> 	if (irq <= 0)
> >> 		return -EINVAL;
> > 		panic();
> > I want a panic here. Return will make debug confused and directly tell
> > the people where is wrong. It's root-timer for us and it must bootup.
> > 
> > If it's a co-timer, I also think return is good.
> 
> We don't need a panic in case of failure. If the board as an alternate
> timer it should be able to boot, that is the general rule of thumb for
> these drivers in this directory.
> 
> The init timer functions will be called via the timer_probe() which
> browse the timer_of_table (the one with all entries for the
> TIMER_OF_DECLARE macros).
> 
> You can see in the code below (from timer_probe.c), there is an error
> message emitted if the driver fails to initialize and another one much
> stronger if no timer was initialize.
> 
> This is enough trace IMO.
> 
> void __init timer_probe(void)
> {
>         struct device_node *np;
>         const struct of_device_id *match;
>         of_init_fn_1_ret init_func_ret;
>         unsigned timers = 0;
>         int ret;
> 
>         for_each_matching_node_and_match(np, __timer_of_table, &match) {
>                 if (!of_device_is_available(np))
>                         continue;
> 
>                 init_func_ret = match->data;
> 
>                 ret = init_func_ret(np);
>                 if (ret) {
>                         pr_err("Failed to initialize '%pOF': %d\n", np,
> ret);
>                         continue;
>                 }
> 
>                 timers++;
Ok, let other timers boot up as possible and no panic for csky timer.

 Guo Ren
