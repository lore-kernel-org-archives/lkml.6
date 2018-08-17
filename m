Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5741C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67804218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67804218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeHQMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:03:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53247 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeHQMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:02:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so6853824wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ECCH/k6jiVWi1l5eaaCRKhrwOJOvg2mUyo3PfA9i7w=;
        b=hK4DYq9RCqvG+no0PXFETowrpPnGxkHhYI1aAhPuvvtKShzNuovF2wJPo3DHmud2sl
         Rtgc0G4ySySr0e+ywsPl3chdmvVY/6wjV7avaCjTuZx4TeGpYKGrOmH9wBnsiKGqX9og
         v+juWUxKi0OBrsnGFC9DpSd9k90Ooprd0blhRE38ru5UDE9siFlPY4QsQDlEfY5OJrp9
         i2Sz4+6FnwRtCwRutv20BrpwG3RImoH//xqS+acReCg5ecgFkC+8yz/fhpjW1UdzKHGO
         do9l+bhBuvvchuoWKfO7l2y3MkuI3HvaPeSSwTuIWmZn1cRpefQqwvdUbAUSdEzJj5ke
         N0Rg==
X-Gm-Message-State: AOUpUlFJBY/lX2YaqO4UQuOHlo8Hqk9qbR/xWeeGPk0jgONjX39DVIRI
        6QYu9+lD1i0JyDVhFNGBztA=
X-Google-Smtp-Source: AA+uWPwK9wRdaRi5EQ3bWRQJjG8o+L8hDi6Sukw/s1xQUKIwppv6plB/HAuWpnz392b6QfpeyEa0XQ==
X-Received: by 2002:a1c:6c03:: with SMTP id h3-v6mr17211304wmc.38.1534496423554;
        Fri, 17 Aug 2018 02:00:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a84-v6sm4446308wmh.27.2018.08.17.02.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:00:22 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 2B0A4124936;
        Fri, 17 Aug 2018 11:00:21 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 2/4] mm/memory_hotplug: Drop mem_blk check from unregister_mem_sect_under_nodes
Date:   Fri, 17 Aug 2018 11:00:15 +0200
Message-Id: <20180817090017.17610-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180817090017.17610-1-osalvador@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
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
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

