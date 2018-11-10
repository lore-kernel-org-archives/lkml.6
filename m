Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A15DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3020883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z4dx80CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKJKSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:18:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43934 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:18:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so2571030lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMRV2yGipuBF9ApADA+TXAr8hu/aCqxWcuczhrEuTnk=;
        b=Z4dx80CNV7E4GV/lLdbydT/nIWvd9Zc+mmVKg0sMlYVMm0FffmwURbPkGRHkSDGJUr
         1BTkdAeG7rxl4j98rnEOmHHTyXgH2xMP9WgT/n8tZZQ+j/Aq5FWakt+IYXQio1ZceBlV
         Y5V46rf3LmLN/a6jW3glIBRAPyJj/FjnhvAEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMRV2yGipuBF9ApADA+TXAr8hu/aCqxWcuczhrEuTnk=;
        b=fQhXQ7j2J49H7fBUdm+ik9KHRWY1bCSW92x5AdYUx9uPSRbuCMvnmFOaysqJk0v8u8
         VQDJZsy3Sms+UabQ+mtZMmMwSW8Gfn9uAeYdm63LIty9iSi88lyEGo3yt7IOBT8RFPM5
         BtOsSTnEDy5RZQH4RlzArTG1Hh2bwPTXmogZpuWMpF+I8h4GalOyHxA5gYVpTTZwKXCw
         FiZH8PxVxXkdrM8lAkp4jCGcR8fuQmXQ4b6g0siwwyHE2s9+XWfpaAGJIxnxr97I35Rt
         mu0A78cLOrFJKelkPwTmr1yFCrytXByDn3VZx3QIoNvgRgYmAY6m7wBlcTD52pwn0ubb
         OYRg==
X-Gm-Message-State: AGRZ1gKkDC8bpWw5KKISD7+n6iA0sQKeXR/UumEqK0wWB248KxevfLoW
        5YOMvwxRrZnrvme2ndHkCHGkOmgAJpRSKw==
X-Google-Smtp-Source: AJdET5ctlZnHmch8b2GPiHgQc38ggSn+KTAYLMCVUZVmwe+XIhzO8FIS4QxGr4lSjRfOwREtm5Tdpg==
X-Received: by 2002:a19:1365:: with SMTP id j98mr6313453lfi.55.1541810108937;
        Fri, 09 Nov 2018 16:35:08 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id 26-v6sm2006603lje.18.2018.11.09.16.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 16:35:08 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] libfs: make all users of simple_attr_open have the format checked
Date:   Sat, 10 Nov 2018 01:35:04 +0100
Message-Id: <20181110003504.629-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all uses of simple_attr_open() happen via macros that do a
__simple_attr_check_format(__fmt, 0ull). One of the few exceptions
actually does not pass a fmt matching an unsigned long long.

So move the check into the call of simple_attr_open() by wrapping it in
a macro of the same name, and fix the powerpc case while at it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 fs/libfs.c                               | 1 +
 include/linux/debugfs.h                  | 1 -
 include/linux/fs.h                       | 6 +++++-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 43e7b93f27c7..b75d70f54f12 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -436,7 +436,7 @@ static int spufs_cntl_open(struct inode *inode, struct file *file)
 		ctx->cntl = inode->i_mapping;
 	mutex_unlock(&ctx->mapping_lock);
 	return simple_attr_open(inode, file, spufs_cntl_get,
-					spufs_cntl_set, "0x%08lx");
+					spufs_cntl_set, "0x%08llx");
 }
 
 static int
diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..327ab701d176 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -792,6 +792,7 @@ struct simple_attr {
 
 /* simple_attr_open is called by an actual attribute open file operation
  * to set the attribute specific access operations. */
+#undef simple_attr_open
 int simple_attr_open(struct inode *inode, struct file *file,
 		     int (*get)(void *, u64 *), int (*set)(void *, u64),
 		     const char *fmt)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 3b0ba54cc4d5..2ddec401343a 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -42,7 +42,6 @@ extern struct dentry *arch_debugfs_dir;
 #define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt)		\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
-	__simple_attr_check_format(__fmt, 0ull);			\
 	return simple_attr_open(inode, file, __get, __set, __fmt);	\
 }									\
 static const struct file_operations __fops = {				\
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..cb79b79d2175 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3387,7 +3387,6 @@ void simple_transaction_set(struct file *file, size_t n);
 #define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
-	__simple_attr_check_format(__fmt, 0ull);			\
 	return simple_attr_open(inode, file, __get, __set, __fmt);	\
 }									\
 static const struct file_operations __fops = {				\
@@ -3408,6 +3407,11 @@ void __simple_attr_check_format(const char *fmt, ...)
 int simple_attr_open(struct inode *inode, struct file *file,
 		     int (*get)(void *, u64 *), int (*set)(void *, u64),
 		     const char *fmt);
+#define simple_attr_open(inode, file, get, set, fmt) ({	\
+	if (0)						\
+		__simple_attr_check_format(fmt, 0ull);	\
+	simple_attr_open(inode, file, get, set, fmt);	\
+	})
 int simple_attr_release(struct inode *inode, struct file *file);
 ssize_t simple_attr_read(struct file *file, char __user *buf,
 			 size_t len, loff_t *ppos);
-- 
2.19.1.6.gbde171bbf5

