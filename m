Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8416CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A7223E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3A7223E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeHJR75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:59:57 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40589 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeHJR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:59:57 -0400
Received: by mail-wr1-f46.google.com with SMTP id h15-v6so8655750wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t8JI55qiiScE0tExHnbnQS/eE8NCPsrYaAtEdiJRMhc=;
        b=ZkR7dYmj8wizCHKUlumP86sK76+eZK173P/xrfDSUyMrZQDxBkxz2qQRNBEj+Mz5aq
         WndCThwvLAcfJYR2kmgg1dODlM+qJv2VLvY7JZ2iQfof2nxWc/jH83tWeFsLGwtiPyb4
         9OQBVE1Q/jvNK/WMHLwIdme+TXGrBMaAv44y6WvZnFGesMyPrYDAZ9d/ljbAjhqmn7IM
         pzmap3NmLnkNMnWpNvWhAdM3fT86F29U8FUL37faBC1/5CUsJzK6efUi+kIuRsb4/xnq
         bEYSRQHhmwSUTLqUzKLaNv0vKd1vjJb6Fi7bsP6c1QOOp4lE/Wdt45E4BB9suYv8w6gw
         d9Sg==
X-Gm-Message-State: AOUpUlHMpvRvP/UKsRofasxaALyi3xxulypxDlxrnZB4xbZKIXGfxpyE
        cn64dAUe2GMO4MaPI5998rwzDvt2yCw=
X-Google-Smtp-Source: AA+uWPw1cBXuoawYK03QJrX64C+d8cn29bn7COhwbJOeE93eiV9ypINZJFUcldakDEap/pBIRGPjxw==
X-Received: by 2002:adf:9007:: with SMTP id h7-v6mr4711364wrh.178.1533914976491;
        Fri, 10 Aug 2018 08:29:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1581907wmh.0.2018.08.10.08.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:29:35 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 7297612481E;
        Fri, 10 Aug 2018 17:29:34 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/3] mm/memory_hotplug: Drop unneeded check from unregister_mem_sect_under_nodes
Date:   Fri, 10 Aug 2018 17:29:30 +0200
Message-Id: <20180810152931.23004-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180810152931.23004-1-osalvador@techadventures.net>
References: <20180810152931.23004-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Before calling to unregister_mem_sect_under_nodes(),
remove_memory_section() already checks if we got a valid
memory_block.

No need to check that again in unregister_mem_sect_under_nodes().

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1ac4c36e13bb..dd3bdab230b2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -455,10 +455,6 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	if (!mem_blk) {
-		NODEMASK_FREE(unlinked_nodes);
-		return -EFAULT;
-	}
 	if (!unlinked_nodes)
 		return -ENOMEM;
 	nodes_clear(*unlinked_nodes);
-- 
2.13.6

