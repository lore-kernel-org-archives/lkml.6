Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeE3L3h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60898 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752392AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "David Rientjes" <rientjes@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.289191784@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 103/153] kernel/relay.c: limit kmalloc size to
 KMALLOC_MAX_SIZE
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>

commit 88913bd8ea2a75d7e460a4bed5f75e1c32660d7e upstream.

chan->n_subbufs is set by the user and relay_create_buf() does a kmalloc()
of chan->n_subbufs * sizeof(size_t *).

kmalloc_slab() will generate a warning when this fails if
chan->subbufs * sizeof(size_t *) > KMALLOC_MAX_SIZE.

Limit chan->n_subbufs to the maximum allowed kmalloc() size.

Link: http://lkml.kernel.org/r/alpine.DEB.2.10.1802061216100.122576@chino.kir.corp.google.com
Fixes: f6302f1bcd75 ("relay: prevent integer overflow in relay_open()")
Signed-off-by: David Rientjes <rientjes@google.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/relay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -166,7 +166,7 @@ static struct rchan_buf *relay_create_bu
 {
 	struct rchan_buf *buf;
 
-	if (chan->n_subbufs > UINT_MAX / sizeof(size_t *))
+	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t *))
 		return NULL;
 
 	buf = kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
