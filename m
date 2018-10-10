Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22344C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C6020644
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWOwkgdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C6020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeJKGg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJKGg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:36:56 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A332075C;
        Wed, 10 Oct 2018 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213152;
        bh=m1AbmUHjx4ismJNG0AP37il4SC25v3hcyR1H2kdv7+w=;
        h=From:To:Cc:Subject:Date:From;
        b=dWOwkgdV5gFfJkLp+4XU2Vyo4VK8/CBsc+7mz8R37GcQgXw21ElR232ZD9gaXRSok
         q9f1RwlkKmVrxPCNYOoNEc3/lGwLbu0Kb6bGCApliZqKrgahw9n/TK7SPbQUrcMtvH
         2p7SrnDuk7A4as4rw1QGneTixK0C8Yy0cESRvnJ0=
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
Subject: [RFC PATCH 00/30] softirq: Make softirqs soft-interruptible (+ per vector disablement)
Date:   Thu, 11 Oct 2018 01:11:47 +0200
Message-Id: <1539213137-13953-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been complaints around the fact that some softirq vectors
consume a lot of CPU at the expense of other's latency. A few solutions
have been proposed, mostly working around a fundamental design of softirqs
in Linux: a vector can not interrupt another while softirq are executing.

Also disabling the softirqs is an all-in-one toggle. It is not possible
to simply disable one vector. Therefore a section of code, that wants not
to be interrupted by a vector, must disable and delay all of them, even
though they are unrelated to the current critical code. That in turn
may induce latencies on workloads that rely on deterministic ends.

Following suggestions from the -rt team, this patchset propose to solve
this with finegrained per softirq vector disablement.

Functions such as local_bh_disable() or spin_lock_bh() now must be
passed a mask of vectors to disable. The functions return the mask of
the vectors enabled state prior to the call, that backup state is then
passed to local_bh_enable()/spin_unlock_bh() to be restored. Ie: it
follows the same logic as local_irq_save/restore():

	// Start with local_bh_disabled() == SOFTIRQ_ALL_MASK
	...
	bh = local_bh_disable(BIT(NET_RX_SOFTIRQ)) {
		bh = local_bh_disabled();
		local_bh_disabled() &= ~BIT(NET_RX_SOFTIRQ);
		// First vector disabled, inc preempt count
		preempt_count += SOFTIRQ_DISABLE_OFFSET;
		return bh;
	}
	....
		bh2 = local_bh_disable(BIT(BLOCK_SOFTIRQ)) {
			bh2 = local_bh_disabled();
			local_bh_disabled() &= ~BIT(NET_RX_SOFTIRQ);
			// No need to inc preempt count
			return bh2;
		}
		...
		local_bh_enable(bh2) {
			local_bh_disabled() = bh2;
			// No need to dec preempt count
		}
			...
	local_bh_enable(bh1) {
			local_bh_disabled() = bh;
			preempt_count -= SOFTIRQ_DISABLE_OFFSET;
	}

Similarly, the softirq processing is now re-entrant: a vector can
interrupt another, but a vector of course can not interrupt itself.

Although the diffstat is huge, some of the patches have been truncated
to fit in lkml. And I haven't yet converted every call sites, there are
still a few of them that I need to flip. At least it's enough
for my config to boot and be happy. Also I may need to teach lockdep
about the new situation.

Other than that, it works pretty well on my box, softirqs nest like a
charm (except for NET_RX and TASKLET as you may find out in the last
patch):

			  <idle>-0     [000] ..s2   119.907085: __do_softirq: run_rebalance_domains
			  <idle>-0     [000] ..s2   119.907090: <stack trace>
	 => __do_softirq
	 => irq_exit
	 => scheduler_ipi
	 => smp_reschedule_interrupt
	 => reschedule_interrupt
	 => _raw_spin_unlock_irq
	 => run_timer_softirq
	 => __do_softirq
	 => irq_exit
	 => smp_apic_timer_interrupt
	 => apic_timer_interrupt
	 => cpuidle_enter_state
	 => cpuidle_enter
	 => call_cpuidle
	 => do_idle

So that's enough to start a debate.	

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	irq/softirq-experimental

HEAD: 84e064f678eb06d0da3e97f04eced4cfb55866ba

Thanks,
	Frederic
---

