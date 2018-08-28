Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91491C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ADA20833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ADA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeH1SiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:38:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1370 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeH1SiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:38:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b85601e0000>; Tue, 28 Aug 2018 07:45:50 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Aug 2018 07:46:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Aug 2018 07:46:00 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 28 Aug
 2018 14:45:57 +0000
Date:   Tue, 28 Aug 2018 17:45:51 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 11/40] mmc: sdhci: Add a quirk to skip clearing the
 transfer mode register on tuning
Message-ID: <20180828174551.12f1d9bf@dhcp-10-21-25-168>
In-Reply-To: <d603be8f-986a-80e1-d98a-daea9c9684aa@intel.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
        <1533924522-1037-12-git-send-email-avienamo@nvidia.com>
        <d603be8f-986a-80e1-d98a-daea9c9684aa@intel.com>
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

On Mon, 27 Aug 2018 14:01:52 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 10/08/18 21:08, Aapo Vienamo wrote:
> > Add SDHCI_QUIRK2_TUNE_SKIP_XFERRMODE_REG_PROG to skip programming the
> > SDHCI_TRANSFER_MODE in sdhci_set_transfer_mode() if tuning command is
> > being sent.
> > 
> > On Tegra210 and Tegra186 the tuning sequence hangs if the SDHCI
> > transfer mode register is touched.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 6 ++++++
> >  drivers/mmc/host/sdhci.h | 2 ++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index a7b5602..04dc443 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1028,6 +1028,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
> >  
> >  	if (data == NULL) {
> >  		if (host->quirks2 &
> > +			SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG &&
> > +				(cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> > +				 cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)) {
> > +			return;
> > +		}  
> 
> Rather than introduce a quirk, can't we just dodge the unnecessary write e.g.
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b3fbd9bd5c5..68af6a67e397 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1033,10 +1033,19 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
>  				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
> -		/* clear Auto CMD settings for no data CMDs */
> +			u16 orig;
> +
> +			/* clear Auto CMD settings for no data CMDs */
>  			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> -			sdhci_writew(host, mode & ~(SDHCI_TRNS_AUTO_CMD12 |
> -				SDHCI_TRNS_AUTO_CMD23), SDHCI_TRANSFER_MODE);
> +			orig = mode;
> +			mode &= ~(SDHCI_TRNS_AUTO_CMD12 | SDHCI_TRNS_AUTO_CMD23);
> +			/*
> +			 * Do not write transfer mode unnecessarily because it
> +			 * can upset some host controllers (e.g. sdhci-tregra)
> +			 * during tuning.
> +			 */
> +			if (mode != orig)
> +				sdhci_writew(host, new_mode, SDHCI_TRANSFER_MODE);
>  		}
>  		return;
>  	}
> 
> 
> Alternatively 
> 
> > +		if (host->quirks2 &
> >  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> >  			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> >  		} else {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 23966f8..0a99008 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -450,6 +450,8 @@ struct sdhci_host {
> >   * obtainable timeout.
> >   */
> >  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
> > +/* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
> > +#define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
> >  
> >  	int irq;		/* Device IRQ */
> >  	void __iomem *ioaddr;	/* Mapped address */
> >   
> 

Looks like writes to the transfer mode register are deferred until the
command register is written by tegra_sdhci_writew(). This code was
introduced due to a quirk in Tegra114/124. The Tegra114 ops struct was
probably just copied over when support for Tegra210 was added, so we
end up with this code also getting run on Tegra210.

The issue with tegra_sdhci_writew() is that it breaks successive
read-modify-write operations. The value written to the transfer mode
register isn't returned on read until the command register is also
touched. Removing the write_w accessor from tegra210_sdhci_ops seems to
make the issue originally addressed by this patch to go away.

 -Aapo
