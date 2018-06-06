Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="dhUziRun"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC98E6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeFFGMJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:12:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55570 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbeFFGMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:12:06 -0400
X-Google-Smtp-Source: ADUXVKIOiRYT/q33mBiJXRPEVdElLlLVdNuPMQaxYkr/07UcTungpDbF1A9ykuSrXC9YwVb+iWw/IQ==
Date: Wed, 6 Jun 2018 08:12:02 +0200
From: Simon Horman <simon.horman@netronome.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net,
        hayeswang@realtek.com, romieu@fr.zoreil.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryankao <ryankao@realtek.com>
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
Message-ID: <20180606061201.eaz6l4e7cmcshji7@netronome.com>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <dfd3a9b4-3f89-9849-8d71-6fc49374b1df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd3a9b4-3f89-9849-8d71-6fc49374b1df@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:13:08PM +0200, Heiner Kallweit wrote:
> On 05.06.2018 06:58, Kai-Heng Feng wrote:
> > This patch reinstate ALDPS and ASPM support on r8169.
> > 
> > On some Intel platforms, ASPM support on r8169 is the key factor to let
> > Package C-State achieve PC8. Without ASPM support, the deepest Package
> > C-State can hit is PC3. PC8 can save additional ~3W in comparison with
> > PC3.
> > 
> > This patch is from Realtek.
> > 
> > Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
> > Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request settings")
> > 
> > Cc: Ryankao <ryankao@realtek.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/net/ethernet/realtek/r8169.c | 190 +++++++++++++++++++++------
> >  1 file changed, 151 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> > index 75dfac0248f4..a28ef20be221 100644
> > --- a/drivers/net/ethernet/realtek/r8169.c
> > +++ b/drivers/net/ethernet/realtek/r8169.c
> > @@ -319,6 +319,8 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
> >  
> >  MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
> >  
> > +static int enable_aspm = 1;
> > +static int enable_aldps = 1;
> >  static int use_dac = -1;
> >  static struct {
> >  	u32 msg_enable;
> > @@ -817,6 +819,10 @@ struct rtl8169_private {
> >  
> >  MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
> >  MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
> > +module_param(enable_aspm, int, 0);
> > +MODULE_PARM_DESC(enable_aspm, "Enable ASPM");
> > +module_param(enable_aldps, int, 0);
> > +MODULE_PARM_DESC(enable_aldps, "Enable ALDPS");
> >  module_param(use_dac, int, 0);
> >  MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
> >  module_param_named(debug, debug.msg_enable, int, 0);

I'm a little surprised to see new module parameters being added.
