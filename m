Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nZm+MaVGGVtjOAAAmS7hNA
	; Thu, 07 Jun 2018 14:52:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0E4B608BA; Thu,  7 Jun 2018 14:52:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 52107601C3;
	Thu,  7 Jun 2018 14:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52107601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935047AbeFGOwe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40911 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934263AbeFGOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:21 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbY-0005Zs-R4; Thu, 07 Jun 2018 15:09:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036s-E8; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Rientjes" <rientjes@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Dave Jiang" <dave.jiang@intel.com>, "Jens Axboe" <axboe@kernel.dk>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.742952040@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 276/410] kernel/relay.c: limit kmalloc size to
 KMALLOC_MAX_SIZE
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
