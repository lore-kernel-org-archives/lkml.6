Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E7EC04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE25208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE25208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeHVM4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:56:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37632 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbeHVM4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:56:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so1471758wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pr2O40TB9sxq7YnJMaW3tfAKxlcOinscuFYdiw5J9bo=;
        b=ddEVgIJnJjYGE3cqP64yvAplgbHomY/KCGDS3pzdK2yC2QxGys82iS1LylAbiKSJNJ
         7E5b4cxqTPOg1KVms3dt5qT4AdD1FkcFK0GgPe1Yn5DZ/xIJtg2eS8b7GxJGCug6/2iN
         1W3+SOsVZBWzKn2jgq90m3UmTvEMC5VaolaGIodpNshnjMecB1DjkcqjFwmr+hR2BlaC
         0yiFndCpRdyEKp6u1cLRKlr497k3m8U7h/7NqnoGYhkcDVY+GMQyFuMIhST6zcBrialx
         vkUZ2jieOp86mOhGHs6ebkH8RYplRNvn8gBWcn5T/Pnj2gvncMtT7ukS8Orj7V+ZQtTF
         46Sw==
X-Gm-Message-State: APzg51BSxjfqoHnGIip7SiDzxhlxmxKqK8cyfQ1inEPL4dXsgrowgW2k
        CKIdUYjB1ujQF7FqcFbYt38=
X-Google-Smtp-Source: ANB0VdYEvE1cm5Z7++E5F9Lg9empOICLxh/N6KJ06RqF1VehZVmu68vt1tdFj0Io/1zvFd2xctnlmQ==
X-Received: by 2002:a1c:3663:: with SMTP id d96-v6mr672209wma.92.1534930355096;
        Wed, 22 Aug 2018 02:32:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q5-v6sm2363469wmd.29.2018.08.22.02.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:32:34 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id D506A124A17;
        Wed, 22 Aug 2018 11:32:31 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 5/5] mm/memory_hotplug: Simplify node_states_check_changes_offline
Date:   Wed, 22 Aug 2018 11:32:26 +0200
Message-Id: <20180822093226.25987-6-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180822093226.25987-1-osalvador@techadventures.net>
References: <20180822093226.25987-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch tries to simplify node_states_check_changes_offline
and make the code more understandable by:

- Removing the if (N_MEMORY == N_NORMAL_MEMORY) wrong statement
- Removing the if (N_MEMORY == N_HIGH_MEMORY) wrong statement
- Re-structure the code a bit
- Removing confusing comments

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 81 ++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 006a7b817724..b45bc681e6db 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1487,51 +1487,40 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	enum zone_type zt, zone_last = ZONE_NORMAL;
 
 	/*
-	 * If we have HIGHMEM or movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_NORMAL,
-	 * set zone_last to ZONE_NORMAL.
-	 *
-	 * If we don't have HIGHMEM nor movable node,
-	 * node_states[N_NORMAL_MEMORY] contains nodes which have zones of
-	 * 0...ZONE_MOVABLE, set zone_last to ZONE_MOVABLE.
+	 * If the current zone is whithin (0..ZONE_NORMAL],
+	 * check if the amount of pages that are going to be
+	 * offlined is above or equal to the sum of the present
+	 * pages of these zones.
+	 * If that happens, we need to take this node out of
+	 * node_state[N_NORMAL_MEMORY]
 	 */
-	if (N_MEMORY == N_NORMAL_MEMORY)
-		zone_last = ZONE_MOVABLE;
+	if (zone_idx(zone) <= zone_last) {
+		for (zt = 0; zt <= zone_last; zt++)
+			present_pages += pgdat->node_zones[zt].present_pages;
 
-	/*
-	 * check whether node_states[N_NORMAL_MEMORY] will be changed.
-	 * If the memory to be offline is in a zone of 0...zone_last,
-	 * and it is the last present memory, 0...zone_last will
-	 * become empty after offline , thus we can determind we will
-	 * need to clear the node from node_states[N_NORMAL_MEMORY].
-	 */
-	for (zt = 0; zt <= zone_last; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= zone_last && nr_pages >= present_pages)
-		arg->status_change_nid_normal = zone_to_nid(zone);
-	else
-		arg->status_change_nid_normal = -1;
+		if (nr_pages >= present_pages)
+			arg->status_change_nid_normal = zone_to_nid(zone);
+		else
+			arg->status_change_nid_normal = -1;
+	}
 
 #ifdef CONFIG_HIGHMEM
 	/*
-	 * If we have movable node, node_states[N_HIGH_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_HIGHMEM,
-	 * set zone_last to ZONE_HIGHMEM.
-	 *
-	 * If we don't have movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_MOVABLE,
-	 * set zone_last to ZONE_MOVABLE.
+	 * If the current zone is whithin (0..ZONE_HIGHMEM], check if
+	 * the amount of pages that are going to be offlined is above
+	 * or equal to the sum of the present pages of these zones.
+	 * If that happens, we need to take this node out of
+	 * node_state[N_HIGH_MEMORY]
 	 */
-	zone_last = ZONE_HIGHMEM;
-	if (N_MEMORY == N_HIGH_MEMORY)
-		zone_last = ZONE_MOVABLE;
-
-	for (; zt <= zone_last; zt++)
+	if (zone_idx(zone) <= ZONE_HIGHMEM) {
+		zt = ZONE_HIGHMEM;
 		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= zone_last && nr_pages >= present_pages)
-		arg->status_change_nid_high = zone_to_nid(zone);
-	else
-		arg->status_change_nid_high = -1;
+
+		if (nr_pages >= present_pages)
+			arg->status_change_nid_high = zone_to_nid(zone);
+		else
+			arg->status_change_nid_high = -1;
+	}
 #else
 	/*
 	 * When !CONFIG_HIGHMEM, N_HIGH_MEMORY equals N_NORMAL_MEMORY
@@ -1541,18 +1530,14 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 #endif
 
 	/*
-	 * node_states[N_HIGH_MEMORY] contains nodes which have 0...ZONE_MOVABLE
+	 * Count pages from ZONE_MOVABLE as well.
+	 * If the amount of pages that are going to be offlined is above
+	 * or equal the sum of the present pages of all zones, we need
+	 * to remove this node from node_state[N_MEMORY]
 	 */
-	zone_last = ZONE_MOVABLE;
+	zt = ZONE_MOVABLE;
+	present_pages += pgdat->node_zones[zt].present_pages;
 
-	/*
-	 * check whether node_states[N_HIGH_MEMORY] will be changed
-	 * If we try to offline the last present @nr_pages from the node,
-	 * we can determind we will need to clear the node from
-	 * node_states[N_HIGH_MEMORY].
-	 */
-	for (; zt <= zone_last; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
 	if (nr_pages >= present_pages)
 		arg->status_change_nid = zone_to_nid(zone);
 	else
-- 
2.13.6

