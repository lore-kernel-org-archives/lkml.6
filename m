Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9387C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADCA223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADCA223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbeKPSmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:42:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32928 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389359AbeKPSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:41:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id r27so15979685eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LzlccDXf/yxTKP+pRsq4A6fnjdUbs9H45qb89MeJwgk=;
        b=GeWWAvNFxPrAc/TwKNpSujjwW8nH1ih8pAB7qQKIv1nVP9faV5VYPs+O6Cq66QG5rF
         H2qFGI1HWucZk1FPC9nAqsBrLutm4ilHtXWMHzsoZ79A9XZJIyPa3Nz6d+jl38FXk8ZE
         p6MAQwe2vhYlmcXopyY5mNG++oSft5wv/HOBd0aPyupL6I79MwdgBjMCp0hdWalXAltR
         5jyqgiaowldfLydIcoVHDl3KzA43ygdxRPenDhH7P+D2/lbAXJAxyzTfGGdrQx0u3Q+k
         0smh+ZHV/1aKxdnAmcA+5ELaR6crGw5+1vgakpfJWyWcI+LP8lWfkuGIYHUcYFjotxKF
         aESw==
X-Gm-Message-State: AGRZ1gL2U2p6WjFQ8ji/tWHwQC5Z54U8wV5OpCj4mSe908GA/tCIQJOS
        EHe+BkcdoRvmzWVFgaiMjJ4=
X-Google-Smtp-Source: AJdET5c8sPRA1OLjYdnOBPxOalFmoaWho8oqy17NWq64FbRugxfrghIX3x/y2iTbh6OilXOnPHZV5w==
X-Received: by 2002:a50:be4c:: with SMTP id b12-v6mr8743984edi.46.1542357038628;
        Fri, 16 Nov 2018 00:30:38 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m13sm5305393edd.2.2018.11.16.00.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:30:37 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 5/5] mm, memory_hotplug: be more verbose for memory offline failures
Date:   Fri, 16 Nov 2018 09:30:20 +0100
Message-Id: <20181116083020.20260-6-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116083020.20260-1-mhocko@kernel.org>
References: <20181116083020.20260-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

There is only very limited information printed when the memory offlining
fails:
[ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff

This tells us that the failure is triggered by the userspace
intervention but it doesn't tell us much more about the underlying
reason. It might be that the page migration failes repeatedly and the
userspace timeout expires and send a signal or it might be some of the
earlier steps (isolation, memory notifier) takes too long.

If the migration failes then it would be really helpful to see which
page that and its state. The same applies to the isolation phase. If we
fail to isolate a page from the allocator then knowing the state of the
page would be helpful as well.

Dump the page state that fails to get isolated or migrated. This will
tell us more about the failure and what to focus on during debugging.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 12 ++++++++----
 mm/page_alloc.c     |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 88d50e74e3fe..c82193db4be6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1388,10 +1388,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 						    page_is_file_cache(page));
 
 		} else {
-#ifdef CONFIG_DEBUG_VM
-			pr_alert("failed to isolate pfn %lx\n", pfn);
+			pr_warn("failed to isolate pfn %lx\n", pfn);
 			dump_page(page, "isolation failed");
-#endif
 			put_page(page);
 			/* Because we don't have big zone->lock. we should
 			   check this again here. */
@@ -1411,8 +1409,14 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		/* Allocate a new page from the nearest neighbor node */
 		ret = migrate_pages(&source, new_node_page, NULL, 0,
 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
-		if (ret)
+		if (ret) {
+			list_for_each_entry(page, &source, lru) {
+				pr_warn("migrating pfn %lx failed ret:%d ",
+				       page_to_pfn(page), ret);
+				dump_page(page, "migration failure");
+			}
 			putback_movable_pages(&source);
+		}
 	}
 out:
 	return ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a919ba5cb3c8..ec2c7916dc2d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7845,6 +7845,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	return false;
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
+	dump_page(pfn_to_page(pfn+iter), "unmovable page");
 	return true;
 }
 
-- 
2.19.1

