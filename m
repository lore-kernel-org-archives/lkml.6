Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeB1QtE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:49:04 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41628 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeB1QtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:49:01 -0500
X-Google-Smtp-Source: AG47ELuZWIxHTwzA0NfD+HOeYxNmdeXpIidDZ3a5INjDrTxb5HbbcQvXEqihZoD9CpDcz888hITeaiUtlqji4XeLUNg=
MIME-Version: 1.0
In-Reply-To: <20180228052006.12074-1-bpoirier@suse.com>
References: <20180228052006.12074-1-bpoirier@suse.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 28 Feb 2018 08:48:59 -0800
Message-ID: <CAKgT0Uc_Dur56FxJfqoh90E=pUYtiKJr20f3fado-GdL8yUi5w@mail.gmail.com>
Subject: Re: [PATCH] e1000e: Fix link status in case of error.
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 9:20 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> Before commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up"), errors which happen after "get_link_status = false" in the copper
> check_for_link callbacks would be ignored and the link considered up. After
> that commit, any error implies that the link is down. Since all
> combinations of link up/down and error/no error are possible, do the same
> thing as e1000e_phy_has_link_generic() and return the link status in a
> separate variable.
>
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

This seems more like a refactor than a fix. There are valid cases
where errors can be ignored after we set the link to up. For example
if we cannot negotiate flow control we may not care as long as the
link is established. In such a case we may see errors establishing
flow control and they should be ignored.

If there are cases where we are setting the link as up to early we
should address that instead of changing all the functions to make them
look like other ones.

