Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165458AbeE1Ngx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937069AbeE1KpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 096/496] mac80211: Fix sending ADDBA response for an ongoing session
Date: Mon, 28 May 2018 11:58:01 +0200
Message-Id: <20180528100323.911299200@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 3b07029729e347f288c70227cfe3c66b085d6b0b ]

In case an ADDBA request is received while there is already
an ongoing BA sessions with the same parameters, i.e., update
flow, an ADBBA response with decline status was sent twice. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/agg-rx.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -8,6 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -322,9 +323,6 @@ void ___ieee80211_start_rx_ba_session(st
 			 * driver so reject the timeout update.
 			 */
 			status = WLAN_STATUS_REQUEST_DECLINED;
-			ieee80211_send_addba_resp(sta->sdata, sta->sta.addr,
-						  tid, dialog_token, status,
-						  1, buf_size, timeout);
 			goto end;
 		}
 
