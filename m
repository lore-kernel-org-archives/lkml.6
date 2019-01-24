Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A21218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otCEUxy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfAXL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:57:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41301 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfAXL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:57:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so4086189lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LH2WfGm9JecgWZzx+vTKmh903j2Nkd/dyKUicbvBqL4=;
        b=otCEUxy9/8LsDspYMLhrFYV4Mt3MDXaRGgPVnH3raQohrhx3IENSURFXhFQYXzsedz
         F4TmLxi9rxVeDu/K5mpRe8tNOBqwW8/6DW+raTEvmAFy7JbwWK3yRgLNxgAoAOd0FHUm
         bcVS1WGX45Lcog/DowgR6A3GWH+Gwcaqv7DRM1arVX9Qx7UV6yAaHTWg8BwBLAqLTa4L
         v9WHSo3jdFFj5HAV+vhUWLeL1L0oKOYodltmV+WWkjeOYwX90wwLc5AxpiP/IzMuWLt/
         okbN9C5tHA7QCOtBkHtA0+7N6IBrwXy+ImLXQDRTHirzyTzuG9ZtF/8/bfru/NNQ/O37
         f7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LH2WfGm9JecgWZzx+vTKmh903j2Nkd/dyKUicbvBqL4=;
        b=RuJe+ej4O7K+exmEGcAptJFHOi+kLOMp4uvMAwCHZEm3TfMG0szkgmrwCNq/xCGk6/
         Xc1yGnowZaVZcjJnU9M1RfmiVpWpV5o7bs2VwyDWEKl+E79RrKLMrhuy/HotLER5Uwp+
         NbBPB003xcX3/lLfbgy3hHlH6pgoTTz2ynINHvwJsUWqi/nmVwfu7BwSTqSZQsdmFsFm
         QqnJxWZcs8nvwuooKEzJu5ZWMXtg+ZTsFquTW0Uv/g/8pEYfOdoDZSvIZhO7+ONZ8iIY
         ayvz4fHDk8sqWbrawnuvV+R0JoKahDJZMLha20QgLBasxNyVI1xhD2mOa138o1SUOUV3
         aAPQ==
X-Gm-Message-State: AJcUukcgTzp04IIRydomz23qL6ymfy1FCa7EEa9NSZpm3FL3iBgvghg9
        DIWCxdjg3bGz687zwr+b1xw=
X-Google-Smtp-Source: ALg8bN5XmuZZCNstoL7umSLMjPTwUb4qtjoHCuVnAOMRQy7Zp/qTmcBmfwsBuyULKrL8NZgyTKdbdg==
X-Received: by 2002:a19:2106:: with SMTP id h6mr4947446lfh.29.1548331024917;
        Thu, 24 Jan 2019 03:57:04 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id w202sm920226lff.31.2019.01.24.03.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:57:04 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v1 2/2] mm: add priority threshold to __purge_vmap_area_lazy()
Date:   Thu, 24 Jan 2019 12:56:48 +0100
Message-Id: <20190124115648.9433-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190124115648.9433-1-urezki@gmail.com>
References: <20190124115648.9433-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 763b218ddfaf ("mm: add preempt points into
__purge_vmap_area_lazy()")

introduced some preempt points, one of those is making an
allocation more prioritized over lazy free of vmap areas.

Prioritizing an allocation over freeing does not work well
all the time, i.e. it should be rather a compromise.

1) Number of lazy pages directly influence on busy list length
thus on operations like: allocation, lookup, unmap, remove, etc.

2) Under heavy stress of vmalloc subsystem i run into a situation
when memory usage gets increased hitting out_of_memory -> panic
state due to completely blocking of logic that frees vmap areas
in the __purge_vmap_area_lazy() function.

Establish a threshold passing which the freeing is prioritized
back over allocation creating a balance between each other.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fb4fb5fcee74..abe83f885069 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -661,23 +661,27 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	struct llist_node *valist;
 	struct vmap_area *va;
 	struct vmap_area *n_va;
-	bool do_free = false;
+	int resched_threshold;
 
 	lockdep_assert_held(&vmap_purge_lock);
 
 	valist = llist_del_all(&vmap_purge_list);
+	if (unlikely(valist == NULL))
+		return false;
+
+	/*
+	 * TODO: to calculate a flush range without looping.
+	 * The list can be up to lazy_max_pages() elements.
+	 */
 	llist_for_each_entry(va, valist, purge_list) {
 		if (va->va_start < start)
 			start = va->va_start;
 		if (va->va_end > end)
 			end = va->va_end;
-		do_free = true;
 	}
 
-	if (!do_free)
-		return false;
-
 	flush_tlb_kernel_range(start, end);
+	resched_threshold = (int) lazy_max_pages() << 1;
 
 	spin_lock(&vmap_area_lock);
 	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
@@ -685,7 +689,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 
 		__free_vmap_area(va);
 		atomic_sub(nr, &vmap_lazy_nr);
-		cond_resched_lock(&vmap_area_lock);
+
+		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
+			cond_resched_lock(&vmap_area_lock);
 	}
 	spin_unlock(&vmap_area_lock);
 	return true;
-- 
2.11.0

