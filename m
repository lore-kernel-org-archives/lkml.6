Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F6C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADED2156F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNdvcd7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADED2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeJHWj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbeJHWj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3592154C;
        Mon,  8 Oct 2018 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012431;
        bh=/MB0G4n9wNs8d3nIvdPCEQU71Wjr6f7TELeoXCLveUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNdvcd7EteGpiEzrVFYkeYpFQ64apsFgnvJlea1hsN/FTo+xK3Gqc5RytiFKrHTtk
         bWxVb/gJ1fW1FK2a7NW1FiawRLcYfUbJ+t/x6vDvMV+CeP3o4NTpDp1/khuS7p292g
         ZVdfyNzDbbtlyyYTCE26iaI+GCfk1OfJtbURKt7E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/23] batman-adv: Prevent duplicated tvlv handler
Date:   Mon,  8 Oct 2018 11:26:47 -0400
Message-Id: <20181008152703.70891-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit ae3cdc97dc10c7a3b31f297dab429bfb774c9ccb ]

The function batadv_tvlv_handler_register is responsible for adding new
tvlv_handler to the handler_list. It first checks whether the entry
already is in the list or not. If it is, then the creation of a new entry
is aborted.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/tvlv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 77654f055f24..8e91a26e9b00 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -528,15 +528,20 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_handler *tvlv_handler;
 
+	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+
 	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
 	if (tvlv_handler) {
+		spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
 		batadv_tvlv_handler_put(tvlv_handler);
 		return;
 	}
 
 	tvlv_handler = kzalloc(sizeof(*tvlv_handler), GFP_ATOMIC);
-	if (!tvlv_handler)
+	if (!tvlv_handler) {
+		spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
 		return;
+	}
 
 	tvlv_handler->ogm_handler = optr;
 	tvlv_handler->unicast_handler = uptr;
@@ -546,7 +551,6 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 	kref_init(&tvlv_handler->refcount);
 	INIT_HLIST_NODE(&tvlv_handler->list);
 
-	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
 	kref_get(&tvlv_handler->refcount);
 	hlist_add_head_rcu(&tvlv_handler->list, &bat_priv->tvlv.handler_list);
 	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
-- 
2.17.1

