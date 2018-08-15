Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718C52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718C52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeHORe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:34:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46066 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHORe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:34:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so1328720wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2QBHJLSndIlhEv9WAsiGy4U1CE6bNUzFCt/babHudhM=;
        b=DkcdK+yvPmRCRBQxLZYngOnvxrd27porgsmVhPc91rP1OQ0UX4EU8Xd3CJ08Cpi2JU
         U/ubNgLniitmzjL06ETezwALp32hJ7nzOobGcwaZU1BQM2u/6yyFYs6/TnFCuhA5xT+p
         8Wb3V9/dmV62G2swhdmDa1X/aMoRDSWLl7oYyhAvMG+3fF4dOzbLFip8rUHyMgeE45ZV
         PRjiIVzn/hgUrD7u92gqw3OCs+lzhExv3PWH6FKY1z6XSIIYDTWxcMWXzFs7H/cIp9fQ
         Dyj5MN/dUGddJjl/wsagg5yG33Kp9gm/n+SILTPw/LxbuUhzgpbMhnCE/wi0/JmspWuV
         EZXw==
X-Gm-Message-State: AOUpUlE37om/V3ub8U4zeB9h6vvGC8/gpQam7Ke1RypG5OXjtthWicfY
        FNEjhecw4hicWOiB0xEqb5o=
X-Google-Smtp-Source: AA+uWPzKqdMDlGqLXohO8LNpswrEfFSAkzyS00GXdQhNfSXRbvPIrkJ8BThDgUGJctV2PO/j00kwEQ==
X-Received: by 2002:adf:8004:: with SMTP id 4-v6mr17031601wrk.130.1534344150509;
        Wed, 15 Aug 2018 07:42:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1271377wmh.41.2018.08.15.07.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:42:29 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 37B1012489F;
        Wed, 15 Aug 2018 16:42:28 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 2/4] mm/memory_hotplug: Drop mem_blk check from unregister_mem_sect_under_nodes
Date:   Wed, 15 Aug 2018 16:42:17 +0200
Message-Id: <20180815144219.6014-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180815144219.6014-1-osalvador@techadventures.net>
References: <20180815144219.6014-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Before calling to unregister_mem_sect_under_nodes(),
remove_memory_section() already checks if we got a valid memory_block.

No need to check that again in unregister_mem_sect_under_nodes().

If more functions start using unregister_mem_sect_under_nodes() in the
future, we can always place a WARN_ON to catch null mem_blk's so we can
safely back off.

For now, let us keep the check in remove_memory_section() since it is the
only function that uses it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
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