> ---
>  drivers/net/ethernet/intel/e1000e/82571.c   |  6 ++++--
>  drivers/net/ethernet/intel/e1000e/ethtool.c |  5 +++--
>  drivers/net/ethernet/intel/e1000e/hw.h      |  2 +-
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 19 +++++++++++--------
>  drivers/net/ethernet/intel/e1000e/mac.c     | 26 +++++++++++++++-----------
>  drivers/net/ethernet/intel/e1000e/mac.h     |  6 +++---
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 11 +++--------
>  7 files changed, 40 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/82571.c b/drivers/net/ethernet/intel/e1000e/82571.c
> index 6b03c8553e59..980ed89e61ea 100644
> --- a/drivers/net/ethernet/intel/e1000e/82571.c
> +++ b/drivers/net/ethernet/intel/e1000e/82571.c
> @@ -40,7 +40,8 @@
>  static s32 e1000_get_phy_id_82571(struct e1000_hw *hw);
>  static s32 e1000_setup_copper_link_82571(struct e1000_hw *hw);
>  static s32 e1000_setup_fiber_serdes_link_82571(struct e1000_hw *hw);
> -static s32 e1000_check_for_serdes_link_82571(struct e1000_hw *hw);
> +static s32 e1000_check_for_serdes_link_82571(struct e1000_hw *hw,
> +                                            bool *unused);
>  static s32 e1000_write_nvm_eewr_82571(struct e1000_hw *hw, u16 offset,
>                                       u16 words, u16 *data);
>  static s32 e1000_fix_nvm_checksum_82571(struct e1000_hw *hw);
> @@ -1493,6 +1494,7 @@ static s32 e1000_setup_fiber_serdes_link_82571(struct e1000_hw *hw)
>  /**
>   *  e1000_check_for_serdes_link_82571 - Check for link (Serdes)
>   *  @hw: pointer to the HW structure
> + *  @unused: unused for serdes links
>   *
>   *  Reports the link state as up or down.
>   *
> @@ -1509,7 +1511,7 @@ static s32 e1000_setup_fiber_serdes_link_82571(struct e1000_hw *hw)
>   *  4) forced_up (the link has been forced up, it did not autonegotiate)
>   *
>   **/
> -static s32 e1000_check_for_serdes_link_82571(struct e1000_hw *hw)
> +static s32 e1000_check_for_serdes_link_82571(struct e1000_hw *hw, bool *unused)
>  {
>         struct e1000_mac_info *mac = &hw->mac;
>         u32 rxcw;
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 003cbd605799..1946ddae06c0 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -1753,6 +1753,7 @@ static int e1000_loopback_test(struct e1000_adapter *adapter, u64 *data)
>  static int e1000_link_test(struct e1000_adapter *adapter, u64 *data)
>  {
>         struct e1000_hw *hw = &adapter->hw;
> +       bool link_status;
>
>         *data = 0;
>         if (hw->phy.media_type == e1000_media_type_internal_serdes) {
> @@ -1764,7 +1765,7 @@ static int e1000_link_test(struct e1000_adapter *adapter, u64 *data)
>                  * could take as long as 2-3 minutes
>                  */
>                 do {
> -                       hw->mac.ops.check_for_link(hw);
> +                       hw->mac.ops.check_for_link(hw, NULL);
>                         if (hw->mac.serdes_has_link)
>                                 return *data;
>                         msleep(20);
> @@ -1772,7 +1773,7 @@ static int e1000_link_test(struct e1000_adapter *adapter, u64 *data)
>
>                 *data = 1;
>         } else {
> -               hw->mac.ops.check_for_link(hw);
> +               hw->mac.ops.check_for_link(hw, &link_status);
>                 if (hw->mac.autoneg)
>                         /* On some Phy/switch combinations, link establishment
>                          * can take a few seconds more than expected.
> diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
> index d803b1a12349..4dff6df469bb 100644
> --- a/drivers/net/ethernet/intel/e1000e/hw.h
> +++ b/drivers/net/ethernet/intel/e1000e/hw.h
> @@ -472,7 +472,7 @@ struct e1000_mac_operations {
>         s32  (*id_led_init)(struct e1000_hw *);
>         s32  (*blink_led)(struct e1000_hw *);
>         bool (*check_mng_mode)(struct e1000_hw *);
> -       s32  (*check_for_link)(struct e1000_hw *);
> +       s32  (*check_for_link)(struct e1000_hw *, bool *);
>         s32  (*cleanup_led)(struct e1000_hw *);
>         void (*clear_hw_cntrs)(struct e1000_hw *);
>         void (*clear_vfta)(struct e1000_hw *);
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index ff308b05d68c..3d25255289ff 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1363,15 +1363,14 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>  /**
>   *  e1000_check_for_copper_link_ich8lan - Check for link (Copper)
>   *  @hw: pointer to the HW structure
> + *  @link_status: pointer to whether the link is up or not
>   *
>   *  Checks to see of the link status of the hardware has changed.  If a
>   *  change in link status has been detected, then we read the PHY registers
>   *  to get the current speed/duplex if link exists.
> - *
> - *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
> - *  up).
>   **/
> -static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> +static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw,
> +                                              bool *link_status)
>  {
>         struct e1000_mac_info *mac = &hw->mac;
>         s32 ret_val, tipg_reg = 0;
> @@ -1384,8 +1383,11 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>          * get_link_status flag is set upon receiving a Link Status
>          * Change or Rx Sequence Error interrupt.
>          */
> -       if (!mac->get_link_status)
> -               return 1;
> +       if (!mac->get_link_status) {
> +               *link_status = true;
> +               return 0;
> +       }
> +       *link_status = false;
>
>         /* First we want to see if the MII Status Register reports
>          * link.  If so, then we want to get the current speed/duplex
> @@ -1554,6 +1556,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>         if (!link)
>                 return 0;       /* No link detected */
>
> +       *link_status = true;
>         mac->get_link_status = false;
>
>         switch (hw->mac.type) {
> @@ -1602,7 +1605,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>          * we have already determined whether we have link or not.
>          */
>         if (!mac->autoneg)
> -               return 1;
> +               return 0;
>
>         /* Auto-Neg is enabled.  Auto Speed Detection takes care
>          * of MAC speed/duplex configuration.  So we only need to
> @@ -1621,7 +1624,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>                 return ret_val;
>         }
>
> -       return 1;
> +       return 0;
>  }
>
>  static s32 e1000_get_variants_ich8lan(struct e1000_adapter *adapter)
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index db735644b312..5a5e219fc864 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -406,15 +406,13 @@ void e1000e_clear_hw_cntrs_base(struct e1000_hw *hw)
>  /**
>   *  e1000e_check_for_copper_link - Check for link (Copper)
>   *  @hw: pointer to the HW structure
> + *  @link_status: pointer to whether the link is up or not
>   *
>   *  Checks to see of the link status of the hardware has changed.  If a
>   *  change in link status has been detected, then we read the PHY registers
>   *  to get the current speed/duplex if link exists.
> - *
> - *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
> - *  up).
>   **/
> -s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
> +s32 e1000e_check_for_copper_link(struct e1000_hw *hw, bool *link_status)
>  {
>         struct e1000_mac_info *mac = &hw->mac;
>         s32 ret_val;
> @@ -425,8 +423,11 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>          * get_link_status flag is set upon receiving a Link Status
>          * Change or Rx Sequence Error interrupt.
>          */
> -       if (!mac->get_link_status)
> -               return 1;
> +       if (!mac->get_link_status) {
> +               *link_status = true;
> +               return 0;
> +       }
> +       *link_status = false;
>
>         /* First we want to see if the MII Status Register reports
>          * link.  If so, then we want to get the current speed/duplex
> @@ -439,6 +440,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>         if (!link)
>                 return 0;       /* No link detected */
>
> +       *link_status = true;
>         mac->get_link_status = false;
>
>         /* Check if there was DownShift, must be checked
> @@ -450,7 +452,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>          * we have already determined whether we have link or not.
>          */
>         if (!mac->autoneg)
> -               return 1;
> +               return 0;
>
>         /* Auto-Neg is enabled.  Auto Speed Detection takes care
>          * of MAC speed/duplex configuration.  So we only need to
> @@ -469,17 +471,18 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>                 return ret_val;
>         }
>
> -       return 1;
> +       return 0;
>  }
>
>  /**
>   *  e1000e_check_for_fiber_link - Check for link (Fiber)
>   *  @hw: pointer to the HW structure
> + *  @unused: unused for fiber links
>   *
>   *  Checks for link up on the hardware.  If link is not up and we have
>   *  a signal, then we need to force link up.
>   **/
> -s32 e1000e_check_for_fiber_link(struct e1000_hw *hw)
> +s32 e1000e_check_for_fiber_link(struct e1000_hw *hw, bool *unused)
>  {
>         struct e1000_mac_info *mac = &hw->mac;
>         u32 rxcw;
> @@ -540,11 +543,12 @@ s32 e1000e_check_for_fiber_link(struct e1000_hw *hw)
>  /**
>   *  e1000e_check_for_serdes_link - Check for link (Serdes)
>   *  @hw: pointer to the HW structure
> + *  @unused: unused for serdes links
>   *
>   *  Checks for link up on the hardware.  If link is not up and we have
>   *  a signal, then we need to force link up.
>   **/
> -s32 e1000e_check_for_serdes_link(struct e1000_hw *hw)
> +s32 e1000e_check_for_serdes_link(struct e1000_hw *hw, bool *unused)
>  {
>         struct e1000_mac_info *mac = &hw->mac;
>         u32 rxcw;
> @@ -833,7 +837,7 @@ static s32 e1000_poll_fiber_serdes_link_generic(struct e1000_hw *hw)
>                  * link up if we detect a signal. This will allow us to
>                  * communicate with non-autonegotiating link partners.
>                  */
> -               ret_val = mac->ops.check_for_link(hw);
> +               ret_val = mac->ops.check_for_link(hw, NULL);
>                 if (ret_val) {
>                         e_dbg("Error while checking for link\n");
>                         return ret_val;
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.h b/drivers/net/ethernet/intel/e1000e/mac.h
> index 8284618af9ff..74299bf1a5bb 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.h
> +++ b/drivers/net/ethernet/intel/e1000e/mac.h
> @@ -23,9 +23,9 @@
>  #define _E1000E_MAC_H_
>
>  s32 e1000e_blink_led_generic(struct e1000_hw *hw);
> -s32 e1000e_check_for_copper_link(struct e1000_hw *hw);
> -s32 e1000e_check_for_fiber_link(struct e1000_hw *hw);
> -s32 e1000e_check_for_serdes_link(struct e1000_hw *hw);
> +s32 e1000e_check_for_copper_link(struct e1000_hw *hw, bool *link_status);
> +s32 e1000e_check_for_fiber_link(struct e1000_hw *hw, bool *unused);
> +s32 e1000e_check_for_serdes_link(struct e1000_hw *hw, bool *unused);
>  s32 e1000e_cleanup_led_generic(struct e1000_hw *hw);
>  s32 e1000e_config_fc_after_link_up(struct e1000_hw *hw);
>  s32 e1000e_disable_pcie_master(struct e1000_hw *hw);
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 9fd4050a91ca..548250108dc5 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5088,19 +5088,14 @@ static bool e1000e_has_link(struct e1000_adapter *adapter)
>          */
>         switch (hw->phy.media_type) {
>         case e1000_media_type_copper:
> -               if (hw->mac.get_link_status) {
> -                       ret_val = hw->mac.ops.check_for_link(hw);
> -                       link_active = ret_val > 0;
> -               } else {
> -                       link_active = true;
> -               }
> +               ret_val = hw->mac.ops.check_for_link(hw, &link_active);
>                 break;
>         case e1000_media_type_fiber:
> -               ret_val = hw->mac.ops.check_for_link(hw);
> +               ret_val = hw->mac.ops.check_for_link(hw, NULL);
>                 link_active = !!(er32(STATUS) & E1000_STATUS_LU);
>                 break;
>         case e1000_media_type_internal_serdes:
> -               ret_val = hw->mac.ops.check_for_link(hw);
> +               ret_val = hw->mac.ops.check_for_link(hw, NULL);
>                 link_active = hw->mac.serdes_has_link;
>                 break;
>         default:
> --
> 2.16.1
>
