Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90712184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="PXQjp5Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfAXGRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:17:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36956 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfAXGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:17:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so5302225qtt.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U0AooFy1ax20zpRlkLDkFt5l6nCkHkjvULoZY6yPeKE=;
        b=PXQjp5Y/Vnl6VbTY9Pbwz7Evmx050L9FWU8JbeaChoUtLye1lmOFhC4eygB5f5gw61
         i50luMUBbTbFYEagdIC/D1wQC/dtGISue7wiwCvan9qmkan8NxAc9CLFk+UF2W49DY2q
         Wwjk7WP4vJDg6nGCfR7QHedgomR0MzjBg/9p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U0AooFy1ax20zpRlkLDkFt5l6nCkHkjvULoZY6yPeKE=;
        b=inArwLdSsl7z7V9LFxm4eO3KOGlluvz3mK9PT71P/To84END8IfYxBmpPGE9MSjvpX
         /Qxj/PhDw9Ms5HVaLG1SxSATikgdnaNWWmUNWbISRg+aP9hzygaUjJldc5lBntKDGCVS
         UAOolVjLJyPfZAVnKQsML93M5ApQIoJUV9NZDZDEMWG/PqW/VXnWtxYdyKCQPAc7K7PE
         KEHbZCKiMEETFT5QDkyNQm44lYtHr64/F4cyF3pjhspBSsn3+TG2TVlKQum1gEwyD2LT
         hXbBYUqwH1NXz5MH0D1aA+obGFa70hrzxCNLh+ttySP3YtnR9jYq7yw5ad7XNRScuQqb
         VfZQ==
X-Gm-Message-State: AJcUukdWO8BemuZsTQVJoERg7108Q1/Jxw+NfWsKxgGqEWouv4bpi/Ku
        1KQ0Y9RsS4Z/TD9vRcGEU/soSYHR6rRFHQ==
X-Google-Smtp-Source: ALg8bN7NrO20Gl4iS+8o3LOICdulN9gsiF0vcHWXGYLgC7BASRc1EA4BuuaqbovuoTHJhAXeEeFBYg==
X-Received: by 2002:ac8:1941:: with SMTP id g1mr5245934qtk.193.1548310639718;
        Wed, 23 Jan 2019 22:17:19 -0800 (PST)
Received: from localhost (rrcs-108-176-24-99.nyc.biz.rr.com. [108.176.24.99])
        by smtp.gmail.com with ESMTPSA id y6sm46551943qke.34.2019.01.23.22.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 22:17:19 -0800 (PST)
Date:   Thu, 24 Jan 2019 01:17:18 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] mm: Move maxable seq_file logic into a single place
Message-ID: <20190124061718.GA15486@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg has a significant number of files exposed to kernfs where their
value is either exposed directly or is "max" in the case of
PAGE_COUNTER_MAX.

There's a fair amount of duplicated code here, since each file involves
turning a seq_file to a css, getting the memcg from the css, safely
reading the counter value, and then doing the right thing depending on
whether the value is PAGE_COUNTER_MAX or not.

This patch adds the macro DEFINE_MEMCG_MAX_OR_VAL, which defines and
implements a generic way to do this work, avoiding fragmenting logic.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 78 ++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 60 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18f4aefbe0bf..90e2e0ff5ed9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,6 +261,19 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
+/* Convenience macro to define seq_file mutators that can return "max" */
+#define DEFINE_MEMCG_MAX_OR_VAL(name, key)				    \
+	static int name(struct seq_file *m, void *v)			    \
+	{								    \
+		struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m)); \
+		unsigned long val = READ_ONCE(memcg->key);		    \
+		if (val == PAGE_COUNTER_MAX)				    \
+			seq_puts(m, "max\n");				    \
+		else							    \
+			seq_printf(m, "%llu\n", (u64)val * PAGE_SIZE);	    \
+		return 0;						    \
+	}
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
@@ -5383,18 +5396,7 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
-static int memory_min_show(struct seq_file *m, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long min = READ_ONCE(memcg->memory.min);
-
-	if (min == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
-
-	return 0;
-}
+DEFINE_MEMCG_MAX_OR_VAL(memory_min_show, memory.min)
 
 static ssize_t memory_min_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
@@ -5413,18 +5415,7 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
-static int memory_low_show(struct seq_file *m, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long low = READ_ONCE(memcg->memory.low);
-
-	if (low == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)low * PAGE_SIZE);
-
-	return 0;
-}
+DEFINE_MEMCG_MAX_OR_VAL(memory_low_show, memory.low)
 
 static ssize_t memory_low_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
@@ -5443,18 +5434,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
-static int memory_high_show(struct seq_file *m, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long high = READ_ONCE(memcg->high);
-
-	if (high == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)high * PAGE_SIZE);
-
-	return 0;
-}
+DEFINE_MEMCG_MAX_OR_VAL(memory_high_show, high)
 
 static ssize_t memory_high_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off)
@@ -5480,18 +5460,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
-static int memory_max_show(struct seq_file *m, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long max = READ_ONCE(memcg->memory.max);
-
-	if (max == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
-
-	return 0;
-}
+DEFINE_MEMCG_MAX_OR_VAL(memory_max_show, memory.max)
 
 static ssize_t memory_max_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
@@ -6620,18 +6589,7 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
 }
 
-static int swap_max_show(struct seq_file *m, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long max = READ_ONCE(memcg->swap.max);
-
-	if (max == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
-
-	return 0;
-}
+DEFINE_MEMCG_MAX_OR_VAL(swap_max_show, swap.max)
 
 static ssize_t swap_max_write(struct kernfs_open_file *of,
 			      char *buf, size_t nbytes, loff_t off)
-- 
2.20.1

