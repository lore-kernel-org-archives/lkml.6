Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE0C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13B020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13B020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeGYLyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:54:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7857 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbeGYLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:54:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5854340000>; Wed, 25 Jul 2018 03:43:00 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Jul 2018 03:43:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Jul 2018 03:43:09 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 25 Jul
 2018 10:43:06 +0000
Date:   Wed, 25 Jul 2018 13:43:00 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mmc: tegra: Perform pad calibration after voltage
 switch
Message-ID: <20180725134300.7e537ceb@dhcp-10-21-25-168>
In-Reply-To: <b44d6ae5-7965-16db-7ad3-39ff682755ca@kapsi.fi>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
        <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
        <1532442865-6391-8-git-send-email-avienamo@nvidia.com>
        <b44d6ae5-7965-16db-7ad3-39ff682755ca@kapsi.fi>
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

On Wed, 25 Jul 2018 10:25:16 +0300
Mikko Perttunen <cyndis@kapsi.fi> wrote:

> On 24.07.2018 17:34, Aapo Vienamo wrote:
> > Run the automatic pad calibration after voltage switching if
> > tegra_host->pad_calib_required is set.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >   drivers/mmc/host/sdhci-tegra.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 78781bd..529aa4e7 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -537,6 +537,8 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
> >   						   struct mmc_ios *ios)
> >   {
> >   	struct sdhci_host *host = mmc_priv(mmc);
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> >   	int ret = 0;
> >   
> >   	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> > @@ -551,6 +553,9 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
> >   		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> >   	}
> >   
> > +	if (tegra_host->pad_calib_required)
> > +		tegra_sdhci_pad_autocalib(host);  
> 
> What if the autocalibration fails? Should we return an error?

I would assume that aborting the signal voltage switch due to a
calibration timeout would not be necessary as the TRM specifies drive
strength values which are to be programmed in case a timeout occurs.

However, I don't know what are the exact implications of running the bus
with the timeout values instead of the calibrated ones. The TRM does not
comment on that. I guess tuning would fail and catch the error that way
in case the timeout default values aren't sufficient.

 -Aapo

> > +
> >   	return ret;
> >   }
> >   
> >   

