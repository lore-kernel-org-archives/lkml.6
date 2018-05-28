Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940315AbeE1Qh3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934391AbeE1KIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:08:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 059/185] mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4
Date: Mon, 28 May 2018 12:01:40 +0200
Message-Id: <20180528100055.898023397@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 651b9920d7a694ffb1f885aef2bbb068a25d9d66 ]

This ensures that mac80211 allocated management frames are properly
aligned, which makes copying them more efficient.
For instance, mt76 uses iowrite32_copy to copy beacon frames to beacon
template memory on the chip.
Misaligned 32-bit accesses cause CPU exceptions on MIPS and should be
avoided.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/mac80211.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3368,7 +3368,7 @@ static inline int ieee80211_sta_ps_trans
  * The TX headroom reserved by mac80211 for its own tx_status functions.
  * This is enough for the radiotap header.
  */
-#define IEEE80211_TX_STATUS_HEADROOM	14
+#define IEEE80211_TX_STATUS_HEADROOM	ALIGN(14, 4)
 
 /**
  * ieee80211_sta_set_buffered - inform mac80211 about driver-buffered frames
