Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7306D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7306D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbeI1WHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbeI1WHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so6880001wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6kSjpHgzA6z91vgrja6vThHugEbFBwVE8go3dvJ9CMo=;
        b=LDpXiZztmOLqgfOKR3xQ2Fu7cPtloeELsh/zf4lcNS0OKZC+sPFm123YmqD5bmExIi
         n5X94+f9v7bA2aIH+u3ScKZblPnVNXTfWaqhpXElln0aqMdHoD5PR9rw887PAoOFo3ou
         7MXw9+TlYTwMGzDZnxzplGj7gfdGTMYKg+HVvPrJZNq4Z+p2J8JVa3UKIGL5sQXSl9p/
         fde1f7V0+TLyWHSwttSfkkaNxUoC7Ciw+lniLvKE+7JnXqjKT8e4W+wL8sjZF7IVg7N0
         Gn8h0zU1qA49WuZfw+4c+6LTmtzbfeNLJ6T75EJ0zNipKOyCgHq0HNXHSrdDs4YQTW1P
         Y9SA==
X-Gm-Message-State: ABuFfogCXPDhTfzExr0wVp9C5Qd8WqC7sDDmRnFjunI2dZzobXUadDSG
        lFbwFqjoyPo/h5HlAcxXs/tuES3GEA8=
X-Google-Smtp-Source: ACcGV62zcmzrb/L2JPTd4xySn71M1T4AFK6sv3jGr8QWT4H1goIFKnem59UWHBItHF7z+TqY9Xhr2w==
X-Received: by 2002:adf:e2c5:: with SMTP id d5-v6mr12855022wrj.139.1538149362815;
        Fri, 28 Sep 2018 08:42:42 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:41 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] fuse: add FOPEN_CACHE_DIR
Date:   Fri, 28 Sep 2018 17:42:27 +0200
Message-Id: <20180928154234.19270-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flag returned by OPENDIR request to allow kernel to cache directory
contents in page cache.  The effect of FOPEN_CACHE_DIR is twofold:

 a) if not already cached, it writes entries into the cache

 b) if already cached, it allows reading entries from the cache

The FOPEN_KEEP_CACHE has the same effect as on regular files: unless this
flag is given the cache is cleared upon completion of open.

So FOPEN_KEEP_CACHE and FOPEN_KEEP_CACHE flags should be used together to
make use of the directory caching facility introduced in the following
patches.

The FUSE_AUTO_INVAL_DATA flag returned in INIT reply also has the same
affect on the directory cache as it has on data cache for regular files.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/uapi/linux/fuse.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 92fa24c24c92..e30e3a6868cd 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -116,6 +116,9 @@
  *
  *  7.27
  *  - add FUSE_ABORT_ERROR
+ *
+ *  7.28
+ *  - add FOPEN_CACHE_DIR
  */
 
 #ifndef _LINUX_FUSE_H
@@ -151,7 +154,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 27
+#define FUSE_KERNEL_MINOR_VERSION 28
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -219,10 +222,12 @@ struct fuse_file_lock {
  * FOPEN_DIRECT_IO: bypass page cache for this open file
  * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
  * FOPEN_NONSEEKABLE: the file is not seekable
+ * FOPEN_CACHE_DIR: allow caching this directory
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
 #define FOPEN_NONSEEKABLE	(1 << 2)
+#define FOPEN_CACHE_DIR		(1 << 3)
 
 /**
  * INIT request/reply flags
-- 
2.14.3

