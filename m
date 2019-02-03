Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28675C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD6B2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfBCOYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:24:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55792 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730468AbfBCOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:22 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe9-0006Qa-E3; Sun, 03 Feb 2019 14:21:21 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9s-0007PU-CS; Sun, 03 Feb 2019 14:50:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Jeff Moyer" <jmoyer@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.88535616@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 277/305] aio: fix spectre gadget in lookup_ioctx
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Moyer <jmoyer@redhat.com>

commit a538e3ff9dabcdf6c3f477a373c629213d1c3066 upstream.

Matthew pointed out that the ioctx_table is susceptible to spectre v1,
because the index can be controlled by an attacker.  The below patch
should mitigate the attack for all of the aio system calls.

Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/aio.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -43,6 +43,7 @@
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
+#include <linux/nospec.h>
 
 #include "internal.h"
 
@@ -1022,6 +1023,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
+	id = array_index_nospec(id, table->nr);
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		if (percpu_ref_tryget_live(&ctx->users))

