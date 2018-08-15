Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E423C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CF320C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF320C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeHORfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:35:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47065 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeHORe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:34:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so1331300wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5t4JM6u128OdWFKaN6Pi+4z+3cMbUK86+f7qJ/R6T8=;
        b=sQWyc1PkYXEv0aBukYYICPDNsQoU7DhnQUtKRjwWWWKL8GBtAGt3CNWsA1sx+H33UD
         gvlqehycD8Trpf30ZWYsSeAO8jHJEYMYx3BQmIt7WK74faHWPuXBa4W8PVgzmmRkl0Uc
         TNr2XZ7BdxgvD2Z27jLAt4NMPJynCkoIbA7/GnZoN7YG/qnZ1aTOQqmKqLtXcdHno4ht
         i8DTFkbNmlY6u1qbMLae+nly2J272u87llyOn66MgJe5lfDJuzL07VIDYJDLZgdhAN92
         bn/ApDHvkNEX5fwDV8kjhrsvCdsu7cYRWyJcW9gHCjw19JwAN4LSuJV+ugUNpM+FNAOP
         uhCQ==
X-Gm-Message-State: AOUpUlEBYJsvx1ZKpi1di/q/yV7HteFefwXaJohQTIBG3OuBLR+eSvEP
        w5IWip2SpUJl8wJL8Mi80T4=
X-Google-Smtp-Source: AA+uWPxpvGb3Z418XXlCV4EC3wi3IkPkHLUaLUA/IaP6UV+yImGQFJzLH6lWRA0daJWjS0ZfeX05Zw==
X-Received: by 2002:adf:e992:: with SMTP id h18-v6mr17038910wrm.238.1534344152122;
        Wed, 15 Aug 2018 07:42:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id n7-v6sm17137985wmc.2.2018.08.15.07.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:42:30 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B77E31248A1;
        Wed, 15 Aug 2018 16:42:28 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 4/4] mm/memory_hotplug: Drop node_online check in unregister_mem_sect_under_nodes
Date:   Wed, 15 Aug 2018 16:42:19 +0200
Message-Id: <20180815144219.6014-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180815144219.6014-1-osalvador@techadventures.net>
References: <20180815144219.6014-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

We are getting the nid from the pages that are not yet removed,
but a node can only be offline when its memory/cpu's have been removed.
Therefore, we know that the node is still online.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 81b27b5b1f15..b23769e4fcbb 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -465,8 +465,6 @@ void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 
 		if (nid < 0)
 			continue;
-		if (!node_online(nid))
-			continue;
 		/*
 		 * It is possible that NODEMASK_ALLOC fails due to memory
 		 * pressure.
-- 
2.13.6

