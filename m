Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A622086C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407529AbfBNPTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:19:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40796 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404736AbfBNPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:19:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so7200840qta.7;
        Thu, 14 Feb 2019 07:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2jDvgeYI07tNG5Owhw2pu2NCO5S1JykUibenL/XOXU=;
        b=GGkPeEWZ+ER6MKjOWAQ9mKXd9RvmTnKlZnjiZGqSOFQAQT0Gqs2BMYdssFiUw7j2Pu
         QJxloXGSnQLQ/Cdw+mLDvTtjsm6aEU0X7pXztkXW6H4yb8PeXYu+kzsHxMoZQEjuprKs
         JFUmARYW1dsf/Tz7V2oM9qaPZRJmH+iPPGgR40W8bWiApRV1/c28fywoHgbkPNcnq8YO
         mP4zzJm8HxumxWlt/vvzHoDH7QbiAvOlt/FC4S8a9KywXyXjErsqdUtG2BDsbiHfsgmE
         RT9gFVTH6vltKtYvMbysTf0x1NLKorRU/+H3WAb0g43t6JXN4GSvRLyfggwGSvR5v2sm
         PkyA==
X-Gm-Message-State: AHQUAua9Gpek9TKQJZC034MMl09ZEEpNhBy8xF/ehXGZkvIf9LWItr0+
        tGa40yoXCWnTdyO8VOfu25X2RZaG5IV8yHBIQz4=
X-Google-Smtp-Source: AHgI3IbJ5kqd7VYoE4Ijv0+wjKEkrfbslEv9L8SgDohBSE1FjjnstcYOPqInxE79z/H/vHEVCdciN0a77rNt50kK7cs=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr3543474qta.152.1550157551498;
 Thu, 14 Feb 2019 07:19:11 -0800 (PST)
MIME-Version: 1.0
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org> <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
In-Reply-To: <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Feb 2019 16:18:53 +0100
Message-ID: <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/02/2019 11:34, Sugaya, Taichi wrote:
> > Hi,
> >
> > On 2019/02/12 18:06, Daniel Lezcano wrote:
> >> On 08/02/2019 13:26, Sugaya Taichi wrote:
> >>> Add timer driver for Milbeaut SoCs series.
> >>>
> >>> The timer has two 32-bit width down counters, one of which is configured
> >>> as a clockevent device and the other is configured as a clock source.
> >>>
> >>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> >>
> >> Do want me to take it through my tree?
> >>
> >
> > Yes, please.
> >
> > By the way, the patch series includes other sub-system drivers, so
> > should it be splitted into each driver patch ?
>
> Well usually changes are per sub-systems but in case of first submission
> you may ask linux-soc@ team to take all the patches together with the
> acked-by tags from those subsystems maintainer.
>
> Added in Cc: Arnd@ and linux-soc@
>
> I'll wait a bit before applying the patch you clarify this.

Yes, I think merging them all together is best here.

I saw the patches fly past but did not do a complete review,
but if all other review comments are addressed, I'd suggest
sending the entire series for inclusion to linux-soc@vger.kernel.org
with the Acked-by/Reviewed-by tags from subsystem maintainers
added in.

     Arnd
