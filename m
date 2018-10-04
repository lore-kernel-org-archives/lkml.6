Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F068FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C638D21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Z3Uy7vFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C638D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJEAWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:22:49 -0400
Received: from smtpbg302.qq.com ([184.105.206.27]:47896 "EHLO smtpbg302.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJEAWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:22:49 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 20:22:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1538674114;
        bh=B9esClcZRhl/UE8f9868tCkTYDoDdN3+34/DgSJS8qM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        b=Z3Uy7vFKkklJFeQEUcmNU5pSDxzS5EENKJa4wA+C+oPUFP0fUv47Zv3tSWePbJmIJ
         zHXjBlRqTfe24DL/A5FbR4vBj3RfEm2qGYPGypeYk188BVD4fyjaRgJmZf8JSSCvfG
         DEa2Dh0G0Vx3QTgBXhpOZH8r1krmyuV/wFCnGd/U=
X-QQ-mid: esmtp5t1538673670tdek395dj
Received: from chenchacha.lan (unknown [111.199.190.105])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 05 Oct 2018 01:21:09 +0800 (CST)
X-QQ-SSF: 01000000000000F0FI100F00000000Q
X-QQ-FEAT: 5nAP71ObQpXV8ZE0/Hyjo0NCBOVOggy6R5HJ4Gzac35czcTQ/iZe6m2Kzibnt
        HqmWwRzNZ/YVCbyptqSmZ7IQa6c8WSlqnpVgQHyQU5zsqMyv8wrs8eA0zWoFqmKILlRnOgE
        l0RfaSaDsFQfoqljOjTqvaIimTidH9MHGc9o1x5TYMtzFY/SDTdFNcX+sTXkCJGPYzm0CQm
        g/ycvY92cCrAAtOwOrKBUeZvBUW4PVDWIouVNj6GqYL2mNxkFRsE6IuzXeUlIEFJouca/wz
        vW2S6y9+2Ugn0KZli/yfeN98s=
X-QQ-GoodBg: 0
From:   chenchacha <chen.chenchacha@foxmail.com>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pali.rohar@gmail.com
Subject: [PATCH 2/2] Add a new function to get root directory with ATTR_VOLUME
Date:   Fri,  5 Oct 2018 01:21:01 +0800
Message-Id: <20181004172101.15525-3-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
References: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
X-QQ-FName: F24B6F0A65A4401694C4E56ED10A6B77
X-QQ-LocalIP: 10.208.130.95
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: chenchacha <chen.chenchacha@foxmail.com>
---
 fs/fat/dir.c | 13 +++++++++++++
 fs/fat/fat.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 7f5f3699fc6c..4fdcc1200f2b 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -881,6 +881,19 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 	return -ENOENT;
 }
 
+int fat_get_root_entry(struct inode *dir, struct buffer_head **bh,
+		       struct msdos_dir_entry **de)
+{
+	loff_t offset = 0;
+
+	*de = NULL;
+	while (fat_get_entry(dir, &offset, bh, de) >= 0) {
+		if (!IS_FREE((*de)->name) && (*de)->attr & ATTR_VOLUME)
+			return 0;
+	}
+	return -ENOENT;
+}
+
 /*
  * The ".." entry can not provide the "struct fat_slot_info" information
  * for inode, nor a usable i_pos. So, this function provides some information
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index be012de96f65..4195cb1e891a 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -302,6 +302,8 @@ extern int fat_scan(struct inode *dir, const unsigned char *name,
 		    struct fat_slot_info *sinfo);
 extern int fat_scan_logstart(struct inode *dir, int i_logstart,
 			     struct fat_slot_info *sinfo);
+extern int fat_get_root_entry(struct inode *dir, struct buffer_head **bh,
+			      struct msdos_dir_entry **de);
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 				struct msdos_dir_entry **de);
 extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
-- 
2.19.0

