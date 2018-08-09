Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67816C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ABA21D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ABA21D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeHIOrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:47:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18995 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:47:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c32250000>; Thu, 09 Aug 2018 05:23:01 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 05:23:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Aug 2018 05:23:04 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 12:23:01 +0000
Date:   Thu, 9 Aug 2018 15:22:54 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Message-ID: <20180809152254.03b97af0@dhcp-10-21-25-168>
In-Reply-To: <20180809114345.GL21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
        <20180809114345.GL21639@ulmo>
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

On Thu, 9 Aug 2018 13:43:45 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 04:59:59PM +0300, Aapo Vienamo wrote:
> > Implement HS400 enhanced strobe.  
> 
> Can you provide a little more information about what the impact is of
> this? Does this increase throughput? How much?

The eMMC enhanced strobe is a mechanism that can be used instead of the
HS400 tuning procedure. Note that the delay line calibration implemented
later on in this series is Tegra specific and has to be performed
regardless of which type of HS400 tuning mechanism is used.

> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 426f7ea..d81143b 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -43,6 +43,9 @@
> >  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
> >  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> >  
> > +#define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
> > +#define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
> > +
> >  #define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
> >  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
> >  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
> > @@ -271,6 +274,22 @@ static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
> >  	}
> >  }
> >  
> > +static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> > +					      struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	u32 reg;
> > +
> > +	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> > +	pr_err("enhanced strobe: %d\n", ios->enhanced_strobe);  
> 
> Left-over debug error?

Yep.

> 
> > +	if (ios->enhanced_strobe)
> > +		reg |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> > +	else
> > +		reg &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> > +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);  
> 
> You might want to add blank lines around the if ... else ... block for
> readability.

True.

 -Aapo

