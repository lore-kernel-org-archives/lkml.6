Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D5BC46463
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA132150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd51A7OQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA132150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJKGiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbeJKGiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:01 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A882087A;
        Wed, 10 Oct 2018 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213217;
        bh=bRmKXsJROfFjbj5rASkB4bzGImi84agKZ7uT4FOslf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dd51A7OQG43ywCnI6v2ahLOPgaH+t86sThDvNgM0u5eo/PNxWIVoz9HAZm1auG9vP
         LB3p1SmU6lGk1qTLX0ktx01avyWqHxLZE1WwPMVeomLAvE6lO1+PefVrG3ixwmVVS5
         swwikV85EcQEAw1gfme7tlqacKbHVqZNsIuMmCIU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 21/30] locking: Prepare spin_lock_bh() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:08 +0200
Message-Id: <1539213137-13953-22-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of __local_bh_disable_ip()
that is going to handle a softirq mask in order to apply finegrained
vector disablement. The lock function is going to return the previous
vectors enabled mask prior to the last call to local_bh_disable(),
following a similar model to that of local_irq_save/restore. Subsequent
calls to local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh2 = spin_lock_bh(...);
		...
		spin_unlock_bh(..., bh2);
	local_bh_enable(bh);

To prepare for that, make spin_lock_bh() able to return a saved vector
enabled mask and pass it back to spin_unlock_bh(). We'll plug it to
__local_bh_disable_ip() in a subsequent patch.

