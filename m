Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 459E2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06007208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06007208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933654AbeFLHvy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:51:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933242AbeFLHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615829"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:49 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 3/6] perf: Add an iterator for AUX data
Date:   Tue, 12 Jun 2018 10:51:14 +0300
Message-Id: <20180612075117.65420-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A helper function to sequentially walk through the AUX buffer with a
given callback. This is useful to copy the AUX data out of its buffer.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/internal.h    |  5 +++++
 kernel/events/ring_buffer.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 6dc725a7e7bc..eb6cd6b370f9 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -56,6 +56,9 @@ struct ring_buffer {
 	void				*data_pages[0];
 };
 
+typedef unsigned long (*aux_copyfn)(void *data, const void *src,
+				    unsigned long len);
+
 extern void rb_free(struct ring_buffer *rb);
 
 static inline void rb_free_rcu(struct rcu_head *rcu_head)
@@ -80,6 +83,8 @@ extern void perf_event_wakeup(struct perf_event *event);
 extern int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			pgoff_t pgoff, int nr_pages, long watermark, int flags);
 extern void rb_free_aux(struct ring_buffer *rb);
+extern long rb_output_aux(struct ring_buffer *rb, unsigned long from,
+			  unsigned long to, aux_copyfn copyfn, void *data);
 extern struct ring_buffer *ring_buffer_get(struct perf_event *event);
 extern void ring_buffer_put(struct ring_buffer *rb);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 141aa2ca8728..d6157143f054 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -519,6 +519,40 @@ void *perf_get_aux(struct perf_output_handle *handle)
 }
 EXPORT_SYMBOL_GPL(perf_get_aux);
 
+/*
+ * Copy out AUX data from a ring_buffer using a supplied callback.
+ */
+long rb_output_aux(struct ring_buffer *rb, unsigned long from,
+		   unsigned long to, aux_copyfn copyfn, void *data)
+{
+	unsigned long tocopy, remainder, len = 0;
+	void *addr;
+
+	from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
+	to &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
+
+	do {
+		tocopy = PAGE_SIZE - offset_in_page(from);
+		if (to > from)
+			tocopy = min(tocopy, to - from);
+		if (!tocopy)
+			break;
+
+		addr = rb->aux_pages[from >> PAGE_SHIFT];
+		addr += offset_in_page(from);
+
+		remainder = copyfn(data, addr, tocopy);
+		if (remainder)
+			return -EFAULT;
+
+		len += tocopy;
+		from += tocopy;
+		from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
+	} while (to != from);
+
+	return len;
+}
+
 #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
 
 static struct page *rb_alloc_aux_page(int node, int order)
-- 
2.17.1

