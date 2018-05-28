Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937759AbeE1KpW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937741AbeE1KpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 093/496] mac80211: fix calling sleeping function in atomic context
Date: Mon, 28 May 2018 11:57:58 +0200
Message-Id: <20180528100323.792889780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 95f3ce6a77893ac828ba841df44421620de4314b ]

sta_info_alloc can be called from atomic paths (such as RX path)
so we need to call pcpu_alloc with the correct gfp.

Fixes: c9c5962b56c1 ("mac80211: enable collecting station statistics per-CPU")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/sta_info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -314,7 +314,7 @@ struct sta_info *sta_info_alloc(struct i
 
 	if (ieee80211_hw_check(hw, USES_RSS)) {
 		sta->pcpu_rx_stats =
-			alloc_percpu(struct ieee80211_sta_rx_stats);
+			alloc_percpu_gfp(struct ieee80211_sta_rx_stats, gfp);
 		if (!sta->pcpu_rx_stats)
 			goto free;
 	}
