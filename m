Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E15920844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895126;
	bh=EehrWLcbKerHAtfAAk9m4siQDbdq6ELgMkbhOojJxdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOhmcfN28clE53d8bZgKf07N32qRKI8LwYjpoAgbGoJHvCDfOSn+8PieWludfJN4t
	 rJdeWhBNzuTie9Onf+S7VwxKLLgNFAztMj0bwCbfv1Wl89F+IO1+NeYttraA9QHWt3
	 W0FhCzzlDTtuM9XsJ+/ZxWYA8KzhPWitxAha+5RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfBKOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfBKOZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88D9A20821;
        Mon, 11 Feb 2019 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895117;
        bh=EehrWLcbKerHAtfAAk9m4siQDbdq6ELgMkbhOojJxdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAJ4B+skqn+KiaqHtIG73+70OxA6nYb6BtqDQ6XTijRoxwoLtwaltnDuXHTCRglZ2
         UnkyEnMxXBAJhuTida12TQGMUxi5EkVa51iJd/6JxA1309MiirNjCJCaY40RvCdIaa
         bvAl+JkcTYTQE3awlfmqT49bf1Eqig9QT9Qm29gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 097/352] mt76x0: dfs: fix IBI_R11 configuration on non-radar channels
Date:   Mon, 11 Feb 2019 15:15:24 +0100
Message-Id: <20190211141852.007113662@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6bf4a8e902aad7df55d7f2b10b850cfa3f880996 ]

Fix IBI_R11 configuration on non-radar channels for mt76x0e
driver. This patch improve system stability under heavy load.
Moreover use IBI_R11 name and remove magic numbers for
0x212c register

Fixes: 0c3b3abc9251 ("mt76x0: pci: add DFS support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_dfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_dfs.c
index b56febae8945..764528c9f48a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_dfs.c
@@ -800,7 +800,7 @@ static void mt76x2_dfs_set_bbp_params(struct mt76x02_dev *dev)
 
 	/* enable detection*/
 	mt76_wr(dev, MT_BBP(DFS, 0), MT_DFS_CH_EN << 16);
-	mt76_wr(dev, 0x212c, 0x0c350001);
+	mt76_wr(dev, MT_BBP(IBI, 11), 0x0c350001);
 }
 
 void mt76x2_dfs_adjust_agc(struct mt76x02_dev *dev)
@@ -843,7 +843,11 @@ void mt76x2_dfs_init_params(struct mt76x02_dev *dev)
 		mt76_wr(dev, MT_BBP(DFS, 0), 0);
 		/* clear detector status */
 		mt76_wr(dev, MT_BBP(DFS, 1), 0xf);
-		mt76_wr(dev, 0x212c, 0);
+		if (mt76_chip(&dev->mt76) == 0x7610 ||
+		    mt76_chip(&dev->mt76) == 0x7630)
+			mt76_wr(dev, MT_BBP(IBI, 11), 0xfde8081);
+		else
+			mt76_wr(dev, MT_BBP(IBI, 11), 0);
 
 		mt76x02_irq_disable(dev, MT_INT_GPTIMER);
 		mt76_rmw_field(dev, MT_INT_TIMER_EN,
-- 
2.19.1



