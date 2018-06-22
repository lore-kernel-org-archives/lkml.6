Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B3C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FA923C6D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FA923C6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFVLTj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:19:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37525 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeFVLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:19:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so2152879wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NBKT+5JUwQw/r3C6aqXjbsngiM0nuvCN+1pO6/0lpaY=;
        b=S8NUo3bQg28m5RI6yjLMc5+RKJm0KmmPBjFq/WUmMLrqXORqMaWChf0+Bt2DewMyj5
         cPyY7UcbbTzOr3TKuI9R4LfAP9hH6MwDw5lJHh/Cxe/UwBXlWkjyrZsJRZoVIdujkA1F
         Qnq6n31qC97/REwxeksAKsIiS49tZDxbKvEnnXU9DfcZRkQD/fHDsluZTgpR2YjONhWT
         Wda18GToypvMFHoQAG/ObV8/s1EKPOycB0XRD/LNVEE744+NeOtJZOpmk3zDmFag66Vb
         qO5cgz/Mem6xNxUeU2LL22cra+cebX7FyWXfWLM1l605oJ/lTqBASa+OqNiu2sPooztk
         48HQ==
X-Gm-Message-State: APt69E3fTFb0l+Wow+wVBGGgXZOaCPOzobPIi629PGJgW9blZ5Nksfa8
        hb08AOc2TW/JKFa6yro3Mas=
X-Google-Smtp-Source: ADUXVKIS6vCu51yWAt/91xx+8dTae8Jw3RsPy60TQlqakeJdDL+jE0vf2E4WVFURmo1Z36Q4A27wOw==
X-Received: by 2002:a1c:9514:: with SMTP id x20-v6mr1484037wmd.76.1529666373481;
        Fri, 22 Jun 2018 04:19:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 203-v6sm1907128wmp.23.2018.06.22.04.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 04:19:32 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B82FA12375B;
        Fri, 22 Jun 2018 13:19:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        Jonathan.Cameron@huawei.com, arbab@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/4] mm/memory_hotplug: Call register_mem_sect_under_node
Date:   Fri, 22 Jun 2018 13:18:37 +0200
Message-Id: <20180622111839.10071-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180622111839.10071-1-osalvador@techadventures.net>
References: <20180622111839.10071-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

When hotpluging memory, it is possible that two calls are being made
to register_mem_sect_under_node().
One comes from __add_section()->hotplug_memory_register()
and the other from add_memory_resource()->link_mem_sections() if
we had to register a new node.

In case we had to register a new node, hotplug_memory_register()
will only handle/allocate the memory_block's since
register_mem_sect_under_node() will return right away because the
node it is not online yet.

I think it is better if we leave hotplug_memory_register() to
handle/allocate only memory_block's and make link_mem_sections()
to call register_mem_sect_under_node().

So this patch removes the call to register_mem_sect_under_node()
from hotplug_memory_register(), and moves the call to link_mem_sections()
out of the condition, so it will always be called.
In this way we only have one place where the memory sections
are registered.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/memory.c |  2 --
 mm/memory_hotplug.c   | 32 +++++++++++---------------------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f5e560188a18..c8a1cb0b6136 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -736,8 +736,6 @@ int hotplug_memory_register(int nid, struct mem_section *section)
 		mem->section_count++;
 	}
 
-	if (mem->section_count == sections_per_block)
-		ret = register_mem_sect_under_node(mem, nid, false);
 out:
 	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 504ba120bdfc..e2ed64b994e5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1123,6 +1123,7 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	u64 start, size;
 	bool new_node = false;
 	int ret;
+	unsigned long start_pfn, nr_pages;
 
 	start = res->start;
 	size = resource_size(res);
@@ -1151,34 +1152,23 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	if (ret < 0)
 		goto error;
 
-	/* we online node here. we can't roll back from here. */
-	node_set_online(nid);
-
 	if (new_node) {
-		unsigned long start_pfn = start >> PAGE_SHIFT;
-		unsigned long nr_pages = size >> PAGE_SHIFT;
-
-		ret = __register_one_node(nid);
-		if (ret)
-			goto register_fail;
-
-		/*
-		 * link memory sections under this node. This is already
-		 * done when creatig memory section in register_new_memory
-		 * but that depends to have the node registered so offline
-		 * nodes have to go through register_node.
-		 * TODO clean up this mess.
-		 */
-		ret = link_mem_sections(nid, start_pfn, nr_pages, false);
-register_fail:
-		/*
-		 * If sysfs file of new node can't create, cpu on the node
+		/* If sysfs file of new node can't be created, cpu on the node
 		 * can't be hot-added. There is no rollback way now.
 		 * So, check by BUG_ON() to catch it reluctantly..
+		 * We online node here. We can't roll back from here.
 		 */
+		node_set_online(nid);
+		ret = __register_one_node(nid);
 		BUG_ON(ret);
 	}
 
+	/* link memory sections under this node.*/
+	start_pfn = start >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
+	ret = link_mem_sections(nid, start_pfn, nr_pages, false);
+	BUG_ON(ret);
+
 	/* create new memmap entry */
 	firmware_map_add_hotplug(start, start + size, "System RAM");
 
-- 
2.13.6

