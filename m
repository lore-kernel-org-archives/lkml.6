Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165430AbeE1NhP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937753AbeE1KpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 095/496] mac80211: Do not disconnect on invalid operating class
Date: Mon, 28 May 2018 11:58:00 +0200
Message-Id: <20180528100323.873276378@linuxfoundation.org>
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

[ Upstream commit 191da271ac260700db3e5b4bb982a17ca78769d6 ]

Some APs include a non global operating class in their extended channel
switch information element. In such a case, as the operating class is not
known, mac80211 would decide to disconnect.

However the specification states that the operating class needs to be
taken from Annex E, but it does not specify from which table it should be
taken, so it is valid for an AP to use a non global operating class.

To avoid possibly unneeded disconnection, in such a case ignore the
operating class and assume that the current band is used, and if the
resulting channel and band configuration is invalid disconnect.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/spectmgmt.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -8,6 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2008, Intel Corporation
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2018        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -27,7 +28,7 @@ int ieee80211_parse_ch_switch_ie(struct
 				 u32 sta_flags, u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie)
 {
-	enum nl80211_band new_band;
+	enum nl80211_band new_band = current_band;
 	int new_freq;
 	u8 new_chan_no;
 	struct ieee80211_channel *new_chan;
@@ -55,15 +56,13 @@ int ieee80211_parse_ch_switch_ie(struct
 				elems->ext_chansw_ie->new_operating_class,
 				&new_band)) {
 			sdata_info(sdata,
-				   "cannot understand ECSA IE operating class %d, disconnecting\n",
+				   "cannot understand ECSA IE operating class, %d, ignoring\n",
 				   elems->ext_chansw_ie->new_operating_class);
-			return -EINVAL;
 		}
 		new_chan_no = elems->ext_chansw_ie->new_ch_num;
 		csa_ie->count = elems->ext_chansw_ie->count;
 		csa_ie->mode = elems->ext_chansw_ie->mode;
 	} else if (elems->ch_switch_ie) {
-		new_band = current_band;
 		new_chan_no = elems->ch_switch_ie->new_ch_num;
 		csa_ie->count = elems->ch_switch_ie->count;
 		csa_ie->mode = elems->ch_switch_ie->mode;
