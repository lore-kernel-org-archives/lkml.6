Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFBAC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F882098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqQOtV1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F882098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeJPCZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:25:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37962 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:25:13 -0400
Received: by mail-io1-f68.google.com with SMTP id n5-v6so14945037ioh.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FB27Bd0ZCxbVI2xpfmkuDM1L376zbfAO2vlWDhwgClM=;
        b=eqQOtV1w+ZQOgh4MkPoaMGVdeg1qMF2xxJp+KZztdyjuGO5jESuQQXJEuH996LMttB
         HUs9XsC2VyomHR8kx3HWdLPFn9D8yh89ty+M9Sqb1whj+Y3M+yDB/0vd9H8MWSBwwVjg
         XVM/A/D9MxK2aoP0Qo/91+lgPl2jTI9nGDsXODVK7mS3EO29S7WPpiGcie15DPD2Vwvr
         cjC6oexlB0SfCOQ2RQ4Dopr7x/PLsEfpwusK15DVzYKclmsDMbUTxdwAoWPuwSDbzO8G
         xQvIvNZPFSxbVqr7YeArYPW1OKqHzo/WKuNEn3wOVfYrXel0SxQTe0y6OG3MmApKCFtf
         O+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FB27Bd0ZCxbVI2xpfmkuDM1L376zbfAO2vlWDhwgClM=;
        b=rWwq0ZNuj9XWZtDrzvCF0KkZJpETD0HczISlLjxz+9TB8Cgk6BIwIoEvT3BSa7QFpl
         CIegaTzBRSwn02oY6Oolnq4c4KTEXLP7RnA+IbI86aobBxaspy7GLE0Uur9K5TSRLnu9
         eksDX4VosSzX+TQRb6Eh+UTwlip4twip1DGL3TAQ/5c60rSuaPD1xHjUeRGUKk2zM+Js
         XM3rq0UZdT8K9DM4ZmV0xGkoj508u2+GUgIdSki2foT2zWV1u0Y8ihAFlobTMI2M/D6n
         hbD+VPnv1Hcqr5O87tHu0D/gpSdqIqlX8ndY5ndLrWkebS5h2RX5Mz7rx/Hjnh17iBmR
         EDuw==
X-Gm-Message-State: ABuFfohrUw6m0NzF55oJ1JZkf3tcCusOUYxKJTwRBEQfvKMvI4yugiWh
        BsnkSTy/3zWhCs8Rcup99oQYPA==
X-Google-Smtp-Source: ACcGV6220peb/QNpOZnl4+HyjvTT/7c2GjbvtM8l/0gTyCAed+n4hIjaSyWnmXOgAFhPit03KoxDJg==
X-Received: by 2002:a6b:108:: with SMTP id 8-v6mr11794134iob.274.1539628726584;
        Mon, 15 Oct 2018 11:38:46 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id z11-v6sm5883974itz.26.2018.10.15.11.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 11:38:45 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Jan Kara <jack@suse.cz>, David Rientjes <rientjes@google.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Roman Gushchin <guro@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm: detect numbers of vmstat keys/values mismatch
Date:   Mon, 15 Oct 2018 12:38:41 -0600
Message-Id: <20181015183841.114341-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were mismatches between number of vmstat keys and number of
vmstat values. They were fixed recently by:
  commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
  commit 28e2c4bb99aa ("mm/vmstat.c: fix outdated vmstat_text")

Add a BUILD_BUG_ON to detect such mismatch and hopefully prevent
it from happening again.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/vmstat.h |  4 ++++
 mm/vmstat.c            | 18 ++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index f25cef84b41d..33fdd37124cb 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -78,6 +78,10 @@ extern void vm_events_fold_cpu(int cpu);
 
 #else
 
+struct vm_event_state {
+	unsigned long event[0];
+};
+
 /* Disable counters */
 static inline void count_vm_event(enum vm_event_item item)
 {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7878da76abf2..7ebf871b4cc9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1647,23 +1647,21 @@ enum writeback_stat_item {
 	NR_VM_WRITEBACK_STAT_ITEMS,
 };
 
+#define NR_VM_STAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + NR_VM_NUMA_STAT_ITEMS + \
+			  NR_VM_NODE_STAT_ITEMS + NR_VM_WRITEBACK_STAT_ITEMS + \
+			  ARRAY_SIZE(((struct vm_event_state *)0)->event))
+
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
+	int i;
 	unsigned long *v;
-	int i, stat_items_size;
+
+	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) != NR_VM_STAT_ITEMS);
 
 	if (*pos >= ARRAY_SIZE(vmstat_text))
 		return NULL;
-	stat_items_size = NR_VM_ZONE_STAT_ITEMS * sizeof(unsigned long) +
-			  NR_VM_NUMA_STAT_ITEMS * sizeof(unsigned long) +
-			  NR_VM_NODE_STAT_ITEMS * sizeof(unsigned long) +
-			  NR_VM_WRITEBACK_STAT_ITEMS * sizeof(unsigned long);
-
-#ifdef CONFIG_VM_EVENT_COUNTERS
-	stat_items_size += sizeof(struct vm_event_state);
-#endif
 
-	v = kmalloc(stat_items_size, GFP_KERNEL);
+	v = kmalloc_array(NR_VM_STAT_ITEMS, sizeof(unsigned long), GFP_KERNEL);
 	m->private = v;
 	if (!v)
 		return ERR_PTR(-ENOMEM);
-- 
2.19.1.331.ge82ca0e54c-goog

