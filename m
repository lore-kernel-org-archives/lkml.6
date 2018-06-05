Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeFEGeb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:34:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37399 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFEGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:34:29 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w556YAO9001522, This message is accepted by code: ctloc85258
From: Ryankao <ryankao@realtek.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>,
        "jrg.otte@gmail.com" <jrg.otte@gmail.com>
CC: David Miller <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Hau <hau@realtek.com>
Subject: RE: [PATCH] r8169: Reinstate ALDPS and ASPM support
Thread-Topic: [PATCH] r8169: Reinstate ALDPS and ASPM support
Thread-Index: AQHT/InWFifzVc+SdEewNm2H+vWVQ6RQlX+AgACdlbA=
Date: Tue, 5 Jun 2018 06:34:09 +0000
Message-ID: <B01FA80E1422A647BEB597328C544223D30B8F90@RTITMBSV05.realtek.com.tw>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com>
In-Reply-To: <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.178.220]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w556YbVZ017134

Add realtek folk Hau

-----Original Message-----
From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com] 
Sent: Tuesday, June 05, 2018 1:02 PM
To: jrg.otte@gmail.com
Cc: David Miller <davem@davemloft.net>; Hayes Wang <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com; Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support

Hi Jörg Otte,

Can you give this patch a try?

Since you are the only one that reported ALDPS/ASPM regression,

And I think this patch should solve the issue you had [1].

Hopefully we don't need to go down the rabbit hole of blacklist/whitelist...

Kai-Heng

[1] https://lkml.org/lkml/2013/1/5/36

