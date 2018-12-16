Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F11A206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeLPXPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:15:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50336 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeLPXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:15:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so10644616wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 15:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko311uXmvpvD0UIJMxwURS+bJkiu7TA9/F70P4mhxG4=;
        b=eEbDSeryYsOLvwKYmLcBDwUCPq5ykiFaZMh2ikXrU36AyLwJG9FD+x5T2tivdz3HJg
         3P0FOPz1wYtVOQOVSnXWKECHU6CpICooGlWVr0pvFhX195phGWkMlLoYcGzJNqR3qWaK
         RXHL7gQt5UNaY5kG0ST/pguDSmFJLcD0gJNtHcgATD4vOWvol3dLVmpIz4VnrAw2GzWz
         Wl4IzmDDm+ICbHSifiMj10Eeki29fdGSK/E2Y75scxIyJSniLqnnfdy9HKpgwwq4EGiQ
         xjl9oar8K3I7LVVnvGvXkgYfnfSaNdusXBxpb6ThNevpvlftgspFMW0HXj9HGSIuSVGG
         HxFQ==
X-Gm-Message-State: AA+aEWYIBZtcFfTR4UZJxpEZdDaBWPLslTKr3xR9m3+mHMmeJjGHa9de
        U2Vd/k8u+lI+ebM/oqmc13FNPQ==
X-Google-Smtp-Source: AFSGD/XfeEQ96b7HVW5UJEMq72qfirM3X3v9zEVs563V2VFe6a+9lr8hhAzqoPepBu7kfXK1raHY7Q==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr9572192wmc.103.1545002112421;
        Sun, 16 Dec 2018 15:15:12 -0800 (PST)
Received: from raver.teknoraver.net (net-37-182-2-241.cust.vodafonedsl.it. [37.182.2.241])
        by smtp.gmail.com with ESMTPSA id h12sm25594050wma.48.2018.12.16.15.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:15:11 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Timothy Redaelli <tredaelli@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] vfat: don't read garbage after last dirent
Date:   Mon, 17 Dec 2018 00:15:10 +0100
Message-Id: <20181216231510.26854-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.19.2
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
v2:
* add the check also in lookup and dir empty check
* fix two tipos in the commit message  

 fs/fat/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c8366cb8eccd..955edf5df286 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -588,7 +588,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry(inode, &cpos, &bh, &de) == -1 || !de->name[0])
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -916,7 +916,8 @@ int fat_dir_empty(struct inode *dir)
 
 	bh = NULL;
 	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
+	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0 &&
+	       de->name[0]) {
 		if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
 		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
 			result = -ENOTEMPTY;
@@ -961,7 +962,7 @@ int fat_scan(struct inode *dir, const unsigned char *name,
 	sinfo->slot_off = 0;
 	sinfo->bh = NULL;
 	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
-				   &sinfo->de) >= 0) {
+				   &sinfo->de) >= 0 && sinfo->de->name[0]) {
 		if (!strncmp(sinfo->de->name, name, MSDOS_NAME)) {
 			sinfo->slot_off -= sizeof(*sinfo->de);
 			sinfo->nr_slots = 1;
-- 
2.19.2

