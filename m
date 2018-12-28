Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CE020879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeL1Niz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 08:38:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730444AbeL1Niy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 08:38:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D40FABE7;
        Fri, 28 Dec 2018 13:38:53 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     tom.zanussi@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] ring-buffer: Remove unused function ring_buffer_page_len()
Date:   Fri, 28 Dec 2018 14:38:47 +0100
Message-Id: <20181228133847.106177-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6b7e633fe9c2 ("tracing: Remove extra zeroing out of the ring
buffer page") removed the only caller of ring_buffer_page_len(). The
function is now unused and may be removed.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
I am sorry if you received the patch more than once (hopefully not). For some
strange reasons git send-email segfaulted, I tried to send from a different
machine and made a mistake. Holiday mode *sigh*.

 include/linux/ring_buffer.h |  3 ---
 kernel/trace/ring_buffer.c  | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0940fda59872..2351aa46dbc7 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -187,9 +187,6 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
 void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
 bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
-size_t ring_buffer_page_len(void *page);
-
-
 void *ring_buffer_alloc_read_page(struct ring_buffer *buffer, int cpu);
 void ring_buffer_free_read_page(struct ring_buffer *buffer, int cpu, void *data);
 int ring_buffer_read_page(struct ring_buffer *buffer, void **data_page,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4f3247a53259..ca1308eec4a4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -353,20 +353,6 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
-/**
- * ring_buffer_page_len - the size of data on the page.
- * @page: The page to read
- *
- * Returns the amount of data on the page, including buffer page header.
- */
-size_t ring_buffer_page_len(void *page)
-{
-	struct buffer_data_page *bpage = page;
-
-	return (local_read(&bpage->commit) & ~RB_MISSED_FLAGS)
-		+ BUF_PAGE_HDR_SIZE;
-}
-
 /*
  * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
  * this issue out.
-- 
2.20.1

