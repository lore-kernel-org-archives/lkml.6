Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E42C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A8F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A8F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbeKLGSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:18:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50584 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730391AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000l7-NC; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qZ-SR; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.522563766@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 329/366] dm bufio: drop the lock when doing GFP_NOIO
 allocation
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-bufio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -773,6 +773,7 @@ enum new_flag {
 static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client *c, enum new_flag nf)
 {
 	struct dm_buffer *b;
+	bool tried_noio_alloc = false;
 
 	/*
 	 * dm-bufio is resistant to allocation failures (it just keeps
@@ -797,6 +798,15 @@ static struct dm_buffer *__alloc_buffer_
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

