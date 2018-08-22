Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D9B208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D9B208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeHVM4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:56:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51482 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHVM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:56:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so1399166wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYkTykqTIEVYyBeQj0aD08ILz0lDkebKvUInR6uiJsg=;
        b=J8IU1q4xT+gAiVmSpasp0iwxnK6VBlKex4WiQpK2zitgw6VzwvedkAaIwAWzZRJiCb
         yahj8rk4SCsaiuLw21hHpVNJwvP9nf4zMRSCfYpOHWCTilMZ1QeuSYt6DgmkRvj98SDF
         xFiJ1W+V4asNwmHyeVNONV8kNuTe+1+hqIAH8nH0Abw0kXXtxHUvSJO3+IV7eUaJaX7d
         b2uxq0zafQbAkfm50naJgm2zllwN1+ksg+3yfQGVKh0PTRxYxceOiia1rBCwN4Xhbnp4
         LN8SUcMskAKyBk3lRlvgA37EfBKjyp5qWwjwPkgyItr4Kqbb5RLbk6JOW6vGQNYWj4Sl
         aaUA==
X-Gm-Message-State: APzg51BO3hjPHhpf6QUpdNTLPaOJaxu9/8F88/dlczfgkcBO3qFJX4G4
        LYnKlGxXyFTJvbv5MT4x3rA=
X-Google-Smtp-Source: ANB0VdaUAKPFzkNQNeYtkQHN9lzSGtEOWGUbTss5CpGcInT9fj+ZMgr64iQyCVEGHsbK+DSdocUFSA==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr1926217wme.125.1534930353964;
        Wed, 22 Aug 2018 02:32:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f132-v6sm1260349wme.24.2018.08.22.02.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:32:32 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 65EE8124A15;
        Wed, 22 Aug 2018 11:32:31 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 3/5] mm/memory_hotplug: Simplify node_states_check_changes_online
Date:   Wed, 22 Aug 2018 11:32:24 +0200
Message-Id: <20180822093226.25987-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180822093226.25987-1-osalvador@techadventures.net>
References: <20180822093226.25987-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

While looking at node_states_check_changes_online, I saw some
confusing things I am not sure how it was supposed to work.

Right after entering the function, we find this:

if (N_MEMORY == N_NORMAL_MEMORY)
	zone_last = ZONE_MOVABLE;

This, unless I am missing something really obvious, is wrong.
N_MEMORY cannot really be equal to N_NORMAL_MEMORY.
My guess is that this wanted to be something like:

if (N_NORMAL_MEMORY == N_HIGH_MEMORY)

to check if we have CONFIG_HIGHMEM.

Later on, in the CONFIG_HICHMEM block, we have:

if (N_MEMORY == N_HIGH_MEMORY)
	zone_last = ZONE_MOVABLE;

This is also wrong, and will never be evaluated to true.

The thing is that besides this, the function can be simplified a bit.

- If the zone is whithin (0..ZONE_NORMAL], we need to set the node
  for node_state[N_NORMAL_MEMORY]
- If we have CONFIG_HIGHMEM, and the zone is within (0..ZONE_NORMAL],
  we need to set the node for node_state[N_HIGH_MEMORY], as
  N_HIGH_MEMORY stands for regular or high memory.
- Finally, we set the node for node_states[N_MEMORY].
  ZONE_MOVABLE ends up there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 44 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1cfd0b5a9cc7..0f2cf6941224 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -680,46 +680,28 @@ static void node_states_check_changes_online(unsigned long nr_pages,
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
-	 */
-	if (N_MEMORY == N_NORMAL_MEMORY)
-		zone_last = ZONE_MOVABLE;
-
-	/*
-	 * if the memory to be online is in a zone of 0...zone_last, and
-	 * the zones of 0...zone_last don't have memory before online, we will
-	 * need to set the node to node_states[N_NORMAL_MEMORY] after
-	 * the memory is online.
+	 * node_states[N_NORMAL_MEMORY] contains nodes which have
+	 * zones from (0..ZONE_NORMAL]
+	 * We can start checking if the current zone is in that range
+	 * and if so, if the node needs to be set to node_states[N_NORMAL_MEMORY]
+	 * after memory is online.
 	 */
-	if (zone_idx(zone) <= zone_last && !node_state(nid, N_NORMAL_MEMORY))
+	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
 		arg->status_change_nid_normal = nid;
 	else
 		arg->status_change_nid_normal = -1;
 
 #ifdef CONFIG_HIGHMEM
 	/*
-	 * If we have movable node, node_states[N_HIGH_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_HIGHMEM,
-	 * set zone_last to ZONE_HIGHMEM.
-	 *
-	 * If we don't have movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_MOVABLE,
-	 * set zone_last to ZONE_MOVABLE.
+	 * The current zone cannot be ZONE_HIGHMEM, as zone_for_pfn_range
+	 * can only return (0..ZONE_NORMAL] or ZONE_MOVABLE.
+	 * N_HIGH_MEMORY stands for regular or high memory, so if the zone
+	 * is within the range (0..ZONE_NORMAL], we have to set the node
+	 * for N_HIGH_MEMORY as well.
 	 */
-	zone_last = ZONE_HIGHMEM;
-	if (N_MEMORY == N_HIGH_MEMORY)
-		zone_last = ZONE_MOVABLE;
-
-	if (zone_idx(zone) <= zone_last && !node_state(nid, N_HIGH_MEMORY))
+	if (zone_idx(zone) < ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
 		arg->status_change_nid_high = nid;
 	else
 		arg->status_change_nid_high = -1;
@@ -732,7 +714,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 #endif
 
 	/*
-	 * if the node don't have memory befor online, we will need to
+	 * if the node don't have memory before online, we will need to
 	 * set the node to node_states[N_MEMORY] after the memory
 	 * is online.
 	 */
-- 
2.13.6

