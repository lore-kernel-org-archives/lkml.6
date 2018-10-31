Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63397ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836B20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhllJkL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2836B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbeKAITs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbeKAILa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C1620840;
        Wed, 31 Oct 2018 23:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027477;
        bh=AUUzt/ZKy5DqjcQpN3iBfNQ38c6hD5Hb52gfrC9tHRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhllJkL81g5FOcaMzjvcnzXCihtyntg+jOQ3CPL/sNUaeyV4OT909aDhk3DukrSRZ
         s1m7thg+mQHY+MY/goYS/OwTuOEPlyjI2Nr2bJJ+YW4p6F4wcTRdFnmasnUVH8MJxy
         xpEZGRtuZFKG/dMNWn6b5zL7XeufOkK3bhHpyoek=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Basierski <sebastianx.basierski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 26/48] ixgbevf: VF2VF TCP RSS
Date:   Wed, 31 Oct 2018 19:10:32 -0400
Message-Id: <20181031231054.29333-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Basierski <sebastianx.basierski@intel.com>

[ Upstream commit 7fb94bd58dd6650a0158e68d414e185077d8b57a ]

While VF2VF with RSS communication, RSS Type were wrongly recognized
and RSS hash was not calculated as it should be. Packets was
distributed on various queues by accident.
This commit fixes that behaviour and causes proper RSS Type recognition.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 029513294984..75607267e656 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3419,6 +3419,10 @@ static void ixgbevf_tx_csum(struct ixgbevf_ring *tx_ring,
 		skb_checksum_help(skb);
 		goto no_csum;
 	}
+
+	if (first->protocol == htons(ETH_P_IP))
+		type_tucmd |= IXGBE_ADVTXD_TUCMD_IPV4;
+
 	/* update TX checksum flag */
 	first->tx_flags |= IXGBE_TX_FLAGS_CSUM;
 	vlan_macip_lens = skb_checksum_start_offset(skb) -
-- 
2.17.1

