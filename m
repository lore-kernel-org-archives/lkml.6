Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeBUUlo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:41:44 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36668 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeBUUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:41:42 -0500
X-Google-Smtp-Source: AH8x226ArLJUgHUKWRsq+J9fUvZCLXoGvVp/GulC29CQfPfZMt3RRFpzkXNHkz6P6DOAZTrKDi4J9A==
From: Garry McNulty <garrmcnu@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, hch@lst.de, linux-kernel@vger.kernel.org,
        Garry McNulty <garrmcnu@gmail.com>
Subject: [PATCH] fs/iomap: fix memory leak on error condition
Date: Wed, 21 Feb 2018 20:41:28 +0000
Message-Id: <20180221204128.5846-1-garrmcnu@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the call to is_sync_kiocb() fails an error is returned without
freeing dio. Set the return code and jump to out_free_dio.

Detected by CoverityScan, CID 1429424 ("Resource leak")

Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
---
 fs/iomap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index afd163586aa0..65c5db38c15a 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1063,8 +1063,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iomap_dio_set_error(dio, ret);
 
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!is_sync_kiocb(iocb))
-			return -EIOCBQUEUED;
+		if (!is_sync_kiocb(iocb)) {
+			ret = -EIOCBQUEUED;
+			goto out_free_dio;
+		}
 
 		for (;;) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
-- 
2.14.3
