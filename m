Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83939C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C33214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896142;
	bh=MfyxUor4WdtfFgvBbOflf2jkGPruXxJ0brK9fptM/tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tlAfRXUbOpImnqZTuTxzMfnx7W/XBAvJVW9sXdbBVecb0WPLuINcDAn2pWXHaHrUW
	 WpVydJksZHufdIg26hhCPipYKxN9chjo6y/lpeE3LgBJMGOmW/Kk/RWQM+N9/eq7ju
	 Y+7KdI/ezu7cKOuNzKxAdwccQcmu1wQB82nlbf1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfBKOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbfBKOmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:42:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C9020700;
        Mon, 11 Feb 2019 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896139;
        bh=MfyxUor4WdtfFgvBbOflf2jkGPruXxJ0brK9fptM/tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXl39BvzfX2pZpbahQNJH0QE7WbeTVszLXmEngUxcoZSJV+28BZI9NBpE/svnab9R
         zS5nvRn1WjmpKLkFewux1ZciwkUIOwC1fGUzadjAlOMC/lJ4Xf9z6sJgwG31hqAW6H
         2VHkcMDnG6m1ot29VP2/GlKXf8WT/jiIED5qZHLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/313] mt76x0: dfs: fix IBI_R11 configuration on non-radar channels
Date:   Mon, 11 Feb 2019 15:16:04 +0100
Message-Id: <20190211141859.468502300@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c
index 374cc655c11d..16e6b6970e28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c
@@ -799,7 +799,7 @@ static void mt76x2_dfs_set_bbp_params(struct mt76x2_dev *dev)
 
 	/* enable detection*/
 	mt76_wr(dev, MT_BBP(DFS, 0), MT_DFS_CH_EN << 16);
-	mt76_wr(dev, 0x212c, 0x0c350001);
+	mt76_wr(dev, MT_BBP(IBI, 11), 0x0c350001);
 }
 
 void mt76x2_dfs_adjust_agc(struct mt76x2_dev *dev)
@@ -842,7 +842,11 @@ void mt76x2_dfs_init_params(struct mt76x2_dev *dev)
 		mt76_wr(dev, MT_BBP(DFS, 0), 0);
 		/* clear detector status */
 		mt76_wr(dev, MT_BBP(DFS, 1), 0xf);
-		mt76_wr(dev, 0x212c, 0);
+		if (mt76_chip(&dev->mt76) == 0x7610 ||
+		    mt76_chip(&dev->mt76) == 0x7630)
+			mt76_wr(dev, MT_BBP(IBI, 11), 0xfde8081);
+		else
+			mt76_wr(dev, MT_BBP(IBI, 11), 0);
 
 		mt76x2_irq_disable(dev, MT_INT_GPTIMER);
 		mt76_rmw_field(dev, MT_INT_TIMER_EN,
-- 
2.19.1



