Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163267AbeE1NaX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163190AbeE1KrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 132/496] mac80211: drop frames with unexpected DS bits from fast-rx to slow path
Date: Mon, 28 May 2018 11:58:37 +0200
Message-Id: <20180528100325.498368563@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit b323ac19b7734a1c464b2785a082ee50bccd3b91 ]

Fixes rx for 4-addr packets in AP mode. These may be used for setting
up a 4-addr link for stations that are allowed to do so.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3928,7 +3928,7 @@ static bool ieee80211_invoke_fast_rx(str
 	if ((hdr->frame_control & cpu_to_le16(IEEE80211_FCTL_FROMDS |
 					      IEEE80211_FCTL_TODS)) !=
 	    fast_rx->expected_ds_bits)
-		goto drop;
+		return false;
 
 	/* assign the key to drop unencrypted frames (later)
 	 * and strip the IV/MIC if necessary
