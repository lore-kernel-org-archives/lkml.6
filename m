Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89BC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796F5218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF0ZoDm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfAYJPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:15:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46321 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfAYJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:15:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so4455503pfe.13;
        Fri, 25 Jan 2019 01:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ald4abrKdW8AbO7gX/eespEZrXh8gG1ZicKya1SVk3k=;
        b=HF0ZoDm1EpK5oP/ECpPSsy7VOwk7/+msWagZvINPPfC/3cblXD40en7dMe+vhHUqMe
         m3YhLr2EX3OLhmoxG/I0TwYpovVhH3JVCqlXE2ud6Eq1Je7+/iGVTwWlfndKb+IvIma7
         ETD8HwQPz6q/19zh0b0e5ASYyyTFu/uzaX39gce0FnBkI1IJIIWDHErRpz/W3JUkIYk1
         FqZEIghPuzrgpv8+8VGXzxe/HQ92L4wECGD64uyVxHsH0bnEkKrqoivc/iMHVAYQeneW
         Lzmy8o3RHeXhXVmx2oklcngbwcpDON5qN9ZymlkZFuhPXDx752XlbepTN0C6qfaa5AfP
         65xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ald4abrKdW8AbO7gX/eespEZrXh8gG1ZicKya1SVk3k=;
        b=B2I+TPmn+w/2LV/T9AIfi9zyNAWYRiyFTWlNdPzNoqGnvKLKHeifQmJf4R68azWhJd
         qOQtyn8N9Ap5AZasZpVzSHZ0yHQEB2llTfd/RD4h8lQ5mdHTSJEIyMGkd0Ho9KH2mWEr
         mUgGsFtpyGjVTex1aSSbOZ/pKOxKa5W40WoBQWmxzTGT2ngY1z7Yxo0+R69p978sQmPA
         TUDz77aPQxTaWTqgtrpE95Ii684KuJCJSoThxztcasVT0juXX34L9mSRtgECR7Cws+0f
         ore/DnnoLHA4eOh+hMJEJNd66M2BpWYbrqAwlfSC98i8+Zw7/6z3yD0XTBbQtf+YmpzO
         VTzQ==
X-Gm-Message-State: AJcUuke8yjuzDqWtQsWTE0JmZuDn/tx3Us9gWg/Ah92xT36VJMfoMO2c
        80qQ8pIhxXrfMAF24a+tPKs=
X-Google-Smtp-Source: ALg8bN6gbhlFhxk9+QZMbV2z5TXtqHhJWFP401rBSVdVGTYsJwPfYeQaPEdA1Gkvt8JfHIZ8jH32nA==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr9317098pgv.393.1548407706195;
        Fri, 25 Jan 2019 01:15:06 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id 12sm32272558pgt.33.2019.01.25.01.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 01:15:05 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coly Li <colyli@suse.de>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] squashfs-tools: Add posix acl support
Date:   Fri, 25 Jan 2019 17:14:50 +0800
Message-Id: <8ccfc9ba88a466cf046c366f07e994ca7a46ac0a.1548406793.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548406694.git.geliangtang@gmail.com>
References: <cover.1548406694.git.geliangtang@gmail.com>
In-Reply-To: <d6cbe74944ad1a6be21cc74b99b30d18cba140c5.1548406694.git.geliangtang@gmail.com>
References: <cover.1548406694.git.geliangtang@gmail.com> <d6cbe74944ad1a6be21cc74b99b30d18cba140c5.1548406694.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds posix acl (Access Control Lists) support to squashfs-tools.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 squashfs-tools/read_xattrs.c |  2 ++
 squashfs-tools/squashfs_fs.h | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/squashfs-tools/read_xattrs.c b/squashfs-tools/read_xattrs.c
index 42106f5..8ef8291 100644
--- a/squashfs-tools/read_xattrs.c
+++ b/squashfs-tools/read_xattrs.c
@@ -64,6 +64,8 @@ static long long xattr_table_start;
  */
 struct prefix prefix_table[] = {
 	{ "user.", SQUASHFS_XATTR_USER },
+	{ "system.", SQUASHFS_XATTR_POSIX_ACL_ACCESS },
+	{ "system.", SQUASHFS_XATTR_POSIX_ACL_DEFAULT },
 	{ "trusted.", SQUASHFS_XATTR_TRUSTED },
 	{ "security.", SQUASHFS_XATTR_SECURITY },
 	{ "", -1 }
diff --git a/squashfs-tools/squashfs_fs.h b/squashfs-tools/squashfs_fs.h
index afca918..040035c 100644
--- a/squashfs-tools/squashfs_fs.h
+++ b/squashfs-tools/squashfs_fs.h
@@ -122,11 +122,13 @@
 #define SQUASHFS_LSOCKET_TYPE		14
 
 /* Xattr types */
-#define SQUASHFS_XATTR_USER		0
-#define SQUASHFS_XATTR_TRUSTED		1
-#define SQUASHFS_XATTR_SECURITY		2
-#define SQUASHFS_XATTR_VALUE_OOL	256
-#define SQUASHFS_XATTR_PREFIX_MASK	0xff
+#define SQUASHFS_XATTR_USER			0
+#define SQUASHFS_XATTR_POSIX_ACL_ACCESS		1
+#define SQUASHFS_XATTR_POSIX_ACL_DEFAULT	2
+#define SQUASHFS_XATTR_TRUSTED			3
+#define SQUASHFS_XATTR_SECURITY			4
+#define SQUASHFS_XATTR_VALUE_OOL		256
+#define SQUASHFS_XATTR_PREFIX_MASK		0xff
 
 /* Flag whether block is compressed or uncompressed, bit is set if block is
  * uncompressed */
-- 
2.17.1

