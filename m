Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4774DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC221557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8AhRgTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBC221557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeJHWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbeJHWj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C5621479;
        Mon,  8 Oct 2018 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012433;
        bh=9UNb5w0cCEJfjkCMnfjxvd3I637c0QbGpSh9M01Sr9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8AhRgThT9CJtXfG/yrYe2+fxKDlpiK19fSf0vPUzaSX5Gac5xlySD7sAEehhXkpy
         aBNRCsMpGtYjABsKbqSDiD0GWE7l/xx00yoAMd2A8hjQiWjzz8Q46qyo7iV5lU0WfD
         ZReMCKNpQFeVUhZRwrlCyoQh8YY2xJg/kglB5pSY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Lindner <mareklindner@neomailbox.ch>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/23] batman-adv: fix hardif_neigh refcount on queue_work() failure
Date:   Mon,  8 Oct 2018 11:26:49 -0400
Message-Id: <20181008152703.70891-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Lindner <mareklindner@neomailbox.ch>

[ Upstream commit 4c4af6900844ab04c9434c972021d7b48610e06a ]

The hardif_neigh refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/bat_v_elp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ee08540ce503..5d79004de25c 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -243,6 +243,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
+	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -304,8 +305,11 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 		 * may sleep and that is not allowed in an rcu protected
 		 * context. Therefore schedule a task for that.
 		 */
-		queue_work(batadv_event_workqueue,
-			   &hardif_neigh->bat_v.metric_work);
+		ret = queue_work(batadv_event_workqueue,
+				 &hardif_neigh->bat_v.metric_work);
+
+		if (!ret)
+			batadv_hardif_neigh_put(hardif_neigh);
 	}
 	rcu_read_unlock();
 
-- 
2.17.1

