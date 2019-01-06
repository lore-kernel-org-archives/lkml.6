Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488CAC43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634B2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Lv9hhLuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfAFOF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 09:05:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38063 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfAFOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 09:05:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so35617943ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cA7JiG3+pMY6OMMY9M4WHcSqTf/4ux50ayP3LWynvjA=;
        b=Lv9hhLukdzqdvg60DkmUh7HyBAeJk08KwZ+d5hs4YooPvggiKNWI9TYZNqSyU+3xGh
         n2XDrYKrUV5fybwm1aVbbFKpUW/OemcuRc5PEqX7YsDiWFLWZWN/Ne/TlgKiMRtpeCBB
         aUXAbwb1LJ+CShQc2MQt/E70xoSgKvVCsvuy1VpRqRCvlHfG8wMKGQx/jkCJr91Uj1V1
         p9Wg7fOvaeWVbVLyNPc2UkaOwbrbk4N35x68TsKtKe+NUW+xNLkKjqWOSLO4tfVM8HJq
         kXhELzKl36Z3QFMFOp52uH374pw9M1WMfQ8tSzpphiCG5R5YtEWM423TAInxgddM/bIs
         GsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA7JiG3+pMY6OMMY9M4WHcSqTf/4ux50ayP3LWynvjA=;
        b=r45ih9lOZFeTwkpkRu8Phqwf1balFSCCDWXufmxHRBblC5iwAl3PwePqh3VPDvhTC2
         v9MIe7TqYxUosfZBoxM8fSTJ2Rlz9oAvyfrDM+c00TE3RBL7KycjkPD2M32dysYaPgJW
         vTKLTaYLLpQQlvcKTt5TGrNUhwIDzHz8uafW+Zkn2QzjdQiW5RY8fU/mURNmOh+hztuF
         6h5luRBmJKPpVBYOVDR47CXwOoBa/Zn96lV+ci2zb5PjsXzgsrjI7slPhEIgygW4/7hB
         yXIL20UAyh2eG0p5Vz+D+2kxjaiH0hDKJM2oUc64foaZTWxonyhSvrXXRxERku1iDSXp
         98yg==
X-Gm-Message-State: AA+aEWbvKqRsDGQIse9x3YZDLGmq3J6yelAtIlKk9EM8174S//En7pCi
        tYyhWxzqvJWb3A80ba3S3y+joQ==
X-Google-Smtp-Source: AFSGD/WVTkB8GfCoDudj9jyVer15FMbFixiNu8Xy9hgVfGcWb0Eqg7QtplB9vAkyAlhMNux82xnS0w==
X-Received: by 2002:a50:b487:: with SMTP id w7mr53739690edd.72.1546783556012;
        Sun, 06 Jan 2019 06:05:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id m13sm26984984edd.2.2019.01.06.06.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 06:05:55 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] binderfs: remove wrong kern_mount() call
Date:   Sun,  6 Jan 2019 15:05:40 +0100
Message-Id: <20190106140541.16442-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106140541.16442-1-christian@brauner.io>
References: <20190106140541.16442-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binderfs filesystem never needs to be mounted by the kernel itself.
This is conceptually wrong and should never have been done in the first
place.

Fixes: 3ad20fe393b ("binder: implement binderfs")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binderfs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7496b10532aa..6f68d6217eb3 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -40,8 +40,6 @@
 #define INTSTRLEN 21
 #define BINDERFS_MAX_MINOR (1U << MINORBITS)
 
-static struct vfsmount *binderfs_mnt;
-
 static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
 static DEFINE_IDA(binderfs_minors);
@@ -530,14 +528,6 @@ static int __init init_binderfs(void)
 		return ret;
 	}
 
-	binderfs_mnt = kern_mount(&binder_fs_type);
-	if (IS_ERR(binderfs_mnt)) {
-		ret = PTR_ERR(binderfs_mnt);
-		binderfs_mnt = NULL;
-		unregister_filesystem(&binder_fs_type);
-		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);
-	}
-
 	return ret;
 }
 
-- 
2.19.1

