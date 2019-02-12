Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA0C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC662084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTTfFT5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfBLOzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:55:02 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44624 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbfBLOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:55:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id b15so1110341ybn.11;
        Tue, 12 Feb 2019 06:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bipEG85DvMxlE/UsDnKVFPVryYnL+gbbKWtw53ErjY=;
        b=FTTfFT5ohFBOFkA0Dq3y+fMb8A+au9e/mNLR/iALb5KqaDrnTqAsc0rVkhsF83SDUU
         wzR+RlvHeuSUKFMh8IttFwu0qxPHECdhUe8bnNx7H2xhEEGmMxQXLSB8l3S61WV4z1uu
         hxg2RlvAwCpWQZDGnwWqdHFlmjnEFNVAIGpcfN5aQIK4oqH3IUMioL8u7rgLzbkCfjQz
         xNJ5JxlbXcnF/+zrkgbfbAuPnu7Ffwd5/v1tsVLyxPTP/qkhGM8GyNQCKmha0pi9wjdJ
         zlh4OYhS80wm6upUKZAwNLLUROyerZ3Puptcerc7kpp0NYQ+j3PkUyQKxy2rS1nbp/WT
         R99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bipEG85DvMxlE/UsDnKVFPVryYnL+gbbKWtw53ErjY=;
        b=ZSyJTzuvezTaYWVEha4PQfy8HiJEdLGbUXUazWwJPSJQQYMfDhKQLj//xvYqENOJ0z
         netY5guvff/mn+kajYiNNL+Ogmt4/2ZL2ADmb6tTFGECzhADrU274sQmLMZcCJhZ5AO+
         zbdLfnnuqkjOOxz9xNj294v59wjk/4MiY135ANazBaGahmG2rdHxAl9RHVeB0ZRda/7h
         MgNIvSji6fMdmSfYzxCdCCvVRPbR/c+Q86Q50JJX55T00jpBv/PSzZxrO4sO8FXr0Th/
         tE2gGscp2hQW+8Kn5PldtZ7RrOy3plAulbLxc+pAJwnCac+E/TWdjNRe07BA1DMlTK04
         dzfQ==
X-Gm-Message-State: AHQUAublVfYQoUaDDuumSwXJseDJ1yTlJnQ0HAky4IS6hHG3LfwtZaot
        zYgMWogoXPbRuJNgb8tDSk8=
X-Google-Smtp-Source: AHgI3IY+BI2iIKayPDu8LJXV0qdif6ytsoyyntUG8xvUZCCzGiocTUW7GxkhqaY9d3xLckTMUEbHhg==
X-Received: by 2002:a25:a3c1:: with SMTP id e59mr3223403ybi.96.1549983299573;
        Tue, 12 Feb 2019 06:54:59 -0800 (PST)
Received: from localhost.localdomain (c-73-120-18-128.hsd1.tn.comcast.net. [73.120.18.128])
        by smtp.gmail.com with ESMTPSA id v134sm4987967ywv.90.2019.02.12.06.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:54:58 -0800 (PST)
From:   demiobenour@gmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Cc:     "Demi M. Obenour" <demiobenour@gmail.com>
Subject: [PATCH 3/4] Add AT_PATHSTATIC to linkat()
Date:   Tue, 12 Feb 2019 09:54:46 -0500
Message-Id: <20190212145450.2200-3-demiobenour@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212145450.2200-1-demiobenour@gmail.com>
References: <20190212145450.2200-1-demiobenour@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demi M. Obenour" <demiobenour@gmail.com>

This has the same meaning as O_PATHSTATIC does in openat(), and has the
same uses.
---
 fs/namei.c                 | 8 +++++++-
 include/uapi/linux/fcntl.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4c90f265c103..b47f89af00f2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4291,8 +4291,14 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 		how = LOOKUP_EMPTY;
 	}
 
-	if (flags & AT_SYMLINK_FOLLOW)
+	if (flags & AT_SYMLINK_FOLLOW) {
+		if (flags & AT_PATHSTATIC)
+			return -EINVAL;
 		how |= LOOKUP_FOLLOW;
+	}
+
+	if (flags & AT_PATHSTATIC)
+		how |= LOOKUP_NEVER_FOLLOW;
 retry:
 	error = user_path_at(olddfd, oldname, how, &old_path);
 	if (error)
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6448cdd9a350..a2f65635c8fc 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -89,6 +89,7 @@
 #define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
 #define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
+#define AT_PATHSTATIC		0x8000	/* Do not follow symbolic links anywhere. */
 
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.20.1

