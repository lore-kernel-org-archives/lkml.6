Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E353C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B6C223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B6C223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeHJR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:59:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32862 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:59:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so1778054wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DThuzYFgA226wgydxOLHMV8CyK7W76Ue8dyps4MED5o=;
        b=G159YnipkgjDbi+p0YncXo/N5PEwhCGBHuY/M2UfRWWN6d87jVX53h9QKoU68USRZv
         kJFlvEY+/uH1vwrbVsA+kNRQ1IY6dtaZYhUQ1AAnO8MNB1IpTQSzRLTFrZPQhjzYnpjn
         4ULzlb2szXuKv2zWi9pOTzbXEsIrnmDMRh3sL/jvDZk9ncUayeLl1yRtLDXxBQYst3zb
         WCyoJ28q5j/EAIphZOagLrAfz4NDesScxbMlcgO4HUIj0hAc8S7lkFMFe1+ndQVGL1+j
         YVvlS0LAqTTp6r4FCvT0qTX6IB9Mokt3VsoS0DVQHXNaiaLTr+qYyhJqLva0EEIAn4fH
         nfnw==
X-Gm-Message-State: AOUpUlGFGgVoEdKX/S6P9CrYqb4fUjCuvxALx1Zr7a2Wes+wDeKelARO
        TqfAYCuZrw8LHbEkq5EZdbk=
X-Google-Smtp-Source: AA+uWPzbs36MxCTUWcZ9pj2HjX2ZyzIipgHJh9Tm0gNRoWHVIbPlItS90THDEvmfRh2AMypOByfCDA==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr1816958wml.45.1533914977055;
        Fri, 10 Aug 2018 08:29:37 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id n7-v6sm8811166wrr.35.2018.08.10.08.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:29:35 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B0EA412481F;
        Fri, 10 Aug 2018 17:29:34 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/3] mm/memory_hotplug: Cleanup unregister_mem_sect_under_nodes
Date:   Fri, 10 Aug 2018 17:29:31 +0200
Message-Id: <20180810152931.23004-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180810152931.23004-1-osalvador@techadventures.net>
References: <20180810152931.23004-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

With the assumption that the relationship between
memory_block <-> node is 1:1, we can refactor this function a bit.

This assumption is being taken from register_mem_sect_under_node()
code.

register_mem_sect_under_node() takes the mem_blk's nid, and compares it
to the pfn's nid we are checking.
If they match, we go ahead and link both objects.
Once done, we just return.

So, the relationship between memory_block <-> node seems to stand.

Currently, unregister_mem_sect_under_nodes() defines a nodemask_t
which is being checked in the loop to see if we have already unliked certain node.
But since a memory_block can only belong to a node, we can drop the nodemask
and the check within the loop.

If we find a match between the mem_block->nid and the nid of the
pfn we are checking, we unlink the objects and return, as unlink the objects
once is enough.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index dd3bdab230b2..0657ed70bddd 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -448,35 +448,27 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 	return 0;
 }
 
-/* unregister memory section under all nodes that it spans */
+/* unregister memory section from the node it belongs to */
 int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 				    unsigned long phys_index)
 {
-	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
-
-	if (!unlinked_nodes)
-		return -ENOMEM;
-	nodes_clear(*unlinked_nodes);
+	int nid = mem_blk->nid;
 
 	sect_start_pfn = section_nr_to_pfn(phys_index);
 	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
-		int nid;
+		int page_nid = get_nid_for_pfn(pfn);
 
-		nid = get_nid_for_pfn(pfn);
-		if (nid < 0)
-			continue;
-		if (!node_online(nid))
-			continue;
-		if (node_test_and_set(nid, *unlinked_nodes))
-			continue;
-		sysfs_remove_link(&node_devices[nid]->dev.kobj,
-			 kobject_name(&mem_blk->dev.kobj));
-		sysfs_remove_link(&mem_blk->dev.kobj,
-			 kobject_name(&node_devices[nid]->dev.kobj));
+		if (page_nid >= 0 && page_nid == nid) {
+			sysfs_remove_link(&node_devices[nid]->dev.kobj,
+				 kobject_name(&mem_blk->dev.kobj));
+			sysfs_remove_link(&mem_blk->dev.kobj,
+				 kobject_name(&node_devices[nid]->dev.kobj));
+			break;
+		}
 	}
-	NODEMASK_FREE(unlinked_nodes);
+
 	return 0;
 }
 
-- 
2.13.6

