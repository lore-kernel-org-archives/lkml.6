Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB006ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8654720858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8654720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeISPpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:45:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34654 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731159AbeISPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:45:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so5172636wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mb6vYlvIYmKOjWLuG2K0eChvByDfjqgy7Ys9RpY0B4o=;
        b=HWiqzy8y+seytSA7JFzwiKw3fJ1u4XierK0p4Kfo78U7D+J47lmON3z5jXIZls9Zzz
         jMWWEl94jDgyXN4V6Tqy7RY061svVbJRdNoNl89Bb0Y2jHXh67tkBZFG0RuS4C5EeWwn
         bBtxoMaaAyKwY//zG20jhj1QX+oTzd+7Ae1MkMZnPjR2hJE+LXOziNRLuRLP9+BSd6gX
         uWEv8+9hLzyYPyyh0BJX0oorTAy3ueF47kbfHODH/K/em6ib9/7BT8j32VhUveJwh1rG
         krJZPvBp+fadWH9+Hli3xCHUwECd0ycMwOzGQW4LenGvYf+4phQ9UL5YCMSPgiacUZK/
         QfWA==
X-Gm-Message-State: APzg51DEFkgZTOifG2u+7+6dVgjdsLbs8QbL5oQhwYsgG6zwHK759ckd
        JMShlHSyWt700LreRf4qMLU=
X-Google-Smtp-Source: ANB0VdbHMUJFArsNd47dTIQSFcl+G6iSMJHasnwRtwV47Aiviqp45n5HWV7nKvoty7ZUX62TWeFkoA==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr26796918wrd.253.1537351720869;
        Wed, 19 Sep 2018 03:08:40 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b10-v6sm16530345wrr.88.2018.09.19.03.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 03:08:39 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 70E981253C5;
        Wed, 19 Sep 2018 12:08:38 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 4/5] mm/memory_hotplug: Simplify node_states_check_changes_online
Date:   Wed, 19 Sep 2018 12:08:18 +0200
Message-Id: <20180919100819.25518-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919100819.25518-1-osalvador@techadventures.net>
References: <20180919100819.25518-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

While looking at node_states_check_changes_online, I stumbled
upon some confusing things.

Right after entering the function, we find this:

if (N_MEMORY == N_NORMAL_MEMORY)
        zone_last = ZONE_MOVABLE;

This is wrong.
N_MEMORY cannot really be equal to N_NORMAL_MEMORY.
My guess is that this wanted to be something like:

if (N_NORMAL_MEMORY == N_HIGH_MEMORY)

to check if we have CONFIG_HIGHMEM.

Later on, in the CONFIG_HIGHMEM block, we have:

if (N_MEMORY == N_HIGH_MEMORY)
        zone_last = ZONE_MOVABLE;

Again, this is wrong, and will never be evaluated to true.

Besides removing these wrong if statements, I simplified
the function a bit.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 71 +++++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 131c08106d54..ab3c1de18c5d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -687,61 +687,36 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 	struct zone *zone, struct memory_notify *arg)
 {
 	int nid = zone_to_nid(zone);
-	enum zone_type zone_last = ZONE_NORMAL;
 
 	/*
-	 * If we have HIGHMEM or movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_NORMAL,
-	 * set zone_last to ZONE_NORMAL.
-	 *
-	 * If we don't have HIGHMEM nor movable node,
-	 * node_states[N_NORMAL_MEMORY] contains nodes which have zones of
-	 * 0...ZONE_MOVABLE, set zone_last to ZONE_MOVABLE.
+	 * zone_for_pfn_range() can only return a zone within
+	 * (0..ZONE_NORMAL] or ZONE_MOVABLE.
+	 * If the zone is within the range (0..ZONE_NORMAL],
+	 * we need to check if:
+	 * 1) We need to set the node for N_NORMAL_MEMORY
+	 * 2) On CONFIG_HIGHMEM systems, we need to also set
+	 *    the node for N_HIGH_MEMORY.
+	 * 3) On !CONFIG_HIGHMEM, we can disregard N_HIGH_MEMORY,
+	 *    as N_HIGH_MEMORY falls back to N_NORMAL_MEMORY.
 	 */
-	if (N_MEMORY == N_NORMAL_MEMORY)
-		zone_last = ZONE_MOVABLE;
 
-	/*
-	 * if the memory to be online is in a zone of 0...zone_last, and
-	 * the zones of 0...zone_last don't have memory before online, we will
-	 * need to set the node to node_states[N_NORMAL_MEMORY] after
-	 * the memory is online.
-	 */
-	if (zone_idx(zone) <= zone_last && !node_state(nid, N_NORMAL_MEMORY))
-		arg->status_change_nid_normal = nid;
-	else
-		arg->status_change_nid_normal = -1;
-
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * If we have movable node, node_states[N_HIGH_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_HIGHMEM,
-	 * set zone_last to ZONE_HIGHMEM.
-	 *
-	 * If we don't have movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_MOVABLE,
-	 * set zone_last to ZONE_MOVABLE.
-	 */
-	zone_last = ZONE_HIGHMEM;
-	if (N_MEMORY == N_HIGH_MEMORY)
-		zone_last = ZONE_MOVABLE;
+	if (zone_idx(zone) <= ZONE_NORMAL) {
+		if (!node_state(nid, N_NORMAL_MEMORY))
+			arg->status_change_nid_normal = nid;
+		else
+			arg->status_change_nid_normal = -1;
 
-	if (zone_idx(zone) <= zone_last && !node_state(nid, N_HIGH_MEMORY))
-		arg->status_change_nid_high = nid;
-	else
-		arg->status_change_nid_high = -1;
-#else
-	/*
-	 * When !CONFIG_HIGHMEM, N_HIGH_MEMORY equals N_NORMAL_MEMORY
-	 * so setting the node for N_NORMAL_MEMORY is enough.
-	 */
-	arg->status_change_nid_high = -1;
-#endif
+		if (IS_ENABLED(CONFIG_HIGHMEM)) {
+			if (!node_state(nid, N_HIGH_MEMORY))
+				arg->status_change_nid_high = nid;
+		} else
+			arg->status_change_nid_high = -1;
+	}
 
 	/*
-	 * if the node don't have memory befor online, we will need to
-	 * set the node to node_states[N_MEMORY] after the memory
-	 * is online.
+	 * if the node doesn't have memory before onlining it, we will need
+	 * to set the node to node_states[N_MEMORY] after the memory
+	 * gets onlined.
 	 */
 	if (!node_state(nid, N_MEMORY))
 		arg->status_change_nid = nid;
-- 
2.13.6

