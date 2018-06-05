Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeFEOLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:11:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55067 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbeFEOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:11:21 -0400
Date: Tue, 5 Jun 2018 16:11:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: davem@davemloft.net, hayeswang@realtek.com, hkallweit1@gmail.com,
        romieu@fr.zoreil.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ryankao <ryankao@realtek.com>
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
Message-ID: <20180605141114.GC14873@lunn.ch>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605045812.17977-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:58:12PM +0800, Kai-Heng Feng wrote:
> This patch reinstate ALDPS and ASPM support on r8169.
> 
> On some Intel platforms, ASPM support on r8169 is the key factor to let
> Package C-State achieve PC8. Without ASPM support, the deepest Package
> C-State can hit is PC3. PC8 can save additional ~3W in comparison with
> PC3.
> 
> This patch is from Realtek.
> 
> Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
> Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request settings")
> 
> Cc: Ryankao <ryankao@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 190 +++++++++++++++++++++------
>  1 file changed, 151 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 75dfac0248f4..a28ef20be221 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -319,6 +319,8 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
>  
>  MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
>  
> +static int enable_aspm = 1;
> +static int enable_aldps = 1;
>  static int use_dac = -1;
>  static struct {
>  	u32 msg_enable;
> @@ -817,6 +819,10 @@ struct rtl8169_private {
>  
>  MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
>  MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
> +module_param(enable_aspm, int, 0);
> +MODULE_PARM_DESC(enable_aspm, "Enable ASPM");
> +module_param(enable_aldps, int, 0);
> +MODULE_PARM_DESC(enable_aldps, "Enable ALDPS");

Hi Kai

No module parameter please. Just turn it on by default. Assuming
testing shows works.

	Andrew
