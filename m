Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11AAECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699EC20878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699EC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeGMOrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:47:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeGMOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:47:47 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Ma2v9-1fMBFn19kF-00Lq0E; Fri, 13 Jul 2018 16:32:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [RESEND] ubifs: use timespec64 for inode timestamps
Date:   Fri, 13 Jul 2018 16:31:55 +0200
Message-Id: <20180713143212.3142541-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:IElBuJ6W/+T6MXgjqxgeI1yczUE0PNei6BKdQbSmOsenVeY7w9v
 QL6u8qvodIN/lUpzF/BwtklX0alVAahBMPXnKxtkrFZV2gL6+dY1O5PrjoSl5x9PxorSOkr
 9cu9YFwLmZIco3RhQ1nSQ1VostkVpchF2axsIMdMNkR+G+q33UwUYrO/CKkamwSiNdLIHIJ
 Nt9vU8qSWb5o4cjXZbhFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:08QmAq6GkAY=:h0rqs/+NgadKVL3QaWjnfH
 xyxkOSGzOO9UY1dZuj0F21udTmDW0cnI3f8O2sNSrbMXyAaiKNGrMrrc3Tt1g9UEbDVfpl37y
 9kHfspGpZrmalCvkEb9ScVMtxkCmIUmr9L2j1MTXPjOQOLbg/5pVPS/7aC8jHGKyyq8+FhtZj
 lptwVPiYNX51uTPedE98J0S62DMg8iKPJtUZGP1B/qcnAcpPIGs13jcOrulXoc8RvpEynSTVb
 WAyQvffTCMsyp26ltSAZcoYBP/QQbWtNaylMqZfNDcupyrTgN9vFTjKR3wWI06Mbc+uTXeILK
 4EnkjsDJz91BOEQ13NFaE/aEK+1chF0SKSX7GdktpfcGLsk6JwnyGfaPaY5QFbybEEd01yHzU
 hKwUqDUeUJBlAldUPKHNeXgp4u3ASgAZ+Rdnc9KsTUOlK916GigmFymc/Wh9PCpGxg8b5oMNU
 78/eLcoaghuJ+MoJOhgPlRZc5IwQuOSw74Iiyfz8lUZ06YSO05+CEeMP/SWQQpAcwco4TYfPx
 1G0TRffw9YREi9N5CDUu+c9uDwWHvdZowrzemzQ69blI8+J01q1nFiAU1Ww7vPQNULb/sOsrf
 I+tZGX4h4o0/qeGFSUmMtFc/LENijedBa9oPnrQDVw0gU8oq2OWGuvaF3YubjgHGIhDvcgTX2
 krm5o4Cy5yjAWh6TKM8Lmz6pSO/7S8WDgGmOPJHvR4stmJ194pVUlXGWrjQx6XKsWXYc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both vfs and the on-disk inode structures can deal with fine-grained
timestamps now, so this is the last missing piece to make ubifs
y2038-safe on 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent these two patches originally on Jun 20, but forgot to write
back when Richard asked who should apply them.

Please pick up both patches in the ubifs tree for 4.19.
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

