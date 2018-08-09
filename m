Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FFC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3262421C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3262421C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeHIPVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:21:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16896 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:21:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c3a000000>; Thu, 09 Aug 2018 05:56:32 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 05:56:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Aug 2018 05:56:47 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 12:56:43 +0000
Date:   Thu, 9 Aug 2018 15:56:38 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 13/40] mmc: tegra: Poll for calibration completion
Message-ID: <20180809155638.23f96e61@dhcp-10-21-25-168>
In-Reply-To: <20180809124616.GV21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
        <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
        <20180809124616.GV21639@ulmo>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2018 14:46:16 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Aug 01, 2018 at 07:32:03PM +0300, Aapo Vienamo wrote:
> > Implement polling with 10 ms timeout for automatic pad drive strength
> > calibration.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 7d98455..c8ff267 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> > @@ -50,6 +51,9 @@
> >  #define SDHCI_AUTO_CAL_START			BIT(31)
> >  #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> >  
> > +#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
> > +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
> > +
> >  #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
> >  #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
> >  #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> > @@ -228,13 +232,20 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
> >  
> >  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
> >  {
> > -	u32 val;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> > +	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> > +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> >    
> 
> I know this is preexisting, but I want to make sure we cover this so we
> don't run into this down the road: do these bits automatically clear on
> calibration completion? Can we run these multiple times and get
> everything properly calibrated?

The TRM states in the pad auto-calibration procedure description that
this bit should not be cleared.

 -Aapo
