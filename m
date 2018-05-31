Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbeEaWUX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:20:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:50331 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbeEaWUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:20:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="228961475"
Date: Fri, 1 Jun 2018 06:19:35 +0800
From: kbuild test robot <lkp@intel.com>
To: Edward Cree <ecree@solarflare.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/sfc/efx.c:3032:1-20: alloc with no test,
 possible model on line 3041
Message-ID: <201806010632.4fsedp9j%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd52cb879063ca5470d5a093c32180ba74fa528e
commit: f8d6203780b73c07dc49ee421fedae8edb76b6e4 sfc: ARFS filter IDs
date:   5 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/sfc/efx.c:3032:1-20: alloc with no test, possible model on line 3041
   drivers/net/ethernet/sfc/efx.c:3032:1-20: alloc with no test, possible model on line 3062

vim +3032 drivers/net/ethernet/sfc/efx.c

  2983	
  2984	/**************************************************************************
  2985	 *
  2986	 * Data housekeeping
  2987	 *
  2988	 **************************************************************************/
  2989	
  2990	/* This zeroes out and then fills in the invariants in a struct
  2991	 * efx_nic (including all sub-structures).
  2992	 */
  2993	static int efx_init_struct(struct efx_nic *efx,
  2994				   struct pci_dev *pci_dev, struct net_device *net_dev)
  2995	{
  2996		int rc = -ENOMEM, i;
  2997	
  2998		/* Initialise common structures */
  2999		INIT_LIST_HEAD(&efx->node);
  3000		INIT_LIST_HEAD(&efx->secondary_list);
  3001		spin_lock_init(&efx->biu_lock);
  3002	#ifdef CONFIG_SFC_MTD
  3003		INIT_LIST_HEAD(&efx->mtd_list);
  3004	#endif
  3005		INIT_WORK(&efx->reset_work, efx_reset_work);
  3006		INIT_DELAYED_WORK(&efx->monitor_work, efx_monitor);
  3007		INIT_DELAYED_WORK(&efx->selftest_work, efx_selftest_async_work);
  3008		efx->pci_dev = pci_dev;
  3009		efx->msg_enable = debug;
  3010		efx->state = STATE_UNINIT;
  3011		strlcpy(efx->name, pci_name(pci_dev), sizeof(efx->name));
  3012	
  3013		efx->net_dev = net_dev;
  3014		efx->rx_prefix_size = efx->type->rx_prefix_size;
  3015		efx->rx_ip_align =
  3016			NET_IP_ALIGN ? (efx->rx_prefix_size + NET_IP_ALIGN) % 4 : 0;
  3017		efx->rx_packet_hash_offset =
  3018			efx->type->rx_hash_offset - efx->type->rx_prefix_size;
  3019		efx->rx_packet_ts_offset =
  3020			efx->type->rx_ts_offset - efx->type->rx_prefix_size;
  3021		INIT_LIST_HEAD(&efx->rss_context.list);
  3022		mutex_init(&efx->rss_lock);
  3023		spin_lock_init(&efx->stats_lock);
  3024		efx->vi_stride = EFX_DEFAULT_VI_STRIDE;
  3025		efx->num_mac_stats = MC_CMD_MAC_NSTATS;
  3026		BUILD_BUG_ON(MC_CMD_MAC_NSTATS - 1 != MC_CMD_MAC_GENERATION_END);
  3027		mutex_init(&efx->mac_lock);
  3028	#ifdef CONFIG_RFS_ACCEL
  3029		mutex_init(&efx->rps_mutex);
  3030		spin_lock_init(&efx->rps_hash_lock);
  3031		/* Failure to allocate is not fatal, but may degrade ARFS performance */
> 3032		efx->rps_hash_table = kcalloc(EFX_ARFS_HASH_TABLE_SIZE,
  3033					      sizeof(*efx->rps_hash_table), GFP_KERNEL);
  3034	#endif
  3035		efx->phy_op = &efx_dummy_phy_operations;
  3036		efx->mdio.dev = net_dev;
  3037		INIT_WORK(&efx->mac_work, efx_mac_work);
  3038		init_waitqueue_head(&efx->flush_wq);
  3039	
  3040		for (i = 0; i < EFX_MAX_CHANNELS; i++) {
> 3041			efx->channel[i] = efx_alloc_channel(efx, i, NULL);
  3042			if (!efx->channel[i])
  3043				goto fail;
  3044			efx->msi_context[i].efx = efx;
  3045			efx->msi_context[i].index = i;
  3046		}
  3047	
  3048		/* Higher numbered interrupt modes are less capable! */
  3049		if (WARN_ON_ONCE(efx->type->max_interrupt_mode >
  3050				 efx->type->min_interrupt_mode)) {
  3051			rc = -EIO;
  3052			goto fail;
  3053		}
  3054		efx->interrupt_mode = max(efx->type->max_interrupt_mode,
  3055					  interrupt_mode);
  3056		efx->interrupt_mode = min(efx->type->min_interrupt_mode,
  3057					  interrupt_mode);
  3058	
  3059		/* Would be good to use the net_dev name, but we're too early */
  3060		snprintf(efx->workqueue_name, sizeof(efx->workqueue_name), "sfc%s",
  3061			 pci_name(pci_dev));
  3062		efx->workqueue = create_singlethread_workqueue(efx->workqueue_name);
  3063		if (!efx->workqueue)
  3064			goto fail;
  3065	
  3066		return 0;
  3067	
  3068	fail:
  3069		efx_fini_struct(efx);
  3070		return rc;
  3071	}
  3072	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
