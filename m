Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A56C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E65B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfBAAOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:14:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45332 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfBAAON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:14:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so5189733wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 16:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyHGW6liGZ+Z953JAZNMwH4i0t6+w+XsNenPzgy1Rj8=;
        b=NujCgVovmtXJMNnB6ZtIuqPbfc9WKqNOWKwSO5VAonnQGj2iLVbQdW97QUOFC5MngR
         A0rEgMex61IoK3MLLIIZvc2FZ2EPJSOmhRjoFxa6kVK28wMIx5CYE/90iENC4FB2XWzY
         wEixSym/QlGuFPPUlOnnWPXtuQCDPrIMTn95WcQD9dlNk+hYa65FhLlZv79AUy/jDqX2
         lq3HjM5j1ryu1r0SFthoLP0DCU3LTI0ydmG6Z3M+wQ2gQPv1cmySeXGuXnL4msVAuC89
         n0IbzZcBOcMMESJU+V7NShDFYTLnLLuZ7SWKhD954KMNPFNHZ3nxm1JcExouQfcWkNWF
         y4Zg==
X-Gm-Message-State: AJcUukejnoL4NfBgTRv2Naot05hAfTaj+t268vC7Zh+m34C5GEynh4vO
        7E3DoB26Vx29dRbWZWBBi9NhXuhVQB4=
X-Google-Smtp-Source: ALg8bN6qx2HcZlLbKyFMtknb50ufnAX2Ce9pXy82ETEzZnxss7Z/B/D21sL64JrsanDlZj2E5boMFg==
X-Received: by 2002:adf:f149:: with SMTP id y9mr38891785wro.284.1548980050454;
        Thu, 31 Jan 2019 16:14:10 -0800 (PST)
Received: from raver.teknoraver.net (net-47-53-225-160.cust.vodafonedsl.it. [47.53.225.160])
        by smtp.gmail.com with ESMTPSA id o16sm10817736wrn.11.2019.01.31.16.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 16:14:09 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Timothy Redaelli <tredaelli@redhat.com>
Subject: [PATCH v3] vfat: don't read garbage after last dirent
Date:   Fri,  1 Feb 2019 01:14:08 +0100
Message-Id: <20190201001408.7453-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FAT32 File System Specification[1] states that:

    If DIR_Name[0] == 0x00, then the directory entry is free, and there
    are no allocated directory entries after this one.

    The special 0 value, indicates to FAT file system driver code that
    the rest of the entries in this directory do not need to be examined
    because they are all free.

This is not enforced by Linux, and is possible to read garbage if not
all dirents after the last one are filled with zeroes.

[1] http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc

Reported-by: Timothy Redaelli <tredaelli@redhat.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 fs/fat/dir.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 9d01db37183f..d919a1ee519c 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -314,7 +314,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 
 		if (ds->id & 0x40)
 			(*unicode)[offset + 13] = 0;
-		if (fat_get_entry(dir, pos, bh, de) < 0)
+		if (fat_get_entry(dir, pos, bh, de) < 0 || !(*de)->name[0])
 			return PARSE_EOF;
 		if (slot == 0)
 			break;
@@ -476,7 +476,8 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 
 	err = -ENOENT;
 	while (1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+		if (fat_get_entry(inode, &cpos, &bh, &de) == -1 ||
+		    !de->name[0])
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
@@ -588,7 +589,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry(inode, &cpos, &bh, &de) == -1 || !de->name[0])
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -898,7 +899,8 @@ int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 	loff_t offset = 0;
 
 	*de = NULL;
-	while (fat_get_short_entry(dir, &offset, bh, de) >= 0) {
+	while (fat_get_short_entry(dir, &offset, bh, de) >= 0 &&
+	       (*de)->name[0]) {
 		if (!strncmp((*de)->name, MSDOS_DOTDOT, MSDOS_NAME))
 			return 0;
 	}
@@ -916,7 +918,8 @@ int fat_dir_empty(struct inode *dir)
 
 	bh = NULL;
 	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
+	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0 &&
+	       de->name[0]) {
 		if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
 		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
 			result = -ENOTEMPTY;
@@ -941,7 +944,8 @@ int fat_subdirs(struct inode *dir)
 
 	bh = NULL;
 	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
+	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0 &&
+	       de->name[0]) {
 		if (de->attr & ATTR_DIR)
 			count++;
 	}
@@ -961,7 +965,7 @@ int fat_scan(struct inode *dir, const unsigned char *name,
 	sinfo->slot_off = 0;
 	sinfo->bh = NULL;
 	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
-				   &sinfo->de) >= 0) {
+				   &sinfo->de) >= 0 && sinfo->de->name[0]) {
 		if (!strncmp(sinfo->de->name, name, MSDOS_NAME)) {
 			sinfo->slot_off -= sizeof(*sinfo->de);
 			sinfo->nr_slots = 1;
@@ -985,7 +989,7 @@ int fat_scan_logstart(struct inode *dir, int i_logstart,
 	sinfo->slot_off = 0;
 	sinfo->bh = NULL;
 	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
-				   &sinfo->de) >= 0) {
+				   &sinfo->de) >= 0 && sinfo->de->name[0]) {
 		if (fat_get_start(MSDOS_SB(sb), sinfo->de) == i_logstart) {
 			sinfo->slot_off -= sizeof(*sinfo->de);
 			sinfo->nr_slots = 1;
-- 
2.20.1

