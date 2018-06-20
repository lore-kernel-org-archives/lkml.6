Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD64C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C01F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C01F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeFTIht (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:37:49 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeFTIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:46 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LuFsJ-1gEc482WUp-011fZ9; Wed, 20 Jun 2018 10:11:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: convert last timespec use to timespec64
Date:   Wed, 20 Jun 2018 10:11:46 +0200
Message-Id: <20180620081158.83283-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:gVWRUHLYqRlFx41uDorRnyHIMpUa9P+ru5dJ82jgQM+niYPxT/B
 rals0Ef9xHe79rKdeeRL4v0PRPCFq0zZj2mgtnohLqQVtHZKg1oX+Nq+B74LAYzp2JZbj9P
 PCodzLbVUPZaKtEOtgkhDQqy5gH7ByUcUMyvlRuO1UXaIbFZS5A4k0zbki3UQ2b+rs3oE6J
 ab+qboHWA2fmsn5jBlY4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZFbgleFKVFo=:QMzu8/zYpwmWVVWdor10nA
 u+NOuergvIu6j6w7fkVrfW9/vQPXx5zIydaxZHiCVaqVUK/LTmSxZ0QBUxm53ouFpPm39lUKI
 XJH6HldrN8KSGUUX15dzLs4hIl6l3hBKEhQe6k/JjXdlIpXw3TGI7teQ+I4kADb3h95WoYwxp
 GY9a+0su6JwvgiZAguRZ/zKHKFC1uB4j6jLI/1fAAkDzHNAckottiSzRsh1zrAWc5WgOMTG5Q
 2EwYxJjN6SfBooMGZqFdrLOcrhK/9w1aV6CDLAwoT5inH2opi5YJ7gjW0nHJczxdglqApjN6O
 CId1PaW0RSfa88Or2qCDMhe4mGjNUbawQM2LhQPCbYCa506gfgN/4wxYrzOUkaFggklWQ3NSC
 5yHEad7rO++JAPHJDAifTji1ZSsyA3dS2gsvYU0idn8ja10jBFiR7spWSyh9ebYATGzPpO+9M
 CrSxk47S8hnVFppwDYRjCaqIel5btY0hb073iSIvGCFTflo2BV8Sa1veLTf7O9Q1k3/Zgeub5
 L7RpbzMpEmUo/hKpljnwQfyjCm1Mpgh6RLahDAiugWILyea0mOlCttoOr7PKCBB0jCNF3TkzP
 /jGalzU1aF164jOb9CnInnh0RTg1PM/HbR7IeQ7N99gyym6fTrmEHUdHgUWY0gOUAtQYS9CAT
 8Gt65s35VwZ5wmk0H4jrN0Gy3vK+tJ/IZeDa8aX/41hLgwp4Yp1p2MzCTS0sM4Ojgy/8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of fuse uses 64-bit timestamps with the exception of the
fuse_change_attributes(), so let's convert this one as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fuse/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index a24df8861b40..3c71eb062ef2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -208,7 +208,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool is_wb = fc->writeback_cache;
 	loff_t oldsize;
-	struct timespec old_mtime;
+	struct timespec64 old_mtime;
 
 	spin_lock(&fc->lock);
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
@@ -217,7 +217,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		return;
 	}
 
-	old_mtime = timespec64_to_timespec(inode->i_mtime);
+	old_mtime = inode->i_mtime;
 	fuse_change_attributes_common(inode, attr, attr_valid);
 
 	oldsize = inode->i_size;
@@ -237,7 +237,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			truncate_pagecache(inode, attr->size);
 			inval = true;
 		} else if (fc->auto_inval_data) {
-			struct timespec new_mtime = {
+			struct timespec64 new_mtime = {
 				.tv_sec = attr->mtime,
 				.tv_nsec = attr->mtimensec,
 			};
@@ -246,7 +246,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			 * Auto inval mode also checks and invalidates if mtime
 			 * has changed.
 			 */
-			if (!timespec_equal(&old_mtime, &new_mtime))
+			if (!timespec64_equal(&old_mtime, &new_mtime))
 				inval = true;
 		}
 
-- 
2.9.0

