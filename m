Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6439C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6B9218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFCiLUVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfAYHfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:35:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44452 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:35:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so4331096pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YI9Veq3ms10uJW7naXHqB+q3hvo6IiJdtihTlWyl+v0=;
        b=RFCiLUVCVCui01cmeylL0bc9Xxe12QraO88mjQYExdJrVxGElhOJptk0dqyO+hz8yx
         tJ6+SXfygpiG7MbKf9cE/KemaVkD4g2A59B714a/z1fnVMA6sifVtT3gQBQZaO1u7cJx
         8Uy+yS99f65M8aXm5Aj43BdO1rALZyhU3QzaOUxhyey3nEZ6EHTsy113hZxaqTeQ4BbG
         SJRvwXp44j9pJ8KOxgSW9KWPFpZWDSrbvqp60S75i/Gm88FfV8WHJ0UuO4ll+sG5wL8D
         SQV6rhoE5t35zSPEldYOmUzikPySi3j/3RaOdw/t1wy2VcLHBo3zsNvp9iiIAWHbDRnT
         KB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YI9Veq3ms10uJW7naXHqB+q3hvo6IiJdtihTlWyl+v0=;
        b=Lg93JYcW8U8NGLYDTN2YotMzHwnDH/wPj6/KL1gXtYfNEyxCo7FcMGVVs+k6j0+DXi
         GTUstG6nHTKI319F6RvFp5FE6qVFh/rzTVrdaRaiOmY0mzz+iqJ81TlUI7bZ1qmfHoAU
         9Prn0oFajSC0jyF0oM7yzj+Bw4sL5qQz8e8dgb/7ksrg7jZ6pPRAclkKE8nSUO23HXlE
         7taUTyM7Phrvlf3u6XxcnL75s1xNmRNT9EyfT5AlkCy+uwxw3VUhttcOEnmOgzQF9ELV
         9XuisnTuj8bHp5IIU4Fq9fnrndZYN0ZPaQmI63Gd/zo7IYs29koHxh7Eet8lq4lsQb0n
         riWQ==
X-Gm-Message-State: AJcUukfBUhFEp2ecN9Tp54Myly14k8UeRkZZf6nDjDaeCQbeTikOw4L9
        31Is+33k2LpKIDOXB6c3Uok=
X-Google-Smtp-Source: ALg8bN5cwso/1EwdUfOy/HwGG60U9ks9SouhVevBUhxUP5ddCLuabXNYcwoAhZhFGwbfPvUnR+t5JA==
X-Received: by 2002:a63:3703:: with SMTP id e3mr8848216pga.348.1548401717261;
        Thu, 24 Jan 2019 23:35:17 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id i193sm79592299pgc.22.2019.01.24.23.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:35:16 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix typos in code comments
Date:   Fri, 25 Jan 2019 15:35:01 +0800
Message-Id: <19c7195d323e7c6a4b03c1e584d070e60458b71f.1548401310.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lengh -> length

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/linux/f2fs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..624b8a47d3c6 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -186,7 +186,7 @@ struct f2fs_orphan_block {
 struct f2fs_extent {
 	__le32 fofs;		/* start file offset of the extent */
 	__le32 blk;		/* start block address of the extent */
-	__le32 len;		/* lengh of the extent */
+	__le32 len;		/* length of the extent */
 } __packed;
 
 #define F2FS_NAME_LEN		255
@@ -511,7 +511,7 @@ typedef __le32	f2fs_hash_t;
 struct f2fs_dir_entry {
 	__le32 hash_code;	/* hash code of file name */
 	__le32 ino;		/* inode number */
-	__le16 name_len;	/* lengh of file name */
+	__le16 name_len;	/* length of file name */
 	__u8 file_type;		/* file type */
 } __packed;
 
-- 
2.17.1

