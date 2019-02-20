Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8D21B24
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfBTSiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbfBTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961F721907;
        Wed, 20 Feb 2019 18:38:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWku-0006eA-H6; Wed, 20 Feb 2019 13:38:04 -0500
Message-Id: <20190220183804.404847769@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-next][PATCH 09/29] ring-buffer: Remove unused function ring_buffer_page_len()
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

Commit 6b7e633fe9c2 ("tracing: Remove extra zeroing out of the ring
buffer page") removed the only caller of ring_buffer_page_len(). The
function is now unused and may be removed.

Link: http://lkml.kernel.org/r/20181228133847.106177-1-mbenes@suse.cz

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  2 --
 kernel/trace/ring_buffer.c  | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 5b9ae62272bb..f1429675f252 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -187,8 +187,6 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
 void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
 bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
-size_t ring_buffer_page_len(void *page);
-
 size_t ring_buffer_nr_pages(struct ring_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct ring_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 06e864a334bb..9a91479bbbfe 100644
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


