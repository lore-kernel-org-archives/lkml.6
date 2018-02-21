Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeBUIED (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:04:03 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35393 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeBUID4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:03:56 -0500
X-Google-Smtp-Source: AH8x224yjtwhXGbkZuA2MQwCgWuyO8MvybMGtPugf3oFgR0gBYQrBNzOegh3jyhVI8tfitS4Z++7nw==
From: hans.ml.holmberg@owltronix.com
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 3/3] lightnvm: pblk: prevent race in pblk_rb_flush_point_set
Date: Wed, 21 Feb 2018 09:03:01 +0100
Message-Id: <1519200181-10886-4-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Make sure that we are not advancing the sync pointer while
we're adding bios to the write buffer entry completion list.

This race condition results in bios not completing and was identified
by a hang when running xfstest generic/113.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 8b14340..52fdd85 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -355,10 +355,13 @@ static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
 	struct pblk_rb_entry *entry;
 	unsigned int sync, flush_point;
 
+	pblk_rb_sync_init(rb, NULL);
 	sync = READ_ONCE(rb->sync);
 
-	if (pos == sync)
+	if (pos == sync) {
+		pblk_rb_sync_end(rb, NULL);
 		return 0;
+	}
 
 #ifdef CONFIG_NVM_DEBUG
 	atomic_inc(&rb->inflight_flush_point);
@@ -367,8 +370,6 @@ static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
 	flush_point = (pos == 0) ? (rb->nr_entries - 1) : (pos - 1);
 	entry = &rb->entries[flush_point];
 
-	pblk_rb_sync_init(rb, NULL);
-
 	/* Protect flush points */
 	smp_store_release(&rb->flush_point, flush_point);
 
-- 
2.7.4
