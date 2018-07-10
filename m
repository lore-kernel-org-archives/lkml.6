Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44996C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E7420936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E7420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbeGJS0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:26:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732406AbeGJS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:26:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F52BE7D;
        Tue, 10 Jul 2018 18:26:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 3.18 18/23] dm bufio: drop the lock when doing GFP_NOIO allocation
Date:   Tue, 10 Jul 2018 20:24:51 +0200
Message-Id: <20180710182309.652294292@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 41c73a49df31151f4ff868f28fe4f129f113fa2c upstream.

If the first allocation attempt using GFP_NOWAIT fails, drop the lock
and retry using GFP_NOIO allocation (lock is dropped because the
allocation can take some time).

Note that we won't do GFP_NOIO allocation when we loop for the second
time, because the lock shouldn't be dropped between __wait_for_free_buffer
and __get_unclaimed_buffer.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-bufio.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -761,6 +761,7 @@ enum new_flag {
 static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client *c, enum new_flag nf)
 {
 	struct dm_buffer *b;
+	bool tried_noio_alloc = false;
 
 	/*
 	 * dm-bufio is resistant to allocation failures (it just keeps
@@ -785,6 +786,15 @@ static struct dm_buffer *__alloc_buffer_
 		if (nf == NF_PREFETCH)
 			return NULL;
 
+		if (dm_bufio_cache_size_latch != 1 && !tried_noio_alloc) {
+			dm_bufio_unlock(c);
+			b = alloc_buffer(c, GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+			dm_bufio_lock(c);
+			if (b)
+				return b;
+			tried_noio_alloc = true;
+		}
+
 		if (!list_empty(&c->reserved_buffers)) {
 			b = list_entry(c->reserved_buffers.next,
 				       struct dm_buffer, lru_list);