Thanks to coccinelle that helped a lot with scripts such as the
following:

	@spin exists@
	identifier func;
	expression e;
	@@
	func(...) {
	+ unsigned int bh;
	...
	- spin_lock_bh(e);
	+ bh = spin_lock_bh(e, SOFTIRQ_ALL_MASK);
	...
	- spin_unlock_bh(e);
	+ spin_unlock_bh(e, bh);
	...
	}

	@raw_spin exists@
	identifier func;
	expression e;
	@@
	func(...) {
	+ unsigned int bh;
	...
	- raw_spin_lock_bh(e);
	+ bh = raw_spin_lock_bh(e, SOFTIRQ_ALL_MASK);
	...
	- raw_spin_unlock_bh(e);
	+ raw_spin_unlock_bh(e, bh);
	...
	}

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/s390/mm/pgalloc.c                             |  24 +-
 arch/xtensa/platforms/iss/console.c                |  10 +-
 arch/xtensa/platforms/iss/network.c                |  28 +-
 block/genhd.c                                      |  15 +-
 crypto/ansi_cprng.c                                |  10 +-
 crypto/mcryptd.c                                   |   5 +-
 drivers/block/rsxx/core.c                          |   5 +-
 drivers/block/rsxx/cregs.c                         |  34 ++-
 drivers/block/rsxx/dma.c                           |  36 +--
 drivers/block/umem.c                               |  10 +-
 drivers/connector/cn_queue.c                       |  15 +-
 drivers/connector/connector.c                      |  15 +-
 drivers/crypto/atmel-aes.c                         |   5 +-
 drivers/crypto/atmel-sha.c                         |   5 +-
 drivers/crypto/atmel-tdes.c                        |   5 +-
 drivers/crypto/axis/artpec6_crypto.c               |  10 +-
 drivers/crypto/caam/jr.c                           |   7 +-
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c       |  22 +-
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c       |  25 +-
 drivers/crypto/ccree/cc_request_mgr.c              |  31 ++-
 drivers/crypto/chelsio/chtls/chtls_cm.c            |  11 +-
 drivers/crypto/chelsio/chtls/chtls_hw.c            |  10 +-
 drivers/crypto/chelsio/chtls/chtls_main.c          |   9 +-
 drivers/crypto/inside-secure/safexcel.c            |  14 +-
 drivers/crypto/inside-secure/safexcel_cipher.c     |  15 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |  15 +-
 drivers/crypto/marvell/cesa.c                      |  15 +-
 drivers/crypto/marvell/tdma.c                      |  13 +-
 drivers/crypto/mediatek/mtk-aes.c                  |   5 +-
 drivers/crypto/mediatek/mtk-sha.c                  |   5 +-
 drivers/crypto/mxc-scc.c                           |  10 +-
 drivers/crypto/nx/nx-842.c                         |  10 +-
 drivers/crypto/omap-aes.c                          |  15 +-
 drivers/crypto/omap-des.c                          |   5 +-
 drivers/crypto/omap-sham.c                         |  10 +-
 drivers/crypto/qat/qat_common/adf_transport.c      |  15 +-
 drivers/crypto/qce/core.c                          |   5 +-
 drivers/crypto/stm32/stm32-cryp.c                  |   5 +-
 drivers/crypto/stm32/stm32-hash.c                  |   5 +-
 drivers/crypto/stm32/stm32_crc32.c                 |   5 +-
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c            |   5 +-
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c            |   5 +-
 drivers/dma/at_xdmac.c                             |   5 +-
 drivers/dma/dmaengine.c                            |   5 +-
 drivers/dma/fsldma.c                               |  44 ++--
 drivers/dma/ioat/dma.c                             |  59 +++--
 drivers/dma/ioat/dma.h                             |   1 +
 drivers/dma/ioat/init.c                            |  28 +-
 drivers/dma/iop-adma.c                             |  60 +++--
 drivers/dma/mv_xor.c                               |  32 ++-
 drivers/dma/mv_xor_v2.c                            |  24 +-
 drivers/dma/ppc4xx/adma.c                          |  74 +++---
 drivers/dma/timb_dma.c                             |  35 ++-
 drivers/dma/txx9dmac.c                             |  50 ++--
 drivers/dma/xgene-dma.c                            |  20 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |  32 ++-
 drivers/gpu/drm/drm_lock.c                         |  35 +--
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   5 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c            |   5 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                |  10 +-
 drivers/hsi/clients/cmt_speech.c                   |  61 +++--
 drivers/hsi/clients/ssi_protocol.c                 | 135 +++++-----
 drivers/hsi/controllers/omap_ssi_port.c            |  60 +++--
 drivers/infiniband/core/addr.c                     |  29 ++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   7 +-
 drivers/infiniband/hw/mlx4/main.c                  |  35 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c              |  33 +--
 drivers/infiniband/sw/rxe/rxe_mmap.c               |  19 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |  24 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |   5 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |  15 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  14 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  52 ++--
 drivers/isdn/capi/capi.c                           |  46 ++--
 drivers/isdn/hardware/eicon/platform.h             |   4 +-
 drivers/isdn/i4l/isdn_concap.c                     |   2 +-
 drivers/isdn/i4l/isdn_net.c                        |  13 +-
 drivers/isdn/i4l/isdn_ppp.c                        |   3 +-
 drivers/leds/trigger/ledtrig-netdev.c              |  15 +-
 drivers/media/pci/ttpci/av7110_av.c                |  10 +-
 drivers/misc/sgi-xp/xpnet.c                        |   9 +-
 drivers/misc/vmw_vmci/vmci_doorbell.c              |  15 +-
 drivers/mmc/host/atmel-mci.c                       |  24 +-
 drivers/mmc/host/dw_mmc.c                          |  15 +-
 drivers/mmc/host/wbsd.c                            |  22 +-
 drivers/net/appletalk/ipddp.c                      |  19 +-
 drivers/net/bonding/bond_3ad.c                     |  30 ++-
 drivers/net/bonding/bond_alb.c                     |  60 +++--
 drivers/net/bonding/bond_debugfs.c                 |   5 +-
 drivers/net/caif/caif_hsi.c                        |  51 ++--
 drivers/net/can/slcan.c                            |  24 +-
 drivers/net/can/softing/softing_main.c             |  15 +-
 drivers/net/eql.c                                  |  25 +-
 drivers/net/ethernet/3com/3c59x.c                  |  10 +-
 drivers/net/ethernet/alacritech/slicoss.c          |  30 ++-
 drivers/net/ethernet/altera/altera_tse_main.c      |   5 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |  10 +-
 drivers/net/ethernet/broadcom/bnx2.c               | 107 ++++----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  24 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |  39 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  12 +-
 drivers/net/ethernet/broadcom/cnic.c               |  12 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   5 +-
 drivers/net/ethernet/broadcom/tg3.c                |  67 ++---
 drivers/net/ethernet/calxeda/xgmac.c               |   5 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  10 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |  10 +-
 .../net/ethernet/cavium/liquidio/octeon_device.c   |  32 ++-
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c |  12 +-
 drivers/net/ethernet/cavium/liquidio/octeon_nic.c  |  11 +-
 .../net/ethernet/cavium/liquidio/request_manager.c |  22 +-
 .../ethernet/cavium/liquidio/response_manager.c    |  11 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   5 +-
 drivers/net/ethernet/chelsio/cxgb/vsc7326.c        |  10 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c |  34 ++-
 drivers/net/ethernet/chelsio/cxgb3/l2t.c           |  29 ++-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c      |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |  17 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  37 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c   |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |  23 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/smt.c           |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |  15 +-
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |  23 +-
 drivers/net/ethernet/cisco/enic/enic_api.c         |   5 +-
 drivers/net/ethernet/cisco/enic/enic_clsf.c        |  25 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c         |  75 +++---
 drivers/net/ethernet/cisco/enic/enic_dev.h         |   2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  18 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  35 ++-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |  10 +-
 drivers/net/ethernet/freescale/gianfar.c           |   5 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |  30 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |   7 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c  |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  49 ++--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  17 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 +--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  68 +++--
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  36 +--
 drivers/net/ethernet/intel/igbvf/ethtool.c         |   5 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |  51 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |  10 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |   5 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  55 ++--
 drivers/net/ethernet/jme.c                         |  52 ++--
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   5 +-
 drivers/net/ethernet/marvell/skge.c                |  29 ++-
 drivers/net/ethernet/marvell/sky2.c                |  34 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  10 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   5 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |  25 +-
 drivers/net/ethernet/mellanox/mlx4/en_port.c       |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  24 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  16 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |  10 +-
 .../net/ethernet/mellanox/mlx5/core/lib/vxlan.c    |  15 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |  12 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   5 +-
 drivers/net/ethernet/microchip/lan743x_ptp.c       |  30 ++-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   |  14 +-
 drivers/net/ethernet/netronome/nfp/flower/main.c   |  14 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |   5 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |  21 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h       |   2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  35 ++-
 drivers/net/ethernet/nvidia/forcedeth.c            |  10 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_init.c   |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |   7 +-
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c         |  19 +-
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |  12 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c        |  19 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |  91 ++++---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  10 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |  26 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  64 +++--
 drivers/net/ethernet/qlogic/qed/qed_roce.c         |  16 +-
 drivers/net/ethernet/qlogic/qed/qed_spq.c          |  26 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |  25 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |  42 +--
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  22 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |  15 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  20 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |   5 +-
 drivers/net/ethernet/qualcomm/qca_uart.c           |  14 +-
 drivers/net/ethernet/realtek/8139too.c             |   5 +-
 drivers/net/ethernet/sfc/ef10.c                    |  15 +-
 drivers/net/ethernet/sfc/efx.c                     |  15 +-
 drivers/net/ethernet/sfc/ethtool.c                 |   5 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |  15 +-
 drivers/net/ethernet/sfc/falcon/ethtool.c          |   5 +-
 drivers/net/ethernet/sfc/falcon/falcon.c           |   9 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |  42 +--
 drivers/net/ethernet/sfc/farch.c                   |   5 +-
 drivers/net/ethernet/sfc/mcdi.c                    |  34 ++-
 drivers/net/ethernet/sfc/ptp.c                     |  22 +-
 drivers/net/ethernet/sfc/rx.c                      |   5 +-
 drivers/net/ethernet/silan/sc92031.c               |  60 +++--
 drivers/net/ethernet/ti/netcp_ethss.c              |  10 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   5 +-
 drivers/net/ethernet/via/via-rhine.c               |  25 +-
 drivers/net/hamradio/6pack.c                       |  15 +-
 drivers/net/hamradio/mkiss.c                       |  30 ++-
 drivers/net/ipvlan/ipvlan_core.c                   |   5 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  22 +-
 drivers/net/macsec.c                               |  25 +-
 drivers/net/macvlan.c                              |   5 +-
 drivers/net/ppp/ppp_async.c                        |  12 +-
 drivers/net/ppp/ppp_generic.c                      |  28 +-
 drivers/net/ppp/ppp_synctty.c                      |   5 +-
 drivers/net/slip/slip.c                            |  53 ++--
 drivers/net/tun.c                                  |  22 +-
 drivers/net/usb/cdc_mbim.c                         |   5 +-
 drivers/net/usb/cdc_ncm.c                          |  24 +-
 drivers/net/usb/r8152.c                            |   5 +-
 drivers/net/vxlan.c                                |  32 ++-
 drivers/net/wan/x25_asy.c                          |  10 +-
 drivers/net/wireless/ath/ath10k/ce.c               |  49 ++--
 drivers/net/wireless/ath/ath10k/coredump.c         |   5 +-
 drivers/net/wireless/ath/ath10k/debug.c            |  47 ++--
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |  15 +-
 drivers/net/wireless/ath/ath10k/htc.c              |  23 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  79 +++---
 drivers/net/wireless/ath/ath10k/htt_tx.c           |  25 +-
 drivers/net/wireless/ath/ath10k/hw.c               |   9 +-
 drivers/net/wireless/ath/ath10k/mac.c              | 284 ++++++++++++---------
 drivers/net/wireless/ath/ath10k/p2p.c              |   5 +-
 drivers/net/wireless/ath/ath10k/pci.c              |  42 +--
 drivers/net/wireless/ath/ath10k/sdio.c             |  27 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |  17 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |  15 +-
 drivers/net/wireless/ath/ath10k/thermal.c          |  10 +-
 drivers/net/wireless/ath/ath10k/txrx.c             |  24 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   5 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |  83 +++---
 drivers/net/wireless/ath/ath5k/ani.c               |   5 +-
 drivers/net/wireless/ath/ath5k/base.c              |  34 ++-
 drivers/net/wireless/ath/ath5k/debug.c             |  10 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |  10 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |  29 ++-
 drivers/net/wireless/ath/ath6kl/hif.c              |  15 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         | 107 ++++----
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |  89 ++++---
 drivers/net/wireless/ath/ath6kl/init.c             |   7 +-
 drivers/net/wireless/ath/ath6kl/main.c             |  49 ++--
 drivers/net/wireless/ath/ath6kl/sdio.c             |  51 ++--
 drivers/net/wireless/ath/ath6kl/txrx.c             | 124 +++++----
 drivers/net/wireless/ath/ath6kl/wmi.c              |  56 ++--
 drivers/net/wireless/ath/ath9k/ath9k.h             |   2 +-
 drivers/net/wireless/ath/ath9k/beacon.c            |   5 +-
 drivers/net/wireless/ath/ath9k/channel.c           |  68 ++---
 drivers/net/wireless/ath/ath9k/dynack.c            |  12 +-
 drivers/net/wireless/ath/ath9k/gpio.c              |  10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |  33 ++-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |  10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |  25 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |  50 ++--
 drivers/net/wireless/ath/ath9k/main.c              |  44 ++--
 drivers/net/wireless/ath/ath9k/recv.c              |  17 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |   7 +-
 drivers/net/wireless/ath/ath9k/wow.c               |  10 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |  38 +--
 drivers/net/wireless/ath/carl9170/debug.c          |  20 +-
 drivers/net/wireless/ath/carl9170/main.c           |  45 ++--
 drivers/net/wireless/ath/carl9170/rx.c             |   5 +-
 drivers/net/wireless/ath/carl9170/tx.c             |  80 +++---
 drivers/net/wireless/ath/carl9170/usb.c            |  12 +-
 drivers/net/wireless/ath/dfs_pri_detector.c        |  30 ++-
 drivers/net/wireless/ath/wcn36xx/main.c            |  13 +-
 drivers/net/wireless/ath/wil6210/debugfs.c         |   5 +-
 drivers/net/wireless/ath/wil6210/main.c            |  10 +-
 drivers/net/wireless/ath/wil6210/rx_reorder.c      |   5 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |  28 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |  10 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |  15 +-
 drivers/net/wireless/atmel/atmel.c                 |   7 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  27 +-
 .../wireless/broadcom/brcm80211/brcmsmac/debug.c   |   5 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      | 135 +++++-----
 drivers/net/wireless/intel/iwlwifi/dvm/calib.c     |  16 +-
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c   |  20 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   5 +-
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c       | 119 +++++----
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |  38 +--
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  51 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  30 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       | 145 ++++++-----
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  34 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  46 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  15 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  29 ++-
 drivers/net/wireless/intersil/hostap/hostap_ap.c   | 145 ++++++-----
 drivers/net/wireless/intersil/hostap/hostap_hw.c   |  20 +-
 .../net/wireless/intersil/hostap/hostap_ioctl.c    |   9 +-
 drivers/net/wireless/intersil/hostap/hostap_proc.c |   4 +-
 .../net/wireless/intersil/orinoco/orinoco_usb.c    |   9 +-
 drivers/net/wireless/mac80211_hwsim.c              |  53 ++--
 drivers/net/wireless/marvell/mwl8k.c               |  21 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |  15 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  15 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_dma.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c    |   5 +-
 .../net/wireless/mediatek/mt76/mt76x2_mac_common.c |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c     |   5 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  45 ++--
 drivers/net/wireless/mediatek/mt76/usb.c           |   5 +-
 drivers/net/wireless/mediatek/mt7601u/mac.c        |  10 +-
 drivers/net/wireless/mediatek/mt7601u/phy.c        |  14 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |  15 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |   5 +-
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |   5 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |  10 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  17 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |  16 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |  22 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |  10 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |  22 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |  10 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |  22 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |  10 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |  20 +-
 drivers/net/wireless/st/cw1200/debug.c             |   5 +-
 drivers/net/wireless/st/cw1200/pm.c                |  10 +-
 drivers/net/wireless/st/cw1200/queue.c             |  80 +++---
 drivers/net/wireless/st/cw1200/sta.c               |  34 ++-
 drivers/net/wireless/st/cw1200/txrx.c              |  77 +++---
 drivers/net/wireless/st/cw1200/wsm.c               |   5 +-
 drivers/net/xen-netfront.c                         |  15 +-
 drivers/pcmcia/bcm63xx_pcmcia.c                    |  10 +-
 drivers/rapidio/devices/tsi721_dma.c               |  32 ++-
 drivers/rapidio/rio_cm.c                           |  92 ++++---
 drivers/s390/block/dasd.c                          |  38 +--
 drivers/s390/block/dasd_ioctl.c                    |   7 +-
 drivers/s390/block/dasd_proc.c                     |   5 +-
 drivers/s390/char/tty3270.c                        |  40 +--
 drivers/s390/char/vmlogrdr.c                       |  17 +-
 drivers/s390/crypto/ap_bus.c                       |  64 +++--
 drivers/s390/crypto/ap_card.c                      |  25 +-
 drivers/s390/crypto/ap_queue.c                     |  60 +++--
 drivers/s390/crypto/pkey_api.c                     |  22 +-
 drivers/s390/net/qeth_l2_main.c                    |  10 +-
 drivers/s390/net/qeth_l3_main.c                    |  55 ++--
 drivers/s390/net/qeth_l3_sys.c                     |  25 +-
 drivers/s390/net/smsgiucv.c                        |  10 +-
 drivers/s390/net/smsgiucv_app.c                    |   5 +-
 drivers/s390/scsi/zfcp_fc.c                        |   5 +-
 drivers/s390/scsi/zfcp_sysfs.c                     |   7 +-
 drivers/scsi/be2iscsi/be_main.c                    |  51 ++--
 drivers/scsi/bnx2fc/bnx2fc_els.c                   |  36 +--
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  58 +++--
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   |  20 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |  67 ++---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                   |  21 +-
 drivers/scsi/bnx2i/bnx2i.h                         |   2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  12 +-
 drivers/scsi/bnx2i/bnx2i_init.c                    |   5 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |  14 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                 |  27 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 |  58 +++--
 drivers/scsi/cxgbi/libcxgbi.c                      |  61 +++--
 drivers/scsi/fcoe/fcoe.c                           |  10 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/fcoe/fcoe_transport.c                 |  14 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           | 105 ++++----
 drivers/scsi/iscsi_tcp.c                           |  26 +-
 drivers/scsi/libfc/fc_exch.c                       | 123 +++++----
 drivers/scsi/libfc/fc_fcp.c                        |  20 +-
 drivers/scsi/libiscsi.c                            | 170 ++++++------
 drivers/scsi/libiscsi_tcp.c                        |  10 +-
 drivers/scsi/qedi/qedi_fw.c                        |  46 ++--
 drivers/scsi/qedi/qedi_main.c                      |  27 +-
 drivers/staging/fwserial/fwserial.c                | 167 +++++++-----
 drivers/staging/mt7621-dma/mtk-hsdma.c             |  15 +-
 drivers/staging/rtl8188eu/core/rtw_ap.c            |  69 ++---
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |  17 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |  32 ++-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |  92 ++++---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |  37 +--
 drivers/staging/rtl8188eu/core/rtw_recv.c          |  38 +--
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c       |  40 +--
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |  55 ++--
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |  12 +-
 drivers/staging/rtl8188eu/include/rtw_mlme.h       |   4 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |  26 +-
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c      |  12 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |  65 +++--
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  21 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |  12 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |  37 +--
 drivers/staging/rtl8723bs/core/rtw_mlme.c          | 101 ++++----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  68 ++---
 drivers/staging/rtl8723bs/core/rtw_recv.c          |  53 ++--
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |  61 +++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  50 ++--
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |  95 ++++---
 drivers/staging/rtl8723bs/hal/hal_com.c            |   2 +-
 drivers/staging/rtl8723bs/hal/hal_sdio.c           |   2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |  22 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |   2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |   4 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  29 ++-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |  44 ++--
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |   5 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |   5 +-
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c   |   5 +-
 drivers/staging/rtlwifi/core.c                     |  10 +-
 drivers/staging/rtlwifi/pci.c                      |  17 +-
 drivers/staging/rtlwifi/rtl8822be/hw.c             |  22 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c            |  41 +--
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |  17 +-
 drivers/target/iscsi/cxgbit/cxgbit_target.c        |  31 ++-
 drivers/target/iscsi/iscsi_target.c                | 221 +++++++++-------
 drivers/target/iscsi/iscsi_target_configfs.c       |  19 +-
 drivers/target/iscsi/iscsi_target_erl0.c           |  49 ++--
 drivers/target/iscsi/iscsi_target_erl1.c           |  79 +++---
 drivers/target/iscsi/iscsi_target_erl2.c           |  18 +-
 drivers/target/iscsi/iscsi_target_login.c          |  68 ++---
 drivers/target/iscsi/iscsi_target_nodeattrib.c     |   5 +-
 drivers/target/iscsi/iscsi_target_stat.c           |  45 ++--
 drivers/target/iscsi/iscsi_target_tmr.c            |  30 ++-
 drivers/target/iscsi/iscsi_target_util.c           | 208 ++++++++-------
 drivers/target/sbp/sbp_target.c                    | 141 +++++-----
 drivers/target/target_core_tpg.c                   |  10 +-
 drivers/target/target_core_transport.c             |   5 +-
 drivers/target/target_core_user.c                  |  12 +-
 drivers/tty/hvc/hvc_iucv.c                         |  40 +--
 drivers/tty/moxa.c                                 |  21 +-
 drivers/usb/serial/keyspan_pda.c                   |   7 +-
 drivers/vhost/vsock.c                              |  45 ++--
 fs/afs/internal.h                                  |   4 +-
 fs/afs/rxrpc.c                                     |   5 +-
 fs/fs-writeback.c                                  |  15 +-
 fs/jffs2/README.Locking                            |   2 +-
 fs/nfs/callback.c                                  |   7 +-
 include/linux/dmaengine.h                          |  16 +-
 include/linux/netdevice.h                          |  13 +-
 include/linux/preempt.h                            |   2 +-
 include/linux/ptr_ring.h                           |  30 ++-
 include/linux/rhashtable.h                         |  17 +-
 include/linux/seqlock.h                            |   8 +-
 include/linux/spinlock.h                           |  23 +-
 include/linux/spinlock_api_smp.h                   |  26 +-
 include/linux/spinlock_api_up.h                    |  18 +-
 include/linux/u64_stats_sync.h                     |   2 +-
 include/linux/xarray.h                             |   2 +-
 include/net/gen_stats.h                            |   1 +
 include/net/netrom.h                               |   9 +-
 include/net/pkt_cls.h                              |   6 +-
 include/net/request_sock.h                         |   5 +-
 include/net/sch_generic.h                          |  19 +-
 include/net/sock.h                                 |   2 +-
 include/net/tcp.h                                  |   3 +-
 include/net/udp.h                                  |   1 +
 include/target/iscsi/iscsi_target_core.h           |   2 +-
 kernel/bpf/btf.c                                   |   5 +-
 kernel/bpf/core.c                                  |  10 +-
 kernel/bpf/local_storage.c                         |  34 ++-
 kernel/bpf/reuseport_array.c                       |  10 +-
 kernel/bpf/sockmap.c                               |  73 +++---
 kernel/bpf/syscall.c                               |  30 ++-
 kernel/cgroup/cgroup.c                             |  15 +-
 kernel/locking/spinlock.c                          |  17 +-
 kernel/rcu/rcutorture.c                            |  12 +-
 lib/rhashtable.c                                   |  12 +-
 mm/backing-dev.c                                   |  22 +-
 mm/page-writeback.c                                |  10 +-
 net/6lowpan/debugfs.c                              |  25 +-
 net/6lowpan/iphc.c                                 |  23 +-
 net/6lowpan/nhc.c                                  |  31 ++-
 net/802/garp.c                                     |  19 +-
 net/802/mrp.c                                      |  19 +-
 net/802/psnap.c                                    |  10 +-
 net/ax25/af_ax25.c                                 |  26 +-
 net/ax25/ax25_dev.c                                |  24 +-
 net/ax25/ax25_iface.c                              |  38 +--
 net/ax25/ax25_out.c                                |   7 +-
 net/batman-adv/bat_iv_ogm.c                        |  51 ++--
 net/batman-adv/bridge_loop_avoidance.c             |  70 ++---
 net/batman-adv/distributed-arp-table.c             |   5 +-
 net/batman-adv/fragmentation.c                     |  10 +-
 net/batman-adv/gateway_client.c                    |  20 +-
 net/batman-adv/hash.h                              |   4 +-
 net/batman-adv/icmp_socket.c                       |  17 +-
 net/batman-adv/log.c                               |  12 +-
 net/batman-adv/multicast.c                         |  37 +--
 net/batman-adv/network-coding.c                    |  37 +--
 net/batman-adv/originator.c                        |  62 +++--
 net/batman-adv/routing.c                           |  22 +-
 net/batman-adv/send.c                              |  21 +-
 net/batman-adv/soft-interface.c                    |  10 +-
 net/batman-adv/tp_meter.c                          |  67 +++--
 net/batman-adv/translation-table.c                 | 158 +++++++-----
 net/batman-adv/tvlv.c                              |  25 +-
 net/bluetooth/hci_core.c                           |   5 +-
 net/bridge/br.c                                    |  13 +-
 net/bridge/br_device.c                             |   5 +-
 net/bridge/br_fdb.c                                |  60 +++--
 net/bridge/br_if.c                                 |  20 +-
 net/bridge/br_ioctl.c                              |   9 +-
 net/bridge/br_mdb.c                                |  15 +-
 net/bridge/br_multicast.c                          |  47 ++--
 net/bridge/br_netlink.c                            |  24 +-
 net/bridge/br_stp.c                                |  20 +-
 net/bridge/br_stp_if.c                             |  25 +-
 net/bridge/br_sysfs_br.c                           |   5 +-
 net/bridge/br_sysfs_if.c                           |   9 +-
 net/bridge/br_vlan.c                               |   5 +-
 net/bridge/netfilter/ebt_limit.c                   |   7 +-
 net/bridge/netfilter/ebt_log.c                     |   5 +-
 net/caif/caif_dev.c                                |  16 +-
 net/caif/caif_socket.c                             |   5 +-
 net/caif/cfctrl.c                                  |  40 +--
 net/caif/cfmuxl.c                                  |  30 ++-
 net/core/datagram.c                                |   5 +-
 net/core/dev.c                                     |   5 +-
 net/core/dev_addr_lists.c                          |  51 ++--
 net/core/gen_estimator.c                           |   4 +-
 net/core/gen_stats.c                               |   8 +-
 net/core/net-procfs.c                              |   5 +-
 net/core/net_namespace.c                           |  31 ++-
 net/core/pktgen.c                                  |   4 +-
 net/core/request_sock.c                            |   7 +-
 net/core/rtnetlink.c                               |   5 +-
 net/core/sock.c                                    |  40 +--
 net/core/sock_reuseport.c                          |  26 +-
 net/dcb/dcbnl.c                                    |  54 ++--
 net/dccp/minisocks.c                               |   5 +-
 net/decnet/dn_fib.c                                |  20 +-
 net/decnet/dn_route.c                              |  24 +-
 net/ieee802154/socket.c                            |   5 +-
 net/ipv4/af_inet.c                                 |  10 +-
 net/ipv4/cipso_ipv4.c                              |  19 +-
 net/ipv4/esp4.c                                    |  19 +-
 net/ipv4/fib_semantics.c                           |  15 +-
 net/ipv4/igmp.c                                    |  82 +++---
 net/ipv4/inet_connection_sock.c                    |  23 +-
 net/ipv4/inet_diag.c                               |   5 +-
 net/ipv4/inet_fragment.c                           |   5 +-
 net/ipv4/inet_hashtables.c                         |  20 +-
 net/ipv4/ipmr.c                                    |  19 +-
 net/ipv4/ipmr_base.c                               |  17 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   9 +-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c        |   5 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv4/route.c                                   |  30 ++-
 net/ipv4/tcp_ipv4.c                                |   8 +-
 net/ipv4/tcp_metrics.c                             |  15 +-
 net/ipv4/udp.c                                     |  41 +--
 net/ipv4/udp_diag.c                                |   7 +-
 net/ipv6/addrconf.c                                |  99 +++----
 net/ipv6/af_inet6.c                                |  10 +-
 net/ipv6/calipso.c                                 |  19 +-
 net/ipv6/esp6.c                                    |  14 +-
 net/ipv6/ip6_fib.c                                 |  29 ++-
 net/ipv6/ip6_flowlabel.c                           |  47 ++--
 net/ipv6/ip6mr.c                                   |  19 +-
 net/ipv6/mcast.c                                   |  93 ++++---
 net/ipv6/mip6.c                                    |  15 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   5 +-
 net/ipv6/raw.c                                     |   5 +-
 net/ipv6/route.c                                   |  67 +++--
 net/ipv6/xfrm6_tunnel.c                            |  10 +-
 net/iucv/af_iucv.c                                 |   5 +-
 net/iucv/iucv.c                                    |  25 +-
 net/kcm/kcmproc.c                                  |  10 +-
 net/kcm/kcmsock.c                                  | 106 ++++----
 net/key/af_key.c                                   |   5 +-
 net/l2tp/l2tp_core.c                               |  34 ++-
 net/l2tp/l2tp_ip.c                                 |   5 +-
 net/llc/llc_conn.c                                 |  10 +-
 net/llc/llc_core.c                                 |  10 +-
 net/llc/llc_proc.c                                 |  10 +-
 net/llc/llc_sap.c                                  |   5 +-
 net/mac80211/agg-rx.c                              |   5 +-
 net/mac80211/agg-tx.c                              |  45 ++--
 net/mac80211/cfg.c                                 |  31 ++-
 net/mac80211/debugfs.c                             |   5 +-
 net/mac80211/debugfs_netdev.c                      |   5 +-
 net/mac80211/debugfs_sta.c                         |   5 +-
 net/mac80211/ht.c                                  |   7 +-
 net/mac80211/ibss.c                                |  14 +-
 net/mac80211/iface.c                               |  14 +-
 net/mac80211/main.c                                |   5 +-
 net/mac80211/mesh_hwmp.c                           |  58 +++--
 net/mac80211/mesh_pathtbl.c                        |  37 +--
 net/mac80211/mesh_plink.c                          |  36 +--
 net/mac80211/mesh_sync.c                           |  15 +-
 net/mac80211/mlme.c                                |   5 +-
 net/mac80211/ocb.c                                 |  14 +-
 net/mac80211/rate.c                                |  20 +-
 net/mac80211/rx.c                                  |  25 +-
 net/mac80211/sta_info.c                            |  15 +-
 net/mac80211/tdls.c                                |   5 +-
 net/mac80211/tkip.c                                |   5 +-
 net/mac80211/tx.c                                  |  45 ++--
 net/mac80211/util.c                                |   5 +-
 net/mac802154/llsec.c                              |  12 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   2 +-
 net/netfilter/ipset/ip_set_core.c                  |  24 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   6 +-
 net/netfilter/ipset/ip_set_list_set.c              |   5 +-
 net/netfilter/ipvs/ip_vs_app.c                     |   5 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  14 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  35 ++-
 net/netfilter/ipvs/ip_vs_est.c                     |  10 +-
 net/netfilter/ipvs/ip_vs_lblc.c                    |  10 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                   |  18 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   5 +-
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |  10 +-
 net/netfilter/ipvs/ip_vs_rr.c                      |  12 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |  48 ++--
 net/netfilter/ipvs/ip_vs_wrr.c                     |  10 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |  18 +-
 net/netfilter/nf_conncount.c                       |  10 +-
 net/netfilter/nf_conntrack_core.c                  |   5 +-
 net/netfilter/nf_conntrack_ecache.c                |  10 +-
 net/netfilter/nf_conntrack_expect.c                |  32 ++-
 net/netfilter/nf_conntrack_ftp.c                   |   5 +-
 net/netfilter/nf_conntrack_h323_main.c             |  26 +-
 net/netfilter/nf_conntrack_helper.c                |  10 +-
 net/netfilter/nf_conntrack_irc.c                   |   5 +-
 net/netfilter/nf_conntrack_netlink.c               |  33 ++-
 net/netfilter/nf_conntrack_pptp.c                  |   5 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |  21 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  19 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |  31 ++-
 net/netfilter/nf_conntrack_sane.c                  |   5 +-
 net/netfilter/nf_conntrack_seqadj.c                |  10 +-
 net/netfilter/nf_conntrack_sip.c                   |  10 +-
 net/netfilter/nf_nat_core.c                        |  10 +-
 net/netfilter/nfnetlink_log.c                      |  52 ++--
 net/netfilter/nfnetlink_queue.c                    |  36 +--
 net/netfilter/nft_limit.c                          |   7 +-
 net/netfilter/xt_RATEEST.c                         |   5 +-
 net/netfilter/xt_dccp.c                            |   9 +-
 net/netfilter/xt_hashlimit.c                       |   7 +-
 net/netfilter/xt_limit.c                           |   7 +-
 net/netfilter/xt_quota.c                           |   5 +-
 net/netfilter/xt_recent.c                          |  35 +--
 net/netrom/af_netrom.c                             |  32 ++-
 net/netrom/nr_route.c                              |  58 +++--
 net/nfc/rawsock.c                                  |  15 +-
 net/openvswitch/flow.c                             |  10 +-
 net/openvswitch/meter.c                            |  15 +-
 net/packet/af_packet.c                             |  34 ++-
 net/rds/af_rds.c                                   |  20 +-
 net/rose/af_rose.c                                 |  32 ++-
 net/rose/rose_route.c                              |  73 +++---
 net/rxrpc/af_rxrpc.c                               |  15 +-
 net/rxrpc/call_accept.c                            |   5 +-
 net/rxrpc/call_event.c                             |  16 +-
 net/rxrpc/call_object.c                            |   5 +-
 net/rxrpc/conn_client.c                            |   5 +-
 net/rxrpc/conn_event.c                             |   7 +-
 net/rxrpc/conn_object.c                            |   5 +-
 net/rxrpc/input.c                                  |  15 +-
 net/rxrpc/output.c                                 |  14 +-
 net/rxrpc/peer_event.c                             |  22 +-
 net/rxrpc/peer_object.c                            |  10 +-
 net/rxrpc/recvmsg.c                                |   5 +-
 net/rxrpc/sendmsg.c                                |   5 +-
 net/sched/act_bpf.c                                |  12 +-
 net/sched/act_csum.c                               |  12 +-
 net/sched/act_gact.c                               |  12 +-
 net/sched/act_ife.c                                |  22 +-
 net/sched/act_ipt.c                                |  12 +-
 net/sched/act_mirred.c                             |  19 +-
 net/sched/act_nat.c                                |   5 +-
 net/sched/act_pedit.c                              |  14 +-
 net/sched/act_police.c                             |  12 +-
 net/sched/act_sample.c                             |  12 +-
 net/sched/act_simple.c                             |  12 +-
 net/sched/act_skbmod.c                             |  12 +-
 net/sched/act_tunnel_key.c                         |  12 +-
 net/sched/act_vlan.c                               |  12 +-
 net/sched/cls_route.c                              |  10 +-
 net/sched/sch_generic.c                            |  19 +-
 net/sched/sch_mq.c                                 |   5 +-
 net/sched/sch_mqprio.c                             |  14 +-
 net/sched/sch_netem.c                              |   5 +-
 net/sched/sch_teql.c                               |   5 +-
 net/sctp/associola.c                               |  10 +-
 net/sctp/ipv6.c                                    |   9 +-
 net/sctp/protocol.c                                |  28 +-
 net/sctp/socket.c                                  |  20 +-
 net/smc/smc_cdc.c                                  |   5 +-
 net/smc/smc_core.c                                 |  42 +--
 net/smc/smc_tx.c                                   |  10 +-
 net/sunrpc/backchannel_rqst.c                      |  10 +-
 net/sunrpc/sched.c                                 |  42 +--
 net/sunrpc/svc.c                                   |  29 ++-
 net/sunrpc/svc_xprt.c                              |  52 ++--
 net/sunrpc/svcsock.c                               |   5 +-
 net/sunrpc/xprt.c                                  |  60 +++--
 net/sunrpc/xprtrdma/backchannel.c                  |  17 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c         |   5 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |  10 +-
 net/sunrpc/xprtrdma/transport.c                    |   5 +-
 net/sunrpc/xprtsock.c                              |  25 +-
 net/switchdev/switchdev.c                          |  10 +-
 net/tipc/bcast.h                                   |   2 +-
 net/tipc/discover.c                                |  20 +-
 net/tipc/msg.h                                     |  10 +-
 net/tipc/name_distr.c                              |  20 +-
 net/tipc/name_table.c                              |  71 +++---
 net/tipc/node.c                                    |  51 ++--
 net/tipc/socket.c                                  |  14 +-
 net/tipc/topsrv.c                                  |  50 ++--
 net/vmw_vsock/af_vsock.c                           |  50 ++--
 net/vmw_vsock/diag.c                               |   5 +-
 net/vmw_vsock/virtio_transport.c                   |  36 +--
 net/vmw_vsock/virtio_transport_common.c            |  44 ++--
 net/vmw_vsock/vmci_transport.c                     |  17 +-
 net/wireless/mlme.c                                |  29 ++-
 net/wireless/nl80211.c                             |  26 +-
 net/wireless/reg.c                                 |  19 +-
 net/wireless/scan.c                                |  49 ++--
 net/xfrm/xfrm_input.c                              |  10 +-
 net/xfrm/xfrm_output.c                             |   7 +-
 net/xfrm/xfrm_policy.c                             |  87 ++++---
 net/xfrm/xfrm_state.c                              | 172 ++++++++-----
 net/xfrm/xfrm_user.c                               |  15 +-
 security/selinux/netif.c                           |  15 +-
 security/selinux/netnode.c                         |  12 +-
 security/selinux/netport.c                         |  12 +-
 sound/pci/asihpi/hpios.h                           |   2 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |  19 +-
 sound/soc/omap/ams-delta.c                         |  10 +-
 tools/virtio/ringtest/ptr_ring.c                   |   2 +-
 744 files changed, 10572 insertions(+), 7570 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 76d89ee..9cc2b96 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -79,6 +79,7 @@ static void __crst_table_upgrade(void *arg)
 
 int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 {
+	unsigned int bh;
 	unsigned long *table, *pgd;
 	int rc, notify;
 
@@ -92,7 +93,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 			rc = -ENOMEM;
 			break;
 		}
