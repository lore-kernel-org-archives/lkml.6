Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEB3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1793420866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwSErbZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJPMZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbeJPMAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9459221477;
        Tue, 16 Oct 2018 04:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663150;
        bh=UJDu9dT2EaQWEhw5D8c+94whtnk8XYIiOQ63h2Ve4N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwSErbZ1c2nwUMIW61Vx9O2vgXn0rbzl7MYqnHWIbFI9vEO8EMbKmVQpOg5xXOvXq
         0xr/CY+gyCDVMU/9kyQHxUR7xreqddJATVkvJCT2nyRJsvNvhHol5zNfGZ8/Wmyduw
         dnoXQxwtKHyw2K1bQArTCXKoR6KEu24+0Yv+to9w=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 005/100] mac80211: Always report TX status
Date:   Tue, 16 Oct 2018 00:10:46 -0400
Message-Id: <20181016041221.135528-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

[ Upstream commit 8682250b3c1b75a45feb7452bc413d004cfe3778 ]

If a frame is dropped for any reason, mac80211 wouldn't report the TX
status back to user space.

As the user space may rely on the TX_STATUS to kick its state
machines, resends etc, it's better to just report this frame as not
acked instead.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/status.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 9a6d7208bf4f..001a869c059c 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -479,11 +479,6 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 	if (!skb)
 		return;
 
-	if (dropped) {
-		dev_kfree_skb_any(skb);
-		return;
-	}
-
 	if (info->flags & IEEE80211_TX_INTFL_NL80211_FRAME_TX) {
 		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
 		struct ieee80211_sub_if_data *sdata;
@@ -506,6 +501,8 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		}
 		rcu_read_unlock();
 
+		dev_kfree_skb_any(skb);
+	} else if (dropped) {
 		dev_kfree_skb_any(skb);
 	} else {
 		/* consumes skb */
-- 
2.17.1

