Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939318AbeE1OJv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162193AbeE1Khp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:37:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinayak Menon <vinmenon@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 225/329] mm/kmemleak.c: wait for scan completion before disabling free
Date: Mon, 28 May 2018 12:02:34 +0200
Message-Id: <20180528100300.846023730@linuxfoundation.org>
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

From: Vinayak Menon <vinmenon@codeaurora.org>

[ Upstream commit 914b6dfff790544d9b77dfd1723adb3745ec9700 ]

A crash is observed when kmemleak_scan accesses the object->pointer,
likely due to the following race.

  TASK A             TASK B                     TASK C
  kmemleak_write
   (with "scan" and
   NOT "scan=on")
  kmemleak_scan()
                     create_object
                     kmem_cache_alloc fails
                     kmemleak_disable
                     kmemleak_do_cleanup
                     kmemleak_free_enabled = 0
                                                kfree
                                                kmemleak_free bails out
                                                 (kmemleak_free_enabled is 0)
                                                slub frees object->pointer
  update_checksum
  crash - object->pointer
   freed (DEBUG_PAGEALLOC)

kmemleak_do_cleanup waits for the scan thread to complete, but not for
direct call to kmemleak_scan via kmemleak_write.  So add a wait for
kmemleak_scan completion before disabling kmemleak_free, and while at it
fix the comment on stop_scan_thread.

[vinmenon@codeaurora.org: fix stop_scan_thread comment]
  Link: http://lkml.kernel.org/r/1522219972-22809-1-git-send-email-vinmenon@codeaurora.org
Link: http://lkml.kernel.org/r/1522063429-18992-1-git-send-email-vinmenon@codeaurora.org
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmemleak.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1577,8 +1577,7 @@ static void start_scan_thread(void)
 }
 
 /*
- * Stop the automatic memory scanning thread. This function must be called
- * with the scan_mutex held.
+ * Stop the automatic memory scanning thread.
  */
 static void stop_scan_thread(void)
 {
@@ -1841,12 +1840,15 @@ static void kmemleak_do_cleanup(struct w
 {
 	stop_scan_thread();
 
+	mutex_lock(&scan_mutex);
 	/*
-	 * Once the scan thread has stopped, it is safe to no longer track
-	 * object freeing. Ordering of the scan thread stopping and the memory
-	 * accesses below is guaranteed by the kthread_stop() function.
+	 * Once it is made sure that kmemleak_scan has stopped, it is safe to no
+	 * longer track object freeing. Ordering of the scan thread stopping and
+	 * the memory accesses below is guaranteed by the kthread_stop()
+	 * function.
 	 */
 	kmemleak_free_enabled = 0;
+	mutex_unlock(&scan_mutex);
 
 	if (!kmemleak_found_leaks)
 		__kmemleak_do_cleanup();
