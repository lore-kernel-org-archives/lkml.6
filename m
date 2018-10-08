Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C13C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14A221557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaWl+Dj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14A221557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeJHWpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbeJHWiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6A821529;
        Mon,  8 Oct 2018 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012400;
        bh=Fja1nZROn9vwICx/C8uMTHQcRdWRaWWC0KCeK035GlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaWl+Dj7Imr8p6SC02k1tnQQmt8LhL89EfFzB/MBrWKK+yNNVl80f3a8XmbOKP2TL
         C+objmeyMxTcrVVYevUY3o6SdbCk+kViURxlmpQPi0xcd9dEZZGVsbSqtCUNnpm9xs
         j1379Cwoa6I8dTqA7SXZIU3O+9UX5dcv2IK/Y5xU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Lindner <mareklindner@neomailbox.ch>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/32] batman-adv: fix backbone_gw refcount on queue_work() failure
Date:   Mon,  8 Oct 2018 11:26:07 -0400
Message-Id: <20181008152629.70812-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Lindner <mareklindner@neomailbox.ch>

[ Upstream commit 5af96b9c59c72fb2af2d19c5cc2f3cdcee391dff ]

The backbone_gw refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 422ee16b7854..c3c848f64fdd 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1772,6 +1772,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct ethhdr *ethhdr;
+	bool ret;
 
 	ethhdr = eth_hdr(skb);
 
@@ -1795,8 +1796,13 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (unlikely(!backbone_gw))
 		return true;
 
-	queue_work(batadv_event_workqueue, &backbone_gw->report_work);
-	/* backbone_gw is unreferenced in the report work function function */
+	ret = queue_work(batadv_event_workqueue, &backbone_gw->report_work);
+
+	/* backbone_gw is unreferenced in the report work function function
+	 * if queue_work() call was successful
+	 */
+	if (!ret)
+		batadv_backbone_gw_put(backbone_gw);
 
 	return true;
 }
-- 
2.17.1

