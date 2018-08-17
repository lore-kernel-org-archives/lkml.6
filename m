Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B636C41536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5112185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5112185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeHQK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:28:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42541 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeHQK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:28:06 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fqZ8i-0000N3-VL; Fri, 17 Aug 2018 09:25:44 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fqZ8i-0003Ju-28; Fri, 17 Aug 2018 09:25:44 +0200
Date:   Fri, 17 Aug 2018 09:25:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 4/5] clk: imx: add imx composite clock
Message-ID: <20180817072544.izryvqlqpaihs7kl@pengutronix.de>
References: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
 <1534433236-8925-5-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534433236-8925-5-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:07:14 up 65 days, 16:16, 60 users,  load average: 0.04, 0.10,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Thu, Aug 16, 2018 at 06:27:15PM +0300, Abel Vesa wrote:
> Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one more complex
> clock type, therefore moving the complexity inside the composite clock and
> outside of the SoC specific clock driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-composite.c | 471 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h           |   9 +
>  3 files changed, 481 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b87513c..4fabb0a 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -3,6 +3,7 @@
>  obj-y += \
>  	clk.o \
>  	clk-busy.o \
> +	clk-composite.o \
>  	clk-cpu.o \
>  	clk-fixup-div.o \
>  	clk-fixup-mux.o \
> diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c

You nearly duplicate drivers/clk/clk-composite.c. This seems necessary
because in the hardware we have two dividers instead of a single one as
the generic composite clock type support.

Instead of duplicating the composite clk code you could create your own
clk_ops for the divider which handles both dividers in a single
callback. You could then use the generic composite clk.

When I made the suggestion that we should a create a composite clk I had
assumed you'd come up with a patch which has a single private struct clk_ops
filled in with the gate/mux/rate callbacks which are then open coded in
your driver. I am not convinced this splitting up in three different
(gate/mux/rate) struct clk_ops brings us anything. For example the open
coded gate code is really trivial compared to all this boilerplate code
we need for the generic composite clk. But maybe the maintainers have a
different opinion?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