Frederic Weisbecker (30):
      x86: Revert "x86/irq: Demote irq_cpustat_t::__softirq_pending to u16"
      arch/softirq: Rename softirq_pending fields to softirq_data
      softirq: Implement local_softirq_pending() below softirq vector definition
      softirq: Normalize softirq_pending naming scheme
      softirq: Convert softirq_pending_set() to softirq_pending_nand()
      softirq: Introduce disabled softirq vectors bits
      softirq: Rename _local_bh_enable() to local_bh_enable_no_softirq()
      softirq: Move vectors bits to bottom_half.h
      x86: Init softirq enabled field
      softirq: Check enabled bits on the softirq loop
      net: Prepare netif_tx_lock_bh/netif_tx_unlock_bh() for handling softirq mask
      rcu: Prepare rcu_read_[un]lock_bh() for handling softirq mask
      net: Prepare tcp_get_md5sig_pool() for handling softirq mask
      softirq: Introduce local_bh_disable_all()
      net: Prepare [un]lock_sock_fast() for handling softirq mask
      net: Prepare nf_log_buf_open() for handling softirq mask
      isdn: Prepare isdn_net_get_locked_lp() for handling softirq mask
      softirq: Prepare local_bh_disable() for handling softirq mask
      diva: Prepare diva_os_enter_spin_lock() for handling softirq mask
      tg3: Prepare tg3_full_[un]lock() for handling softirq mask
      locking: Prepare spin_lock_bh() for handling softirq mask
      seqlock: Prepare write_seq[un]lock_bh() for handling softirq mask
      rwlock: Prepare write_[un]lock_bh() for handling softirq mask
      softirq: Introduce Local_bh_enter/exit()
      softirq: Push down softirq mask to __local_bh_disable_ip()
      softirq: Increment the softirq offset on top of enabled bits
      softirq: Swap softirq serving VS disable on preempt mask layout
      softirq: Disable vector on execution
      softirq: Make softirq processing softinterruptible
      softirq: Tasklet/net-rx fixup


 arch/arm/include/asm/hardirq.h                     |   2 +-
 arch/arm64/include/asm/hardirq.h                   |   2 +-
 arch/arm64/kernel/fpsimd.c                         |  37 +--
 arch/h8300/kernel/asm-offsets.c                    |   2 +-
 arch/ia64/include/asm/hardirq.h                    |   2 +-
 arch/ia64/include/asm/processor.h                  |   2 +-
 arch/m68k/include/asm/hardirq.h                    |   2 +-
 arch/m68k/kernel/asm-offsets.c                     |   2 +-
 arch/parisc/include/asm/hardirq.h                  |   2 +-
 arch/powerpc/include/asm/hardirq.h                 |   2 +-
 arch/s390/include/asm/hardirq.h                    |  11 +-
 arch/s390/lib/delay.c                              |   5 +-
 arch/s390/mm/pgalloc.c                             |  24 +-
 arch/sh/include/asm/hardirq.h                      |   2 +-
 arch/sparc/include/asm/cpudata_64.h                |   2 +-
 arch/sparc/include/asm/hardirq_64.h                |   4 +-
 arch/um/include/asm/hardirq.h                      |   2 +-
 arch/x86/crypto/sha1-mb/sha1_mb.c                  |   9 +-
 arch/x86/crypto/sha256-mb/sha256_mb.c              |   9 +-
 arch/x86/crypto/sha512-mb/sha512_mb.c              |   9 +-
 arch/x86/include/asm/hardirq.h                     |   2 +-
 arch/x86/kernel/irq.c                              |   5 +-
 arch/xtensa/platforms/iss/console.c                |  10 +-
 arch/xtensa/platforms/iss/network.c                |  28 +-
 block/genhd.c                                      |  15 +-
 crypto/ansi_cprng.c                                |  10 +-
 crypto/cryptd.c                                    |  25 +-
 crypto/mcryptd.c                                   |  30 ++-
 crypto/pcrypt.c                                    |   5 +-
 drivers/block/drbd/drbd_receiver.c                 |  10 +-
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
 drivers/crypto/chelsio/chcr_algo.c                 |   5 +-
 drivers/crypto/chelsio/chtls/chtls_cm.c            |  36 ++-
 drivers/crypto/chelsio/chtls/chtls_hw.c            |  10 +-
 drivers/crypto/chelsio/chtls/chtls_main.c          |   9 +-
 drivers/crypto/inside-secure/safexcel.c            |  19 +-
 drivers/crypto/inside-secure/safexcel_cipher.c     |  15 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |  15 +-
 drivers/crypto/marvell/cesa.c                      |  20 +-
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
 drivers/gpu/drm/i915/i915_gem.c                    |   5 +-
 drivers/gpu/drm/i915/i915_request.c                |   5 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   5 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |   5 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                |  10 +-
 drivers/hsi/clients/cmt_speech.c                   |  76 +++---
 drivers/hsi/clients/ssi_protocol.c                 | 135 +++++-----
 drivers/hsi/controllers/omap_ssi_port.c            |  60 +++--
 drivers/infiniband/core/addr.c                     |  29 ++-
 drivers/infiniband/core/roce_gid_mgmt.c            |   5 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  10 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   7 +-
 drivers/infiniband/hw/mlx4/main.c                  |  35 ++-
 drivers/infiniband/sw/rdmavt/cq.c                  |   5 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c              |  33 +--
 drivers/infiniband/sw/rxe/rxe_mmap.c               |  19 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |  24 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |   5 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |  15 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  14 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |  42 +--
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  14 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |  19 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  52 ++--
 drivers/isdn/capi/capi.c                           |  46 ++--
 drivers/isdn/hardware/eicon/capifunc.c             |  53 ++--
 drivers/isdn/hardware/eicon/dadapter.c             |  39 ++-
 drivers/isdn/hardware/eicon/debug.c                | 129 ++++++----
 drivers/isdn/hardware/eicon/debug_if.h             |   6 +-
 drivers/isdn/hardware/eicon/diva.c                 |  45 ++--
 drivers/isdn/hardware/eicon/idifunc.c              |  22 +-
 drivers/isdn/hardware/eicon/io.c                   |  88 ++++---
 drivers/isdn/hardware/eicon/mntfunc.c              |  13 +-
 drivers/isdn/hardware/eicon/platform.h             |   9 +-
 drivers/isdn/hardware/eicon/um_idi.c               | 104 +++++---
 drivers/isdn/i4l/isdn_concap.c                     |   5 +-
 drivers/isdn/i4l/isdn_net.c                        |  16 +-
 drivers/isdn/i4l/isdn_net.h                        |   5 +-
 drivers/isdn/i4l/isdn_ppp.c                        |   6 +-
 drivers/isdn/mISDN/socket.c                        |  17 +-
 drivers/isdn/mISDN/stack.c                         |  10 +-
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
 drivers/net/ethernet/aurora/nb8800.c               |   5 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |  10 +-
 drivers/net/ethernet/broadcom/bnx2.c               | 107 ++++----
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  29 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |  39 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  12 +-
 drivers/net/ethernet/broadcom/cnic.c               |  12 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   5 +-
 drivers/net/ethernet/broadcom/tg3.c                | 221 +++++++++-------
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
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |   5 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c |  56 ++--
 drivers/net/ethernet/chelsio/cxgb3/l2t.c           |  39 +--
 drivers/net/ethernet/chelsio/cxgb3/sge.c           |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c      |  42 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |  17 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  42 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c   |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |  40 +--
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |  32 ++-
 drivers/net/ethernet/chelsio/cxgb4/smt.c           |  10 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |  15 +-
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |  23 +-
 drivers/net/ethernet/cisco/enic/enic_api.c         |   5 +-
 drivers/net/ethernet/cisco/enic/enic_clsf.c        |  25 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c         |  75 +++---
 drivers/net/ethernet/cisco/enic/enic_dev.h         |   2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  18 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  35 ++-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |  15 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   5 +-
 drivers/net/ethernet/freescale/fec_main.c          |  34 ++-
 drivers/net/ethernet/freescale/gianfar.c           |   5 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |  30 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |   7 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c  |   9 +-
 drivers/net/ethernet/ibm/emac/core.c               |  15 +-
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
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  10 +-
 drivers/net/ethernet/marvell/skge.c                |  34 ++-
 drivers/net/ethernet/marvell/sky2.c                |  34 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  10 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   5 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |  35 ++-
 drivers/net/ethernet/mellanox/mlx4/en_port.c       |   5 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  24 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  21 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  10 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |  10 +-
 .../net/ethernet/mellanox/mlx5/core/lib/vxlan.c    |  15 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |  12 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   5 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |   5 +-
 drivers/net/ethernet/microchip/lan743x_ptp.c       |  30 ++-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   |  14 +-
 drivers/net/ethernet/netronome/nfp/flower/main.c   |  14 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |   5 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |  21 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h       |   2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  35 ++-
 drivers/net/ethernet/nvidia/forcedeth.c            |  50 ++--
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c |   7 +-
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
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |  22 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  20 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |   5 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  10 +-
 drivers/net/ethernet/qualcomm/qca_uart.c           |  14 +-
 drivers/net/ethernet/realtek/8139too.c             |   5 +-
 drivers/net/ethernet/sfc/ef10.c                    |  15 +-
 drivers/net/ethernet/sfc/efx.c                     |  15 +-
 drivers/net/ethernet/sfc/ethtool.c                 |   5 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |  15 +-
 drivers/net/ethernet/sfc/falcon/ethtool.c          |   5 +-
 drivers/net/ethernet/sfc/falcon/falcon.c           |   9 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |  42 +--
 drivers/net/ethernet/sfc/falcon/selftest.c         |  10 +-
 drivers/net/ethernet/sfc/farch.c                   |   5 +-
 drivers/net/ethernet/sfc/mcdi.c                    |  34 ++-
 drivers/net/ethernet/sfc/ptp.c                     |  32 ++-
 drivers/net/ethernet/sfc/rx.c                      |   5 +-
 drivers/net/ethernet/sfc/selftest.c                |  10 +-
 drivers/net/ethernet/silan/sc92031.c               |  60 +++--
 drivers/net/ethernet/ti/netcp_ethss.c              |  10 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   5 +-
 drivers/net/ethernet/via/via-rhine.c               |  25 +-
 drivers/net/hamradio/6pack.c                       |  30 ++-
 drivers/net/hamradio/mkiss.c                       |  45 ++--
 drivers/net/hyperv/rndis_filter.c                  |   5 +-
 drivers/net/ieee802154/fakelb.c                    |  20 +-
 drivers/net/ipvlan/ipvlan_core.c                   |  10 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  22 +-
 drivers/net/macsec.c                               |  37 +--
 drivers/net/macvlan.c                              |   5 +-
 drivers/net/ppp/ppp_async.c                        |  12 +-
 drivers/net/ppp/ppp_generic.c                      |  70 ++---
 drivers/net/ppp/ppp_synctty.c                      |   5 +-
 drivers/net/ppp/pppoe.c                            |  24 +-
 drivers/net/slip/slip.c                            |  53 ++--
 drivers/net/tun.c                                  |  62 +++--
 drivers/net/usb/cdc_mbim.c                         |   5 +-
 drivers/net/usb/cdc_ncm.c                          |  39 +--
 drivers/net/usb/r8152.c                            |   5 +-
 drivers/net/virtio_net.c                           |   5 +-
 drivers/net/vrf.c                                  |  19 +-
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
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  51 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  30 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       | 150 ++++++-----
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  34 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  46 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  19 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  15 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  29 ++-
 .../net/wireless/intersil/hostap/hostap_80211_rx.c |   5 +-
 drivers/net/wireless/intersil/hostap/hostap_ap.c   | 145 ++++++-----
 drivers/net/wireless/intersil/hostap/hostap_hw.c   |  20 +-
 .../net/wireless/intersil/hostap/hostap_ioctl.c    |   9 +-
 drivers/net/wireless/intersil/hostap/hostap_main.c |  12 +-
 drivers/net/wireless/intersil/hostap/hostap_proc.c |   6 +-
 .../net/wireless/intersil/orinoco/orinoco_usb.c    |   9 +-
 drivers/net/wireless/mac80211_hwsim.c              |  67 +++--
 drivers/net/wireless/marvell/mwl8k.c               |  21 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |  20 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  15 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_dma.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c    |   5 +-
 .../net/wireless/mediatek/mt76/mt76x2_mac_common.c |  10 +-
 .../net/wireless/mediatek/mt76/mt76x2_phy_common.c |   5 +-
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
 drivers/s390/char/sclp.c                           |   5 +-
 drivers/s390/char/tty3270.c                        |  40 +--
 drivers/s390/char/vmlogrdr.c                       |  17 +-
 drivers/s390/cio/cio.c                             |   5 +-
 drivers/s390/crypto/ap_bus.c                       |  64 +++--
 drivers/s390/crypto/ap_card.c                      |  25 +-
 drivers/s390/crypto/ap_queue.c                     |  60 +++--
 drivers/s390/crypto/pkey_api.c                     |  22 +-
 drivers/s390/crypto/zcrypt_api.c                   |  20 +-
 drivers/s390/net/netiucv.c                         |  36 +--
 drivers/s390/net/qeth_l2_main.c                    |  10 +-
 drivers/s390/net/qeth_l3_main.c                    |  65 +++--
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
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |  59 +++--
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                 |  27 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 |  58 +++--
 drivers/scsi/cxgbi/libcxgbi.c                      |  76 +++---
 drivers/scsi/fcoe/fcoe.c                           |  10 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/fcoe/fcoe_transport.c                 |  14 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           | 105 ++++----
 drivers/scsi/iscsi_tcp.c                           |  57 +++--
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
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  69 ++---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c            |  41 +--
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |  17 +-
 drivers/target/iscsi/cxgbit/cxgbit_target.c        |  31 ++-
 drivers/target/iscsi/iscsi_target.c                | 221 +++++++++-------
 drivers/target/iscsi/iscsi_target_configfs.c       |  19 +-
 drivers/target/iscsi/iscsi_target_erl0.c           |  49 ++--
 drivers/target/iscsi/iscsi_target_erl1.c           |  79 +++---
 drivers/target/iscsi/iscsi_target_erl2.c           |  18 +-
 drivers/target/iscsi/iscsi_target_login.c          |  68 ++---
 drivers/target/iscsi/iscsi_target_nego.c           |  60 +++--
 drivers/target/iscsi/iscsi_target_nodeattrib.c     |   5 +-
 drivers/target/iscsi/iscsi_target_stat.c           |  45 ++--
 drivers/target/iscsi/iscsi_target_tmr.c            |  30 ++-
 drivers/target/iscsi/iscsi_target_util.c           | 208 ++++++++-------
 drivers/target/sbp/sbp_target.c                    | 141 +++++-----
 drivers/target/target_core_tpg.c                   |  10 +-
 drivers/target/target_core_transport.c             |   5 +-
 drivers/target/target_core_user.c                  |  12 +-
 drivers/tty/hvc/hvc_iucv.c                         |  55 ++--
 drivers/tty/moxa.c                                 |  21 +-
 drivers/usb/serial/keyspan_pda.c                   |   7 +-
 drivers/vhost/net.c                                |   5 +-
 drivers/vhost/vsock.c                              |  45 ++--
 drivers/xen/pvcalls-back.c                         |  20 +-
 fs/afs/internal.h                                  |   4 +-
 fs/afs/rxrpc.c                                     |   5 +-
 fs/dlm/lowcomms.c                                  |  40 +--
 fs/fs-writeback.c                                  |  15 +-
 fs/jffs2/README.Locking                            |   2 +-
 fs/nfs/callback.c                                  |   7 +-
 fs/ocfs2/cluster/tcp.c                             |  35 ++-
 include/asm-generic/hardirq.h                      |   2 +-
 include/linux/bottom_half.h                        |  57 ++++-
 include/linux/dmaengine.h                          |  16 +-
 include/linux/interrupt.h                          |  82 +++---
 include/linux/netdevice.h                          |  40 ++-
 include/linux/preempt.h                            |  11 +-
 include/linux/ptr_ring.h                           |  30 ++-
 include/linux/rcupdate.h                           |  11 +-
 include/linux/rhashtable.h                         |  17 +-
 include/linux/rwlock.h                             |   8 +-
 include/linux/rwlock_api_smp.h                     |  40 +--
 include/linux/seqlock.h                            |  21 +-
 include/linux/spinlock.h                           |  23 +-
 include/linux/spinlock_api_smp.h                   |  34 ++-
 include/linux/spinlock_api_up.h                    |  18 +-
 include/linux/u64_stats_sync.h                     |   2 +-
 include/linux/xarray.h                             |   2 +-
 include/net/arp.h                                  |  10 +-
 include/net/gen_stats.h                            |   1 +
 include/net/ip6_fib.h                              |   1 +
 include/net/mac80211.h                             |  15 +-
 include/net/ndisc.h                                |  10 +-
 include/net/neighbour.h                            |   1 +
 include/net/netfilter/nf_log.h                     |   4 +-
 include/net/netrom.h                               |   9 +-
 include/net/ping.h                                 |   1 +
 include/net/pkt_cls.h                              |   6 +-
 include/net/request_sock.h                         |   5 +-
 include/net/sch_generic.h                          |  19 +-
 include/net/snmp.h                                 |  10 +-
 include/net/sock.h                                 |  17 +-
 include/net/tcp.h                                  |   9 +-
 include/net/udp.h                                  |   1 +
 include/target/iscsi/iscsi_target_core.h           |   2 +-
 kernel/bpf/btf.c                                   |   5 +-
 kernel/bpf/core.c                                  |  10 +-
 kernel/bpf/cpumap.c                                |   5 +-
 kernel/bpf/local_storage.c                         |  34 ++-
 kernel/bpf/reuseport_array.c                       |  32 ++-
 kernel/bpf/sockmap.c                               |  93 ++++---
 kernel/bpf/syscall.c                               |  30 ++-
 kernel/cgroup/cgroup.c                             |  15 +-
 kernel/irq/manage.c                                |   5 +-
 kernel/locking/spinlock.c                          |  41 +--
 kernel/padata.c                                    |  20 +-
 kernel/rcu/rcuperf.c                               |   2 +-
 kernel/rcu/rcutorture.c                            |  19 +-
 kernel/rcu/srcutiny.c                              |   5 +-
 kernel/rcu/srcutree.c                              |   5 +-
 kernel/rcu/tiny.c                                  |   5 +-
 kernel/rcu/tree_plugin.h                           |  12 +-
 kernel/rcu/update.c                                |   5 +-
 kernel/softirq.c                                   | 164 +++++++++---
 kernel/time/hrtimer.c                              |   5 +-
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace.c                               |   2 +-
 lib/locking-selftest.c                             |   8 +-
 lib/rhashtable.c                                   |  12 +-
 mm/backing-dev.c                                   |  22 +-
 mm/page-writeback.c                                |  10 +-
 net/6lowpan/debugfs.c                              |  25 +-
 net/6lowpan/iphc.c                                 |  23 +-
 net/6lowpan/ndisc.c                                |  12 +-
 net/6lowpan/nhc.c                                  |  31 ++-
 net/802/garp.c                                     |  19 +-
 net/802/mrp.c                                      |  19 +-
 net/802/psnap.c                                    |  10 +-
 net/appletalk/aarp.c                               |  48 ++--
 net/appletalk/atalk_proc.c                         |   6 +-
 net/appletalk/ddp.c                                |  65 +++--
 net/atm/clip.c                                     |   5 +-
 net/atm/mpc.c                                      |   5 +-
 net/atm/mpoa_caches.c                              |  41 +--
 net/ax25/af_ax25.c                                 |  26 +-
 net/ax25/ax25_dev.c                                |  24 +-
 net/ax25/ax25_iface.c                              |  53 ++--
 net/ax25/ax25_out.c                                |   7 +-
 net/ax25/ax25_route.c                              |  33 ++-
 net/ax25/ax25_subr.c                               |   5 +-
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
 net/bridge/br_fdb.c                                |  65 +++--
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
 net/bridge/netfilter/ebtables.c                    |  32 ++-
 net/caif/caif_dev.c                                |  21 +-
 net/caif/caif_socket.c                             |   5 +-
 net/caif/cfctrl.c                                  |  40 +--
 net/caif/cfmuxl.c                                  |  30 ++-
 net/can/gw.c                                       |   5 +-
 net/core/datagram.c                                |  10 +-
 net/core/dev.c                                     |  51 ++--
 net/core/dev_addr_lists.c                          |  51 ++--
 net/core/gen_estimator.c                           |   9 +-
 net/core/gen_stats.c                               |   8 +-
 net/core/link_watch.c                              |   5 +-
 net/core/neighbour.c                               | 175 +++++++------
 net/core/net-procfs.c                              |   5 +-
 net/core/net_namespace.c                           |  31 ++-
 net/core/netpoll.c                                 |   5 +-
 net/core/pktgen.c                                  |  23 +-
 net/core/request_sock.c                            |   7 +-
 net/core/rtnetlink.c                               |  15 +-
 net/core/skbuff.c                                  |   5 +-
 net/core/sock.c                                    |  52 ++--
 net/core/sock_reuseport.c                          |  26 +-
 net/dcb/dcbnl.c                                    |  54 ++--
 net/dccp/input.c                                   |   5 +-
 net/dccp/ipv4.c                                    |   5 +-
 net/dccp/minisocks.c                               |  10 +-
 net/dccp/proto.c                                   |   5 +-
 net/decnet/af_decnet.c                             |  20 +-
 net/decnet/dn_fib.c                                |  20 +-
 net/decnet/dn_route.c                              |  56 ++--
 net/decnet/dn_table.c                              |  27 +-
 net/hsr/hsr_device.c                               |   7 +-
 net/ieee802154/6lowpan/tx.c                        |   5 +-
 net/ieee802154/socket.c                            |  25 +-
 net/ipv4/af_inet.c                                 |  10 +-
 net/ipv4/arp.c                                     |  10 +-
 net/ipv4/cipso_ipv4.c                              |  19 +-
 net/ipv4/esp4.c                                    |  19 +-
 net/ipv4/fib_frontend.c                            |   5 +-
 net/ipv4/fib_semantics.c                           |  20 +-
 net/ipv4/icmp.c                                    |  10 +-
 net/ipv4/igmp.c                                    |  82 +++---
 net/ipv4/inet_connection_sock.c                    |  28 +-
 net/ipv4/inet_diag.c                               |   5 +-
 net/ipv4/inet_fragment.c                           |   5 +-
 net/ipv4/inet_hashtables.c                         |  30 ++-
 net/ipv4/inet_timewait_sock.c                      |   5 +-
 net/ipv4/inetpeer.c                                |   5 +-
 net/ipv4/ip_output.c                               |   7 +-
 net/ipv4/ipmr.c                                    |  36 +--
 net/ipv4/ipmr_base.c                               |  17 +-
 net/ipv4/netfilter/arp_tables.c                    |  10 +-
 net/ipv4/netfilter/ip_tables.c                     |  10 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  21 +-
 net/ipv4/netfilter/nf_defrag_ipv4.c                |   5 +-
 net/ipv4/netfilter/nf_log_arp.c                    |   5 +-
 net/ipv4/netfilter/nf_log_ipv4.c                   |   5 +-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c        |   5 +-
 net/ipv4/ping.c                                    |  22 +-
 net/ipv4/raw.c                                     |  15 +-
 net/ipv4/route.c                                   |  30 ++-
 net/ipv4/sysctl_net_ipv4.c                         |   5 +-
 net/ipv4/tcp.c                                     |  32 ++-
 net/ipv4/tcp_input.c                               |   5 +-
 net/ipv4/tcp_ipv4.c                                |  32 ++-
 net/ipv4/tcp_metrics.c                             |  20 +-
 net/ipv4/tcp_minisocks.c                           |   5 +-
 net/ipv4/udp.c                                     |  52 ++--
 net/ipv4/udp_diag.c                                |   7 +-
 net/ipv6/addrconf.c                                | 240 +++++++++--------
 net/ipv6/af_inet6.c                                |  10 +-
 net/ipv6/anycast.c                                 |  38 +--
 net/ipv6/calipso.c                                 |  19 +-
 net/ipv6/esp6.c                                    |  14 +-
 net/ipv6/icmp.c                                    |  10 +-
 net/ipv6/inet6_hashtables.c                        |   5 +-
 net/ipv6/ip6_fib.c                                 |  43 ++--
 net/ipv6/ip6_flowlabel.c                           |  88 ++++---
 net/ipv6/ip6_output.c                              |  12 +-
 net/ipv6/ip6mr.c                                   |  46 ++--
 net/ipv6/ipv6_sockglue.c                           |  20 +-
 net/ipv6/mcast.c                                   | 221 +++++++++-------
 net/ipv6/mip6.c                                    |  15 +-
 net/ipv6/ndisc.c                                   |  17 +-
 net/ipv6/netfilter/ip6_tables.c                    |  10 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   5 +-
 net/ipv6/netfilter/nf_log_ipv6.c                   |   5 +-
 net/ipv6/netfilter/nf_tproxy_ipv6.c                |   5 +-
 net/ipv6/raw.c                                     |   5 +-
 net/ipv6/route.c                                   |  87 ++++---
 net/ipv6/seg6_hmac.c                               |   5 +-
 net/ipv6/tcp_ipv6.c                                |  14 +-
 net/ipv6/xfrm6_tunnel.c                            |  15 +-
 net/iucv/af_iucv.c                                 |  25 +-
 net/iucv/iucv.c                                    |  70 +++--
 net/kcm/kcmproc.c                                  |  10 +-
 net/kcm/kcmsock.c                                  | 130 ++++++----
 net/key/af_key.c                                   |   5 +-
 net/l2tp/l2tp_core.c                               | 100 +++++---
 net/l2tp/l2tp_debugfs.c                            |   5 +-
 net/l2tp/l2tp_ip.c                                 |  34 ++-
 net/l2tp/l2tp_ip6.c                                |  29 ++-
 net/l2tp/l2tp_ppp.c                                |  10 +-
 net/lapb/lapb_iface.c                              |  15 +-
 net/llc/llc_conn.c                                 |  15 +-
 net/llc/llc_core.c                                 |  15 +-
 net/llc/llc_proc.c                                 |  23 +-
 net/llc/llc_sap.c                                  |  10 +-
 net/mac80211/agg-rx.c                              |   5 +-
 net/mac80211/agg-tx.c                              |  50 ++--
 net/mac80211/cfg.c                                 |  36 +--
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
 net/mac80211/sta_info.c                            |  20 +-
 net/mac80211/tdls.c                                |  10 +-
 net/mac80211/tkip.c                                |   5 +-
 net/mac80211/tx.c                                  |  55 ++--
 net/mac80211/util.c                                |   5 +-
 net/mac802154/llsec.c                              |  43 ++--
 net/mpls/internal.h                                |  10 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   2 +-
 net/netfilter/ipset/ip_set_core.c                  |  79 +++---
 net/netfilter/ipset/ip_set_hash_gen.h              |  21 +-
 net/netfilter/ipset/ip_set_list_set.c              |   5 +-
 net/netfilter/ipvs/ip_vs_app.c                     |   5 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  22 +-
 net/netfilter/ipvs/ip_vs_core.c                    |  20 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  40 +--
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
 net/netfilter/nf_conntrack_core.c                  |  46 ++--
 net/netfilter/nf_conntrack_ecache.c                |  15 +-
 net/netfilter/nf_conntrack_expect.c                |  32 ++-
 net/netfilter/nf_conntrack_ftp.c                   |   5 +-
 net/netfilter/nf_conntrack_h323_main.c             |  26 +-
 net/netfilter/nf_conntrack_helper.c                |  10 +-
 net/netfilter/nf_conntrack_irc.c                   |   5 +-
 net/netfilter/nf_conntrack_netlink.c               |  38 +--
 net/netfilter/nf_conntrack_pptp.c                  |   5 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |  21 +-
 net/netfilter/nf_conntrack_proto_gre.c             |  27 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  19 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |  31 ++-
 net/netfilter/nf_conntrack_sane.c                  |   5 +-
 net/netfilter/nf_conntrack_seqadj.c                |  10 +-
 net/netfilter/nf_conntrack_sip.c                   |  10 +-
 net/netfilter/nf_log.c                             |   8 +-
 net/netfilter/nf_log_common.c                      |   5 +-
 net/netfilter/nf_nat_core.c                        |  10 +-
 net/netfilter/nf_nat_redirect.c                    |   5 +-
 net/netfilter/nf_queue.c                           |   5 +-
 net/netfilter/nf_tables_core.c                     |   5 +-
 net/netfilter/nfnetlink_log.c                      |  76 +++---
 net/netfilter/nfnetlink_queue.c                    |  48 ++--
 net/netfilter/nft_counter.c                        |  10 +-
 net/netfilter/nft_limit.c                          |   7 +-
 net/netfilter/nft_meta.c                           |  13 +-
 net/netfilter/nft_set_rbtree.c                     |  32 ++-
 net/netfilter/x_tables.c                           |   7 +-
 net/netfilter/xt_RATEEST.c                         |   5 +-
 net/netfilter/xt_dccp.c                            |   9 +-
 net/netfilter/xt_hashlimit.c                       |  18 +-
 net/netfilter/xt_limit.c                           |   7 +-
 net/netfilter/xt_quota.c                           |   5 +-
 net/netfilter/xt_recent.c                          |  35 +--
 net/netlink/af_netlink.c                           |  10 +-
 net/netrom/af_netrom.c                             |  32 ++-
 net/netrom/nr_route.c                              |  58 +++--
 net/nfc/rawsock.c                                  |  15 +-
 net/openvswitch/datapath.c                         |   5 +-
 net/openvswitch/flow.c                             |  10 +-
 net/openvswitch/meter.c                            |  15 +-
 net/packet/af_packet.c                             |  34 ++-
 net/rds/af_rds.c                                   |  20 +-
 net/rds/tcp.c                                      |  10 +-
 net/rds/tcp_connect.c                              |   5 +-
 net/rds/tcp_listen.c                               |  15 +-
 net/rds/tcp_recv.c                                 |   5 +-
 net/rds/tcp_send.c                                 |   5 +-
 net/rose/af_rose.c                                 |  32 ++-
 net/rose/rose_route.c                              |  73 +++---
 net/rxrpc/af_rxrpc.c                               |  15 +-
 net/rxrpc/ar-internal.h                            |  15 +-
 net/rxrpc/call_accept.c                            |  17 +-
 net/rxrpc/call_event.c                             |  16 +-
 net/rxrpc/call_object.c                            |  10 +-
 net/rxrpc/conn_client.c                            |  10 +-
 net/rxrpc/conn_event.c                             |  12 +-
 net/rxrpc/conn_object.c                            |   5 +-
 net/rxrpc/conn_service.c                           |   4 +-
 net/rxrpc/input.c                                  |  15 +-
 net/rxrpc/output.c                                 |  14 +-
 net/rxrpc/peer_event.c                             |  22 +-
 net/rxrpc/peer_object.c                            |  10 +-
 net/rxrpc/recvmsg.c                                |  31 ++-
 net/rxrpc/sendmsg.c                                |  15 +-
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
 net/sched/sch_generic.c                            |  24 +-
 net/sched/sch_mq.c                                 |   5 +-
 net/sched/sch_mqprio.c                             |  14 +-
 net/sched/sch_netem.c                              |   5 +-
 net/sched/sch_teql.c                               |   5 +-
 net/sctp/associola.c                               |  10 +-
 net/sctp/input.c                                   |  15 +-
 net/sctp/ipv6.c                                    |  14 +-
 net/sctp/proc.c                                    |   5 +-
 net/sctp/protocol.c                                |  28 +-
 net/sctp/sm_make_chunk.c                           |   9 +-
 net/sctp/socket.c                                  |  45 ++--
 net/smc/af_smc.c                                   |  10 +-
 net/smc/smc_cdc.c                                  |  10 +-
 net/smc/smc_core.c                                 |  83 +++---
 net/smc/smc_tx.c                                   |  10 +-
 net/sunrpc/backchannel_rqst.c                      |  10 +-
 net/sunrpc/sched.c                                 |  42 +--
 net/sunrpc/svc.c                                   |  29 ++-
 net/sunrpc/svc_xprt.c                              |  52 ++--
 net/sunrpc/svcsock.c                               |  12 +-
 net/sunrpc/xprt.c                                  |  60 +++--
 net/sunrpc/xprtrdma/backchannel.c                  |  17 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c         |   5 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |  10 +-
 net/sunrpc/xprtrdma/transport.c                    |   5 +-
 net/sunrpc/xprtsock.c                              |  70 +++--
 net/switchdev/switchdev.c                          |  10 +-
 net/tipc/bcast.h                                   |   2 +-
 net/tipc/discover.c                                |  20 +-
 net/tipc/monitor.c                                 |  54 ++--
 net/tipc/msg.h                                     |  10 +-
 net/tipc/name_distr.c                              |  20 +-
 net/tipc/name_table.c                              |  71 +++---
 net/tipc/node.c                                    |  65 +++--
 net/tipc/socket.c                                  |  14 +-
 net/tipc/topsrv.c                                  |  85 +++---
 net/tls/tls_sw.c                                   |  10 +-
 net/unix/af_unix.c                                 |  10 +-
 net/vmw_vsock/af_vsock.c                           |  50 ++--
 net/vmw_vsock/diag.c                               |   5 +-
 net/vmw_vsock/virtio_transport.c                   |  36 +--
 net/vmw_vsock/virtio_transport_common.c            |  44 ++--
 net/vmw_vsock/vmci_transport.c                     |  17 +-
 net/wireless/mlme.c                                |  29 ++-
 net/wireless/nl80211.c                             |  26 +-
 net/wireless/reg.c                                 |  19 +-
 net/wireless/scan.c                                |  49 ++--
 net/x25/af_x25.c                                   |  45 ++--
 net/x25/x25_forward.c                              |  25 +-
 net/x25/x25_link.c                                 |  30 ++-
 net/x25/x25_proc.c                                 |   6 +-
 net/x25/x25_route.c                                |  25 +-
 net/xdp/xsk.c                                      |  10 +-
 net/xfrm/xfrm_input.c                              |  10 +-
 net/xfrm/xfrm_ipcomp.c                             |   7 +-
 net/xfrm/xfrm_output.c                             |   7 +-
 net/xfrm/xfrm_policy.c                             |  94 ++++---
 net/xfrm/xfrm_state.c                              | 172 ++++++++-----
 net/xfrm/xfrm_user.c                               |  15 +-
 security/selinux/netif.c                           |  15 +-
 security/selinux/netnode.c                         |  12 +-
 security/selinux/netport.c                         |  12 +-
 security/smack/smack_lsm.c                         |   5 +-
 sound/pci/asihpi/hpios.h                           |   2 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |  19 +-
 sound/soc/omap/ams-delta.c                         |  10 +-
 tools/virtio/ringtest/ptr_ring.c                   |   2 +-
 945 files changed, 13857 insertions(+), 9767 deletions(-)
