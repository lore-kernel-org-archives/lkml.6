Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7442C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C17F2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C17F2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbeIUTPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:15:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37653 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:15:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so12859191wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RCTTXVkL71qkxGQmeRTBKaL8TjPr8oGCumoctB9DgDA=;
        b=cOZZq94eVYe5zfZ7vOUsKvbJbjHm1PsVw3vr04CZmrkCPTxrkflJX3ZK1sIueglvoH
         sqpb38cX1hpaE0T+6Dcf6mv7TTNTTb50h1dnCTFD/BomAraRFU3RPgEuV0aF/sIiV7S4
         P9Nti3h3HaTuMWEAJGU4uDVpy2Skm2a1+w5LZda/1ydosuQEfVINiMK4tDUXeYDMQQlb
         CKowcaf+Ss3BFRyyBgNCM+CYhlqkhghT7Nf2/eGY3UsR+jS6rzKIeNJkHzlnFctuvIqc
         ht4HDv64KkCf5pfOBDTbqfdJzzC7j54ZjkB5zjb0tzyHll8Ozbl9DNXboe4XeVLJJAGY
         CqGQ==
X-Gm-Message-State: APzg51BwWROuaZw2tV5wRqpFl/YADYwBTCxO3lx0MKeu8hesc9gFdTDn
        9vkXn462zmqf6sRqHrdH4is=
X-Google-Smtp-Source: ANB0VdbdQH2QGULdBiqI2bwJ+Av8EaBk4PfgnTPNz4WhXo+tilr8wkafVPnOGz47MIFZJcrZPhzqNA==
X-Received: by 2002:adf:fc44:: with SMTP id e4-v6mr11704736wrs.9.1537536403548;
        Fri, 21 Sep 2018 06:26:43 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id y17-v6sm23774170wrh.49.2018.09.21.06.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:26:42 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id C655E12533E;
        Fri, 21 Sep 2018 15:26:40 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/4] mm/memory_hotplug: Simplify node_states_check_changes_online
Date:   Fri, 21 Sep 2018 15:26:33 +0200
Message-Id: <20180921132634.10103-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180921132634.10103-1-osalvador@techadventures.net>
References: <20180921132634.10103-1-osalvador@techadventures.net>
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
Suggested-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/memory_hotplug.c | 57 +++++++----------------------------------------------
 1 file changed, 7 insertions(+), 50 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 561c44761f95..eadd149eb7bc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -687,62 +687,19 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 	struct zone *zone, struct memory_notify *arg)
 {
 	int nid = zone_to_nid(zone);
-	enum zone_type zone_last = ZONE_NORMAL;
 
-	/*
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
+	arg->status_change_nid = -1;
+	arg->status_change_nid_normal = -1;
+	arg->status_change_nid_high = -1;
 
-	/*
-	 * if the memory to be online is in a zone of 0...zone_last, and
-	 * the zones of 0...zone_last don't have memory before online, we will
-	 * need to set the node to node_states[N_NORMAL_MEMORY] after
-	 * the memory is online.
-	 */
-	if (zone_idx(zone) <= zone_last && !node_state(nid, N_NORMAL_MEMORY))
+	if (!node_state(nid, N_MEMORY))
+		arg->status_change_nid = nid;
+	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
 		arg->status_change_nid_normal = nid;
-	else
-		arg->status_change_nid_normal = -1;
-
 #ifdef CONFIG_HIGHMEM
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
-
-	if (zone_idx(zone) <= zone_last && !node_state(nid, N_HIGH_MEMORY))
+	if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
 		arg->status_change_nid_high = nid;
-	else
-		arg->status_change_nid_high = -1;
-#else
-	arg->status_change_nid_high = arg->status_change_nid_normal;
 #endif
-
-	/*
-	 * if the node don't have memory befor online, we will need to
-	 * set the node to node_states[N_MEMORY] after the memory
-	 * is online.
-	 */
-	if (!node_state(nid, N_MEMORY))
-		arg->status_change_nid = nid;
-	else
-		arg->status_change_nid = -1;
 }
 
 static void node_states_set_node(int node, struct memory_notify *arg)
-- 
2.13.6