-		spin_lock_bh(&mm->page_table_lock);
+		bh = spin_lock_bh(&mm->page_table_lock, SOFTIRQ_ALL_MASK);
 		pgd = (unsigned long *) mm->pgd;
 		if (mm->context.asce_limit == _REGION2_SIZE) {
 			crst_table_init(table, _REGION2_ENTRY_EMPTY);
@@ -110,7 +111,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 				_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
 		}
 		notify = 1;
-		spin_unlock_bh(&mm->page_table_lock);
+		spin_unlock_bh(&mm->page_table_lock, bh);
 	}
 	if (notify)
 		on_each_cpu(__crst_table_upgrade, mm, 0);
@@ -179,6 +180,7 @@ void page_table_free_pgste(struct page *page)
  */
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
+	unsigned int bh;
 	unsigned long *table;
 	struct page *page;
 	unsigned int mask, bit;
@@ -186,7 +188,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	/* Try to get a fragment of a 4K page as a 2K page table */
 	if (!mm_alloc_pgste(mm)) {
 		table = NULL;
-		spin_lock_bh(&mm->context.lock);
+		bh = spin_lock_bh(&mm->context.lock, SOFTIRQ_ALL_MASK);
 		if (!list_empty(&mm->context.pgtable_list)) {
 			page = list_first_entry(&mm->context.pgtable_list,
 						struct page, lru);
@@ -202,7 +204,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 				list_del(&page->lru);
 			}
 		}
