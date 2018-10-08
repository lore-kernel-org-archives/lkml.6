Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD54C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC352086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFO6ClhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC352086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeJHWur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbeJHWhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299FF2145D;
        Mon,  8 Oct 2018 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012338;
        bh=OqVDLI38IOd+1PyRD0hsblu11L8+F83XLszN8QUdkIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFO6ClhK5dt77VkW1K+POWoB94IjDpby3kowXxfT3goPRSzMo+s84EQSy1icuidu/
         0DXFi/BqzJEBhYblSNjicvaf60jFrxHiRZAPeVMScsstlUn34VE5eXiQMwdeuvGxY0
         EoR2+KCdqEbwelKE3ZeqXE8e8U3y3ic2Sydn99b4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/58] batman-adv: Prevent duplicated global TT entry
Date:   Mon,  8 Oct 2018 11:24:37 -0400
Message-Id: <20181008152523.70705-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit e7136e48ffdfb9f37b0820f619380485eb407361 ]

The function batadv_tt_global_orig_entry_add is responsible for adding new
tt_orig_list_entry to the orig_list. It first checks whether the entry
already is in the list or not. If it is, then the creation of a new entry
is aborted.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: d657e621a0f5 ("batman-adv: add reference counting for type batadv_tt_orig_list_entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 12a2b7d21376..d21624c44665 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1613,6 +1613,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 
+	spin_lock_bh(&tt_global->list_lock);
+
 	orig_entry = batadv_tt_global_orig_entry_find(tt_global, orig_node);
 	if (orig_entry) {
 		/* refresh the ttvn: the current value could be a bogus one that
@@ -1635,11 +1637,9 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	orig_entry->flags = flags;
 	kref_init(&orig_entry->refcount);
 
-	spin_lock_bh(&tt_global->list_lock);
 	kref_get(&orig_entry->refcount);
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
-	spin_unlock_bh(&tt_global->list_lock);
 	atomic_inc(&tt_global->orig_list_count);
 
 sync_flags:
@@ -1647,6 +1647,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 out:
 	if (orig_entry)
 		batadv_tt_orig_list_entry_put(orig_entry);
+
+	spin_unlock_bh(&tt_global->list_lock);
 }
 
 /**
-- 
2.17.1

