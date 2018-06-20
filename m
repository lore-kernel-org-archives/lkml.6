Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030D8208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030D8208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeFTI1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:27:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51073 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeFTI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:27:44 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MRDAN-1fd4NO1bn5-00UeOe; Wed, 20 Jun 2018 10:13:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Hyunchul Lee <cheol.lee@lge.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: use timespec64 for inode timestamps
Date:   Wed, 20 Jun 2018 10:12:58 +0200
Message-Id: <20180620081311.126158-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:+d/wZIPgnBVV5vfcl8g7Rp8wKUBtcQzct1uGCE6u7aaQce7IfAH
 +Plnf5d4Y53UsbFissltElr8SWP9GocXGRmLZkjfF1d8x8Xgjk69cTyrIBP8eVoIdj7whog
 E61a4wPueMjI8w77E0JuPNi8x3Ai6iqNc87v/fLAWRpC8pLyOzHWXUQ0cE77oh7CNguNKO2
 hLwiK5QJZbSLm7C6irO2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/nY34qRgByw=:L8kjstIl8HKzVWo3HnCJLB
 e0vrlt4O4BGLxbyMaG3sFRyykxaFJzNI1UzqlUJrXbFGOBsGPTrOidowqt5iGhEX4lwS1PELZ
 m+l+rC21ZnvYtj/sRDanAe+OyDWF9OsnzJgY7tBaYG48S+XqOHkOixUM1RBZ8iqlWdd02ktNf
 kHNVk6/EzhtOh/9Md8oP5426n6zAM00cQrrkXmG5A6XOBHqoNjeEqbL/Uov3g022EBldfFvOd
 2Qy7+pZxppxjz2Du72/lRiTBgz1DGWJqNHPH2uh1GvTcyERc0w9HY/pevjVLHSH0dA9EoiCR6
 rHmA2ueHnhTcuzsllG+JDEmz5xGrlYB0JoUuPg57hcy3hN5Bb6V2crFjTCLnYNLaoe7xkTnkY
 urJegq7jkIcFw8cqAJgkIhd+3fYOl4ybkBmv1Uetva7/EFszVGxXV/mungOLqpldrnNfPx9eg
 YiqK61YRofnOfQegwCzKLfHadhhDvk4JCrdb+3GALcKZ21+a9gdx6P+OsSI3Fy121CQtjTfEu
 6jdc97c9H4b2Eb6lbBI3kUbQRKj8/oEN6zq2Y48QHcN9Gxa8026cBApDM0nW+iq/WjIYGUyOY
 pWArZtoLO8hJGP9Y1UbYjznTgWF/RbSs5XbK3HGM46hY5yiZbIFjgE34ltjDwQsgHqj8qLI3X
 bL6cb0S/Vy+avnhT4+0pWV55Z1omnKNsvtAB+FXMazC7lNnr3x45uE5Ri+fm+e0sXLLQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both vfs and the on-disk inode structures can deal with fine-grained
timestamps now, so this is the last missing piece to make ubifs
y2038-safe on 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/file.c | 11 +++++------
 fs/ubifs/sb.c   |  6 +++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index fd7eb6fe9090..02fab5c322c7 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1365,11 +1365,10 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  * granularity, they are not updated. This is an optimization.
  */
 static inline int mctime_update_needed(const struct inode *inode,
-				       const struct timespec *now)
+				       const struct timespec64 *now)
 {
-	struct timespec64 now64 = timespec_to_timespec64(*now);
-	if (!timespec64_equal(&inode->i_mtime, &now64) ||
-	    !timespec64_equal(&inode->i_ctime, &now64))
+	if (!timespec64_equal(&inode->i_mtime, now) ||
+	    !timespec64_equal(&inode->i_ctime, now))
 		return 1;
 	return 0;
 }
@@ -1425,7 +1424,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
  */
 static int update_mctime(struct inode *inode)
 {
-	struct timespec now = timespec64_to_timespec(current_time(inode));
+	struct timespec64 now = current_time(inode);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
@@ -1519,7 +1518,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
-	struct timespec now = timespec64_to_timespec(current_time(inode));
+	struct timespec64 now = current_time(inode);
 	struct ubifs_budget_req req = { .new_page = 1 };
 	int err, update_time;
 
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 8c25081a5109..fa0a982a6797 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -85,7 +85,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 	long long tmp64, main_bytes;
 	__le64 tmp_le64;
 	__le32 tmp_le32;
-	struct timespec ts;
+	struct timespec64 ts;
 
 	/* Some functions called from here depend on the @c->key_len filed */
 	c->key_len = UBIFS_SK_LEN;
@@ -301,8 +301,8 @@ static int create_default_filesystem(struct ubifs_info *c)
 	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
 	ino->nlink = cpu_to_le32(2);
 
-	ktime_get_real_ts(&ts);
-	ts = timespec_trunc(ts, DEFAULT_TIME_GRAN);
+	ktime_get_real_ts64(&ts);
+	ts = timespec64_trunc(ts, DEFAULT_TIME_GRAN);
 	tmp_le64 = cpu_to_le64(ts.tv_sec);
 	ino->atime_sec   = tmp_le64;
 	ino->ctime_sec   = tmp_le64;
-- 
2.9.0

