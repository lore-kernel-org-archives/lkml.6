Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030366AbeBNNko (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:40:44 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55447 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030208AbeBNNkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:40:42 -0500
Date: Wed, 14 Feb 2018 14:40:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chunhao Lin <hau@realtek.com>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH net-next] r8169: add module param for control of
 ASPM disable.
Message-ID: <20180214134040.GB22014@lunn.ch>
References: <1518598965-3593-1-git-send-email-hau@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518598965-3593-1-git-send-email-hau@realtek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:02:45PM +0800, Chunhao Lin wrote:
> The patch is from Todd Broch <tbroch@chromium.org>.
> 	ASPM has been disabled in this driver by default as its been
> 	implicated in stability issues on at least one platform.  This CL adds
> 	a module parameter to allow control of ASPM disable.  The default
> 	value is to enable ASPM again as its provides signficant (200mW) power
> 	savings on the platform I tested.
> 
> I make some modification that let this patch only for RTL8168G and later.
> 
> Signed-off-by: Chunhao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 73 ++++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 0bf7d17..87d3136 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -346,6 +346,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
>  MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
>  
>  static int rx_buf_sz = 16383;
> +static int aspm_disable = 0;
>  static int use_dac = -1;
>  static struct {
>  	u32 msg_enable;
> @@ -867,6 +868,8 @@ struct rtl8169_private {
>  
>  MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
>  MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
> +module_param(aspm_disable, int, 0444);
> +MODULE_PARM_DESC(aspm_disable, "Disable ASPM completely.");

Hi Chunhao

linux/drivers$ grep -ir aspm * | grep MODULE_
gpu/drm/amd/amdgpu/amdgpu_drv.c:MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
gpu/drm/radeon/radeon_drv.c:MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
infiniband/hw/hfi1/pcie.c:MODULE_PARM_DESC(aspm, "PCIe ASPM: 0: disable, 1: enable, 2: dynamic");
net/wireless/realtek/rtlwifi/rtl8192ee/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8188ee/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8821ae/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8192se/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8192ce/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8723be/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8192de/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
net/wireless/realtek/rtlwifi/rtl8723ae/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
staging/rts5208/rtsx.c:MODULE_PARM_DESC(aspm_l0s_l1_en, "enable device aspm");
staging/rtlwifi/rtl8822be/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");

This patch seems to have the exact opposite of everybody else already
does.

Maybe you can follow the AMD example, and default to -1, since you are
proposing to mostly have it enabled, but disabled in one case?

	  Andrew
