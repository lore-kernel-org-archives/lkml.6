Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423573AbeE1LIU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423503AbeE1LH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:07:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 081/272] fscache: Fix hanging wait on page discarded by writeback
Date: Mon, 28 May 2018 12:01:54 +0200
Message-Id: <20180528100247.947838077@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2c98425720233ae3e135add0c7e869b32913502f ]

If the fscache asynchronous write operation elects to discard a page that's
pending storage to the cache because the page would be over the store limit
then it needs to wake the page as someone may be waiting on completion of
the write.

The problem is that the store limit may be updated by a different
asynchronous operation - and so may miss the write - and that the store
limit may not even get updated until later by the netfs.

Fix the kernel hang by making fscache_write_op() mark as written any pages
that are over the limit.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fscache/page.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -776,6 +776,7 @@ static void fscache_write_op(struct fsca
 
 	_enter("{OP%x,%d}", op->op.debug_id, atomic_read(&op->op.usage));
 
+again:
 	spin_lock(&object->lock);
 	cookie = object->cookie;
 
@@ -816,10 +817,6 @@ static void fscache_write_op(struct fsca
 		goto superseded;
 	page = results[0];
 	_debug("gang %d [%lx]", n, page->index);
-	if (page->index >= op->store_limit) {
-		fscache_stat(&fscache_n_store_pages_over_limit);
-		goto superseded;
-	}
 
 	radix_tree_tag_set(&cookie->stores, page->index,
 			   FSCACHE_COOKIE_STORING_TAG);
@@ -829,6 +826,9 @@ static void fscache_write_op(struct fsca
 	spin_unlock(&cookie->stores_lock);
 	spin_unlock(&object->lock);
 
+	if (page->index >= op->store_limit)
+		goto discard_page;
+
 	fscache_stat(&fscache_n_store_pages);
 	fscache_stat(&fscache_n_cop_write_page);
 	ret = object->cache->ops->write_page(op, page);
@@ -844,6 +844,11 @@ static void fscache_write_op(struct fsca
 	_leave("");
 	return;
 
+discard_page:
+	fscache_stat(&fscache_n_store_pages_over_limit);
+	fscache_end_page_write(object, page);
+	goto again;
+
 superseded:
 	/* this writer is going away and there aren't any more things to
 	 * write */
