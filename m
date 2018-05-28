Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937715AbeE1KpJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163096AbeE1Ko5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <sh.li@alibaba-inc.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 087/496] MD: Free bioset when md_run fails
Date: Mon, 28 May 2018 11:57:52 +0200
Message-Id: <20180528100323.467858579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

[ Upstream commit b126194cbb799f9980b92a77e58db6ad794c8082 ]

Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5479,8 +5479,10 @@ int md_run(struct mddev *mddev)
 	}
 	if (mddev->sync_set == NULL) {
 		mddev->sync_set = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
-		if (!mddev->sync_set)
-			return -ENOMEM;
+		if (!mddev->sync_set) {
+			err = -ENOMEM;
+			goto abort;
+		}
 	}
 
 	spin_lock(&pers_lock);
@@ -5493,7 +5495,8 @@ int md_run(struct mddev *mddev)
 		else
 			pr_warn("md: personality for level %s is not loaded!\n",
 				mddev->clevel);
-		return -EINVAL;
+		err = -EINVAL;
+		goto abort;
 	}
 	spin_unlock(&pers_lock);
 	if (mddev->level != pers->level) {
@@ -5506,7 +5509,8 @@ int md_run(struct mddev *mddev)
 	    pers->start_reshape == NULL) {
 		/* This personality cannot handle reshaping... */
 		module_put(pers->owner);
-		return -EINVAL;
+		err = -EINVAL;
+		goto abort;
 	}
 
 	if (pers->sync_request) {
@@ -5580,7 +5584,7 @@ int md_run(struct mddev *mddev)
 		mddev->private = NULL;
 		module_put(pers->owner);
 		bitmap_destroy(mddev);
-		return err;
+		goto abort;
 	}
 	if (mddev->queue) {
 		bool nonrot = true;
@@ -5642,6 +5646,18 @@ int md_run(struct mddev *mddev)
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	sysfs_notify(&mddev->kobj, NULL, "degraded");
 	return 0;
+
+abort:
+	if (mddev->bio_set) {
+		bioset_free(mddev->bio_set);
+		mddev->bio_set = NULL;
+	}
+	if (mddev->sync_set) {
+		bioset_free(mddev->sync_set);
+		mddev->sync_set = NULL;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
 
