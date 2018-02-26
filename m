Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeBZRrr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeBZRrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:47:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1421784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: don't stop GC if GC is contended
Date: Mon, 26 Feb 2018 09:47:31 -0800
Message-Id: <20180226174731.26679-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's do GC as much as possible, while gc_urgent is set.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd532a9..bc9420ce2275 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -76,14 +76,15 @@ static int gc_thread_func(void *data)
 		 * invalidated soon after by user update or deletion.
 		 * So, I'd like to wait some time to collect dirty segments.
 		 */
-		if (!mutex_trylock(&sbi->gc_mutex))
-			goto next;
-
 		if (gc_th->gc_urgent) {
 			wait_ms = gc_th->urgent_sleep_time;
+			mutex_lock(&sbi->gc_mutex);
 			goto do_gc;
 		}
 
+		if (!mutex_trylock(&sbi->gc_mutex))
+			goto next;
+
 		if (!is_idle(sbi)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
-- 
2.15.0.531.g2ccb3012c9-goog