-		spin_unlock_bh(&mm->context.lock);
+		spin_unlock_bh(&mm->context.lock, bh);
 		if (table)
 			return table;
 	}
@@ -226,15 +228,16 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		/* Return the first 2K fragment of the page */
 		atomic_xor_bits(&page->_refcount, 1 << 24);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
-		spin_lock_bh(&mm->context.lock);
+		bh = spin_lock_bh(&mm->context.lock, SOFTIRQ_ALL_MASK);
 		list_add(&page->lru, &mm->context.pgtable_list);
-		spin_unlock_bh(&mm->context.lock);
+		spin_unlock_bh(&mm->context.lock, bh);
 	}
 	return table;
 }
 
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
+	unsigned int bh;
 	struct page *page;
 	unsigned int bit, mask;
 
@@ -242,14 +245,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = (__pa(table) & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
-		spin_lock_bh(&mm->context.lock);
+		bh = spin_lock_bh(&mm->context.lock, SOFTIRQ_ALL_MASK);
 		mask = atomic_xor_bits(&page->_refcount, 1U << (bit + 24));
 		mask >>= 24;
 		if (mask & 3)
 			list_add(&page->lru, &mm->context.pgtable_list);
 		else
 			list_del(&page->lru);
-		spin_unlock_bh(&mm->context.lock);
+		spin_unlock_bh(&mm->context.lock, bh);
 		if (mask != 0)
 			return;
 	} else {
@@ -263,6 +266,7 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 			 unsigned long vmaddr)
 {
+	unsigned int bh;
 	struct mm_struct *mm;
 	struct page *page;
 	unsigned int bit, mask;
@@ -276,14 +280,14 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 		return;
 	}
 	bit = (__pa(table) & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
-	spin_lock_bh(&mm->context.lock);
+	bh = spin_lock_bh(&mm->context.lock, SOFTIRQ_ALL_MASK);
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
 	if (mask & 3)
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
 	else
 		list_del(&page->lru);
-	spin_unlock_bh(&mm->context.lock);
+	spin_unlock_bh(&mm->context.lock, bh);
 	table = (unsigned long *) (__pa(table) | (1U << bit));
 	tlb_remove_table(tlb, table);
 }
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index af81a62..9d5c4cc 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -51,13 +51,14 @@ static void rs_poll(struct timer_list *);
 
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
+	unsigned int bh;
 	tty->port = &serial_port;
-	spin_lock_bh(&timer_lock);
+	bh = spin_lock_bh(&timer_lock, SOFTIRQ_ALL_MASK);
 	if (tty->count == 1) {
 		timer_setup(&serial_timer, rs_poll, 0);
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
 	}
-	spin_unlock_bh(&timer_lock);
+	spin_unlock_bh(&timer_lock, bh);
 
 	return 0;
 }
@@ -75,10 +76,11 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
  */
 static void rs_close(struct tty_struct *tty, struct file * filp)
 {
-	spin_lock_bh(&timer_lock);
+	unsigned int bh;
+	bh = spin_lock_bh(&timer_lock, SOFTIRQ_ALL_MASK);
 	if (tty->count == 1)
 		del_timer_sync(&serial_timer);
-	spin_unlock_bh(&timer_lock);
+	spin_unlock_bh(&timer_lock, bh);
 }
 
 
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index d027ddd..f25ec51 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -364,10 +364,11 @@ static void iss_net_timer(struct timer_list *t)
 
 static int iss_net_open(struct net_device *dev)
 {
+	unsigned int bh;
 	struct iss_net_private *lp = netdev_priv(dev);
 	int err;
 
-	spin_lock_bh(&lp->lock);
+	bh = spin_lock_bh(&lp->lock, SOFTIRQ_ALL_MASK);
 
 	err = lp->tp.open(lp);
 	if (err < 0)
@@ -382,26 +383,27 @@ static int iss_net_open(struct net_device *dev)
 	while ((err = iss_net_rx(dev)) > 0)
 		;
 
-	spin_unlock_bh(&lp->lock);
-	spin_lock_bh(&opened_lock);
+	spin_unlock_bh(&lp->lock, bh);
+	bh = spin_lock_bh(&opened_lock, SOFTIRQ_ALL_MASK);
 	list_add(&lp->opened_list, &opened);
-	spin_unlock_bh(&opened_lock);
-	spin_lock_bh(&lp->lock);
+	spin_unlock_bh(&opened_lock, bh);
+	bh = spin_lock_bh(&lp->lock, SOFTIRQ_ALL_MASK);
 
 	timer_setup(&lp->timer, iss_net_timer, 0);
 	lp->timer_val = ISS_NET_TIMER_VALUE;
 	mod_timer(&lp->timer, jiffies + lp->timer_val);
 
 out:
-	spin_unlock_bh(&lp->lock);
+	spin_unlock_bh(&lp->lock, bh);
 	return err;
 }
 
 static int iss_net_close(struct net_device *dev)
 {
+	unsigned int bh;
 	struct iss_net_private *lp = netdev_priv(dev);
 	netif_stop_queue(dev);
-	spin_lock_bh(&lp->lock);
+	bh = spin_lock_bh(&lp->lock, SOFTIRQ_ALL_MASK);
 
 	spin_lock(&opened_lock);
 	list_del(&opened);
@@ -411,17 +413,18 @@ static int iss_net_close(struct net_device *dev)
 
 	lp->tp.close(lp);
 
-	spin_unlock_bh(&lp->lock);
+	spin_unlock_bh(&lp->lock, bh);
 	return 0;
 }
 
 static int iss_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	unsigned int bh;
 	struct iss_net_private *lp = netdev_priv(dev);
 	int len;
 
 	netif_stop_queue(dev);
-	spin_lock_bh(&lp->lock);
+	bh = spin_lock_bh(&lp->lock, SOFTIRQ_ALL_MASK);
 
 	len = lp->tp.write(lp, &skb);
 
@@ -443,7 +446,7 @@ static int iss_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		pr_err("%s: %s failed(%d)\n", dev->name, __func__, len);
 	}
 
