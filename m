Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2509AC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E913C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfA2P5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:57:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbfA2P5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:57:54 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC115CA49DF7F31FE8B0;
        Tue, 29 Jan 2019 23:57:47 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.201)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 29 Jan 2019 23:57:40
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH] staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()
Date:   Tue, 29 Jan 2019 23:55:40 +0800
Message-ID: <20190129155540.17473-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Al pointed out, "
... and while we are at it, what happens to
	unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
	unsigned int matched = min(startprfx, endprfx);

	struct qstr dname = QSTR_INIT(data + nameoff,
		unlikely(mid >= ndirents - 1) ?
			maxsize - nameoff :
			le16_to_cpu(de[mid + 1].nameoff) - nameoff);

	/* string comparison without already matched prefix */
	int ret = dirnamecmp(name, &dname, &matched);
if le16_to_cpu(de[...].nameoff) is not monotonically increasing?  I.e.
what's to prevent e.g. (unsigned)-1 ending up in dname.len?

Corrupted fs image shouldn't oops the kernel.. "

Revisit the related lookup flow to address the issue.

Fixes: d72d1ce60174 ("staging: erofs: add namei functions")
Cc: <stable@vger.kernel.org> # 4.19+
Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
TODO:
 - fix similar issue in readdir of dir.c with another patch.

 drivers/staging/erofs/namei.c | 167 ++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index 5596c52e246d..a1300c420e63 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -15,74 +15,76 @@
 
 #include <trace/events/erofs.h>
 
