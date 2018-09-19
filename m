Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9840C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E04120858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E04120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbeISPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:45:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36933 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbeISPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:45:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so6196426wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0E8GrSFo/1cWrkiXCf/RJ9KCZnuIkg29ttwOJg6NQJI=;
        b=gKbBwjRuhxGTNsAmRmQFro1j4Q2hrieSiJsjz34iZD26ofucHhqefDi3tOt9GFRhdP
         ZsDV33Rn739ihq3DOnlpBUN7sSWXznAK5TZ5zTSgLEF3vEwvLpwbmvbXtSdH3DugLN2e
         ot9n/e98kJy4sH0MB2KaMvtWY06RRVd4IweVF0Rxr6lQT0ZYaenPP/gpsU1/MQ1A4poP
         U+4piNUqOuvWPn8QMidbAy2n5e/wd38PQ8mtKZi2R5zykRMfiRio54VI+02x8/YASIRY
         oQRatP1GtI351j3eyV11r46qhrX1Wj503olhKnbkGCoOJjWA4CtkRuBAQ5nqefqzSEC5
         jAUw==
X-Gm-Message-State: APzg51Cq25AEg5DIDMFnUD02nG/KIpwOQt2jltE2jYRKug1CmF9UKoWb
        krcZNJ+uvKDBj9GlQMpEQLY=
X-Google-Smtp-Source: ANB0Vdb34HC3HV+ZiMDEQ/899rzIBRO3em9du2agMFpbdsRrUU9mOEvH/Qb6iAdxyFjxFnYfjWwNwg==
X-Received: by 2002:a1c:f11a:: with SMTP id p26-v6mr8343491wmh.92.1537351719329;
        Wed, 19 Sep 2018 03:08:39 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h15-v6sm3058786wmb.21.2018.09.19.03.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 03:08:38 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id A83811253C2;
        Wed, 19 Sep 2018 12:08:37 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/5] mm/memory_hotplug: Spare unnecessary calls to node_set_state
Date:   Wed, 19 Sep 2018 12:08:15 +0200
Message-Id: <20180919100819.25518-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919100819.25518-1-osalvador@techadventures.net>
References: <20180919100819.25518-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

In node_states_check_changes_online, we check if the node will
have to be set for any of the N_*_MEMORY states after the pages
have been onlined.

Later on, we perform the activation in node_states_set_node.
Currently, in node_states_set_node we set the node to N_MEMORY
unconditionally.
This means that we call node_set_state for N_MEMORY every time
pages go online, but we only need to do it if the node has not yet been
set for N_MEMORY.

Fix this by checking status_change_nid.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 38d94b703e9d..63facfc57224 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -753,7 +753,8 @@ static void node_states_set_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_high >= 0)
 		node_set_state(node, N_HIGH_MEMORY);
 
-	node_set_state(node, N_MEMORY);
+	if (arg->status_change_nid >= 0)
+		node_set_state(node, N_MEMORY);
 }
 
 static void __meminit resize_zone_range(struct zone *zone, unsigned long start_pfn,
-- 
2.13.6

