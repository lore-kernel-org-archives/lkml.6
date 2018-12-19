Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67AC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AB72184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeLSIym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:54:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53732 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbeLSIyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:54:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B4EA207D9; Wed, 19 Dec 2018 09:54:39 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 054FA207B2;
        Wed, 19 Dec 2018 09:54:29 +0100 (CET)
Date:   Wed, 19 Dec 2018 09:54:29 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Message-ID: <20181219085429.GJ19816@piout.net>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 29/11/2018 01:50:11+0000, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and secure rtc etc..
> 
> This patch adds i.MX system controller RTC driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to set/get RTC time and other alarm functions,
> since the RTC set time needs to be done in secure EL3 mode (required
> by system controller firmware) and alarm functions needs to be done
> with general MU IRQ handle, these depend on other components which
> are NOT ready, so this patch ONLY enables the RTC time read.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *remove unnecessary headfile included;
>   *fix potential memory currpution for the message responce;
>   *update the compatible string name to start with "fsl" instead of "nxp".
>  drivers/rtc/Kconfig      |  6 +++
>  drivers/rtc/Makefile     |  1 +
>  drivers/rtc/rtc-imx-sc.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/rtc/rtc-imx-sc.c
> 

I applied it on my test branch and this makes sparc64-allyesconfig fail
with:

   drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_read_time':
   rtc-imx-sc.c:(.text+0x34): undefined reference to `imx_scu_call_rpc'
   drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_probe':
   rtc-imx-sc.c:(.text+0x90): undefined reference to `imx_scu_get_handle'



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