-/* based on the value of qn->len is accurate */
-static inline int dirnamecmp(struct qstr *qn,
-	struct qstr *qd, unsigned int *matched)
+struct erofs_qstr {
+	const unsigned char *name;
+	const unsigned char *end;
+};
+
+/* based on the end of qn is accurate and it must have the trailing '\0' */
+static inline int dirnamecmp(const struct erofs_qstr *qn,
+			     const struct erofs_qstr *qd,
+			     unsigned int *matched)
 {
-	unsigned int i = *matched, len = min(qn->len, qd->len);
-loop:
-	if (unlikely(i >= len)) {
-		*matched = i;
-		if (qn->len < qd->len) {
-			/*
-			 * actually (qn->len == qd->len)
-			 * when qd->name[i] == '\0'
-			 */
-			return qd->name[i] == '\0' ? 0 : -1;
+	unsigned int i = *matched;
+
+	/*
+	 * on-disk error, let's only BUG_ON in the debugging mode.
+	 * otherwise, it will return 1 to just skip the invalid name
+	 * and go on (in consideration of the lookup performance).
+	 */
+	DBG_BUGON(qd->name > qd->end);
+
+	/* qd could not have trailing '\0' */
+	/* However it is absolutely safe if < qd->end */
+	while (qd->name + i < qd->end && qd->name[i] != '\0') {
+		if (qn->name[i] != qd->name[i]) {
+			*matched = i;
+			return qn->name[i] > qd->name[i] ? 1 : -1;
 		}
-		return (qn->len > qd->len);
+		++i;
 	}
-
-	if (qn->name[i] != qd->name[i]) {
-		*matched = i;
-		return qn->name[i] > qd->name[i] ? 1 : -1;
-	}
-
-	++i;
-	goto loop;
+	*matched = i;
+	/* See comments in __d_alloc on the terminating NUL character */
+	return qn->name[i] == '\0' ? 0 : 1;
 }
 
-static struct erofs_dirent *find_target_dirent(
-	struct qstr *name,
-	u8 *data, int maxsize)
+#define nameoff_from_disk(off, sz)	(le16_to_cpu(off) & ((sz) - 1))
+
+static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
+					       u8 *data,
+					       unsigned int dirblksize,
+					       const int ndirents)
 {
-	unsigned int ndirents, head, back;
+	int head, back;
 	unsigned int startprfx, endprfx;
 	struct erofs_dirent *const de = (struct erofs_dirent *)data;
 
-	/* make sure that maxsize is valid */
-	BUG_ON(maxsize < sizeof(struct erofs_dirent));
-
-	ndirents = le16_to_cpu(de->nameoff) / sizeof(*de);
-
-	/* corrupted dir (may be unnecessary...) */
-	BUG_ON(!ndirents);
-
 	head = 0;
 	back = ndirents - 1;
 	startprfx = endprfx = 0;
 
 	while (head <= back) {
-		unsigned int mid = head + (back - head) / 2;
-		unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
+		const int mid = head + (back - head) / 2;
+		const int nameoff = nameoff_from_disk(de[mid].nameoff,
+						      dirblksize);
 		unsigned int matched = min(startprfx, endprfx);
-
-		struct qstr dname = QSTR_INIT(data + nameoff,
-			unlikely(mid >= ndirents - 1) ?
-				maxsize - nameoff :
-				le16_to_cpu(de[mid + 1].nameoff) - nameoff);
+		struct erofs_qstr dname = {
+			.name = data + nameoff,
+			.end = unlikely(mid >= ndirents - 1) ?
+				data + dirblksize :
+				data + nameoff_from_disk(de[mid + 1].nameoff,
+							 dirblksize)
+		};
 
 		/* string comparison without already matched prefix */
 		int ret = dirnamecmp(name, &dname, &matched);
 
-		if (unlikely(!ret))
+		if (unlikely(!ret)) {
 			return de + mid;
-		else if (ret > 0) {
+		} else if (ret > 0) {
 			head = mid + 1;
 			startprfx = matched;
-		} else if (unlikely(mid < 1))	/* fix "mid" overflow */
-			break;
-		else {
+		} else {
 			back = mid - 1;
 			endprfx = matched;
 		}
@@ -91,12 +93,13 @@ static struct erofs_dirent *find_target_dirent(
 	return ERR_PTR(-ENOENT);
 }
 
-static struct page *find_target_block_classic(
-	struct inode *dir,
-	struct qstr *name, int *_diff)
+static struct page *find_target_block_classic(struct inode *dir,
+					      struct erofs_qstr *name,
+					      int *_diff,
+					      int *_ndirents)
 {
 	unsigned int startprfx, endprfx;
-	unsigned int head, back;
+	int head, back;
 	struct address_space *const mapping = dir->i_mapping;
 	struct page *candidate = ERR_PTR(-ENOENT);
 
@@ -105,33 +108,34 @@ static struct page *find_target_block_classic(
 	back = inode_datablocks(dir) - 1;
 
 	while (head <= back) {
-		unsigned int mid = head + (back - head) / 2;
+		const int mid = head + (back - head) / 2;
 		struct page *page = read_mapping_page(mapping, mid, NULL);
 
-		if (IS_ERR(page)) {
-exact_out:
-			if (!IS_ERR(candidate)) /* valid candidate */
-				put_page(candidate);
-			return page;
-		} else {
-			int diff;
-			unsigned int ndirents, matched;
-			struct qstr dname;
+		if (!IS_ERR(page)) {
 			struct erofs_dirent *de = kmap_atomic(page);
-			unsigned int nameoff = le16_to_cpu(de->nameoff);
-
-			ndirents = nameoff / sizeof(*de);
+			const int nameoff = nameoff_from_disk(de->nameoff,
+							      EROFS_BLKSIZ);
+			const int ndirents = nameoff / sizeof(*de);
+			int diff;
+			unsigned int matched;
+			struct erofs_qstr dname;
 
-			/* corrupted dir (should have one entry at least) */
-			BUG_ON(!ndirents || nameoff > PAGE_SIZE);
+			if (unlikely(!ndirents)) {
+				DBG_BUGON(1);
+				put_page(page);
+				page = ERR_PTR(-EIO);
+				goto out;
+			}
 
 			matched = min(startprfx, endprfx);
 
 			dname.name = (u8 *)de + nameoff;
-			dname.len = ndirents == 1 ?
-				/* since the rest of the last page is 0 */
-				EROFS_BLKSIZ - nameoff
-				: le16_to_cpu(de[1].nameoff) - nameoff;
+			if (ndirents == 1)
+				dname.end = (u8 *)de + EROFS_BLKSIZ;
+			else
+				dname.end = (u8 *)de +
+					nameoff_from_disk(de[1].nameoff,
+							  EROFS_BLKSIZ);
 
 			/* string comparison without already matched prefix */
 			diff = dirnamecmp(name, &dname, &matched);
@@ -139,7 +143,7 @@ static struct page *find_target_block_classic(
 
 			if (unlikely(!diff)) {
 				*_diff = 0;
-				goto exact_out;
+				goto out;
 			} else if (diff > 0) {
 				head = mid + 1;
 				startprfx = matched;
@@ -147,35 +151,42 @@ static struct page *find_target_block_classic(
 				if (likely(!IS_ERR(candidate)))
 					put_page(candidate);
 				candidate = page;
+				*_ndirents = ndirents;
 			} else {
 				put_page(page);
 
-				if (unlikely(mid < 1))	/* fix "mid" overflow */
-					break;
-
 				back = mid - 1;
 				endprfx = matched;
 			}
+			continue;
 		}
+out:		/* free if the candidate is valid */
+		if (!IS_ERR(candidate))
+			put_page(candidate);
+		return page;
 	}
 	*_diff = 1;
 	return candidate;
 }
 
 int erofs_namei(struct inode *dir,
-	struct qstr *name,
-	erofs_nid_t *nid, unsigned int *d_type)
+		struct qstr *name,
+		erofs_nid_t *nid, unsigned int *d_type)
 {
-	int diff;
+	int diff, ndirents;
 	struct page *page;
 	u8 *data;
 	struct erofs_dirent *de;
+	struct erofs_qstr qn;
 
 	if (unlikely(!dir->i_size))
 		return -ENOENT;
 
+	qn.name = name->name;
+	qn.end = name->name + name->len;
+
 	diff = 1;
-	page = find_target_block_classic(dir, name, &diff);
+	page = find_target_block_classic(dir, &qn, &diff, &ndirents);
 
 	if (unlikely(IS_ERR(page)))
 		return PTR_ERR(page);
@@ -184,7 +195,7 @@ int erofs_namei(struct inode *dir,
 	/* the target page has been mapped */
 	de = likely(diff) ?
 		/* since the rest of the last page is 0 */
-		find_target_dirent(name, data, EROFS_BLKSIZ) :
+		find_target_dirent(&qn, data, EROFS_BLKSIZ, ndirents) :
 		(struct erofs_dirent *)data;
 
 	if (likely(!IS_ERR(de))) {
-- 
2.14.4

