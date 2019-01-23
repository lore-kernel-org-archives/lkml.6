Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC001C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A97820861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MQ32nMdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAWLlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:41:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38029 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAWLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:41:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so1438349ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObO3YsnTVviCNIPXBgKNdE44QZk54k9UT01/xxx67Zs=;
        b=MQ32nMdgU5DnE1DimI558UQ0e64IZ6ItEfrupqPBMCgX9/oLSVhiGcv6cgX5HdpXw9
         kxMDRJvY3c1JLThXcqVSkJNOTk1eV3jG0Cr424xrUXHdnrs9x3zW3a3NXhq3EjmiGx/4
         Z04pwtlK84fTWsltdiWkhYx2Zy3wBVtFxajhZu44eY0HeQJYTJofS4hcMq7RqEOptxuF
         DcevKMnbBGs0U2nog5ZDE2xpNbQom2/FHU0/4axpX/KX7UIKVgcm+G1JQx9AHb74/Wcw
         +JZlkvW670NTvaYHT9CDHUjcd63Wqk6gk0EwrFu+b257SLWADwKIhHUXi706u3oC7Qxa
         JlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObO3YsnTVviCNIPXBgKNdE44QZk54k9UT01/xxx67Zs=;
        b=KbpcfagL1tWouFBwcUquj4iku+bI+lGRAl1R6tVXpmccrQIXwouDLSQUPNKFHnh82l
         ovfhVL0GjoMT5FndNCt1cmeIw1Z6pVamnyEU7GiO1BLTkk2hRpa/6HyHNMk7K2E0Pdia
         4yKLgHDD0xBzbxrqhx3PGC+EvqWa+6I08SAqyRrMzr5obP1P+xDU2XrKQY8G0B4mHOYQ
         ouLakbtTK1444hSiQFzgOLScLWwEN2h33/MrPSar65zkI5elNOsDqVQR7SGFyvzqFDez
         kux7ZY/7VCppZDYlhQo43kLR+eOKMqtL0IXL1thqqq24mtoir4gticMLU+QTM0a5On3G
         qEgg==
X-Gm-Message-State: AJcUukd6MNbwWZPoVC1sbh9+itmKWgl3Zmy8CQMa69Eyui+6bllQAgeq
        oU2bW6QNRLt0IpTRmArbzJbmHg==
X-Google-Smtp-Source: ALg8bN5/ZbRf0XXbkU3vqdDHhbPU1cK8DqmfsTlmccLvbutrN0TlXHhmzLEizyYrDUGuogQKXXZeRQ==
X-Received: by 2002:aa7:df07:: with SMTP id c7mr2347902edy.85.1548243708514;
        Wed, 23 Jan 2019 03:41:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id l17sm66100ejz.18.2019.01.23.03.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 03:41:47 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] binderfs: remove separate device_initcall()
Date:   Wed, 23 Jan 2019 12:41:16 +0100
Message-Id: <20190123114116.5251-2-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123114116.5251-1-christian@brauner.io>
References: <20190123114116.5251-1-christian@brauner.io>
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
 drivers/android/binder.c          | 4 ++++
 drivers/android/binder_internal.h | 9 +++++++++
 drivers/android/binderfs.c        | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cdfc87629efb..751d76173f81 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5915,6 +5915,10 @@ static int __init binder_init(void)
 			goto err_init_binder_device_failed;
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

