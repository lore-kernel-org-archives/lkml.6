Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B7C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11DC21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11DC21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeHIOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:54:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19300 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:54:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c33a40001>; Thu, 09 Aug 2018 05:29:24 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 05:29:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 09 Aug 2018 05:29:21 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 12:29:24 +0000
Date:   Thu, 9 Aug 2018 15:29:18 +0300
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
Subject: Re: [PATCH 4/8] mmc: tegra: Implement HS400 delay line calibration
Message-ID: <20180809152918.4a3e7060@dhcp-10-21-25-168>
In-Reply-To: <20180809114805.GM21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
        <20180809114805.GM21639@ulmo>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2018 13:48:05 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 05:00:00PM +0300, Aapo Vienamo wrote:
> > Implement HS400 specific delay line calibration procedure.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)  
> 
> Should this be before the previous patch in order to make sure the
> calibration is performed as soon as the feature is available. This is
> counting beans I guess, but it is technically possible for someone to
> get everything up to patch 3/8 and then get the corresponding changes
> in the DTS files to enable the mode and then have HS400 enabled without
> this calibration.

True.

> 
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index d81143b..d0b68b7 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -56,6 +56,12 @@
> >  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
> >  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
> >  
> > +#define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
> > +#define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
> > +
> > +#define SDHCI_TEGRA_VENDOR_DLLCAL_STA			0x1bc
> > +#define SDHCI_TEGRA_DLLCAL_STA_ACTIVE			BIT(31)
> > +
> >  #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
> >  #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> >  
> > @@ -584,6 +590,24 @@ static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
> >  	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> >  }
> >  
> > +static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
> > +{
> > +	u32 reg;
> > +	int err;
> > +
> > +	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
> > +	reg |= SDHCI_TEGRA_DLLCAL_CALIBRATE;
> > +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);  
> 
> Is this self-clearing? Or do we need to clear it manually in order for
> a subsequent calibration procedure to succeed?

Yes, the TRM states that this bit should not be cleared by software.

 -Aapo

