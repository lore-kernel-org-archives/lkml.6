Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2882AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BA020877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BA020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbeIXSJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:09:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbeIXSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:09:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56C641082;
        Mon, 24 Sep 2018 12:07:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Yanhui He <yanhuih@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 106/111] Partial revert "e1000e: Avoid receiver overrun interrupt bursts"
Date:   Mon, 24 Sep 2018 13:53:13 +0200
Message-Id: <20180924113115.739975723@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
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

From: Benjamin Poirier <bpoirier@suse.com>

commit 1f0ea19722ef9dfa229a9540f70b8d1c34a98a6a upstream.

This partially reverts commit 4aea7a5c5e940c1723add439f4088844cd26196d.

We keep the fix for the first part of the problem (1) described in the log
of that commit, that is to read ICR in the other interrupt handler. We
remove the fix for the second part of the problem (2), Other interrupt
throttling.

Bursts of "Other" interrupts may once again occur during rxo (receive
overflow) traffic conditions. This is deemed acceptable in the interest of
avoiding unforeseen fallout from changes that are not strictly necessary.
As discussed, the e1000e driver should be in "maintenance mode".

Link: https://www.spinics.net/lists/netdev/msg480675.html
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Yanhui He <yanhuih@vmware.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1912,21 +1912,10 @@ static irqreturn_t e1000_msix_other(int
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 icr;
-	bool enable = true;
 
 	icr = er32(ICR);
 	ew32(ICR, E1000_ICR_OTHER);
 
-	if (icr & E1000_ICR_RXO) {
-		ew32(ICR, E1000_ICR_RXO);
-		enable = false;
-		/* napi poll will re-enable Other, make sure it runs */
-		if (napi_schedule_prep(&adapter->napi)) {
-			adapter->total_rx_bytes = 0;
-			adapter->total_rx_packets = 0;
-			__napi_schedule(&adapter->napi);
-		}
-	}
 	if (icr & E1000_ICR_LSC) {
 		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;
@@ -1935,7 +1924,7 @@ static irqreturn_t e1000_msix_other(int
 			mod_timer(&adapter->watchdog_timer, jiffies + 1);
 	}
 
-	if (enable && !test_bit(__E1000_DOWN, &adapter->state))
+	if (!test_bit(__E1000_DOWN, &adapter->state))
 		ew32(IMS, E1000_IMS_OTHER);
 
 	return IRQ_HANDLED;
@@ -2706,8 +2695,7 @@ static int e1000e_poll(struct napi_struc
 		napi_complete_done(napi, work_done);
 		if (!test_bit(__E1000_DOWN, &adapter->state)) {
 			if (adapter->msix_entries)
-				ew32(IMS, adapter->rx_ring->ims_val |
-				     E1000_IMS_OTHER);
+				ew32(IMS, adapter->rx_ring->ims_val);
 			else
 				e1000_irq_enable(adapter);
 		}


