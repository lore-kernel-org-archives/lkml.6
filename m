Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DBC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF4C2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF4C2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeHMS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:29:39 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40641 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbeHMS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:29:39 -0400
Received: by mail-wm0-f43.google.com with SMTP id y9-v6so9340985wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t8JI55qiiScE0tExHnbnQS/eE8NCPsrYaAtEdiJRMhc=;
        b=INklvrrYBiXO7p5m45dimPil8c0MYo2Uv9PpKBTBSawJX9Ygkfu/ka6TCghqAoT07I
         WkOLQtMasFp9hz1FV4rifCDhtaV1VADrgmqVIt9LUTBpmE4uZx9aZxL+1wpI1YcKCOuX
         WdPLZi0b6d+gITtK0C/gKOOUvsuGZtvcKr1wz6gcjUwx71zI9yKdxlJ5SmLbgf3VVzpR
         20x1KBw1jU5p4A9htuGR2g881EaLmV8yKLdELQWX9kZy7915J2PXir4gztr4z0Q5/k5Z
         IO8GuWt2ISnuzh6QaB494xeLEINwKghfu0hqg3xti+MBr8RGLPz8vnAJficHgEPQ3oHA
         u5pQ==
X-Gm-Message-State: AOUpUlHPfQe7zk2c6GWRmOpUUl4HSoRGaAMWm9YILM+24F2ts8NvCFge
        7gsmmqP+/kl8QOvCyjUFZuI=
X-Google-Smtp-Source: AA+uWPwYVyNyN9KpmIV0w/2O1uBSTnfW8Aubyv0bOtU1GjAt4i2I3YYV0pZniJifvPTY7/Zf6LNDFQ==
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr8134789wma.84.1534175211194;
        Mon, 13 Aug 2018 08:46:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id y11-v6sm17891575wrt.4.2018.08.13.08.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 08:46:50 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id A790A12485E;
        Mon, 13 Aug 2018 17:46:48 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        rafael@kernel.org, david@redhat.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/3] mm/memory_hotplug: Drop mem_blk check from unregister_mem_sect_under_nodes
Date:   Mon, 13 Aug 2018 17:46:38 +0200
Message-Id: <20180813154639.19454-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180813154639.19454-1-osalvador@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
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