> On Jun 5, 2018, at 12:58 PM, Kai-Heng Feng 
> <kai.heng.feng@canonical.com>
> wrote:
>
> This patch reinstate ALDPS and ASPM support on r8169.
>
> On some Intel platforms, ASPM support on r8169 is the key factor to 
> let Package C-State achieve PC8. Without ASPM support, the deepest 
> Package C-State can hit is PC3. PC8 can save additional ~3W in 
> comparison with PC3.
>
> This patch is from Realtek.
>
> Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
> Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request
> settings")
>
> Cc: Ryankao <ryankao@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 190 
> +++++++++++++++++++++------
>  1 file changed, 151 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169.c
> b/drivers/net/ethernet/realtek/r8169.c
> index 75dfac0248f4..a28ef20be221 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -319,6 +319,8 @@ static const struct pci_device_id 
> rtl8169_pci_tbl[] = {
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
>  MODULE_AUTHOR("Realtek and the Linux r8169 crew 
> <netdev@vger.kernel.org>");  MODULE_DESCRIPTION("RealTek RTL-8169 
> Gigabit Ethernet driver");
> +module_param(enable_aspm, int, 0);
> +MODULE_PARM_DESC(enable_aspm, "Enable ASPM"); 
> +module_param(enable_aldps, int, 0); MODULE_PARM_DESC(enable_aldps, 
> +"Enable ALDPS");
>  module_param(use_dac, int, 0);
>  MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI 
> slot.");  module_param_named(debug, debug.msg_enable, int, 0); @@ 
> -1567,25 +1573,6 @@ static void rtl_link_chg_patch(struct 
> rtl8169_private *tp)
>  	}
>  }
>
> -static void rtl8169_check_link_status(struct net_device *dev,
> -				      struct rtl8169_private *tp)
> -{
> -	struct device *d = tp_to_dev(tp);
> -
> -	if (tp->link_ok(tp)) {
> -		rtl_link_chg_patch(tp);
> -		/* This is to cancel a scheduled suspend if there's one. */
> -		pm_request_resume(d);
> -		netif_carrier_on(dev);
> -		if (net_ratelimit())
> -			netif_info(tp, ifup, dev, "link up\n");
> -	} else {
> -		netif_carrier_off(dev);
> -		netif_info(tp, ifdown, dev, "link down\n");
> -		pm_runtime_idle(d);
> -	}
> -}
> -
>  #define WAKE_ANY (WAKE_PHY | WAKE_MAGIC | WAKE_UCAST | WAKE_BCAST | 
> WAKE_MCAST)
>
>  static u32 __rtl8169_get_wol(struct rtl8169_private *tp) @@ -3520,6 
> +3507,15 @@ static void rtl8168e_1_hw_phy_config(struct 
> rtl8169_private *tp)
>  	rtl_writephy(tp, 0x0d, 0x4007);
>  	rtl_writephy(tp, 0x0e, 0x0000);
>  	rtl_writephy(tp, 0x0d, 0x0000);
> +
> +	/* Check ALDPS bit, disable it if enabled */
> +	rtl_writephy(tp, 0x1f, 0x0000);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x15, 0x1000, 0x0000);
> +	else if (rtl_readphy(tp, 0x15) & 0x1000)
> +		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1000);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl_rar_exgmac_set(struct rtl8169_private *tp, u8 *addr) 
> @@ -3627,6 +3623,15 @@ static void rtl8168e_2_hw_phy_config(struct 
> rtl8169_private *tp)
>
>  	/* Broken BIOS workaround: feed GigaMAC registers with MAC address. */
>  	rtl_rar_exgmac_set(tp, tp->dev->dev_addr);
> +
> +	/* Check ALDPS bit, disable it if enabled */
> +	rtl_writephy(tp, 0x1f, 0x0000);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x15, 0x1000, 0x0000);
> +	else if (rtl_readphy(tp, 0x15) & 0x1000)
> +		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1000);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl8168f_hw_phy_config(struct rtl8169_private *tp) @@ 
> -3649,6 +3654,15 @@ static void rtl8168f_hw_phy_config(struct 
> rtl8169_private *tp)
>  	rtl_writephy(tp, 0x05, 0x8b86);
>  	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
>  	rtl_writephy(tp, 0x1f, 0x0000);
> +
> +	/* Check ALDPS bit, disable it if enabled */
> +	rtl_writephy(tp, 0x1f, 0x0000);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x15, 0x1000, 0x0000);
> +	else if (rtl_readphy(tp, 0x15) & 0x1000)
> +		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1000);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl8168f_1_hw_phy_config(struct rtl8169_private *tp) @@ 
> -3865,7 +3879,9 @@ static void rtl8168g_1_hw_phy_config(struct 
> rtl8169_private *tp)
>
>  	/* Check ALDPS bit, disable it if enabled */
>  	rtl_writephy(tp, 0x1f, 0x0a43);
> -	if (rtl_readphy(tp, 0x10) & 0x0004)
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x10, 0x0004, 0x0000);
> +	else if (rtl_readphy(tp, 0x10) & 0x0004)
>  		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
>
>  	rtl_writephy(tp, 0x1f, 0x0000);
> @@ -3874,6 +3890,14 @@ static void rtl8168g_1_hw_phy_config(struct 
> rtl8169_private *tp)  static void rtl8168g_2_hw_phy_config(struct 
> rtl8169_private *tp)  {
>  	rtl_apply_firmware(tp);
> +
> +	rtl_writephy(tp, 0x1f, 0x0a43);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x10, 0x0004, 0x0000);
> +	else if (rtl_readphy(tp, 0x10) & 0x0004)
> +		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl8168h_1_hw_phy_config(struct rtl8169_private *tp) @@ 
> -3980,7 +4004,9 @@ static void rtl8168h_1_hw_phy_config(struct 
> rtl8169_private *tp)
>
>  	/* Check ALDPS bit, disable it if enabled */
>  	rtl_writephy(tp, 0x1f, 0x0a43);
> -	if (rtl_readphy(tp, 0x10) & 0x0004)
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x10, 0x0004, 0x0000);
> +	else if (rtl_readphy(tp, 0x10) & 0x0004)
>  		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
>
>  	rtl_writephy(tp, 0x1f, 0x0000);
> @@ -4053,7 +4079,9 @@ static void rtl8168h_2_hw_phy_config(struct 
> rtl8169_private *tp)
>
>  	/* Check ALDPS bit, disable it if enabled */
>  	rtl_writephy(tp, 0x1f, 0x0a43);
> -	if (rtl_readphy(tp, 0x10) & 0x0004)
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x10, 0x0004, 0x0000);
> +	else if (rtl_readphy(tp, 0x10) & 0x0004)
>  		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
>
>  	rtl_writephy(tp, 0x1f, 0x0000);
> @@ -4095,7 +4123,9 @@ static void rtl8168ep_1_hw_phy_config(struct 
> rtl8169_private *tp)
>
>  	/* Check ALDPS bit, disable it if enabled */
>  	rtl_writephy(tp, 0x1f, 0x0a43);
> -	if (rtl_readphy(tp, 0x10) & 0x0004)
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x10, 0x0004, 0x0000);
> +	else if (rtl_readphy(tp, 0x10) & 0x0004)
>  		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
>
>  	rtl_writephy(tp, 0x1f, 0x0000);
> @@ -4186,7 +4216,9 @@ static void rtl8168ep_2_hw_phy_config(struct 
> rtl8169_private *tp)
>
>  	/* Check ALDPS bit, disable it if enabled */
>  	rtl_writephy(tp, 0x1f, 0x0a43);
> -	if (rtl_readphy(tp, 0x10) & 0x0004)
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x10, 0x0004, 0x0000);
> +	else if (rtl_readphy(tp, 0x10) & 0x0004)
>  		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
>
>  	rtl_writephy(tp, 0x1f, 0x0000);
> @@ -4233,6 +4265,15 @@ static void rtl8105e_hw_phy_config(struct 
> rtl8169_private *tp)
>  	rtl_apply_firmware(tp);
>
>  	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
> +
> +	/* Check ALDPS bit, disable it if enabled */
> +	rtl_writephy(tp, 0x1f, 0x0000);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x18, 0x1000, 0x0000);
> +	else if (rtl_readphy(tp, 0x18) & 0x1000)
> +		rtl_w0w1_phy(tp, 0x18, 0x0000, 0x1000);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl8402_hw_phy_config(struct rtl8169_private *tp) @@ 
> -4250,6 +4291,15 @@ static void rtl8402_hw_phy_config(struct 
> rtl8169_private *tp)
>  	rtl_writephy(tp, 0x10, 0x401f);
>  	rtl_writephy(tp, 0x19, 0x7030);
>  	rtl_writephy(tp, 0x1f, 0x0000);
> +
> +	/* Check ALDPS bit, disable it if enabled */
> +	rtl_writephy(tp, 0x1f, 0x0000);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x18, 0x1000, 0x0000);
> +	else if (rtl_readphy(tp, 0x18) & 0x1000)
> +		rtl_w0w1_phy(tp, 0x18, 0x0000, 0x1000);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl8106e_hw_phy_config(struct rtl8169_private *tp) @@ 
> -4272,6 +4322,15 @@ static void rtl8106e_hw_phy_config(struct 
> rtl8169_private *tp)
>  	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
>
>  	rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
> +
> +	/* Check ALDPS bit, disable it if enabled */
> +	rtl_writephy(tp, 0x1f, 0x0000);
> +	if (enable_aldps)
> +		rtl_w0w1_phy(tp, 0x18, 0x1000, 0x0000);
> +	else if (rtl_readphy(tp, 0x18) & 0x1000)
> +		rtl_w0w1_phy(tp, 0x18, 0x0000, 0x1000);
> +
> +	rtl_writephy(tp, 0x1f, 0x0000);
>  }
>
>  static void rtl_hw_phy_config(struct net_device *dev) @@ -5290,6 
> +5349,18 @@ static void rtl_pcie_state_l2l3_enable(struct 
> rtl8169_private *tp, bool enable)
>  	RTL_W8(tp, Config3, data);
>  }
>
> +static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private *tp,
> +					       bool enable)
> +{
> +	if (enable) {
> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
> +	} else {
> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	}
> +}
> +
>  static void rtl_hw_start_8168bb(struct rtl8169_private *tp)  {
>  	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en); @@ -5646,9 
> +5717,10 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private 
> *tp)
>  	rtl_hw_start_8168g(tp);
>
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
> +	if (enable_aspm)
> +		rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>
>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp) @@ 
> -5681,9 +5753,10 @@ static void rtl_hw_start_8411_2(struct 
> rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
> +	if (enable_aspm)
> +		rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>
>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp) @@ 
> -5700,8 +5773,7 @@ static void rtl_hw_start_8168h_1(struct 
> rtl8169_private *tp)
>  	};
>
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
>
>  	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO); @@ 
> -5780,6 +5852,9 @@ static void rtl_hw_start_8168h_1(struct 
> rtl8169_private *tp)
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +
> +	if (enable_aspm)
> +		rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>
>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp) @@ 
> -5831,11 +5906,13 @@ static void rtl_hw_start_8168ep_1(struct 
> rtl8169_private *tp)
>  	};
>
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
>
>  	rtl_hw_start_8168ep(tp);
> +
> +	if (enable_aspm)
> +		rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>
>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp) @@ 
> -5847,14 +5924,16 @@ static void rtl_hw_start_8168ep_2(struct 
> rtl8169_private *tp)
>  	};
>
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
>
>  	rtl_hw_start_8168ep(tp);
>
>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>  	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
> +
> +	if (enable_aspm)
> +		rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>
>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp) @@ 
> -5868,8 +5947,7 @@ static void rtl_hw_start_8168ep_3(struct 
> rtl8169_private *tp)
>  	};
>
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
>
>  	rtl_hw_start_8168ep(tp);
> @@ -5889,6 +5967,9 @@ static void rtl_hw_start_8168ep_3(struct 
> rtl8169_private *tp)
>  	data = r8168_mac_ocp_read(tp, 0xe860);
>  	data |= 0x0080;
>  	r8168_mac_ocp_write(tp, 0xe860, data);
> +
> +	if (enable_aspm)
> +		rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>
>  static void rtl_hw_start_8168(struct rtl8169_private *tp) @@ -6364,7 
> +6445,7 @@ static void rtl8169_tx_clear(struct rtl8169_private
> *tp)
>  	tp->cur_tx = tp->dirty_tx = 0;
>  }
>
> -static void rtl_reset_work(struct rtl8169_private *tp)
> +static void _rtl_reset_work(struct rtl8169_private *tp)
>  {
>  	struct net_device *dev = tp->dev;
>  	int i;
> @@ -6384,6 +6465,33 @@ static void rtl_reset_work(struct 
> rtl8169_private
> *tp)
>  	napi_enable(&tp->napi);
>  	rtl_hw_start(tp);
>  	netif_wake_queue(dev);
> +}
> +
> +static void rtl8169_check_link_status(struct net_device *dev,
> +				      struct rtl8169_private *tp) {
> +	struct device *d = tp_to_dev(tp);
> +
> +	if (tp->link_ok(tp)) {
> +		rtl_link_chg_patch(tp);
> +		/* This is to cancel a scheduled suspend if there's one. */
> +		if (pm_request_resume(d))
> +			_rtl_reset_work(tp);
> +		netif_carrier_on(dev);
> +		if (net_ratelimit())
> +			netif_info(tp, ifup, dev, "link up\n");
> +	} else {
> +		netif_carrier_off(dev);
> +		netif_info(tp, ifdown, dev, "link down\n");
> +		pm_runtime_idle(d);
> +	}
> +}
> +
> +static void rtl_reset_work(struct rtl8169_private *tp) {
> +	struct net_device *dev = tp->dev;
> +
> +	_rtl_reset_work(tp);
>  	rtl8169_check_link_status(dev, tp);
>  }
>
> @@ -7649,8 +7757,12 @@ static int rtl_init_one(struct pci_dev *pdev, 
> const struct pci_device_id *ent)
>
>  	/* disable ASPM completely as that cause random device stop working
>  	 * problems as well as full system hangs for some PCIe devices users */
> -	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
> -				     PCIE_LINK_STATE_CLKPM);
> +	if (!enable_aspm) {
> +		pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
> +					     PCIE_LINK_STATE_L1 |
> +					     PCIE_LINK_STATE_CLKPM);
> +		netif_info(tp, probe, dev, "ASPM disabled\n");
> +	}
>
>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>  	rc = pcim_enable_device(pdev);
> --
> 2.17.0

------Please consider the environment before printing this e-mail.
