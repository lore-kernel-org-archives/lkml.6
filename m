Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28A520844
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28A520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeGDQdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:33:49 -0400
Received: from foss.arm.com ([217.140.101.70]:40474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbeGDQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:33:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6CA41595;
        Wed,  4 Jul 2018 09:33:46 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BE713F5AD;
        Wed,  4 Jul 2018 09:33:44 -0700 (PDT)
Date:   Wed, 4 Jul 2018 17:35:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH 1/2] reset: imx7: Fix always writing bits as 0
Message-ID: <20180704163517.GA13155@red-moon>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
 <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:39:16PM +0300, Leonard Crestez wrote:
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
> ---
>  drivers/reset/reset-imx7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think Philipp will pick it up, so I will drop it from the PCI
patchwork, if there is a problem please let me know.

Thanks,
Lorenzo

> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 4db177bc89bc..fdeac1946429 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -78,11 +78,11 @@ static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
>  static int imx7_reset_set(struct reset_controller_dev *rcdev,
>  			  unsigned long id, bool assert)
>  {
>  	struct imx7_src *imx7src = to_imx7_src(rcdev);
>  	const struct imx7_src_signal *signal = &imx7_src_signals[id];
> -	unsigned int value = 0;
> +	unsigned int value = assert ? signal->bit : 0;
>  
>  	switch (id) {
>  	case IMX7_RESET_PCIEPHY:
>  		/*
>  		 * wait for more than 10us to release phy g_rst and
> -- 
> 2.17.0
> 
