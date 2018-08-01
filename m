Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECA120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECA120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405526AbeHATH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:07:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389715AbeHATH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:07:56 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36763CF7;
        Wed,  1 Aug 2018 17:21:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 187/246] igb: Fix queue selection on MAC filters on i210
Date:   Wed,  1 Aug 2018 18:51:37 +0200
Message-Id: <20180801165020.663383255@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 4dc93fcf0b95dc3fda4db917effae31fbb8ad2a8 ]

On the RAH registers there are semantic differences on the meaning of
the "queue" parameter for traffic steering depending on the controller
model: there is the 82575 meaning, which "queue" means a RX Hardware
Queue, and the i350 meaning, where it is a reception pool.

The previous behaviour was having no effect for i210 based controllers
because the QSEL bit of the RAH register wasn't being set.

This patch separates the condition in discrete cases, so the different
handling is clearer.

Fixes: 83c21335c876 ("igb: improve MAC filter handling")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8376,12 +8376,17 @@ static void igb_rar_set_index(struct igb
 		if (is_valid_ether_addr(addr))
 			rar_high |= E1000_RAH_AV;
 
-		if (hw->mac.type == e1000_82575)
+		switch (hw->mac.type) {
+		case e1000_82575:
+		case e1000_i210:
 			rar_high |= E1000_RAH_POOL_1 *
 				    adapter->mac_table[index].queue;
-		else
+			break;
+		default:
 			rar_high |= E1000_RAH_POOL_1 <<
 				    adapter->mac_table[index].queue;
+			break;
+		}
 	}
 
 	wr32(E1000_RAL(index), rar_low);


