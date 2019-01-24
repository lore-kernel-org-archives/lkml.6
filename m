Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C99BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAF220663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="vyMN0TH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfAXTlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:04 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36360 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbfAXTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:02 -0500
Received: by mail-yw1-f65.google.com with SMTP id i73so2924254ywg.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XQxFCnqX2P8KUUqb8YwfiiSFK3gunL+QvptxXbOpYcA=;
        b=vyMN0TH+/6oVgdBcFhjoqtghfPopjw353xrPZsi7Qc1KTSVCzBT5zMiX7RbFZOpde/
         nREk2GI0YQzUrh96Hme9mWtIBEAOYXdniwX6cvzHYjbXXO1HfMEewUSSvp+tnlJAKEWj
         AZE2Cm6U+P5try7YJoMuZJPWD0XX3QdCmH4a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XQxFCnqX2P8KUUqb8YwfiiSFK3gunL+QvptxXbOpYcA=;
        b=gTgV/Q5Gs5AuIJ7K+pELE8c7bIm54afKiFt0s0KAEb77A3M8pvsXCSz1uBWYzX3jdE
         hKiBvB/7M+BKIGA4vdBjona0p4wcrAWf3dU4/+CDj+JkzVIoDW1V0aNJvYgsYacI3M8K
         ykEAUYHaNOP6/EiHdZ5vcg5KhpLsEbWNbWS/b4iCDRtYOrXPwZ1kjpfS8qrwjZsob8l8
         piAbew3RPZ1z5sHvAzn4hPj1kihp9jWN4nzRMTLeOx5HHXxG7it2dVuPdGfBWMS5Nh2v
         QMd9aV5BdmqiIxgvUYVG4cx9/1Quw42vHRpY9i54Nu0FlwpFI0YOR3PNBZan3Tu4V5+v
         5Zeg==
X-Gm-Message-State: AJcUukfWY45aLC2J8YXy5oWQQFcH+VY8ABpLhOG5T/Wknj1+N3hswdxf
        whdvHkwT0Tk7jnXswK6Yovntyw==
X-Google-Smtp-Source: ALg8bN6tMfRjqPLp4khiK1lST5UzPb4bn19TKPP8fw+DLb2OYUviZnXkQqpNprsT259FS/KXfAESpQ==
X-Received: by 2002:a81:6087:: with SMTP id u129mr7905481ywb.115.1548358860924;
        Thu, 24 Jan 2019 11:41:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:d7cc])
        by smtp.gmail.com with ESMTPSA id k127sm9340681ywa.81.2019.01.24.11.41.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 24 Jan 2019 11:41:00 -0800 (PST)
Date:   Thu, 24 Jan 2019 14:41:00 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH 2/2] mm: Extract memcg maxable seq_file logic to
 seq_show_memcg_tunable
Message-ID: <20190124194100.GA31425@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg has a significant number of files exposed to kernfs where their
value is either exposed directly or is "max" in the case of
PAGE_COUNTER_MAX.

This patch makes this generic by providing a single function to do this
work. In combination with the previous patch adding mem_cgroup_from_seq,
this makes all of the seq_show feeder functions significantly more
simple.

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
 mm/memcontrol.c | 64 +++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 98aad31f5226..81b6f752471a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5375,6 +5375,16 @@ static void mem_cgroup_bind(struct cgroup_subsys_state *root_css)
 		root_mem_cgroup->use_hierarchy = false;
 }
 
+static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
+{
+	if (value == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)value * PAGE_SIZE);
+
+	return 0;
+}
+
 static u64 memory_current_read(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
@@ -5385,15 +5395,8 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 
 static int memory_min_show(struct seq_file *m, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	unsigned long min = READ_ONCE(memcg->memory.min);
-
-	if (min == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
-
-	return 0;
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.min));
 }
 
 static ssize_t memory_min_write(struct kernfs_open_file *of,
@@ -5415,15 +5418,8 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 
 static int memory_low_show(struct seq_file *m, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	unsigned long low = READ_ONCE(memcg->memory.low);
-
-	if (low == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)low * PAGE_SIZE);
-
-	return 0;
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.low));
 }
 
 static ssize_t memory_low_write(struct kernfs_open_file *of,
@@ -5445,15 +5441,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 
 static int memory_high_show(struct seq_file *m, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	unsigned long high = READ_ONCE(memcg->high);
-
-	if (high == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)high * PAGE_SIZE);
-
-	return 0;
+	return seq_puts_memcg_tunable(m, READ_ONCE(mem_cgroup_from_seq(m)->high));
 }
 
 static ssize_t memory_high_write(struct kernfs_open_file *of,
@@ -5482,15 +5470,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 static int memory_max_show(struct seq_file *m, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	unsigned long max = READ_ONCE(memcg->memory.max);
-
-	if (max == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
-
-	return 0;
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.max));
 }
 
 static ssize_t memory_max_write(struct kernfs_open_file *of,
@@ -6622,15 +6603,8 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 
 static int swap_max_show(struct seq_file *m, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	unsigned long max = READ_ONCE(memcg->swap.max);
-
-	if (max == PAGE_COUNTER_MAX)
-		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
-
-	return 0;
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->swap.max));
 }
 
 static ssize_t swap_max_write(struct kernfs_open_file *of,
-- 
2.20.1

