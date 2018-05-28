Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161420AbeE1KcA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161359AbeE1Kbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Dave Jiang <dave.jiang@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 126/329] kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE
Date: Mon, 28 May 2018 12:00:55 +0200
Message-Id: <20180528100253.151451858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>

[ Upstream commit 88913bd8ea2a75d7e460a4bed5f75e1c32660d7e ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/relay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -163,7 +163,7 @@ static struct rchan_buf *relay_create_bu
 {
 	struct rchan_buf *buf;
 
-	if (chan->n_subbufs > UINT_MAX / sizeof(size_t *))
+	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t *))
 		return NULL;
 
 	buf = kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
