Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48E62086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48E62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH1Tdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:33:52 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4206 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Tdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:33:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b856d280000>; Tue, 28 Aug 2018 08:41:28 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Aug 2018 08:41:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Aug 2018 08:41:38 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 28 Aug
 2018 15:41:35 +0000
Date:   Tue, 28 Aug 2018 18:41:29 +0300
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
Subject: Re: [PATCH v2 25/40] mmc: sdhci: Add a quirk to disable card clock
 during tuning
Message-ID: <20180828184129.525439ba@dhcp-10-21-25-168>
In-Reply-To: <b0b761ac-00fb-5a79-7a38-89b08c620c02@intel.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
        <1533924522-1037-26-git-send-email-avienamo@nvidia.com>
        <b0b761ac-00fb-5a79-7a38-89b08c620c02@intel.com>
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

On Mon, 27 Aug 2018 14:25:44 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 10/08/18 21:08, Aapo Vienamo wrote:
> > Add a quirk to disable card clock when the tuning command is sent.
> > 
> > This has to be done to prevent the SDHCI controller from hanging on
> > Tegra210. Without the quirk enabled there appears to be around 10%
> > chance that the tuning sequence will fail and time out due to the
> > controller locking up.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 15 +++++++++++++++
> >  drivers/mmc/host/sdhci.h |  2 ++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 04dc443..166b16f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2175,6 +2175,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> >  	struct mmc_request mrq = {};
> >  	unsigned long flags;
> >  	u32 b = host->sdma_boundary;
> > +	u16 clk;
> >  
> >  	spin_lock_irqsave(&host->lock, flags);
> >  
> > @@ -2183,6 +2184,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> >  	cmd.mrq = &mrq;
> >  
> >  	mrq.cmd = &cmd;
> > +
> > +	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
> > +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +		clk &= ~SDHCI_CLOCK_CARD_EN;
> > +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);  
> 
> Rather than using a quirk, could you use the sdhci I/O accessors to disable
> the clock before the tuning comment is written, udelay(1), and then enable
> it again?

This was the way it was implemented in the downstream kernel. However,
doing it in the IO accessor when a tuning command is sent seems to work
too.

 -Aapo
