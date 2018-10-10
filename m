Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77245C46463
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EE1214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lskpU9Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EE1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJKGhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbeJKGhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:55 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C5E21470;
        Wed, 10 Oct 2018 23:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213213;
        bh=+y4paSpoSrWw8+D7KwEH4lTw1luKntqsChKHOjRhVB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lskpU9PwuFvW/quKGyQ6J48F0vxWZYkcPWNENSj2ZjaUggK+sOlhuItPQ3kVE5b9R
         xkDqW8q1UOGxxvBCQxUlX0gd/oS2h23sSamG4rrAdBQ2y2Ig3Zd8q+WLcVmNjRHCCG
         HcWLJJBDNCKKUA5WM5jHrUClOg+Kg9SZAPt+qo68=
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
Subject: [RFC PATCH 20/30] tg3: Prepare tg3_full_[un]lock() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:07 +0200
Message-Id: <1539213137-13953-21-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of spin_[un]lock_bh() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh2 = tg3_full_lock(...) {
			return spin_lock_bh(...)
		}
		...
		tg3_full_unlock(..., bh2) {
			spin_unlock_bh(bh2, ...);
		}
	local_bh_enable(bh);

To prepare for that, make tg3_full_lock() able to return a saved vector
enabled mask and pass it back to tg3_full_unlock(). We'll plug it to
spin_lock_bh() in a subsequent patch.

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
 drivers/net/ethernet/broadcom/tg3.c | 160 +++++++++++++++++++++---------------
 1 file changed, 95 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e6f28c7..765185c 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6156,8 +6156,8 @@ static void tg3_refclk_write(struct tg3 *tp, u64 newval)
 	tw32_f(TG3_EAV_REF_CLCK_CTL, clock_ctl | TG3_EAV_REF_CLCK_CTL_RESUME);
 }
 
