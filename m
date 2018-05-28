Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033772AbeE1Kp1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937621AbeE1KpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avraham Stern <avraham.stern@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 094/496] cfg80211: clear wep keys after disconnection
Date: Mon, 28 May 2018 11:57:59 +0200
Message-Id: <20180528100323.834602073@linuxfoundation.org>
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

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 3027a8e799b20fc922496a12f8ad2f9f36a8a696 ]

When a low level driver calls cfg80211_disconnected(), wep keys are
not cleared. As a result, following connection requests will fail
since cfg80211 internal state shows a connection is still in progress.

Fix this by clearing the wep keys when disconnecting.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/sme.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -989,6 +989,8 @@ void __cfg80211_disconnected(struct net_
 	wdev->current_bss = NULL;
 	wdev->ssid_len = 0;
 	wdev->conn_owner_nlportid = 0;
+	kzfree(wdev->connect_keys);
+	wdev->connect_keys = NULL;
 
 	nl80211_send_disconnected(rdev, dev, reason, ie, ie_len, from_ap);
 
