Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FF621486
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FF621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeHWL6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:58:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbeHWL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:58:14 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B50DC74;
        Thu, 23 Aug 2018 08:29:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masashi Honma <masashi.honma@gmail.com>,
        Bob Copeland <bobcopeland@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 110/217] nl80211: relax ht operation checks for mesh
Date:   Thu, 23 Aug 2018 09:53:43 +0200
Message-Id: <20180823075510.428790147@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Copeland <me@bobcopeland.com>

[ Upstream commit 188f60ab8e787fcbb5ac9d64ede23a0070231f09 ]

Commit 9757235f451c, "nl80211: correct checks for
NL80211_MESHCONF_HT_OPMODE value") relaxed the range for the HT
operation field in meshconf, while also adding checks requiring
the non-greenfield and non-ht-sta bits to be set in certain
circumstances.  The latter bit is actually reserved for mesh BSSes
according to Table 9-168 in 802.11-2016, so in fact it should not
be set.

wpa_supplicant sets these bits because the mesh and AP code share
the same implementation, but authsae does not.  As a result, some
meshconf updates from authsae which set only the NONHT_MIXED
protection bits were being rejected.

In order to avoid breaking userspace by changing the rules again,
simply accept the values with or without the bits set, and mask
off the reserved bit to match the spec.

While in here, update the 802.11-2012 reference to 802.11-2016.

Fixes: 9757235f451c ("nl80211: correct checks for NL80211_MESHCONF_HT_OPMODE value")
Cc: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Bob Copeland <bobcopeland@fb.com>
Reviewed-by: Masashi Honma <masashi.honma@gmail.com>
Reviewed-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5990,7 +5990,7 @@ do {									    \
 				  nl80211_check_s32);
 	/*
 	 * Check HT operation mode based on
-	 * IEEE 802.11 2012 8.4.2.59 HT Operation element.
+	 * IEEE 802.11-2016 9.4.2.57 HT Operation element.
 	 */
 	if (tb[NL80211_MESHCONF_HT_OPMODE]) {
 		ht_opmode = nla_get_u16(tb[NL80211_MESHCONF_HT_OPMODE]);
@@ -6000,22 +6000,9 @@ do {									    \
 				  IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT))
 			return -EINVAL;
 
-		if ((ht_opmode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT) &&
-		    (ht_opmode & IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT))
-			return -EINVAL;
+		/* NON_HT_STA bit is reserved, but some programs set it */
+		ht_opmode &= ~IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT;
 
-		switch (ht_opmode & IEEE80211_HT_OP_MODE_PROTECTION) {
-		case IEEE80211_HT_OP_MODE_PROTECTION_NONE:
-		case IEEE80211_HT_OP_MODE_PROTECTION_20MHZ:
-			if (ht_opmode & IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT)
-				return -EINVAL;
-			break;
-		case IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER:
-		case IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED:
-			if (!(ht_opmode & IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT))
-				return -EINVAL;
-			break;
-		}
 		cfg->ht_opmode = ht_opmode;
 		mask |= (1 << (NL80211_MESHCONF_HT_OPMODE - 1));
 	}