-static inline void tg3_full_lock(struct tg3 *tp, int irq_sync);
-static inline void tg3_full_unlock(struct tg3 *tp);
+static inline unsigned int tg3_full_lock(struct tg3 *tp, int irq_sync);
+static inline void tg3_full_unlock(struct tg3 *tp, unsigned int bh);
 static int tg3_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 {
 	struct tg3 *tp = netdev_priv(dev);
@@ -6189,6 +6189,7 @@ static int tg3_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 static int tg3_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 {
 	struct tg3 *tp = container_of(ptp, struct tg3, ptp_info);
+	unsigned int bh;
 	bool neg_adj = false;
 	u32 correction = 0;
 
@@ -6208,7 +6209,7 @@ static int tg3_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 	correction = div_u64((u64)ppb * (1 << 24), 1000000000ULL) &
 		     TG3_EAV_REF_CLK_CORRECT_MASK;
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	if (correction)
 		tw32(TG3_EAV_REF_CLK_CORRECT_CTL,
@@ -6217,7 +6218,7 @@ static int tg3_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 	else
 		tw32(TG3_EAV_REF_CLK_CORRECT_CTL, 0);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	return 0;
 }
@@ -6225,10 +6226,11 @@ static int tg3_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 static int tg3_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct tg3 *tp = container_of(ptp, struct tg3, ptp_info);
+	unsigned int bh;
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	tp->ptp_adjust += delta;
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	return 0;
 }
@@ -6236,12 +6238,13 @@ static int tg3_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 static int tg3_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	u64 ns;
+	unsigned int bh;
 	struct tg3 *tp = container_of(ptp, struct tg3, ptp_info);
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	ns = tg3_refclk_read(tp);
 	ns += tp->ptp_adjust;
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	*ts = ns_to_timespec64(ns);
 
@@ -6253,13 +6256,14 @@ static int tg3_ptp_settime(struct ptp_clock_info *ptp,
 {
 	u64 ns;
 	struct tg3 *tp = container_of(ptp, struct tg3, ptp_info);
+	unsigned int bh;
 
 	ns = timespec64_to_ns(ts);
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	tg3_refclk_write(tp, ns);
 	tp->ptp_adjust = 0;
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	return 0;
 }
@@ -6268,6 +6272,7 @@ static int tg3_ptp_enable(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on)
 {
 	struct tg3 *tp = container_of(ptp, struct tg3, ptp_info);
+	unsigned int bh;
 	u32 clock_ctl;
 	int rval = 0;
 
@@ -6276,7 +6281,7 @@ static int tg3_ptp_enable(struct ptp_clock_info *ptp,
 		if (rq->perout.index != 0)
 			return -EINVAL;
 
-		tg3_full_lock(tp, 0);
+		bh = tg3_full_lock(tp, 0);
 		clock_ctl = tr32(TG3_EAV_REF_CLCK_CTL);
 		clock_ctl &= ~TG3_EAV_CTL_TSYNC_GPIO_MASK;
 
@@ -6313,7 +6318,7 @@ static int tg3_ptp_enable(struct ptp_clock_info *ptp,
 		}
 
 err_out:
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 		return rval;
 
 	default:
@@ -7428,7 +7433,7 @@ static inline void tg3_netif_start(struct tg3 *tp)
 	tg3_enable_ints(tp);
 }
 
-static void tg3_irq_quiesce(struct tg3 *tp)
+static unsigned int tg3_irq_quiesce(struct tg3 *tp, unsigned int bh)
 	__releases(tp->lock)
 	__acquires(tp->lock)
 {
@@ -7445,6 +7450,8 @@ static void tg3_irq_quiesce(struct tg3 *tp)
 		synchronize_irq(tp->napi[i].irq_vec);
 
 	spin_lock_bh(&tp->lock);
+
+	return 0;
 }
 
 /* Fully shutdown all tg3 driver activity elsewhere in the system.
@@ -7452,14 +7459,18 @@ static void tg3_irq_quiesce(struct tg3 *tp)
  * with as well.  Most of the time, this is not necessary except when
  * shutting down the device.
  */
-static inline void tg3_full_lock(struct tg3 *tp, int irq_sync)
+static inline unsigned int tg3_full_lock(struct tg3 *tp, int irq_sync)
 {
+	unsigned int bh = 0;
+
 	spin_lock_bh(&tp->lock);
 	if (irq_sync)
-		tg3_irq_quiesce(tp);
+		bh = tg3_irq_quiesce(tp, bh);
+
+	return bh;
 }
 
-static inline void tg3_full_unlock(struct tg3 *tp)
+static inline void tg3_full_unlock(struct tg3 *tp, unsigned int bh)
 {
 	spin_unlock_bh(&tp->lock);
 }
@@ -11184,10 +11195,11 @@ static int tg3_restart_hw(struct tg3 *tp, bool reset_phy)
 static void tg3_reset_task(struct work_struct *work)
 {
 	struct tg3 *tp = container_of(work, struct tg3, reset_task);
+	unsigned int bh;
 	int err;
 
 	rtnl_lock();
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	if (!netif_running(tp->dev)) {
 		tg3_flag_clear(tp, RESET_TASK_PENDING);
@@ -11219,7 +11231,7 @@ static void tg3_reset_task(struct work_struct *work)
 	tg3_netif_start(tp);
 
 out:
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	if (!err)
 		tg3_phy_start(tp);
@@ -11350,6 +11362,7 @@ static int tg3_test_msi(struct tg3 *tp)
 {
 	int err;
 	u16 pci_cmd;
+	unsigned int bh;
 
 	if (!tg3_flag(tp, USING_MSI))
 		return 0;
@@ -11391,12 +11404,12 @@ static int tg3_test_msi(struct tg3 *tp)
 	/* Need to reset the chip because the MSI cycle may have terminated
 	 * with Master Abort.
 	 */
-	tg3_full_lock(tp, 1);
+	bh = tg3_full_lock(tp, 1);
 
 	tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 	err = tg3_init_hw(tp, true);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	if (err)
 		free_irq(tp->napi[0].irq_vec, &tp->napi[0]);
@@ -11565,6 +11578,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 		     bool init)
 {
 	struct net_device *dev = tp->dev;
+	unsigned int bh;
 	int i, err;
 
 	/*
@@ -11598,7 +11612,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 		}
 	}
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	if (init)
 		tg3_ape_driver_state_change(tp, RESET_KIND_INIT);
@@ -11609,7 +11623,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 		tg3_free_rings(tp);
 	}
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	if (err)
 		goto out_free_irq;
@@ -11618,10 +11632,10 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 		err = tg3_test_msi(tp);
 
 		if (err) {
-			tg3_full_lock(tp, 0);
+			bh = tg3_full_lock(tp, 0);
 			tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 			tg3_free_rings(tp);
-			tg3_full_unlock(tp);
+			tg3_full_unlock(tp, bh);
 
 			goto out_napi_fini;
 		}
@@ -11638,7 +11652,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 
 	tg3_hwmon_open(tp);
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	tg3_timer_start(tp);
 	tg3_flag_set(tp, INIT_COMPLETE);
@@ -11646,7 +11660,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 
 	tg3_ptp_resume(tp);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	netif_tx_start_all_queues(dev);
 
@@ -11679,6 +11693,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 static void tg3_stop(struct tg3 *tp)
 {
 	int i;
+	unsigned int bh;
 
 	tg3_reset_task_cancel(tp);
 	tg3_netif_stop(tp);
@@ -11689,7 +11704,7 @@ static void tg3_stop(struct tg3 *tp)
 
 	tg3_phy_stop(tp);
 
-	tg3_full_lock(tp, 1);
+	bh = tg3_full_lock(tp, 1);
 
 	tg3_disable_ints(tp);
 
@@ -11697,7 +11712,7 @@ static void tg3_stop(struct tg3 *tp)
 	tg3_free_rings(tp);
 	tg3_flag_clear(tp, INIT_COMPLETE);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	for (i = tp->irq_cnt - 1; i >= 0; i--) {
 		struct tg3_napi *tnapi = &tp->napi[i];
@@ -11714,6 +11729,7 @@ static void tg3_stop(struct tg3 *tp)
 static int tg3_open(struct net_device *dev)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	int err;
 
 	if (tp->pcierr_recovery) {
@@ -11750,12 +11766,12 @@ static int tg3_open(struct net_device *dev)
 	if (err)
 		return err;
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	tg3_disable_ints(tp);
 	tg3_flag_clear(tp, INIT_COMPLETE);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	err = tg3_start(tp,
 			!(tp->phy_flags & TG3_PHYFLG_KEEP_LINK_ON_PWRDN),
@@ -11968,6 +11984,7 @@ static void tg3_get_regs(struct net_device *dev,
 		struct ethtool_regs *regs, void *_p)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 
 	regs->version = 0;
 
@@ -11976,11 +11993,11 @@ static void tg3_get_regs(struct net_device *dev,
 	if (tp->phy_flags & TG3_PHYFLG_IS_LOW_POWER)
 		return;
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	tg3_dump_legacy_regs(tp, (u32 *)_p);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 }
 
 static int tg3_get_eeprom_len(struct net_device *dev)
@@ -12217,6 +12234,7 @@ static int tg3_set_link_ksettings(struct net_device *dev,
 {
 	struct tg3 *tp = netdev_priv(dev);
 	u32 speed = cmd->base.speed;
+	unsigned int bh;
 	u32 advertising;
 
 	if (tg3_flag(tp, USE_PHYLIB)) {
@@ -12282,7 +12300,7 @@ static int tg3_set_link_ksettings(struct net_device *dev,
 		}
 	}
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	tp->link_config.autoneg = cmd->base.autoneg;
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
@@ -12303,7 +12321,7 @@ static int tg3_set_link_ksettings(struct net_device *dev,
 	if (netif_running(dev))
 		tg3_setup_phy(tp, true);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	return 0;
 }
@@ -12490,6 +12508,7 @@ static void tg3_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 static int tg3_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *epause)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	int err = 0;
 
 	if (tp->link_config.autoneg == AUTONEG_ENABLE)
@@ -12564,7 +12583,7 @@ static int tg3_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 			irq_sync = 1;
 		}
 
-		tg3_full_lock(tp, irq_sync);
+		bh = tg3_full_lock(tp, irq_sync);
 
 		if (epause->autoneg)
 			tg3_flag_set(tp, PAUSE_AUTONEG);
@@ -12586,7 +12605,7 @@ static int tg3_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 				tg3_netif_start(tp);
 		}
 
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 	}
 
 	tp->phy_flags |= TG3_PHYFLG_USER_CONFIGURED;
@@ -12662,6 +12681,7 @@ static int tg3_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key,
 			const u8 hfunc)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	size_t i;
 
 	/* We require at least one supported parameter to be changed and no
@@ -12683,9 +12703,9 @@ static int tg3_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key,
 	/* It is legal to write the indirection
 	 * table while the device is running.
 	 */
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	tg3_rss_write_indir_tbl(tp);
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, 0);
 
 	return 0;
 }
@@ -13762,6 +13782,7 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 			  u64 *data)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	bool doextlpbk = etest->flags & ETH_TEST_FL_EXTERNAL_LB;
 
 	if (tp->phy_flags & TG3_PHYFLG_IS_LOW_POWER) {
@@ -13792,7 +13813,7 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 			irq_sync = 1;
 		}
 
-		tg3_full_lock(tp, irq_sync);
+		bh = tg3_full_lock(tp, irq_sync);
 		tg3_halt(tp, RESET_KIND_SUSPEND, 1);
 		err = tg3_nvram_lock(tp);
 		tg3_halt_cpu(tp, RX_CPU_BASE);
@@ -13820,14 +13841,14 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 		if (tg3_test_loopback(tp, data, doextlpbk))
 			etest->flags |= ETH_TEST_FL_FAILED;
 
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 
 		if (tg3_test_interrupt(tp) != 0) {
 			etest->flags |= ETH_TEST_FL_FAILED;
 			data[TG3_INTERRUPT_TEST] = 1;
 		}
 
-		tg3_full_lock(tp, 0);
+		bh = tg3_full_lock(tp, 0);
 
 		tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 		if (netif_running(dev)) {
@@ -13837,7 +13858,7 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 				tg3_netif_start(tp);
 		}
 
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 
 		if (irq_sync && !err2)
 			tg3_phy_start(tp);
@@ -14071,6 +14092,7 @@ static int tg3_get_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
 static int tg3_set_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	u32 max_rxcoal_tick_int = 0, max_txcoal_tick_int = 0;
 	u32 max_stat_coal_ticks = 0, min_stat_coal_ticks = 0;
 
@@ -14107,9 +14129,9 @@ static int tg3_set_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
 	tp->coal.stats_block_coalesce_usecs = ec->stats_block_coalesce_usecs;
 
 	if (netif_running(dev)) {
-		tg3_full_lock(tp, 0);
+		bh = tg3_full_lock(tp, 0);
 		__tg3_set_coalesce(tp, &tp->coal);
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 	}
 	return 0;
 }
@@ -14117,6 +14139,7 @@ static int tg3_set_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
 static int tg3_set_eee(struct net_device *dev, struct ethtool_eee *edata)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 
 	if (!(tp->phy_flags & TG3_PHYFLG_EEE_CAP)) {
 		netdev_warn(tp->dev, "Board does not support EEE!\n");
@@ -14142,10 +14165,10 @@ static int tg3_set_eee(struct net_device *dev, struct ethtool_eee *edata)
 	tg3_warn_mgmt_link_flap(tp);
 
 	if (netif_running(tp->dev)) {
-		tg3_full_lock(tp, 0);
+		bh = tg3_full_lock(tp, 0);
 		tg3_setup_eee(tp);
 		tg3_phy_reset(tp);
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 	}
 
 	return 0;
@@ -14221,13 +14244,14 @@ static void tg3_get_stats64(struct net_device *dev,
 static void tg3_set_rx_mode(struct net_device *dev)
 {
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 
 	if (!netif_running(dev))
 		return;
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	__tg3_set_rx_mode(dev);
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 }
 
 static inline void tg3_set_mtu(struct net_device *dev, struct tg3 *tp,
@@ -14256,6 +14280,7 @@ static int tg3_change_mtu(struct net_device *dev, int new_mtu)
 	struct tg3 *tp = netdev_priv(dev);
 	int err;
 	bool reset_phy = false;
+	unsigned int bh;
 
 	if (!netif_running(dev)) {
 		/* We'll just catch it later when the
@@ -14271,7 +14296,7 @@ static int tg3_change_mtu(struct net_device *dev, int new_mtu)
 
 	tg3_set_mtu(dev, tp, new_mtu);
 
-	tg3_full_lock(tp, 1);
+	bh = tg3_full_lock(tp, 1);
 
 	tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 
@@ -14289,7 +14314,7 @@ static int tg3_change_mtu(struct net_device *dev, int new_mtu)
 	if (!err)
 		tg3_netif_start(tp);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	if (!err)
 		tg3_phy_start(tp);
@@ -17663,6 +17688,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	char str[40];
 	u64 dma_mask, persist_dma_mask;
 	netdev_features_t features = 0;
+	unsigned int bh;
 
 	printk_once(KERN_INFO "%s\n", version);
 
@@ -17945,10 +17971,10 @@ static int tg3_init_one(struct pci_dev *pdev,
 	 */
 	if ((tr32(HOSTCC_MODE) & HOSTCC_MODE_ENABLE) ||
 	    (tr32(WDMAC_MODE) & WDMAC_MODE_ENABLE)) {
-		tg3_full_lock(tp, 0);
+		bh = tg3_full_lock(tp, 0);
 		tw32(MEMARB_MODE, MEMARB_MODE_ENABLE);
 		tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 	}
 
 	err = tg3_test_dma(tp);
@@ -18085,6 +18111,7 @@ static int tg3_suspend(struct device *device)
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	int err = 0;
 
 	rtnl_lock();
@@ -18098,22 +18125,22 @@ static int tg3_suspend(struct device *device)
 
 	tg3_timer_stop(tp);
 
-	tg3_full_lock(tp, 1);
+	bh= tg3_full_lock(tp, 1);
 	tg3_disable_ints(tp);
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	netif_device_detach(dev);
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 	tg3_flag_clear(tp, INIT_COMPLETE);
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	err = tg3_power_down_prepare(tp);
 	if (err) {
 		int err2;
 
-		tg3_full_lock(tp, 0);
+		bh = tg3_full_lock(tp, 0);
 
 		tg3_flag_set(tp, INIT_COMPLETE);
 		err2 = tg3_restart_hw(tp, true);
@@ -18126,7 +18153,7 @@ static int tg3_suspend(struct device *device)
 		tg3_netif_start(tp);
 
 out:
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 
 		if (!err2)
 			tg3_phy_start(tp);
@@ -18142,6 +18169,7 @@ static int tg3_resume(struct device *device)
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(dev);
+	unsigned int bh;
 	int err = 0;
 
 	rtnl_lock();
@@ -18151,7 +18179,7 @@ static int tg3_resume(struct device *device)
 
 	netif_device_attach(dev);
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 
 	tg3_ape_driver_state_change(tp, RESET_KIND_INIT);
 
@@ -18166,7 +18194,7 @@ static int tg3_resume(struct device *device)
 	tg3_netif_start(tp);
 
 out:
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	if (!err)
 		tg3_phy_start(tp);
@@ -18210,6 +18238,7 @@ static pci_ers_result_t tg3_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(netdev);
 	pci_ers_result_t err = PCI_ERS_RESULT_NEED_RESET;
+	unsigned int bh;
 
 	netdev_info(netdev, "PCI I/O error detected\n");
 
@@ -18235,9 +18264,9 @@ static pci_ers_result_t tg3_io_error_detected(struct pci_dev *pdev,
 	netif_device_detach(netdev);
 
 	/* Clean up software state, even if MMIO is blocked */
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	tg3_halt(tp, RESET_KIND_SHUTDOWN, 0);
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 done:
 	if (state == pci_channel_io_perm_failure) {
@@ -18315,6 +18344,7 @@ static void tg3_io_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(netdev);
+	unsigned int bh;
 	int err;
 
 	rtnl_lock();
@@ -18322,12 +18352,12 @@ static void tg3_io_resume(struct pci_dev *pdev)
 	if (!netdev || !netif_running(netdev))
 		goto done;
 
-	tg3_full_lock(tp, 0);
+	bh = tg3_full_lock(tp, 0);
 	tg3_ape_driver_state_change(tp, RESET_KIND_INIT);
 	tg3_flag_set(tp, INIT_COMPLETE);
 	err = tg3_restart_hw(tp, true);
 	if (err) {
-		tg3_full_unlock(tp);
+		tg3_full_unlock(tp, bh);
 		netdev_err(netdev, "Cannot restart hardware after reset.\n");
 		goto done;
 	}
@@ -18338,7 +18368,7 @@ static void tg3_io_resume(struct pci_dev *pdev)
 
 	tg3_netif_start(tp);
 
-	tg3_full_unlock(tp);
+	tg3_full_unlock(tp, bh);
 
 	tg3_phy_start(tp);
 
-- 
2.7.4

