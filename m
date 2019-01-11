Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB62E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391756AbfAKPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:02:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54228 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389215AbfAKObn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8AF90209BD; Fri, 11 Jan 2019 15:31:41 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr [109.213.145.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id 313A7209BC;
        Fri, 11 Jan 2019 15:31:41 +0100 (CET)
Date:   Fri, 11 Jan 2019 15:31:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: snvs: make sure clock is enabled for interrupt
 handle
Message-ID: <20190111143141.GC2547@piout.net>
References: <1547190255-9388-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547190255-9388-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/01/2019 07:09:02+0000, Anson Huang wrote:
> During system suspend, the SNVS RTC's clock will be disabled in
> noirq suspend phase, but SNVS RTC's alarm interrupt could still
> arrive, system will hang if SNVS RTC driver tries to access register
> without clock enabled, this patch fixes the issue of this scenario.
> 

Are you sure this is the real issue? I don't think the handler can be
called before the resume_noirq callback. Isn't the issue that your clock
driver has not yet resumed by the time you call the rtc driver
resume_noirq callback ?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/rtc/rtc-snvs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index b2483a7..0b9eff1 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -239,6 +239,9 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
>  	u32 lpsr;
>  	u32 events = 0;
>  
> +	if (data->clk)
> +		clk_enable(data->clk);
> +

Anyway, won't that need a clk_prepare_enable because it has been
clk_disable_unprepare in suspend_noirq? And this is something you can
not do in atomic context

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
