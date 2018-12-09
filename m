Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BBF20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BBF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbeLIWXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:23:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35064 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbeLIVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002ik-Rp; Sun, 09 Dec 2018 21:55:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003SF-Rp; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Johannes Berg" <johannes.berg@intel.com>,
        "Arunk Khandavalli" <akhandav@codeaurora.org>,
        "Jouni Malinen" <jouni@codeaurora.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.137730742@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 174/328] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arunk Khandavalli <akhandav@codeaurora.org>

commit 4f0223bfe9c3e62d8f45a85f1ef1b18a8a263ef9 upstream.

nl80211_update_ft_ies() tried to validate NL80211_ATTR_IE with
is_valid_ie_attr() before dereferencing it, but that helper function
returns true in case of NULL pointer (i.e., attribute not included).
This can result to dereferencing a NULL pointer. Fix that by explicitly
checking that NL80211_ATTR_IE is included.

Fixes: 355199e02b83 ("cfg80211: Extend support for IEEE 802.11r Fast BSS Transition")
Signed-off-by: Arunk Khandavalli <akhandav@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9185,6 +9185,7 @@ static int nl80211_update_ft_ies(struct
 		return -EOPNOTSUPP;
 
 	if (!info->attrs[NL80211_ATTR_MDID] ||
+	    !info->attrs[NL80211_ATTR_IE] ||
 	    !is_valid_ie_attr(info->attrs[NL80211_ATTR_IE]))
 		return -EINVAL;
 

