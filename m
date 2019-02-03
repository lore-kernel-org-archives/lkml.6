Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9204FC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCD0218FC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfBCNvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:51:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54362 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728977AbfBCNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:51:03 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIAn-0003tt-UA; Sun, 03 Feb 2019 13:51:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007OG-2a; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Emmanuel Grumbach" <emmanuel.grumbach@intel.com>,
        "Johannes Berg" <johannes.berg@intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.365151850@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 265/305] mac80211: ignore NullFunc frames in the
 duplicate detection
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 990d71846a0b7281bd933c34d734e6afc7408e7e upstream.

NullFunc packets should never be duplicate just like
QoS-NullFunc packets.

We saw a client that enters / exits power save with
NullFunc frames (and not with QoS-NullFunc) despite the
fact that the association supports HT.
This specific client also re-uses a non-zero sequence number
for different NullFunc frames.
At some point, the client had to send a retransmission of
the NullFunc frame and we dropped it, leading to a
misalignment in the power save state.
Fix this by never consider a NullFunc frame as duplicate,
just like we do for QoS NullFunc frames.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=201449

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[bwh: Backported to 3.16: The condition for "should we check for duplication"
 is in ieee80211_rx_h_check() and is not inverted]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/mac80211/rx.c | 1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -967,6 +967,7 @@ ieee80211_rx_h_check(struct ieee80211_rx
 	 */
 	if (rx->skb->len >= 24 && rx->sta &&
 	    !ieee80211_is_ctl(hdr->frame_control) &&
+	    !ieee80211_is_nullfunc(hdr->frame_control) &&
 	    !ieee80211_is_qos_nullfunc(hdr->frame_control) &&
 	    !is_multicast_ether_addr(hdr->addr1)) {
 		if (unlikely(ieee80211_has_retry(hdr->frame_control) &&

