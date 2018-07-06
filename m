Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C823F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5C823F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934298AbeGFFv1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeGFFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:24 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E03C186A;
        Fri,  6 Jul 2018 05:51:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Shaohua Li <shli@fb.com>,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 37/61] md: use mddev_suspend/resume instead of ->quiesce()
Date:   Fri,  6 Jul 2018 07:47:01 +0200
Message-Id: <20180706054713.761302829@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 9e1cc0a54556a6c63dc0cfb7cd7d60d43337bba6 upstream.

mddev_suspend() is a more general interface than
calling ->quiesce() and is so more extensible.  A
future patch will make use of this.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4870,8 +4870,8 @@ suspend_lo_store(struct mddev *mddev, co
 		mddev->pers->quiesce(mddev, 2);
 	} else {
 		/* Expanding suspended region - need to wait */
-		mddev->pers->quiesce(mddev, 1);
-		mddev->pers->quiesce(mddev, 0);
+		mddev_suspend(mddev);
+		mddev_resume(mddev);
 	}
 	err = 0;
 unlock:
@@ -4914,8 +4914,8 @@ suspend_hi_store(struct mddev *mddev, co
 		mddev->pers->quiesce(mddev, 2);
 	} else {
 		/* Expanding suspended region - need to wait */
-		mddev->pers->quiesce(mddev, 1);
-		mddev->pers->quiesce(mddev, 0);
+		mddev_suspend(mddev);
+		mddev_resume(mddev);
 	}
 	err = 0;
 unlock:
@@ -6666,7 +6666,7 @@ static int set_bitmap_file(struct mddev
 			struct bitmap *bitmap;
 
 			bitmap = bitmap_create(mddev, -1);
-			mddev->pers->quiesce(mddev, 1);
+			mddev_suspend(mddev);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				err = bitmap_load(mddev);
@@ -6676,11 +6676,11 @@ static int set_bitmap_file(struct mddev
 				bitmap_destroy(mddev);
 				fd = -1;
 			}
-			mddev->pers->quiesce(mddev, 0);
+			mddev_resume(mddev);
 		} else if (fd < 0) {
-			mddev->pers->quiesce(mddev, 1);
+			mddev_suspend(mddev);
 			bitmap_destroy(mddev);
-			mddev->pers->quiesce(mddev, 0);
+			mddev_resume(mddev);
 		}
 	}
 	if (fd < 0) {
@@ -6966,7 +6966,7 @@ static int update_array_info(struct mdde
 			mddev->bitmap_info.space =
 				mddev->bitmap_info.default_space;
 			bitmap = bitmap_create(mddev, -1);
-			mddev->pers->quiesce(mddev, 1);
+			mddev_suspend(mddev);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				rv = bitmap_load(mddev);
@@ -6974,7 +6974,7 @@ static int update_array_info(struct mdde
 				rv = PTR_ERR(bitmap);
 			if (rv)
 				bitmap_destroy(mddev);
-			mddev->pers->quiesce(mddev, 0);
+			mddev_resume(mddev);
 		} else {
 			/* remove the bitmap */
 			if (!mddev->bitmap) {
@@ -6997,9 +6997,9 @@ static int update_array_info(struct mdde
 				mddev->bitmap_info.nodes = 0;
 				md_cluster_ops->leave(mddev);
 			}
-			mddev->pers->quiesce(mddev, 1);
+			mddev_suspend(mddev);
 			bitmap_destroy(mddev);
-			mddev->pers->quiesce(mddev, 0);
+			mddev_resume(mddev);
 			mddev->bitmap_info.offset = 0;
 		}
 	}