-	spin_unlock_bh(&lp->lock);
+	spin_unlock_bh(&lp->lock, bh);
 
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
@@ -466,14 +469,15 @@ static void iss_net_tx_timeout(struct net_device *dev)
 
 static int iss_net_set_mac(struct net_device *dev, void *addr)
 {
+	unsigned int bh;
 	struct iss_net_private *lp = netdev_priv(dev);
 	struct sockaddr *hwaddr = addr;
 
 	if (!is_valid_ether_addr(hwaddr->sa_data))
 		return -EADDRNOTAVAIL;
-	spin_lock_bh(&lp->lock);
+	bh = spin_lock_bh(&lp->lock, SOFTIRQ_ALL_MASK);
 	memcpy(dev->dev_addr, hwaddr->sa_data, ETH_ALEN);
-	spin_unlock_bh(&lp->lock);
+	spin_unlock_bh(&lp->lock, bh);
 	return 0;
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index be5bab2..86cbaa6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -473,6 +473,7 @@ static int blk_mangle_minor(int minor)
  */
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 {
+	unsigned int bh;
 	struct gendisk *disk = part_to_disk(part);
 	int idx;
 
@@ -485,9 +486,9 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 	/* allocate ext devt */
 	idr_preload(GFP_KERNEL);
 
-	spin_lock_bh(&ext_devt_lock);
+	bh = spin_lock_bh(&ext_devt_lock, SOFTIRQ_ALL_MASK);
 	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_NOWAIT);
-	spin_unlock_bh(&ext_devt_lock);
+	spin_unlock_bh(&ext_devt_lock, bh);
 
 	idr_preload_end();
 	if (idx < 0)
@@ -508,13 +509,14 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
  */
 void blk_free_devt(dev_t devt)
 {
+	unsigned int bh;
 	if (devt == MKDEV(0, 0))
 		return;
 
 	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
-		spin_lock_bh(&ext_devt_lock);
+		bh = spin_lock_bh(&ext_devt_lock, SOFTIRQ_ALL_MASK);
 		idr_remove(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		spin_unlock_bh(&ext_devt_lock);
+		spin_unlock_bh(&ext_devt_lock, bh);
 	}
 }
 
@@ -817,6 +819,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
  */
 struct gendisk *get_gendisk(dev_t devt, int *partno)
 {
+	unsigned int bh;
 	struct gendisk *disk = NULL;
 
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
@@ -828,13 +831,13 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	} else {
 		struct hd_struct *part;
 
-		spin_lock_bh(&ext_devt_lock);
+		bh = spin_lock_bh(&ext_devt_lock, SOFTIRQ_ALL_MASK);
 		part = idr_find(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
 		if (part && get_disk_and_module(part_to_disk(part))) {
 			*partno = part->partno;
 			disk = part_to_disk(part);
 		}
-		spin_unlock_bh(&ext_devt_lock);
+		spin_unlock_bh(&ext_devt_lock, bh);
 	}
 
 	if (!disk)
diff --git a/crypto/ansi_cprng.c b/crypto/ansi_cprng.c
index eff337c..6ecc1a1 100644
--- a/crypto/ansi_cprng.c
+++ b/crypto/ansi_cprng.c
@@ -186,12 +186,13 @@ static int _get_more_prng_bytes(struct prng_context *ctx, int cont_test)
 static int get_prng_bytes(char *buf, size_t nbytes, struct prng_context *ctx,
 				int do_cont_test)
 {
+	unsigned int bh;
 	unsigned char *ptr = buf;
 	unsigned int byte_count = (unsigned int)nbytes;
 	int err;
 
 
-	spin_lock_bh(&ctx->prng_lock);
+	bh = spin_lock_bh(&ctx->prng_lock, SOFTIRQ_ALL_MASK);
 
 	err = -EINVAL;
 	if (ctx->flags & PRNG_NEED_RESET)
@@ -267,7 +268,7 @@ static int get_prng_bytes(char *buf, size_t nbytes, struct prng_context *ctx,
 		goto remainder;
 
 done:
-	spin_unlock_bh(&ctx->prng_lock);
+	spin_unlock_bh(&ctx->prng_lock, bh);
 	dbgprint(KERN_CRIT "returning %d from get_prng_bytes in context %p\n",
 		err, ctx);
 	return err;
@@ -282,10 +283,11 @@ static int reset_prng_context(struct prng_context *ctx,
 			      const unsigned char *key, size_t klen,
 			      const unsigned char *V, const unsigned char *DT)
 {
+	unsigned int bh;
 	int ret;
 	const unsigned char *prng_key;
 
-	spin_lock_bh(&ctx->prng_lock);
+	bh = spin_lock_bh(&ctx->prng_lock, SOFTIRQ_ALL_MASK);
 	ctx->flags |= PRNG_NEED_RESET;
 
 	prng_key = (key != NULL) ? key : (unsigned char *)DEFAULT_PRNG_KEY;
@@ -318,7 +320,7 @@ static int reset_prng_context(struct prng_context *ctx,
 	ret = 0;
 	ctx->flags &= ~PRNG_NEED_RESET;
 out:
-	spin_unlock_bh(&ctx->prng_lock);
+	spin_unlock_bh(&ctx->prng_lock, bh);
 	return ret;
 }
 
diff --git a/crypto/mcryptd.c b/crypto/mcryptd.c
index 1c8e1b8..911a3f7 100644
--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -150,6 +150,7 @@ static void mcryptd_opportunistic_flush(void)
  */
 static void mcryptd_queue_worker(struct work_struct *work)
 {
+	unsigned int bh;
 	struct mcryptd_cpu_queue *cpu_queue;
 	struct crypto_async_request *req, *backlog;
 	int i;
@@ -163,10 +164,10 @@ static void mcryptd_queue_worker(struct work_struct *work)
 	i = 0;
 	while (i < MCRYPTD_BATCH || single_task_running()) {
 
-		spin_lock_bh(&cpu_queue->q_lock);
+		bh = spin_lock_bh(&cpu_queue->q_lock, SOFTIRQ_ALL_MASK);
 		backlog = crypto_get_backlog(&cpu_queue->queue);
 		req = crypto_dequeue_request(&cpu_queue->queue);
-		spin_unlock_bh(&cpu_queue->q_lock);
+		spin_unlock_bh(&cpu_queue->q_lock, bh);
 
 		if (!req) {
 			mcryptd_opportunistic_flush();
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index f2c631c..50f8990 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -589,6 +589,7 @@ static int rsxx_eeh_frozen(struct pci_dev *dev)
 
 static void rsxx_eeh_failure(struct pci_dev *dev)
 {
+	unsigned int bh;
 	struct rsxx_cardinfo *card = pci_get_drvdata(dev);
 	int i;
 	int cnt = 0;
@@ -599,11 +600,11 @@ static void rsxx_eeh_failure(struct pci_dev *dev)
 	card->halt = 1;
 
 	for (i = 0; i < card->n_targets; i++) {
-		spin_lock_bh(&card->ctrl[i].queue_lock);
+		bh = spin_lock_bh(&card->ctrl[i].queue_lock, SOFTIRQ_ALL_MASK);
 		cnt = rsxx_cleanup_dma_queue(&card->ctrl[i],
 					     &card->ctrl[i].queue,
 					     COMPLETE_DMA);
-		spin_unlock_bh(&card->ctrl[i].queue_lock);
+		spin_unlock_bh(&card->ctrl[i].queue_lock, bh);
 
 		cnt += rsxx_dma_cancel(&card->ctrl[i]);
 
diff --git a/drivers/block/rsxx/cregs.c b/drivers/block/rsxx/cregs.c
index c148e83..2567387 100644
--- a/drivers/block/rsxx/cregs.c
+++ b/drivers/block/rsxx/cregs.c
@@ -167,6 +167,7 @@ static int creg_queue_cmd(struct rsxx_cardinfo *card,
 			  creg_cmd_cb callback,
 			  void *cb_private)
 {
+	unsigned int bh;
 	struct creg_cmd *cmd;
 
 	/* Don't queue stuff up if we're halted. */
@@ -194,11 +195,11 @@ static int creg_queue_cmd(struct rsxx_cardinfo *card,
 	cmd->cb_private = cb_private;
 	cmd->status	= 0;
 
-	spin_lock_bh(&card->creg_ctrl.lock);
+	bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&cmd->list, &card->creg_ctrl.queue);
 	card->creg_ctrl.q_depth++;
 	creg_kick_queue(card);
-	spin_unlock_bh(&card->creg_ctrl.lock);
+	spin_unlock_bh(&card->creg_ctrl.lock, bh);
 
 	return 0;
 }
@@ -235,6 +236,7 @@ static void creg_cmd_timed_out(struct timer_list *t)
 
 static void creg_cmd_done(struct work_struct *work)
 {
+	unsigned int bh;
 	struct rsxx_cardinfo *card;
 	struct creg_cmd *cmd;
 	int st = 0;
@@ -249,10 +251,10 @@ static void creg_cmd_done(struct work_struct *work)
 	if (del_timer_sync(&card->creg_ctrl.cmd_timer) == 0)
 		card->creg_ctrl.creg_stats.failed_cancel_timer++;
 
-	spin_lock_bh(&card->creg_ctrl.lock);
+	bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 	cmd = card->creg_ctrl.active_cmd;
 	card->creg_ctrl.active_cmd = NULL;
-	spin_unlock_bh(&card->creg_ctrl.lock);
+	spin_unlock_bh(&card->creg_ctrl.lock, bh);
 
 	if (cmd == NULL) {
 		dev_err(CARD_TO_DEV(card),
@@ -302,14 +304,15 @@ static void creg_cmd_done(struct work_struct *work)
 
 	kmem_cache_free(creg_cmd_pool, cmd);
 
-	spin_lock_bh(&card->creg_ctrl.lock);
+	bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 	card->creg_ctrl.active = 0;
 	creg_kick_queue(card);
-	spin_unlock_bh(&card->creg_ctrl.lock);
+	spin_unlock_bh(&card->creg_ctrl.lock, bh);
 }
 
 static void creg_reset(struct rsxx_cardinfo *card)
 {
+	unsigned int bh;
 	struct creg_cmd *cmd = NULL;
 	struct creg_cmd *tmp;
 	unsigned long flags;
@@ -330,7 +333,7 @@ static void creg_reset(struct rsxx_cardinfo *card)
 		"Resetting creg interface for recovery\n");
 
 	/* Cancel outstanding commands */
-	spin_lock_bh(&card->creg_ctrl.lock);
+	bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry_safe(cmd, tmp, &card->creg_ctrl.queue, list) {
 		list_del(&cmd->list);
 		card->creg_ctrl.q_depth--;
@@ -351,7 +354,7 @@ static void creg_reset(struct rsxx_cardinfo *card)
 
 		card->creg_ctrl.active = 0;
 	}
-	spin_unlock_bh(&card->creg_ctrl.lock);
+	spin_unlock_bh(&card->creg_ctrl.lock, bh);
 
 	card->creg_ctrl.reset = 0;
 	spin_lock_irqsave(&card->irq_lock, flags);
@@ -707,6 +710,7 @@ int rsxx_reg_access(struct rsxx_cardinfo *card,
 
 void rsxx_eeh_save_issued_creg(struct rsxx_cardinfo *card)
 {
+	unsigned int bh;
 	struct creg_cmd *cmd = NULL;
 
 	cmd = card->creg_ctrl.active_cmd;
@@ -715,20 +719,21 @@ void rsxx_eeh_save_issued_creg(struct rsxx_cardinfo *card)
 	if (cmd) {
 		del_timer_sync(&card->creg_ctrl.cmd_timer);
 
-		spin_lock_bh(&card->creg_ctrl.lock);
+		bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 		list_add(&cmd->list, &card->creg_ctrl.queue);
 		card->creg_ctrl.q_depth++;
 		card->creg_ctrl.active = 0;
-		spin_unlock_bh(&card->creg_ctrl.lock);
+		spin_unlock_bh(&card->creg_ctrl.lock, bh);
 	}
 }
 
 void rsxx_kick_creg_queue(struct rsxx_cardinfo *card)
 {
-	spin_lock_bh(&card->creg_ctrl.lock);
+	unsigned int bh;
+	bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 	if (!list_empty(&card->creg_ctrl.queue))
 		creg_kick_queue(card);
-	spin_unlock_bh(&card->creg_ctrl.lock);
+	spin_unlock_bh(&card->creg_ctrl.lock, bh);
 }
 
 /*------------ Initialization & Setup --------------*/
@@ -752,12 +757,13 @@ int rsxx_creg_setup(struct rsxx_cardinfo *card)
 
 void rsxx_creg_destroy(struct rsxx_cardinfo *card)
 {
+	unsigned int bh;
 	struct creg_cmd *cmd;
 	struct creg_cmd *tmp;
 	int cnt = 0;
 
 	/* Cancel outstanding commands */
-	spin_lock_bh(&card->creg_ctrl.lock);
+	bh = spin_lock_bh(&card->creg_ctrl.lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry_safe(cmd, tmp, &card->creg_ctrl.queue, list) {
 		list_del(&cmd->list);
 		if (cmd->cb)
@@ -782,7 +788,7 @@ void rsxx_creg_destroy(struct rsxx_cardinfo *card)
 			"Canceled active creg command\n");
 		kmem_cache_free(creg_cmd_pool, cmd);
 	}
-	spin_unlock_bh(&card->creg_ctrl.lock);
+	spin_unlock_bh(&card->creg_ctrl.lock, bh);
 
 	cancel_work_sync(&card->creg_ctrl.done_work);
 }
diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index 8fbc1bf..ab6ac00 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -275,14 +275,15 @@ int rsxx_cleanup_dma_queue(struct rsxx_dma_ctrl *ctrl,
 static void rsxx_requeue_dma(struct rsxx_dma_ctrl *ctrl,
 				 struct rsxx_dma *dma)
 {
+	unsigned int bh;
 	/*
 	 * Requeued DMAs go to the front of the queue so they are issued
 	 * first.
 	 */
-	spin_lock_bh(&ctrl->queue_lock);
+	bh = spin_lock_bh(&ctrl->queue_lock, SOFTIRQ_ALL_MASK);
 	ctrl->stats.sw_q_depth++;
 	list_add(&dma->list, &ctrl->queue);
-	spin_unlock_bh(&ctrl->queue_lock);
+	spin_unlock_bh(&ctrl->queue_lock, bh);
 }
 
 static void rsxx_handle_dma_error(struct rsxx_dma_ctrl *ctrl,
@@ -395,6 +396,7 @@ static void dma_engine_stalled(struct timer_list *t)
 
 static void rsxx_issue_dmas(struct rsxx_dma_ctrl *ctrl)
 {
+	unsigned int bh;
 	struct rsxx_dma *dma;
 	int tag;
 	int cmds_pending = 0;
@@ -408,22 +410,22 @@ static void rsxx_issue_dmas(struct rsxx_dma_ctrl *ctrl)
 		return;
 
 	while (1) {
-		spin_lock_bh(&ctrl->queue_lock);
+		bh = spin_lock_bh(&ctrl->queue_lock, SOFTIRQ_ALL_MASK);
 		if (list_empty(&ctrl->queue)) {
-			spin_unlock_bh(&ctrl->queue_lock);
+			spin_unlock_bh(&ctrl->queue_lock, bh);
 			break;
 		}
-		spin_unlock_bh(&ctrl->queue_lock);
+		spin_unlock_bh(&ctrl->queue_lock, bh);
 
 		tag = pop_tracker(ctrl->trackers);
 		if (tag == -1)
 			break;
 
-		spin_lock_bh(&ctrl->queue_lock);
+		bh = spin_lock_bh(&ctrl->queue_lock, SOFTIRQ_ALL_MASK);
 		dma = list_entry(ctrl->queue.next, struct rsxx_dma, list);
 		list_del(&dma->list);
 		ctrl->stats.sw_q_depth--;
-		spin_unlock_bh(&ctrl->queue_lock);
+		spin_unlock_bh(&ctrl->queue_lock, bh);
 
 		/*
 		 * This will catch any DMAs that slipped in right before the
@@ -507,6 +509,7 @@ static void rsxx_issue_dmas(struct rsxx_dma_ctrl *ctrl)
 
 static void rsxx_dma_done(struct rsxx_dma_ctrl *ctrl)
 {
+	unsigned int bh;
 	struct rsxx_dma *dma;
 	unsigned long flags;
 	u16 count;
@@ -583,10 +586,10 @@ static void rsxx_dma_done(struct rsxx_dma_ctrl *ctrl)
 	rsxx_enable_ier(ctrl->card, CR_INTR_DMA(ctrl->id));
 	spin_unlock_irqrestore(&ctrl->card->irq_lock, flags);
 
-	spin_lock_bh(&ctrl->queue_lock);
+	bh = spin_lock_bh(&ctrl->queue_lock, SOFTIRQ_ALL_MASK);
 	if (ctrl->stats.sw_q_depth)
 		queue_work(ctrl->issue_wq, &ctrl->issue_dma_work);
-	spin_unlock_bh(&ctrl->queue_lock);
+	spin_unlock_bh(&ctrl->queue_lock, bh);
 }
 
 static void rsxx_schedule_issue(struct work_struct *work)
@@ -683,6 +686,7 @@ blk_status_t rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 			   rsxx_dma_cb cb,
 			   void *cb_data)
 {
+	unsigned int bh;
 	struct list_head dma_list[RSXX_MAX_TARGETS];
 	struct bio_vec bvec;
 	struct bvec_iter iter;
@@ -753,10 +757,10 @@ blk_status_t rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 
 	for (i = 0; i < card->n_targets; i++) {
 		if (!list_empty(&dma_list[i])) {
-			spin_lock_bh(&card->ctrl[i].queue_lock);
+			bh = spin_lock_bh(&card->ctrl[i].queue_lock, SOFTIRQ_ALL_MASK);
 			card->ctrl[i].stats.sw_q_depth += dma_cnt[i];
 			list_splice_tail(&dma_list[i], &card->ctrl[i].queue);
-			spin_unlock_bh(&card->ctrl[i].queue_lock);
+			spin_unlock_bh(&card->ctrl[i].queue_lock, bh);
 
 			queue_work(card->ctrl[i].issue_wq,
 				   &card->ctrl[i].issue_dma_work);
@@ -995,6 +999,7 @@ int rsxx_dma_cancel(struct rsxx_dma_ctrl *ctrl)
 
 void rsxx_dma_destroy(struct rsxx_cardinfo *card)
 {
+	unsigned int bh;
 	struct rsxx_dma_ctrl *ctrl;
 	int i;
 
@@ -1015,9 +1020,9 @@ void rsxx_dma_destroy(struct rsxx_cardinfo *card)
 			del_timer_sync(&ctrl->activity_timer);
 
 		/* Clean up the DMA queue */
-		spin_lock_bh(&ctrl->queue_lock);
+		bh = spin_lock_bh(&ctrl->queue_lock, SOFTIRQ_ALL_MASK);
 		rsxx_cleanup_dma_queue(ctrl, &ctrl->queue, COMPLETE_DMA);
-		spin_unlock_bh(&ctrl->queue_lock);
+		spin_unlock_bh(&ctrl->queue_lock, bh);
 
 		rsxx_dma_cancel(ctrl);
 
@@ -1032,6 +1037,7 @@ void rsxx_dma_destroy(struct rsxx_cardinfo *card)
 
 int rsxx_eeh_save_issued_dmas(struct rsxx_cardinfo *card)
 {
+	unsigned int bh;
 	int i;
 	int j;
 	int cnt;
@@ -1071,13 +1077,13 @@ int rsxx_eeh_save_issued_dmas(struct rsxx_cardinfo *card)
 			cnt++;
 		}
 
-		spin_lock_bh(&card->ctrl[i].queue_lock);
+		bh = spin_lock_bh(&card->ctrl[i].queue_lock, SOFTIRQ_ALL_MASK);
 		list_splice(&issued_dmas[i], &card->ctrl[i].queue);
 
 		atomic_sub(cnt, &card->ctrl[i].stats.hw_q_depth);
 		card->ctrl[i].stats.sw_q_depth += cnt;
 		card->ctrl[i].e_cnt = 0;
-		spin_unlock_bh(&card->ctrl[i].queue_lock);
+		spin_unlock_bh(&card->ctrl[i].queue_lock, bh);
 	}
 
 	kfree(issued_dmas);
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 5c7fb8c..33d25af 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -410,6 +410,7 @@ static int add_bio(struct cardinfo *card)
 
 static void process_page(unsigned long data)
 {
+	unsigned int bh;
 	/* check if any of the requests in the page are DMA_COMPLETE,
 	 * and deal with them appropriately.
 	 * If we find a descriptor without DMA_COMPLETE in the semaphore, then
@@ -421,7 +422,7 @@ static void process_page(unsigned long data)
 	struct cardinfo *card = (struct cardinfo *)data;
 	unsigned int dma_status = card->dma_status;
 
-	spin_lock_bh(&card->lock);
+	bh = spin_lock_bh(&card->lock, SOFTIRQ_ALL_MASK);
 	if (card->Active < 0)
 		goto out_unlock;
 	page = &card->mm_pages[card->Active];
@@ -496,7 +497,7 @@ static void process_page(unsigned long data)
 		mm_start_io(card);
 	}
  out_unlock:
-	spin_unlock_bh(&card->lock);
+	spin_unlock_bh(&card->lock, bh);
 
 	while (return_bio) {
 		struct bio *bio = return_bio;
@@ -720,17 +721,18 @@ static void check_batteries(struct cardinfo *card)
 
 static void check_all_batteries(struct timer_list *unused)
 {
+	unsigned int bh;
 	int i;
 
 	for (i = 0; i < num_cards; i++)
 		if (!(cards[i].flags & UM_FLAG_NO_BATT)) {
 			struct cardinfo *card = &cards[i];
-			spin_lock_bh(&card->lock);
+			bh = spin_lock_bh(&card->lock, SOFTIRQ_ALL_MASK);
 			if (card->Active >= 0)
 				card->check_batteries = 1;
 			else
 				check_batteries(card);
-			spin_unlock_bh(&card->lock);
+			spin_unlock_bh(&card->lock, bh);
 		}
 
 	init_battery_timer();
diff --git a/drivers/connector/cn_queue.c b/drivers/connector/cn_queue.c
index 9c54fdf..1a94afb 100644
--- a/drivers/connector/cn_queue.c
+++ b/drivers/connector/cn_queue.c
@@ -75,6 +75,7 @@ int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 			  void (*callback)(struct cn_msg *,
 					   struct netlink_skb_parms *))
 {
+	unsigned int bh;
 	struct cn_callback_entry *cbq, *__cbq;
 	int found = 0;
 
@@ -82,7 +83,7 @@ int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 	if (!cbq)
 		return -ENOMEM;
 
-	spin_lock_bh(&dev->queue_lock);
+	bh = spin_lock_bh(&dev->queue_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(__cbq, &dev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->id.id, id)) {
 			found = 1;
@@ -91,7 +92,7 @@ int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 	}
 	if (!found)
 		list_add_tail(&cbq->callback_entry, &dev->queue_list);
-	spin_unlock_bh(&dev->queue_lock);
+	spin_unlock_bh(&dev->queue_lock, bh);
 
 	if (found) {
 		cn_queue_release_callback(cbq);
@@ -106,10 +107,11 @@ int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 
 void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id)
 {
+	unsigned int bh;
 	struct cn_callback_entry *cbq, *n;
 	int found = 0;
 
-	spin_lock_bh(&dev->queue_lock);
+	bh = spin_lock_bh(&dev->queue_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
 		if (cn_cb_equal(&cbq->id.id, id)) {
 			list_del(&cbq->callback_entry);
@@ -117,7 +119,7 @@ void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id)
 			break;
 		}
 	}
-	spin_unlock_bh(&dev->queue_lock);
+	spin_unlock_bh(&dev->queue_lock, bh);
 
 	if (found)
 		cn_queue_release_callback(cbq);
@@ -143,12 +145,13 @@ struct cn_queue_dev *cn_queue_alloc_dev(const char *name, struct sock *nls)
 
 void cn_queue_free_dev(struct cn_queue_dev *dev)
 {
+	unsigned int bh;
 	struct cn_callback_entry *cbq, *n;
 
-	spin_lock_bh(&dev->queue_lock);
+	bh = spin_lock_bh(&dev->queue_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry)
 		list_del(&cbq->callback_entry);
-	spin_unlock_bh(&dev->queue_lock);
+	spin_unlock_bh(&dev->queue_lock, bh);
 
 	while (atomic_read(&dev->refcnt)) {
 		pr_info("Waiting for %s to become free: refcnt=%d.\n",
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index eeb7d31..b9adef9 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -74,6 +74,7 @@ static int cn_already_initialized;
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
 	gfp_t gfp_mask)
 {
+	unsigned int bh;
 	struct cn_callback_entry *__cbq;
 	unsigned int size;
 	struct sk_buff *skb;
@@ -86,7 +87,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
 	if (portid || __group) {
 		group = __group;
 	} else {
-		spin_lock_bh(&dev->cbdev->queue_lock);
+		bh = spin_lock_bh(&dev->cbdev->queue_lock, SOFTIRQ_ALL_MASK);
 		list_for_each_entry(__cbq, &dev->cbdev->queue_list,
 				    callback_entry) {
 			if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
@@ -95,7 +96,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
 				break;
 			}
 		}
-		spin_unlock_bh(&dev->cbdev->queue_lock);
+		spin_unlock_bh(&dev->cbdev->queue_lock, bh);
 
 		if (!found)
 			return -ENODEV;
@@ -143,6 +144,7 @@ EXPORT_SYMBOL_GPL(cn_netlink_send);
  */
 static int cn_call_callback(struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct nlmsghdr *nlh;
 	struct cn_callback_entry *i, *cbq = NULL;
 	struct cn_dev *dev = &cdev;
@@ -155,7 +157,7 @@ static int cn_call_callback(struct sk_buff *skb)
 	if (nlh->nlmsg_len < NLMSG_HDRLEN + sizeof(struct cn_msg) + msg->len)
 		return -EINVAL;
 
-	spin_lock_bh(&dev->cbdev->queue_lock);
+	bh = spin_lock_bh(&dev->cbdev->queue_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(i, &dev->cbdev->queue_list, callback_entry) {
 		if (cn_cb_equal(&i->id.id, &msg->id)) {
 			refcount_inc(&i->refcnt);
@@ -163,7 +165,7 @@ static int cn_call_callback(struct sk_buff *skb)
 			break;
 		}
 	}
-	spin_unlock_bh(&dev->cbdev->queue_lock);
+	spin_unlock_bh(&dev->cbdev->queue_lock, bh);
 
 	if (cbq != NULL) {
 		cbq->callback(msg, nsp);
@@ -242,12 +244,13 @@ EXPORT_SYMBOL_GPL(cn_del_callback);
 
 static int __maybe_unused cn_proc_show(struct seq_file *m, void *v)
 {
+	unsigned int bh;
 	struct cn_queue_dev *dev = cdev.cbdev;
 	struct cn_callback_entry *cbq;
 
 	seq_printf(m, "Name            ID\n");
 
-	spin_lock_bh(&dev->queue_lock);
+	bh = spin_lock_bh(&dev->queue_lock, SOFTIRQ_ALL_MASK);
 
 	list_for_each_entry(cbq, &dev->queue_list, callback_entry) {
 		seq_printf(m, "%-15s %u:%u\n",
@@ -256,7 +259,7 @@ static int __maybe_unused cn_proc_show(struct seq_file *m, void *v)
 			   cbq->id.id.val);
 	}
 
-	spin_unlock_bh(&dev->queue_lock);
+	spin_unlock_bh(&dev->queue_lock, bh);
 
 	return 0;
 }
diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 801aeab..aaee981 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -423,10 +423,11 @@ static inline size_t atmel_aes_padlen(size_t len, size_t block_size)
 
 static struct atmel_aes_dev *atmel_aes_find_dev(struct atmel_aes_base_ctx *ctx)
 {
+	unsigned int bh;
 	struct atmel_aes_dev *aes_dd = NULL;
 	struct atmel_aes_dev *tmp;
 
-	spin_lock_bh(&atmel_aes.lock);
+	bh = spin_lock_bh(&atmel_aes.lock, SOFTIRQ_ALL_MASK);
 	if (!ctx->dd) {
 		list_for_each_entry(tmp, &atmel_aes.dev_list, list) {
 			aes_dd = tmp;
@@ -437,7 +438,7 @@ static struct atmel_aes_dev *atmel_aes_find_dev(struct atmel_aes_base_ctx *ctx)
 		aes_dd = ctx->dd;
 	}
 
-	spin_unlock_bh(&atmel_aes.lock);
+	spin_unlock_bh(&atmel_aes.lock, bh);
 
 	return aes_dd;
 }
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 8a19df2..6c0a754 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -406,10 +406,11 @@ static void atmel_sha_fill_padding(struct atmel_sha_reqctx *ctx, int length)
 
 static struct atmel_sha_dev *atmel_sha_find_dev(struct atmel_sha_ctx *tctx)
 {
+	unsigned int bh;
 	struct atmel_sha_dev *dd = NULL;
 	struct atmel_sha_dev *tmp;
 
-	spin_lock_bh(&atmel_sha.lock);
+	bh = spin_lock_bh(&atmel_sha.lock, SOFTIRQ_ALL_MASK);
 	if (!tctx->dd) {
 		list_for_each_entry(tmp, &atmel_sha.dev_list, list) {
 			dd = tmp;
@@ -420,7 +421,7 @@ static struct atmel_sha_dev *atmel_sha_find_dev(struct atmel_sha_ctx *tctx)
 		dd = tctx->dd;
 	}
 
-	spin_unlock_bh(&atmel_sha.lock);
+	spin_unlock_bh(&atmel_sha.lock, bh);
 
 	return dd;
 }
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 97b0423..db2a3b1 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -198,10 +198,11 @@ static void atmel_tdes_write_n(struct atmel_tdes_dev *dd, u32 offset,
 
 static struct atmel_tdes_dev *atmel_tdes_find_dev(struct atmel_tdes_ctx *ctx)
 {
+	unsigned int bh;
 	struct atmel_tdes_dev *tdes_dd = NULL;
 	struct atmel_tdes_dev *tmp;
 
-	spin_lock_bh(&atmel_tdes.lock);
+	bh = spin_lock_bh(&atmel_tdes.lock, SOFTIRQ_ALL_MASK);
 	if (!ctx->dd) {
 		list_for_each_entry(tmp, &atmel_tdes.dev_list, list) {
 			tdes_dd = tmp;
@@ -211,7 +212,7 @@ static struct atmel_tdes_dev *atmel_tdes_find_dev(struct atmel_tdes_ctx *ctx)
 	} else {
 		tdes_dd = ctx->dd;
 	}
-	spin_unlock_bh(&atmel_tdes.lock);
+	spin_unlock_bh(&atmel_tdes.lock, bh);
 
 	return tdes_dd;
 }
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 7f07a50..5912232 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -459,10 +459,11 @@ static inline bool artpec6_crypto_busy(void)
 
 static int artpec6_crypto_submit(struct artpec6_crypto_req_common *req)
 {
+	unsigned int bh;
 	struct artpec6_crypto *ac = dev_get_drvdata(artpec6_crypto_dev);
 	int ret = -EBUSY;
 
-	spin_lock_bh(&ac->queue_lock);
+	bh = spin_lock_bh(&ac->queue_lock, SOFTIRQ_ALL_MASK);
 
 	if (!artpec6_crypto_busy()) {
 		list_add_tail(&req->list, &ac->pending);
@@ -474,7 +475,7 @@ static int artpec6_crypto_submit(struct artpec6_crypto_req_common *req)
 		artpec6_crypto_common_destroy(req);
 	}
 
-	spin_unlock_bh(&ac->queue_lock);
+	spin_unlock_bh(&ac->queue_lock, bh);
 
 	return ret;
 }
@@ -2084,6 +2085,7 @@ static void artpec6_crypto_timeout(struct timer_list *t)
 
 static void artpec6_crypto_task(unsigned long data)
 {
+	unsigned int bh;
 	struct artpec6_crypto *ac = (struct artpec6_crypto *)data;
 	struct artpec6_crypto_req_common *req;
 	struct artpec6_crypto_req_common *n;
@@ -2093,7 +2095,7 @@ static void artpec6_crypto_task(unsigned long data)
 		return;
 	}
 
-	spin_lock_bh(&ac->queue_lock);
+	bh = spin_lock_bh(&ac->queue_lock, SOFTIRQ_ALL_MASK);
 
 	list_for_each_entry_safe(req, n, &ac->pending, list) {
 		struct artpec6_crypto_dma_descriptors *dma = req->dma;
@@ -2132,7 +2134,7 @@ static void artpec6_crypto_task(unsigned long data)
 
 	artpec6_crypto_process_queue(ac);
 
-	spin_unlock_bh(&ac->queue_lock);
+	spin_unlock_bh(&ac->queue_lock, bh);
 }
 
 static void artpec6_crypto_complete_crypto(struct crypto_async_request *req)
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index acdd720..e3b83f3 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -327,6 +327,7 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 				u32 status, void *areq),
 		    void *areq)
 {
+	unsigned int bh;
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	struct caam_jrentry_info *head_entry;
 	int head, tail, desc_size;
@@ -339,14 +340,14 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 		return -EIO;
 	}
 
-	spin_lock_bh(&jrp->inplock);
+	bh = spin_lock_bh(&jrp->inplock, SOFTIRQ_ALL_MASK);
 
 	head = jrp->head;
 	tail = READ_ONCE(jrp->tail);
 
 	if (!rd_reg32(&jrp->rregs->inpring_avail) ||
 	    CIRC_SPACE(head, tail, JOBR_DEPTH) <= 0) {
-		spin_unlock_bh(&jrp->inplock);
+		spin_unlock_bh(&jrp->inplock, bh);
 		dma_unmap_single(dev, desc_dma, desc_size, DMA_TO_DEVICE);
 		return -EBUSY;
 	}
@@ -379,7 +380,7 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 
 	wr_reg32(&jrp->rregs->inpring_jobadd, 1);
 
-	spin_unlock_bh(&jrp->inplock);
+	spin_unlock_bh(&jrp->inplock, bh);
 
 	return 0;
 }
diff --git a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c b/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
index b0ba433..f988e66 100644
--- a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
+++ b/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
@@ -342,6 +342,7 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 					 struct pending_qinfo *pqinfo,
 					 int qno)
 {
+	unsigned int bh;
 	struct pci_dev *pdev = cptvf->pdev;
 	struct pending_queue *pqueue = &pqinfo->queue[qno];
 	struct pending_entry *pentry = NULL;
@@ -350,10 +351,10 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 	unsigned char ccode;
 
 	while (1) {
-		spin_lock_bh(&pqueue->lock);
+		bh = spin_lock_bh(&pqueue->lock, SOFTIRQ_ALL_MASK);
 		pentry = &pqueue->head[pqueue->front];
 		if (unlikely(!pentry->busy)) {
-			spin_unlock_bh(&pqueue->lock);
+			spin_unlock_bh(&pqueue->lock, bh);
 			break;
 		}
 
@@ -361,7 +362,7 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 		if (unlikely(!info)) {
 			dev_err(&pdev->dev, "Pending Entry post arg NULL\n");
 			pending_queue_inc_front(pqinfo, qno);
-			spin_unlock_bh(&pqueue->lock);
+			spin_unlock_bh(&pqueue->lock, bh);
 			continue;
 		}
 
@@ -378,7 +379,7 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 			pentry->post_arg = NULL;
 			pending_queue_inc_front(pqinfo, qno);
 			do_request_cleanup(cptvf, info);
-			spin_unlock_bh(&pqueue->lock);
+			spin_unlock_bh(&pqueue->lock, bh);
 			break;
 		} else if (status->s.compcode == COMPLETION_CODE_INIT) {
 			/* check for timeout */
@@ -392,14 +393,14 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 				pentry->post_arg = NULL;
 				pending_queue_inc_front(pqinfo, qno);
 				do_request_cleanup(cptvf, info);
-				spin_unlock_bh(&pqueue->lock);
+				spin_unlock_bh(&pqueue->lock, bh);
 				break;
 			} else if ((*info->alternate_caddr ==
 				(~COMPLETION_CODE_INIT)) &&
 				(info->extra_time < TIME_IN_RESET_COUNT)) {
 				info->time_in = jiffies;
 				info->extra_time++;
-				spin_unlock_bh(&pqueue->lock);
+				spin_unlock_bh(&pqueue->lock, bh);
 				break;
 			}
 		}
@@ -409,7 +410,7 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 		pentry->post_arg = NULL;
 		atomic64_dec((&pqueue->pending_count));
 		pending_queue_inc_front(pqinfo, qno);
-		spin_unlock_bh(&pqueue->lock);
+		spin_unlock_bh(&pqueue->lock, bh);
 
 		do_post_process(info->cptvf, info);
 		/*
@@ -422,6 +423,7 @@ static inline void process_pending_queue(struct cpt_vf *cptvf,
 
 int process_request(struct cpt_vf *cptvf, struct cpt_request_info *req)
 {
+	unsigned int bh;
 	int ret = 0, clear = 0, queue = 0;
 	struct cpt_info_buffer *info = NULL;
 	struct cptvf_request *cpt_req = NULL;
@@ -500,10 +502,10 @@ int process_request(struct cpt_vf *cptvf, struct cpt_request_info *req)
 	}
 
 get_pending_entry:
-	spin_lock_bh(&pqueue->lock);
+	bh = spin_lock_bh(&pqueue->lock, SOFTIRQ_ALL_MASK);
 	pentry = get_free_pending_entry(pqueue, cptvf->pqinfo.qlen);
 	if (unlikely(!pentry)) {
-		spin_unlock_bh(&pqueue->lock);
+		spin_unlock_bh(&pqueue->lock, bh);
 		if (clear == 0) {
 			process_pending_queue(cptvf, &cptvf->pqinfo, queue);
 			clear = 1;
@@ -541,7 +543,7 @@ int process_request(struct cpt_vf *cptvf, struct cpt_request_info *req)
 	cptinst.s.ei3 = vq_cmd.cptr.u64;
 
 	ret = send_cpt_command(cptvf, &cptinst, queue);
-	spin_unlock_bh(&pqueue->lock);
+	spin_unlock_bh(&pqueue->lock, bh);
 	if (unlikely(ret)) {
 		dev_err(&pdev->dev, "Send command failed for AE\n");
 		ret = -EFAULT;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
index 4a362fc..b6cf94f 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -380,31 +380,34 @@ static inline int softreq_map_iobuf(struct nitrox_softreq *sr,
 static inline void backlog_list_add(struct nitrox_softreq *sr,
 				    struct nitrox_cmdq *cmdq)
 {
+	unsigned int bh;
 	INIT_LIST_HEAD(&sr->backlog);
 
-	spin_lock_bh(&cmdq->backlog_lock);
+	bh = spin_lock_bh(&cmdq->backlog_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&sr->backlog, &cmdq->backlog_head);
 	atomic_inc(&cmdq->backlog_count);
 	atomic_set(&sr->status, REQ_BACKLOG);
-	spin_unlock_bh(&cmdq->backlog_lock);
+	spin_unlock_bh(&cmdq->backlog_lock, bh);
 }
 
 static inline void response_list_add(struct nitrox_softreq *sr,
 				     struct nitrox_cmdq *cmdq)
 {
+	unsigned int bh;
 	INIT_LIST_HEAD(&sr->response);
 
-	spin_lock_bh(&cmdq->response_lock);
+	bh = spin_lock_bh(&cmdq->response_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&sr->response, &cmdq->response_head);
-	spin_unlock_bh(&cmdq->response_lock);
+	spin_unlock_bh(&cmdq->response_lock, bh);
 }
 
 static inline void response_list_del(struct nitrox_softreq *sr,
 				     struct nitrox_cmdq *cmdq)
 {
-	spin_lock_bh(&cmdq->response_lock);
+	unsigned int bh;
+	bh = spin_lock_bh(&cmdq->response_lock, SOFTIRQ_ALL_MASK);
 	list_del(&sr->response);
-	spin_unlock_bh(&cmdq->response_lock);
+	spin_unlock_bh(&cmdq->response_lock, bh);
 }
 
 static struct nitrox_softreq *
@@ -435,11 +438,12 @@ static inline bool cmdq_full(struct nitrox_cmdq *cmdq, int qlen)
 static void post_se_instr(struct nitrox_softreq *sr,
 			  struct nitrox_cmdq *cmdq)
 {
+	unsigned int bh;
 	struct nitrox_device *ndev = sr->ndev;
 	int idx;
 	u8 *ent;
 
-	spin_lock_bh(&cmdq->cmdq_lock);
+	bh = spin_lock_bh(&cmdq->cmdq_lock, SOFTIRQ_ALL_MASK);
 
 	idx = cmdq->write_idx;
 	/* copy the instruction */
@@ -459,11 +463,12 @@ static void post_se_instr(struct nitrox_softreq *sr,
 
 	cmdq->write_idx = incr_index(idx, 1, ndev->qlen);
 
-	spin_unlock_bh(&cmdq->cmdq_lock);
+	spin_unlock_bh(&cmdq->cmdq_lock, bh);
 }
 
 static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 {
+	unsigned int bh;
 	struct nitrox_device *ndev = cmdq->ndev;
 	struct nitrox_softreq *sr, *tmp;
 	int ret = 0;
@@ -471,7 +476,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 	if (!atomic_read(&cmdq->backlog_count))
 		return 0;
 
-	spin_lock_bh(&cmdq->backlog_lock);
+	bh = spin_lock_bh(&cmdq->backlog_lock, SOFTIRQ_ALL_MASK);
 
 	list_for_each_entry_safe(sr, tmp, &cmdq->backlog_head, backlog) {
 		struct skcipher_request *skreq;
@@ -494,7 +499,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 		/* backlog requests are posted, wakeup with -EINPROGRESS */
 		skcipher_request_complete(skreq, -EINPROGRESS);
 	}
-	spin_unlock_bh(&cmdq->backlog_lock);
+	spin_unlock_bh(&cmdq->backlog_lock, bh);
 
 	return ret;
 }
diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree/cc_request_mgr.c
index 83a8aaae..4c0c135 100644
--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -335,12 +335,13 @@ static int cc_do_send_request(struct cc_drvdata *drvdata,
 static void cc_enqueue_backlog(struct cc_drvdata *drvdata,
 			       struct cc_bl_item *bli)
 {
+	unsigned int bh;
 	struct cc_req_mgr_handle *mgr = drvdata->request_mgr_handle;
 
-	spin_lock_bh(&mgr->bl_lock);
+	bh = spin_lock_bh(&mgr->bl_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&bli->list, &mgr->backlog);
 	++mgr->bl_len;
-	spin_unlock_bh(&mgr->bl_lock);
+	spin_unlock_bh(&mgr->bl_lock, bh);
 	tasklet_schedule(&mgr->comptask);
 }
 
@@ -412,6 +413,7 @@ int cc_send_request(struct cc_drvdata *drvdata, struct cc_crypto_req *cc_req,
 		    struct cc_hw_desc *desc, unsigned int len,
 		    struct crypto_async_request *req)
 {
+	unsigned int bh;
 	int rc;
 	struct cc_req_mgr_handle *mgr = drvdata->request_mgr_handle;
 	bool ivgen = !!cc_req->ivgen_dma_addr_len;
@@ -427,7 +429,7 @@ int cc_send_request(struct cc_drvdata *drvdata, struct cc_crypto_req *cc_req,
 		return rc;
 	}
 
-	spin_lock_bh(&mgr->hw_lock);
+	bh = spin_lock_bh(&mgr->hw_lock, SOFTIRQ_ALL_MASK);
 	rc = cc_queues_status(drvdata, mgr, total_len);
 
 #ifdef CC_DEBUG_FORCE_BACKLOG
@@ -436,7 +438,7 @@ int cc_send_request(struct cc_drvdata *drvdata, struct cc_crypto_req *cc_req,
 #endif /* CC_DEBUG_FORCE_BACKLOG */
 
 	if (rc == -ENOSPC && backlog_ok) {
-		spin_unlock_bh(&mgr->hw_lock);
+		spin_unlock_bh(&mgr->hw_lock, bh);
 
 		bli = kmalloc(sizeof(*bli), flags);
 		if (!bli) {
@@ -456,7 +458,7 @@ int cc_send_request(struct cc_drvdata *drvdata, struct cc_crypto_req *cc_req,
 		rc = cc_do_send_request(drvdata, cc_req, desc, len, false,
 					ivgen);
 
-	spin_unlock_bh(&mgr->hw_lock);
+	spin_unlock_bh(&mgr->hw_lock, bh);
 	return rc;
 }
 
@@ -464,6 +466,7 @@ int cc_send_sync_request(struct cc_drvdata *drvdata,
 			 struct cc_crypto_req *cc_req, struct cc_hw_desc *desc,
 			 unsigned int len)
 {
+	unsigned int bh;
 	int rc;
 	struct device *dev = drvdata_to_dev(drvdata);
 	struct cc_req_mgr_handle *mgr = drvdata->request_mgr_handle;
@@ -479,13 +482,13 @@ int cc_send_sync_request(struct cc_drvdata *drvdata,
 	}
 
 	while (true) {
-		spin_lock_bh(&mgr->hw_lock);
+		bh = spin_lock_bh(&mgr->hw_lock, SOFTIRQ_ALL_MASK);
 		rc = cc_queues_status(drvdata, mgr, len + 1);
 
 		if (!rc)
 			break;
 
-		spin_unlock_bh(&mgr->hw_lock);
+		spin_unlock_bh(&mgr->hw_lock, bh);
 		if (rc != -EAGAIN) {
 			cc_pm_put_suspend(dev);
 			return rc;
@@ -495,7 +498,7 @@ int cc_send_sync_request(struct cc_drvdata *drvdata,
 	}
 
 	rc = cc_do_send_request(drvdata, cc_req, desc, len, true, false);
-	spin_unlock_bh(&mgr->hw_lock);
+	spin_unlock_bh(&mgr->hw_lock, bh);
 
 	if (rc != -EINPROGRESS) {
 		cc_pm_put_suspend(dev);
@@ -668,12 +671,13 @@ static void comp_handler(unsigned long devarg)
 #if defined(CONFIG_PM)
 int cc_resume_req_queue(struct cc_drvdata *drvdata)
 {
+	unsigned int bh;
 	struct cc_req_mgr_handle *request_mgr_handle =
 		drvdata->request_mgr_handle;
 
-	spin_lock_bh(&request_mgr_handle->hw_lock);
+	bh = spin_lock_bh(&request_mgr_handle->hw_lock, SOFTIRQ_ALL_MASK);
 	request_mgr_handle->is_runtime_suspended = false;
-	spin_unlock_bh(&request_mgr_handle->hw_lock);
+	spin_unlock_bh(&request_mgr_handle->hw_lock, bh);
 
 	return 0;
 }
@@ -684,18 +688,19 @@ int cc_resume_req_queue(struct cc_drvdata *drvdata)
  */
 int cc_suspend_req_queue(struct cc_drvdata *drvdata)
 {
+	unsigned int bh;
 	struct cc_req_mgr_handle *request_mgr_handle =
 						drvdata->request_mgr_handle;
 
 	/* lock the send_request */
-	spin_lock_bh(&request_mgr_handle->hw_lock);
+	bh = spin_lock_bh(&request_mgr_handle->hw_lock, SOFTIRQ_ALL_MASK);
 	if (request_mgr_handle->req_queue_head !=
 	    request_mgr_handle->req_queue_tail) {
-		spin_unlock_bh(&request_mgr_handle->hw_lock);
+		spin_unlock_bh(&request_mgr_handle->hw_lock, bh);
 		return -EBUSY;
 	}
 	request_mgr_handle->is_runtime_suspended = true;
-	spin_unlock_bh(&request_mgr_handle->hw_lock);
+	spin_unlock_bh(&request_mgr_handle->hw_lock, bh);
 
 	return 0;
 }
diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 8af8c84..67bee49 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -1307,7 +1307,9 @@ static DEFINE_SPINLOCK(reap_list_lock);
  */
 DECLARE_TASK_FUNC(process_reap_list, task_param)
 {
-	spin_lock_bh(&reap_list_lock);
+	unsigned int bh;
+
+	bh = spin_lock_bh(&reap_list_lock, SOFTIRQ_ALL_MASK);
 	while (reap_list) {
 		struct sock *sk = reap_list;
 		struct chtls_sock *csk = rcu_dereference_sk_user_data(sk);
@@ -1326,7 +1328,7 @@ DECLARE_TASK_FUNC(process_reap_list, task_param)
 		sock_put(sk);
 		spin_lock(&reap_list_lock);
 	}
-	spin_unlock_bh(&reap_list_lock);
+	spin_unlock_bh(&reap_list_lock, bh);
 }
 
 static DECLARE_WORK(reap_task, process_reap_list);
@@ -1838,12 +1840,13 @@ static void send_abort_rpl(struct sock *sk, struct sk_buff *skb,
 static void t4_defer_reply(struct sk_buff *skb, struct chtls_dev *cdev,
 			   defer_handler_t handler)
 {
+	unsigned int bh;
 	DEFERRED_SKB_CB(skb)->handler = handler;
-	spin_lock_bh(&cdev->deferq.lock);
+	bh = spin_lock_bh(&cdev->deferq.lock, SOFTIRQ_ALL_MASK);
 	__skb_queue_tail(&cdev->deferq, skb);
 	if (skb_queue_len(&cdev->deferq) == 1)
 		schedule_work(&cdev->deferq_task);
-	spin_unlock_bh(&cdev->deferq.lock);
+	spin_unlock_bh(&cdev->deferq.lock, bh);
 }
 
 static void chtls_send_abort_rpl(struct sock *sk, struct sk_buff *skb,
diff --git a/drivers/crypto/chelsio/chtls/chtls_hw.c b/drivers/crypto/chelsio/chtls/chtls_hw.c
index 4909607..2fbe923 100644
--- a/drivers/crypto/chelsio/chtls/chtls_hw.c
+++ b/drivers/crypto/chelsio/chtls/chtls_hw.c
@@ -139,6 +139,7 @@ int chtls_init_kmap(struct chtls_dev *cdev, struct cxgb4_lld_info *lldi)
 
 static int get_new_keyid(struct chtls_sock *csk, u32 optname)
 {
+	unsigned int bh;
 	struct net_device *dev = csk->egress_dev;
 	struct chtls_dev *cdev = csk->cdev;
 	struct chtls_hws *hws;
@@ -148,7 +149,7 @@ static int get_new_keyid(struct chtls_sock *csk, u32 optname)
 	adap = netdev2adap(dev);
 	hws = &csk->tlshws;
 
-	spin_lock_bh(&cdev->kmap.lock);
+	bh = spin_lock_bh(&cdev->kmap.lock, SOFTIRQ_ALL_MASK);
 	keyid = find_first_zero_bit(cdev->kmap.addr, cdev->kmap.size);
 	if (keyid < cdev->kmap.size) {
 		__set_bit(keyid, cdev->kmap.addr);
@@ -160,12 +161,13 @@ static int get_new_keyid(struct chtls_sock *csk, u32 optname)
 	} else {
 		keyid = -1;
 	}
-	spin_unlock_bh(&cdev->kmap.lock);
+	spin_unlock_bh(&cdev->kmap.lock, bh);
 	return keyid;
 }
 
 void free_tls_keyid(struct sock *sk)
 {
+	unsigned int bh;
 	struct chtls_sock *csk = rcu_dereference_sk_user_data(sk);
 	struct net_device *dev = csk->egress_dev;
 	struct chtls_dev *cdev = csk->cdev;
@@ -178,7 +180,7 @@ void free_tls_keyid(struct sock *sk)
 	adap = netdev2adap(dev);
 	hws = &csk->tlshws;
 
-	spin_lock_bh(&cdev->kmap.lock);
+	bh = spin_lock_bh(&cdev->kmap.lock, SOFTIRQ_ALL_MASK);
 	if (hws->rxkey >= 0) {
 		__clear_bit(hws->rxkey, cdev->kmap.addr);
 		atomic_dec(&adap->chcr_stats.tls_key);
@@ -189,7 +191,7 @@ void free_tls_keyid(struct sock *sk)
 		atomic_dec(&adap->chcr_stats.tls_key);
 		hws->txkey = -1;
 	}
-	spin_unlock_bh(&cdev->kmap.lock);
+	spin_unlock_bh(&cdev->kmap.lock, bh);
 }
 
 unsigned int keyid_to_addr(int start_addr, int keyid)
diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
index f59b044..5816d3f 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -170,17 +170,18 @@ static void chtls_unregister_dev(struct chtls_dev *cdev)
 
 static void process_deferq(struct work_struct *task_param)
 {
+	unsigned int bh;
 	struct chtls_dev *cdev = container_of(task_param,
 				struct chtls_dev, deferq_task);
 	struct sk_buff *skb;
 
-	spin_lock_bh(&cdev->deferq.lock);
+	bh = spin_lock_bh(&cdev->deferq.lock, SOFTIRQ_ALL_MASK);
 	while ((skb = __skb_dequeue(&cdev->deferq)) != NULL) {
-		spin_unlock_bh(&cdev->deferq.lock);
+		spin_unlock_bh(&cdev->deferq.lock, bh);
 		DEFERRED_SKB_CB(skb)->handler(cdev, skb);
-		spin_lock_bh(&cdev->deferq.lock);
+		bh = spin_lock_bh(&cdev->deferq.lock, SOFTIRQ_ALL_MASK);
 	}
-	spin_unlock_bh(&cdev->deferq.lock);
+	spin_unlock_bh(&cdev->deferq.lock, bh);
 }
 
 static int chtls_get_skb(struct chtls_dev *cdev) 
-- 
2.7.4

