Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C7AC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EA42081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA42081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbeKGTsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:48:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbeKGTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so16747056wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5/bX0/SWP8L0SIclkIvq/xCjg7Ure75U3oy5+jt8kI=;
        b=iXoKBKKFh5OMIrviU761wUVESneZ+4fgL570cCjoDF/vqf6P7vGi/rZa/UDB03EDZu
         /drlsmzWabtWKvudvib3+bZUkGC6w4fEpDMXvLLvJy3Hy64LTIY4QvheiH43VrTM/kxj
         YamQawMDOa2iERwZ789xYp6EOhL1f0AyYzgp3wzwWI+GIcB4V7YNw0pT4TmOQsDpbXi5
         tflvCuordV0sRtTmQmWscrRIuQsBTVwRitUX40QFT/I69qBwFp5Ylx44ecS1tx29rI9/
         QMqL5a7dCRaA+RnA1Jswc7QTPRrvYlKuK/I4+WvGy1oD8iqOwc9RTV5q0W1AaAXXpxJV
         zCpA==
X-Gm-Message-State: AGRZ1gJBOxOpC2zR7c41DVrbgn0gK9vd8ymHA+xgq2dWzuP04sazx5v7
        QTjDpdWNuKHZcl5UfnBEbvQ=
X-Google-Smtp-Source: AJdET5eHo2JX1vYp8BkfX/qztqCKji8admMiIOvP+AoZ2YzWgs+cVV3KFo5eEzErRWcJHfx1pjbacg==
X-Received: by 2002:a5d:660c:: with SMTP id n12-v6mr1393687wru.19.1541585929283;
        Wed, 07 Nov 2018 02:18:49 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-140-85.eurotel.cz. [37.188.140.85])
        by smtp.gmail.com with ESMTPSA id w18-v6sm217527wrn.66.2018.11.07.02.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:18:48 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 5/5] mm, memory_hotplug: be more verbose for memory offline failures
Date:   Wed,  7 Nov 2018 11:18:30 +0100
Message-Id: <20181107101830.17405-6-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107101830.17405-1-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
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
index 1badac89c58e..bf214beccda3 100644
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
+				pr_warn("migrating pfn %lx failed ",
+				       page_to_pfn(page), ret);
+				dump_page(page, NULL);
+			}
 			putback_movable_pages(&source);
+		}
 	}
 out:
 	return ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a919ba5cb3c8..23267767bf98 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7845,6 +7845,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	return false;
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
+	dump_page(pfn_to_page(pfn+iter), "has_unmovable_pages");
 	return true;
 }
 
-- 
2.19.1

