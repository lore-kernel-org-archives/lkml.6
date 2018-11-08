Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF798C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DF120818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGBgX9io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DF120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbeKIHmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731548AbeKIHmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD5820892;
        Thu,  8 Nov 2018 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714708;
        bh=MkguXUI+2WAlfWLnc899SWDXrSSnG0eqFEz2NsPSIAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGBgX9ioso3v7mfdu5x33SLjb1iQBkhwfMuaARwsxKgM9JPHdaAyFmQdBi0kAA7If
         Sp6yYjgniVVMxmC8XhuB6PwGO7BlNLyJiul844nq3mpyRn+lT3g8O2GeejFhMbkiKt
         jPQKM86pUUDjMb48jVIisXRwymO7iPHUeMFI5weg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 054/171] bnxt_en: Dont use rtnl lock to protect link change logic in workqueue.
Date:   Thu,  8 Nov 2018 13:50:24 -0800
Message-Id: <20181108215131.407370576@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e2dc9b6e38fa3919e63d6d7905da70ca41cbf908 ]

As a further improvement to the PF/VF link change logic, use a private
mutex instead of the rtnl lock to protect link change logic.  With the
new mutex, we don't have to take the rtnl lock in the workqueue when
we have to handle link related functions.  If the VF and PF drivers
are running on the same host and both take the rtnl lock and one is
waiting for the other, it will cause timeout.  This patch fixes these
timeouts.

Fixes: 90c694bb7181 ("bnxt_en: Fix RTNL lock usage on bnxt_update_link().")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +++
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 208e9dacfd34..a036f7039d76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5580,7 +5580,9 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	}
 
 	if (link_re_init) {
+		mutex_lock(&bp->link_lock);
 		rc = bnxt_update_phy_setting(bp);
+		mutex_unlock(&bp->link_lock);
 		if (rc)
 			netdev_warn(bp->dev, "failed to update phy settings\n");
 	}
@@ -6230,30 +6232,28 @@ static void bnxt_sp_task(struct work_struct *work)
 	if (test_and_clear_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event))
 		bnxt_hwrm_port_qstats(bp);
 
-	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
-	 * must be the last functions to be called before exiting.
-	 */
 	if (test_and_clear_bit(BNXT_LINK_CHNG_SP_EVENT, &bp->sp_event)) {
-		int rc = 0;
+		int rc;
 
+		mutex_lock(&bp->link_lock);
 		if (test_and_clear_bit(BNXT_LINK_SPEED_CHNG_SP_EVENT,
 				       &bp->sp_event))
 			bnxt_hwrm_phy_qcaps(bp);
 
-		bnxt_rtnl_lock_sp(bp);
-		if (test_bit(BNXT_STATE_OPEN, &bp->state))
-			rc = bnxt_update_link(bp, true);
-		bnxt_rtnl_unlock_sp(bp);
+		rc = bnxt_update_link(bp, true);
+		mutex_unlock(&bp->link_lock);
 		if (rc)
 			netdev_err(bp->dev, "SP task can't update link (rc: %x)\n",
 				   rc);
 	}
 	if (test_and_clear_bit(BNXT_HWRM_PORT_MODULE_SP_EVENT, &bp->sp_event)) {
-		bnxt_rtnl_lock_sp(bp);
-		if (test_bit(BNXT_STATE_OPEN, &bp->state))
-			bnxt_get_port_module_status(bp);
-		bnxt_rtnl_unlock_sp(bp);
+		mutex_lock(&bp->link_lock);
+		bnxt_get_port_module_status(bp);
+		mutex_unlock(&bp->link_lock);
 	}
+	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
+	 * must be the last functions to be called before exiting.
+	 */
 	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event))
 		bnxt_reset(bp, false);
 
@@ -6788,6 +6788,7 @@ static int bnxt_probe_phy(struct bnxt *bp)
 			   rc);
 		return rc;
 	}
+	mutex_init(&bp->link_lock);
 
 	rc = bnxt_update_link(bp, false);
 	if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 666bc0608ed7..017c10c53715 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1109,6 +1109,10 @@ struct bnxt {
 	unsigned long		*ntp_fltr_bmap;
 	int			ntp_fltr_count;
 
+	/* To protect link related settings during link changes and
+	 * ethtool settings changes.
+	 */
+	struct mutex		link_lock;
 	struct bnxt_link_info	link_info;
 	struct ethtool_eee	eee;
 	u32			lpi_tmr_lo;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cde4b96f3153..3a352f76e633 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -793,6 +793,7 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	u32 ethtool_speed;
 
 	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
+	mutex_lock(&bp->link_lock);
 	bnxt_fw_to_ethtool_support_spds(link_info, lk_ksettings);
 
 	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
@@ -840,6 +841,7 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 			base->port = PORT_FIBRE;
 	}
 	base->phy_address = link_info->phy_addr;
+	mutex_unlock(&bp->link_lock);
 
 	return 0;
 }
@@ -926,6 +928,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
 	if (!BNXT_SINGLE_PF(bp))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&bp->link_lock);
 	if (base->autoneg == AUTONEG_ENABLE) {
 		BNXT_ETHTOOL_TO_FW_SPDS(fw_advertising, lk_ksettings,
 					advertising);
@@ -970,6 +973,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
 		rc = bnxt_hwrm_set_link_setting(bp, set_pause, false);
 
 set_setting_exit:
+	mutex_unlock(&bp->link_lock);
 	return rc;
 }
 
-- 
2.17.1



