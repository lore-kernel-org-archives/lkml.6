Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354642087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354642087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeGMNK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:10:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14983 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbeGMNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:10:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b48a1510000>; Fri, 13 Jul 2018 05:55:46 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 13 Jul 2018 05:55:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 13 Jul 2018 05:55:52 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 12:55:47 +0000
Date:   Fri, 13 Jul 2018 15:55:41 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: REGRESSION: [PATCH] mmc: tegra: Use
 sdhci_pltfm_clk_get_max_clock
Message-ID: <20180713155541.286425e9@dhcp-10-21-25-168>
In-Reply-To: <1531446183.5479.14.camel@toradex.com>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
        <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
        <1531446183.5479.14.camel@toradex.com>
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

On Fri, 13 Jul 2018 01:43:05 +0000
Marcel Ziswiler <marcel.ziswiler@toradex.com> wrote:

> On Mon, 2018-07-02 at 15:16 +0200, Ulf Hansson wrote:
> > On 4 June 2018 at 17:35, Aapo Vienamo <avienamo@nvidia.com> wrote:  
> > > The sdhci get_max_clock callback is set to
> > > sdhci_pltfm_clk_get_max_clock
> > > and tegra_sdhci_get_max_clock is removed. It appears that the
> > > shdci-tegra specific callback was originally introduced due to the
> > > requirement that the host clock has to be twice the bus clock on
> > > DDR50
> > > mode. As far as I can tell the only effect the removal has on DDR50
> > > mode
> > > is in cases where the parent clock is unable to supply the
> > > requested
> > > clock rate, causing the DDR50 mode to run at a lower frequency.
> > > Currently the DDR50 mode isn't enabled on any of the SoCs and would
> > > also
> > > require configuring the SDHCI clock divider register to function
> > > properly.
> > > 
> > > The problem with tegra_sdhci_get_max_clock is that it divides the
> > > clock
> > > rate by two and thus artificially limits the maximum frequency of
> > > faster
> > > signaling modes which don't have the host-bus frequency ratio
> > > requirement
> > > of DDR50 such as SDR104 and HS200. Furthermore, the call to
> > > clk_round_rate() may return an error which isn't handled by
> > > tegra_sdhci_get_max_clock.
> > > 
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>  
> > 
> > Thanks, applied for next!
> > 
> > Kind regards
> > Uffe
> >   
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
> > >  1 file changed, 2 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c
> > > b/drivers/mmc/host/sdhci-tegra.c
> > > index 970d38f6..c8745b5 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -234,17 +234,6 @@ static void
> > > tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
> > >         sdhci_set_uhs_signaling(host, timing);
> > >  }
> > > 
> > > -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host
> > > *host)
> > > -{
> > > -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > -
> > > -       /*
> > > -        * DDR modes require the host to run at double the card
> > > frequency, so
> > > -        * the maximum rate we can support is half of the module
> > > input clock.
> > > -        */
> > > -       return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
> > > -}
> > > -
> > >  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned
> > > int tap)
> > >  {
> > >         u32 reg;
> > > @@ -309,7 +298,7 @@ static const struct sdhci_ops tegra_sdhci_ops =
> > > {
> > >         .platform_execute_tuning = tegra_sdhci_execute_tuning,
> > >         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> > >         .voltage_switch = tegra_sdhci_voltage_switch,
> > > -       .get_max_clock = tegra_sdhci_get_max_clock,
> > > +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > >  };
> > > 
> > >  static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> > > @@ -357,7 +346,7 @@ static const struct sdhci_ops
> > > tegra114_sdhci_ops = {
> > >         .platform_execute_tuning = tegra_sdhci_execute_tuning,
> > >         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> > >         .voltage_switch = tegra_sdhci_voltage_switch,
> > > -       .get_max_clock = tegra_sdhci_get_max_clock,
> > > +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > >  };
> > > 
> > >  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> > > --
> > > 2.7.4  
> 
> Hm, for us this definitely breaks stuff. While using Stefan's patch set
> [1] we may not only run eMMC at DDR52 even SD cards run stable at
> SDR104. With this patch however the clock gets crippled to 45.33 resp.
> 48 MHz always. This is observed both on Apalis/Colibri T30 as well as
> Apalis TK1.
> 
> Current next-20180712 just with Stefan's 3 patches:
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc1/ios 
> clock:          48000000 Hz
> actual clock:   45333333 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk1
> 
> /dev/mmcblk1:
>  Timing buffered disk reads: 218 MB in  3.03 seconds =  71.95 MB/sec
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc2/ios 
> clock:          48000000 Hz
> actual clock:   48000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk2
> 
> /dev/mmcblk2:
>  Timing buffered disk reads:  66 MB in  3.06 seconds =  21.60 MB/sec
> 
> And with this patch reverted it works as expected again:
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc1/ios 
> clock:          52000000 Hz
> actual clock:   51000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk1
> 
> /dev/mmcblk1:
>  Timing buffered disk reads: 240 MB in  3.02 seconds =  79.50 MB/sec
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc2/ios 
> clock:          204000000 Hz
> actual clock:   204000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk2
> 
> /dev/mmcblk2:
>  Timing buffered disk reads: 258 MB in  3.01 seconds =  85.58 MB/sec
> 
> [1] https://lore.kernel.org/lkml/20180712073904.4705-1-stefan@agner.ch

This happens because sdhci_pltfm_clk_get_max_clock() does not actually
return the maximum clock rate but the current one, leading to smaller
clock rates on some platforms. I'll send a patch that fixes this for
sdhci-tegra. Although this raises the question whether the current
behaviour of sdhci_pltfm_clk_get_max_clock() is desirable or not.

 -Aapo
