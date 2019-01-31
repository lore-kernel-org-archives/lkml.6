Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEACC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB52920833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Q98bUTHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfAaAZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:25:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33931 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfAaAZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:25:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so1210008ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrpDYX/PRqS0L2g8V2tZdMYib91aazMaxACMXUeBxZ8=;
        b=Q98bUTHT0Vbxa4uMbGMe0q1jTxpE67/CUZXIC50pPD2y2Y+3PsnVX+pSHXy/UqyFzr
         R2mv4KIz0R9TuTZQkGjjRUI4AzePsLNBLeeIDOVVpWwrC5x5cqz8TAkmuaDZvd9DiHcb
         sYvy3xvvZ/v3/Uv7OzHatdT2xs5oDWYcvaBfjcwvhgKvANlDOgYepYDWeIjV0+cmKW0t
         kXO8DYFIF2PqDj31F46FiY8pGIDph1ngWCxxx0X5DH/6UbKoCBMCi/Kh6SfXwdXq5d6e
         rWkwtNaUcVYGlNtC0CCb9PKbeQpkbeAMa0wQ2pKow5tIYl4yZKmfxd2hkgVJt+f3Nx53
         Hq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrpDYX/PRqS0L2g8V2tZdMYib91aazMaxACMXUeBxZ8=;
        b=gpsZv7Oyrg+cP6zoDTFWziTf4NUe99ln3eoyCqTRBy8j9N10eDmgwnDH+aX+FMpvon
         SOEKzHuA1g7q5q3AUchwROWdAKOriawrqdFcufzfajg4yHncR8oZTpr7as0WRuFQg/cD
         5Z5Y9+hZgznAbZqVjSi2thv60MZhRz387RTjHUWQYisWO9/CrfOuPyQH0Q9e93qRifIJ
         acO6BEnxGGZSerVQmIoaI9PUF6IcB/VbU0xl/Tv4c9e+ghMwQfKEvt67FSDIbuRUQTtJ
         MdKeNK48i0o3zRQbDZkPX5RVWVxB/b4TiyUwrmTTZkXI9ntbZo4mGjAcJ+qC+/82rMU5
         CeHQ==
X-Gm-Message-State: AJcUukd1F6vulT8SwFTTFacHjxgFWULs1XDaikuCVZKB0KZJOo2uJysV
        l3cOeqXlfV/RVYoddMukrgEsRA==
X-Google-Smtp-Source: ALg8bN4rbjU5a/b0T9JAd4Tq5w9UmN7AYcAtc6Xa7BsWtRiP1/8ZPHQeW8lUlBiP8tNvjybhRl85rQ==
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr31684093edh.46.1548894304783;
        Wed, 30 Jan 2019 16:25:04 -0800 (PST)
Received: from localhost.localdomain (84-199-88-155.iFiber.telenet-ops.be. [84.199.88.155])
        by smtp.gmail.com with ESMTPSA id j31sm879432eda.46.2019.01.30.16.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:25:04 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1] binderfs: remove separate device_initcall()
Date:   Thu, 31 Jan 2019 01:25:02 +0100
Message-Id: <20190131002502.14525-1-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binderfs should not have a separate device_initcall(). When a kernel is
compiled with CONFIG_ANDROID_BINDERFS register the filesystem alongside
CONFIG_ANDROID_IPC. This use-case is especially sensible when users specify
CONFIG_ANDROID_IPC=y, CONFIG_ANDROID_BINDERFS=y and
ANDROID_BINDER_DEVICES="".
When CONFIG_ANDROID_BINDERFS=n then this always succeeds so there's no
regression potential for legacy workloads.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
/* Changelog */
- ensure that device_name is set to NULL so kfree() doesn't freak out
---
 drivers/android/binder.c          | 7 ++++++-
 drivers/android/binder_internal.h | 9 +++++++++
 drivers/android/binderfs.c        | 4 +---
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 57cf259de600..4d2b2ad1ee0e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5854,9 +5854,10 @@ static int __init init_binder_device(const char *name)
 static int __init binder_init(void)
 {
 	int ret;
-	char *device_name, *device_names, *device_tmp;
+	char *device_name, *device_tmp;
 	struct binder_device *device;
 	struct hlist_node *tmp;
+	char *device_names = NULL;
 
 	ret = binder_alloc_shrinker_init();
 	if (ret)
@@ -5917,6 +5918,10 @@ static int __init binder_init(void)
 		}
 	}
 
+	ret = init_binderfs();
+	if (ret)
+		goto err_init_binder_device_failed;
+
 	return ret;
 
 err_init_binder_device_failed:
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 7fb97f503ef2..045b3e42d98b 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -46,4 +46,13 @@ static inline bool is_binderfs_device(const struct inode *inode)
 }
 #endif
 
+#ifdef CONFIG_ANDROID_BINDERFS
+extern int __init init_binderfs(void);
+#else
+static inline int __init init_binderfs(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7a550104a722..e773f45d19d9 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -550,7 +550,7 @@ static struct file_system_type binder_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
-static int __init init_binderfs(void)
+int __init init_binderfs(void)
 {
 	int ret;
 
@@ -568,5 +568,3 @@ static int __init init_binderfs(void)
 
 	return ret;
 }
-
-device_initcall(init_binderfs);
-- 
2.20.1

