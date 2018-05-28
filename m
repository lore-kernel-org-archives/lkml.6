Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423852AbeE1LKB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423830AbeE1LJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 113/272] mt76x2: fix warning in ieee80211_get_key_rx_seq()
Date: Mon, 28 May 2018 12:02:26 +0200
Message-Id: <20180528100250.694063970@linuxfoundation.org>
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

[ Upstream commit c03a5aacde0c86f6dabab8f17a6d1911ee13b6c4 ]

Fall back to software encryption for hw unsupported ciphers in order
to fix the following warning in ieee80211_get_key_rx_seq routine:

WARNING: CPU: 1 PID: 1277 at backports-2017-11-01/net/mac80211/key.c:
1010 mt76_wcid_key_setup+0x6c/0x138 [mt76]
CPU: 1 PID: 1277 Comm: hostapd Tainted: G        W       4.9.86 #0
Stack : 00000000 00000000 80527b4a 00000042 80523824 00000000 00000000 80520000
        8fd79a9c 804bbda7 80454c84 00000001 000004fd 80523824 8f7e4ba0 8eceda12
        00000010 8006af94 00000001 80520000 804c1f04 804c1f08 80459890 8ec999b4
        00000003 800a7840 8f7e4ba0 8eceda12 8121de20 00000000 00000001 00c999b4
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        ...
Call Trace:
[<8000f52c>] show_stack+0x70/0x8c
[<801d8d04>] dump_stack+0x94/0xd0
[<8002bcd4>] __warn+0x110/0x118
[<8002bd70>] warn_slowpath_null+0x1c/0x2c
[<8f0415cc>] mt76_wcid_key_setup+0x6c/0x138 [mt76]
[<8f1311b4>] mt76x2_dma_cleanup+0xa38/0x1048 [mt76x2e]

Fixes: 30ce7f4456ae ("mt76: validate rx CCMP PN")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Acked-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt76x2_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_main.c
@@ -336,6 +336,17 @@ mt76x2_set_key(struct ieee80211_hw *hw,
 	int idx = key->keyidx;
 	int ret;
 
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	/*
 	 * The hardware does not support per-STA RX GTK, fall back
 	 * to software mode for these.
