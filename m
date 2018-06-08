Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JhTYNYGRGlsAZgAAmS7hNA
	; Fri, 08 Jun 2018 14:24:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B5A83608B8; Fri,  8 Jun 2018 14:24:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4559060590;
	Fri,  8 Jun 2018 14:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4559060590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHOYC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:24:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49061 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbeFHOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:24:01 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fRIJ2-0004St-9F; Fri, 08 Jun 2018 16:23:56 +0200
Message-ID: <1528467832.26356.18.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] reset: imx7: Fix always writing bits as 0
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 08 Jun 2018 16:23:52 +0200
In-Reply-To: <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
         <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> Right now the only user of reset-imx7 is pci-imx6 and the
> reset_control_assert and deassert calls on pciephy_reset don't toggle
> the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
> 1 or 0 respectively.
> 
> The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
> other registers like MIPIPHY and HSICPHY the bits are explicitly
> documented as "1 means assert, 0 means deassert".
> 
> The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/reset/reset-imx7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 4db177bc89bc..fdeac1946429 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -78,11 +78,11 @@ static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
>  static int imx7_reset_set(struct reset_controller_dev *rcdev,
> >  			  unsigned long id, bool assert)
>  {
> >  	struct imx7_src *imx7src = to_imx7_src(rcdev);
> >  	const struct imx7_src_signal *signal = &imx7_src_signals[id];
> > -	unsigned int value = 0;
> > +	unsigned int value = assert ? signal->bit : 0;
>  
> >  	switch (id) {
> >  	case IMX7_RESET_PCIEPHY:
> >  		/*
> >  		 * wait for more than 10us to release phy g_rst and
