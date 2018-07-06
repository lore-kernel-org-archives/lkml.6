Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F73BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9ED208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9ED208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeGFFvU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeGFFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:18 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE2D486A;
        Fri,  6 Jul 2018 05:51:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Shaohua Li <shli@fb.com>,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 35/61] md: dont call bitmap_create() while array is quiesced.
Date:   Fri,  6 Jul 2018 07:46:59 +0200
Message-Id: <20180706054713.679536995@linuxfoundation.org>
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

commit 52a0d49de3d592a3118e13f35985e3d99eaf43df upstream.

bitmap_create() allocates memory with GFP_KERNEL and
so can wait for IO.
If called while the array is quiesced, it could wait indefinitely
for write out to the array - deadlock.
So call bitmap_create() before quiescing the array.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6645,22 +6645,26 @@ static int set_bitmap_file(struct mddev
 		return -ENOENT; /* cannot remove what isn't there */
 	err = 0;
 	if (mddev->pers) {
-		mddev->pers->quiesce(mddev, 1);
 		if (fd >= 0) {
 			struct bitmap *bitmap;
 
 			bitmap = bitmap_create(mddev, -1);
+			mddev->pers->quiesce(mddev, 1);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				err = bitmap_load(mddev);
 			} else
 				err = PTR_ERR(bitmap);
-		}
-		if (fd < 0 || err) {
+			if (err) {
+				bitmap_destroy(mddev);
+				fd = -1;
+			}
+			mddev->pers->quiesce(mddev, 0);
+		} else if (fd < 0) {
+			mddev->pers->quiesce(mddev, 1);
 			bitmap_destroy(mddev);
-			fd = -1; /* make sure to put the file */
+			mddev->pers->quiesce(mddev, 0);
 		}
-		mddev->pers->quiesce(mddev, 0);
 	}
 	if (fd < 0) {
 		struct file *f = mddev->bitmap_info.file;
@@ -6944,8 +6948,8 @@ static int update_array_info(struct mdde
 				mddev->bitmap_info.default_offset;
 			mddev->bitmap_info.space =
 				mddev->bitmap_info.default_space;
-			mddev->pers->quiesce(mddev, 1);
 			bitmap = bitmap_create(mddev, -1);
+			mddev->pers->quiesce(mddev, 1);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				rv = bitmap_load(mddev);


