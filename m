Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04724ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A19208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A19208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeGMHAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:00:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:34352 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeGMHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:00:24 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 05BDBADF6A;
        Fri, 13 Jul 2018 15:47:11 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6D6l9bP020758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jul 2018 15:47:10 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6D6l9hd025264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jul 2018 15:47:09 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w6D6l8BJ025263;
        Fri, 13 Jul 2018 15:47:08 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, "Wang\, Matt" <Matt.Wang@Dell.com>,
        "dan.carpenter\@oracle.com" <dan.carpenter@oracle.com>
Subject: [PATCH] fat: Fix potential shift wrap with FITRIM ioctl on FAT
References: <C8ECE1B7A767434691FEEFA3A01765D72AF77119@MX203CL03.corp.emc.com>
Date:   Fri, 13 Jul 2018 15:47:08 +0900
In-Reply-To: <C8ECE1B7A767434691FEEFA3A01765D72AF77119@MX203CL03.corp.emc.com>
        (Matt Wang's message of "Fri, 13 Jul 2018 03:37:23 +0000")
Message-ID: <87h8l37hub.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the fix of fat-add-fitrim-ioctl-for-fat-file-system.patch.
Maybe better to merge with it (if it is easy).

Anyway, please apply this with above patch.

--------
From: Wentao Wang <witallwang@gmail.com>

If we keep "trimmed" as an u32, there will be a potential shift wrap.

It would be a problem on a larger than 4GB partition with
FAT32. Though most tools who call this ioctl would ignore this value,
it would be great to fix it.

Signed-off-by: Wentao Wang <witallwang@gmail.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fatent.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/fat/fatent.c~fat-fitrim-fix fs/fat/fatent.c
--- linux/fs/fat/fatent.c~fat-fitrim-fix	2018-07-13 15:39:14.417110998 +0900
+++ linux-hirofumi/fs/fat/fatent.c	2018-07-13 15:39:14.418110996 +0900
@@ -705,8 +705,8 @@ int fat_trim_fs(struct inode *inode, str
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent;
-	u64 ent_start, ent_end, minlen;
-	u32 free = 0, trimmed = 0;
+	u64 ent_start, ent_end, minlen, trimmed = 0;
+	u32 free = 0;
 	unsigned long reada_blocks, reada_mask, cur_block = 0;
 	int err = 0;
 
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
