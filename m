Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeEUEic (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:38:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55589 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbeEUEi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:38:29 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 21 May 2018 14:35:12 +1000
Subject: [PATCH 09/30] staging: lustre: discard LOWEST_BIT_SET()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152687731269.24196.12873538902260418047.stgit@noble>
In-Reply-To: <152687724799.24196.7718555295926047576.stgit@noble>
References: <152687724799.24196.7718555295926047576.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is only used once to test if a value is
a power of two.  So use is_power_of_2() instead and
discard the macro.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    2 --
 drivers/staging/lustre/lnet/lnet/lib-eq.c          |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 7259544e4c32..084150e9d9ac 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -89,8 +89,6 @@
 
 #define LIBCFS_VERSION "0.7.0"
 
-#define LOWEST_BIT_SET(x)       ((x) & ~((x) - 1))
-
 /*
  * One jiffy
  */
diff --git a/drivers/staging/lustre/lnet/lnet/lib-eq.c b/drivers/staging/lustre/lnet/lnet/lib-eq.c
index ea53b5cb3f72..c78e70373ab4 100644
--- a/drivers/staging/lustre/lnet/lnet/lib-eq.c
+++ b/drivers/staging/lustre/lnet/lnet/lib-eq.c
@@ -225,7 +225,7 @@ lnet_eq_enqueue_event(struct lnet_eq *eq, struct lnet_event *ev)
 	lnet_eq_wait_lock();
 	ev->sequence = eq->eq_enq_seq++;
 
-	LASSERT(eq->eq_size == LOWEST_BIT_SET(eq->eq_size));
+	LASSERT(is_power_of_2(eq->eq_size));
 	index = ev->sequence & (eq->eq_size - 1);
 
 	eq->eq_events[index] = *ev;
