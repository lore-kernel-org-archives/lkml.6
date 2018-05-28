Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423788AbeE1LJe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423403AbeE1LJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 112/272] mt76x2: fix possible NULL pointer dereferencing in mt76x2_tx()
Date: Mon, 28 May 2018 12:02:25 +0200
Message-Id: <20180528100250.618608699@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 6958b027435aa54d82bbef09a007fd287f439977 ]

Fix a theoretical NULL pointer dereferencing in mt76x2_tx routine that
can occurs for injected frames in a monitor vif since vif pointer could
be NULL for that interfaces

Fixes: 23405236460b ("mt76: fix transmission of encrypted mgmt frames")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Acked-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x2_tx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_tx.c
@@ -36,9 +36,12 @@ void mt76x2_tx(struct ieee80211_hw *hw,
 
 		msta = (struct mt76x2_sta *) control->sta->drv_priv;
 		wcid = &msta->wcid;
+		/* sw encrypted frames */
+		if (!info->control.hw_key && wcid->hw_key_idx != -1)
+			control->sta = NULL;
 	}
 
-	if (vif || (!info->control.hw_key && wcid->hw_key_idx != -1)) {
+	if (vif && !control->sta) {
 		struct mt76x2_vif *mvif;
 
 		mvif = (struct mt76x2_vif *) vif->drv_priv;
