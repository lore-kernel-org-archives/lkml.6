Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D9920855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D9920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeIHB7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeIHB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76959F07;
        Fri,  7 Sep 2018 21:16:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Kali <adityakali@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 081/145] ovl: fix wrong use of impure dir cache in ovl_iterate()
Date:   Fri,  7 Sep 2018 23:09:07 +0200
Message-Id: <20180907210910.937690754@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 67810693077afc1ebf9e1646af300436cb8103c2 upstream.

Only upper dir can be impure, but if we are in the middle of
iterating a lower real dir, dir could be copied up and marked
impure. We only want the impure cache if we started iterating
a real upper dir to begin with.

Aditya Kali reported that the following reproducer hits the
WARN_ON(!cache->refcount) in ovl_get_cache():

 docker run --rm drupal:8.5.4-fpm-alpine \
    sh -c 'cd /var/www/html/vendor/symfony && \
           chown -R www-data:www-data . && ls -l .'

Reported-by: Aditya Kali <adityakali@google.com>
Tested-by: Aditya Kali <adityakali@google.com>
Fixes: 4edb83bb1041 ('ovl: constant d_ino for non-merge dirs')
Cc: <stable@vger.kernel.org> # v4.14
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -668,6 +668,21 @@ static int ovl_fill_real(struct dir_cont
 	return orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
 }
 
+static bool ovl_is_impure_dir(struct file *file)
+{
+	struct ovl_dir_file *od = file->private_data;
+	struct inode *dir = d_inode(file->f_path.dentry);
+
+	/*
+	 * Only upper dir can be impure, but if we are in the middle of
+	 * iterating a lower real dir, dir could be copied up and marked
+	 * impure. We only want the impure cache if we started iterating
+	 * a real upper dir to begin with.
+	 */
+	return od->is_upper && ovl_test_flag(OVL_IMPURE, dir);
+
+}
+
 static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 {
 	int err;
@@ -696,7 +711,7 @@ static int ovl_iterate_real(struct file
 		rdt.parent_ino = stat.ino;
 	}
 
-	if (ovl_test_flag(OVL_IMPURE, d_inode(dir))) {
+	if (ovl_is_impure_dir(file)) {
 		rdt.cache = ovl_cache_get_impure(&file->f_path);
 		if (IS_ERR(rdt.cache))
 			return PTR_ERR(rdt.cache);
@@ -727,7 +742,7 @@ static int ovl_iterate(struct file *file
 		 */
 		if (ovl_xino_bits(dentry->d_sb) ||
 		    (ovl_same_sb(dentry->d_sb) &&
-		     (ovl_test_flag(OVL_IMPURE, d_inode(dentry)) ||
+		     (ovl_is_impure_dir(file) ||
 		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
 			return ovl_iterate_real(file, ctx);
 		}


