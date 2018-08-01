Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA312083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA312083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHATuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:50:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405837AbeHATIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11F9D1175;
        Wed,  1 Aug 2018 17:06:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 211/336] bnxt_en: Always forward VF MAC address to the PF.
Date:   Wed,  1 Aug 2018 18:49:06 +0200
Message-Id: <20180801165037.148129507@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 707e7e96602675beb5e09bb994195663da6eb56d ]

The current code already forwards the VF MAC address to the PF, except
in one case.  If the VF driver gets a valid MAC address from the firmware
during probe time, it will not forward the MAC address to the PF,
incorrectly assuming that the PF already knows the MAC address.  This
causes "ip link show" to show zero VF MAC addresses for this case.

This assumption is not correct.  Newer firmware remembers the VF MAC
address last used by the VF and provides it to the VF driver during
probe.  So we need to always forward the VF MAC address to the PF.

The forwarded MAC address may now be the PF assigned MAC address and so we
need to make sure we approve it for this case.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8617,8 +8617,8 @@ static int bnxt_init_mac_addr(struct bnx
 			memcpy(bp->dev->dev_addr, vf->mac_addr, ETH_ALEN);
 		} else {
 			eth_hw_addr_random(bp->dev);
-			rc = bnxt_approve_mac(bp, bp->dev->dev_addr);
 		}
+		rc = bnxt_approve_mac(bp, bp->dev->dev_addr);
 #endif
 	}
 	return rc;
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -914,7 +914,8 @@ static int bnxt_vf_configure_mac(struct
 	if (req->enables & cpu_to_le32(FUNC_VF_CFG_REQ_ENABLES_DFLT_MAC_ADDR)) {
 		if (is_valid_ether_addr(req->dflt_mac_addr) &&
 		    ((vf->flags & BNXT_VF_TRUST) ||
-		     (!is_valid_ether_addr(vf->mac_addr)))) {
+		     !is_valid_ether_addr(vf->mac_addr) ||
+		     ether_addr_equal(req->dflt_mac_addr, vf->mac_addr))) {
 			ether_addr_copy(vf->vf_mac_addr, req->dflt_mac_addr);
 			return bnxt_hwrm_exec_fwd_resp(bp, vf, msg_size);
 		}


