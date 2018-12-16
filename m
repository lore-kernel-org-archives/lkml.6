Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB632082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeLPTta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:49:30 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:47941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeLPTta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:49:30 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7am5-1gVbC00qYH-0084Ul; Sun, 16 Dec 2018 20:48:41 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org
Cc:     "Acked-by : Phil Sutter" <phil@nwl.cc>,
        Arnd Bergmann <arnd@arndb.de>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] test_rhashtable: remove semaphore usage
Date:   Sun, 16 Dec 2018 20:48:21 +0100
Message-Id: <20181216194836.1310998-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FUnMhcPAbSkKA2vor1FOapiMSRYuHsIns8zB/3OOnCCLgmuprWp
 gWdqNuCiZK2edPluRXVSIevEhPkNyPFoeuzahKcRfVKusgl/Hhr1CVfeE3SZVEZkYbWmVXk
 s9InSjaS/6WxCdU0PP1SrXERmVVw/8cQF72RELxzuNw8J3PLPzcerhP4ba4hRgERNGF4+VB
 SevBQyRAKxseUMfBHE8jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4mM1BL8o3FA=:AJXkdMDkC9mR+fnkB/tL1n
 +FJD/WwBDVES30FNpdMuX/jMJoVHjQ/F5O4Ir4/SlZLLOxt5eYRBUTc97dfjZ4QnfldMeR+qL
 srcFkISE2NIiiTGM6hq0EYehfeNz73Kx0heLcNulCtaf5R1FqXON647RSR0c7eKcxIFAE1UMb
 kv+XomzY9iQ81CT5giQF+L/Zwj+HbP5BWPH6x2Zqkyo1kbFXqkbkmxbizKSjn9jvnISF2zRPZ
 waNXWCsw7pz9XgyCxoH7YZCAMNm5DBgEBZkdXcQLZgUGZZQ8O8pvBjZrEd3hbG3v5naLXD3SP
 BCo3ce2I1PQUpcmCdTWF+rfX834IOuaRkY09AEbW1p8UZJrRfJefhqRT0Ao0OtUyTqCA4Z63c
 OJ35d3ax4GCChjEdbGmEurdBBpPmjDxoMewl9upkicEma5T6dMutMxfLeBWcfWO+L07tIwz/L
 wT5iWjnSho1WT+y174gdRe+iGLFrZ9zt35JETHNH6eRwgtfZx9qK8/QmwXGQQJbqQTa/jI9v/
 6rG38Zn4JF/vywC7eEISebLbrJzaG6tjfGkgEAhubdZ3h47W/VeqkxzhJkBxt4+xSambs2XeW
 zhdkvNuvsrZRNz6QorThUO+rxitmxttNVf5L+Ulivj4LHiGNixR4u3DHsqAf5LpDYEubmeab4
 /BY/Xj3YxqLM8jE5Ly8z3Rh9poroifmNiU5k0dpdz5PaOgrRtUSU+SMuHBs73XNbMgvi2VpnA
 0YNnOMhhxs7kJYbRPUiTWQRpD0LM2yh121QAiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of only two files that initialize a semaphore to a negative
value. We don't really need the two semaphores here at all, but can do
the same thing in more conventional and more effient way, by using a
single waitqueue and an atomic thread counter.

This gets us a little bit closer to eliminating classic semaphores from
the kernel. It also fixes a corner case where we fail to continue after
one of the threads fails to start up.

An alternative would be to use a split kthread_create()+wake_up_process()
and completely eliminate the separate synchronization.

Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Changes from v1:
 - rebase to mainline,
 - fix pr_err() output
 - bail out if interrupted
---
 lib/test_rhashtable.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 82ac39ce5310..6a8ac7626797 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -20,11 +20,11 @@
 #include <linux/module.h>
 #include <linux/rcupdate.h>
 #include <linux/rhashtable.h>
-#include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/random.h>
 #include <linux/vmalloc.h>
+#include <linux/wait.h>
 
 #define MAX_ENTRIES	1000000
 #define TEST_INSERT_FAIL INT_MAX
@@ -112,8 +112,8 @@ static struct rhashtable_params test_rht_params_dup = {
 	.automatic_shrinking = false,
 };
 
-static struct semaphore prestart_sem;
-static struct semaphore startup_sem = __SEMAPHORE_INITIALIZER(startup_sem, 0);
+static atomic_t startup_count;
+static DECLARE_WAIT_QUEUE_HEAD(startup_wait);
 
 static int insert_retry(struct rhashtable *ht, struct test_obj *obj,
                         const struct rhashtable_params params)
@@ -634,9 +634,12 @@ static int threadfunc(void *data)
 	int i, step, err = 0, insert_retries = 0;
 	struct thread_data *tdata = data;
 
-	up(&prestart_sem);
-	if (down_interruptible(&startup_sem))
-		pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);
+	if (atomic_dec_and_test(&startup_count))
+		wake_up(&startup_wait);
+	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == -1)) {
+		pr_err("  thread[%d]: interrupted\n", tdata->id);
+		goto out;
+	}
 
 	for (i = 0; i < tdata->entries; i++) {
 		tdata->objs[i].value.id = i;
@@ -755,7 +758,7 @@ static int __init test_rht_init(void)
 
 	pr_info("Testing concurrent rhashtable access from %d threads\n",
 	        tcount);
-	sema_init(&prestart_sem, 1 - tcount);
+	atomic_set(&startup_count, tcount);
 	tdata = vzalloc(array_size(tcount, sizeof(struct thread_data)));
 	if (!tdata)
 		return -ENOMEM;
@@ -781,15 +784,18 @@ static int __init test_rht_init(void)
 		tdata[i].objs = objs + i * entries;
 		tdata[i].task = kthread_run(threadfunc, &tdata[i],
 		                            "rhashtable_thrad[%d]", i);
-		if (IS_ERR(tdata[i].task))
+		if (IS_ERR(tdata[i].task)) {
 			pr_err(" kthread_run failed for thread %d\n", i);
-		else
+			atomic_dec(&startup_count);
+		} else {
 			started_threads++;
+		}
 	}
-	if (down_interruptible(&prestart_sem))
-		pr_err("  down interruptible failed\n");
-	for (i = 0; i < tcount; i++)
-		up(&startup_sem);
+	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == 0))
+		pr_err("  wait_event interruptible failed\n");
+	/* count is 0 now, set it to -1 and wake up all threads together */
+	atomic_dec(&startup_count);
+	wake_up_all(&startup_wait);
 	for (i = 0; i < tcount; i++) {
 		if (IS_ERR(tdata[i].task))
 			continue;
-- 
2.20.0

