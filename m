Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C66ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D692145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kp0P7Nvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D692145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJRFjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:39:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33198 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeJRFjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:39:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so13160759pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HvIoC9XLkj4GwwVHYXaba/jypxmVdie7CNZPCHwu19U=;
        b=kp0P7NvpQ/D6TfAE+/0WPel98cni7W6aM3KKul7yxFHm4DsUXJTFDAqatEcKBGSj/B
         EMRmijmxYhMZX3I4GjqUXWXcbRm1azdlCOaPIag38nxm6LR0jRlgre0A4qtkzqB363Bp
         evhnFuTdfAZxxmI3Nyw5pqEmWgQeoa3s6x/0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HvIoC9XLkj4GwwVHYXaba/jypxmVdie7CNZPCHwu19U=;
        b=rkclvyhPeVAkg9Xxbi6pV+WsPY+johwD7+taO5n2WMRg3K6zRW3U44pIQgJBqMXF/g
         8ZEd3QIjLI6Cq7IIof9iQX2RSSlpJuxZGSfwmlria6y9fks4NHZTk1EXIDoNv/V532lV
         HjRyyh/exFHo4zEWWZ0hsXC5gDJEtvaIB6eLzmCqVlQ2OcgRrD4hMbH3yne9hTg6CWmP
         Un4KeMuG2/a9kmTf/NCoclGYlrJ4QBFpscOK3rEmkmfXcaMrsGEKDUf+Vf4a9HaUXxBa
         /QlyU2404gVzj2b/O7LRzEdILmyIwerbhXeNujnid+6ARopNATnW/cvAZWs5P6zlq3aL
         2H6w==
X-Gm-Message-State: ABuFfojao+HXc1ZI2AKtOcwcJlZTmz/vBiPJAOTFEAoYll/HS/jb9sTM
        TpKLvc3pYGewC0Mf4wUveBB4x13PBBA=
X-Google-Smtp-Source: ACcGV60KRnBkbDPRGXrxvJ9QUvhVwVfqNLSY2f1xWk/oNOcbGyNu0AruUjksc4OkKCWFSQ5W1ZLQ8g==
X-Received: by 2002:a63:8448:: with SMTP id k69-v6mr314808pgd.83.1539812487863;
        Wed, 17 Oct 2018 14:41:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t11-v6sm22185670pgn.38.2018.10.17.14.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 14:41:26 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:41:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: Refactor compression initialization
Message-ID: <20181017214124.GA8239@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With compression initialization now separated from pstore_register(),
there is no longer a good reason to do compression method selection
during fs init. Instead, merge everything together into the late init.
Additionally cleans up the reporting to be more clear.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This patch goes on top of Joel's. I'll have both in linux-next shortly...
---
 fs/pstore/inode.c    |  2 --
 fs/pstore/internal.h |  3 --
 fs/pstore/platform.c | 65 ++++++++++++++++++++++++++++----------------
 3 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..d814723fb27d 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -486,8 +486,6 @@ static int __init init_pstore_fs(void)
 {
 	int err;
 
-	pstore_choose_compression();
-
 	/* Create a convenient mount point for people to access pstore */
 	err = sysfs_create_mount_point(fs_kobj, "pstore");
 	if (err)
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index fb767e28aeb2..c029314478fa 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -37,7 +37,4 @@ extern bool	pstore_is_mounted(void);
 extern void	pstore_record_init(struct pstore_record *record,
 				   struct pstore_info *psi);
 
-/* Called during module_init() */
-extern void __init pstore_choose_compression(void);
-
 #endif
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f09066db2d4d..e4737a5fa68c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -274,36 +274,56 @@ static int pstore_decompress(void *in, void *out,
 
 static void allocate_buf_for_compression(void)
 {
+	struct crypto_comp *ctx;
+	int size;
+	char *buf;
+
+	/* Skip if not built-in or compression backend not selected yet. */
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
 		return;
 
+	/* Skip if no pstore backend yet or compression init already done. */
+	if (!psinfo || tfm)
+		return;
+
 	if (!crypto_has_comp(zbackend->name, 0, 0)) {
-		pr_err("No %s compression\n", zbackend->name);
+		pr_err("Unknown compression: %s\n", zbackend->name);
 		return;
 	}
 
-	big_oops_buf_sz = zbackend->zbufsize(psinfo->bufsize);
-	if (big_oops_buf_sz <= 0)
+	size = zbackend->zbufsize(psinfo->bufsize);
+	if (size <= 0) {
+		pr_err("Invalid compression size for %s: %d\n",
+		       zbackend->name, size);
 		return;
+	}
 
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (!big_oops_buf) {
-		pr_err("allocate compression buffer error!\n");
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		pr_err("Failed %d byte compression buffer allocation for: %s\n",
+		       size, zbackend->name);
 		return;
 	}
 
-	tfm = crypto_alloc_comp(zbackend->name, 0, 0);
-	if (IS_ERR_OR_NULL(tfm)) {
-		kfree(big_oops_buf);
-		big_oops_buf = NULL;
-		pr_err("crypto_alloc_comp() failed!\n");
+	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
+	if (IS_ERR_OR_NULL(ctx)) {
+		kfree(buf);
+		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
+		       PTR_ERR(ctx));
 		return;
 	}
+
+	/* A non-NULL big_oops_buf indicates compression is available. */
+	tfm = ctx;
+	big_oops_buf_sz = size;
+	big_oops_buf = buf;
+
+	pr_info("Using compression: %s\n", zbackend->name);
 }
 
 static void free_buf_for_compression(void)
 {
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && !IS_ERR_OR_NULL(tfm))
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
 		crypto_free_comp(tfm);
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
@@ -764,31 +784,28 @@ static void pstore_timefunc(struct timer_list *unused)
 			  jiffies + msecs_to_jiffies(pstore_update_ms));
 }
 
-void __init pstore_choose_compression(void)
+static int __init pstore_compression_late_init(void)
 {
 	const struct pstore_zbackend *step;
 
 	if (!compress)
-		return;
+		return 0;
 
+	/* Locate desired compression method. */
 	for (step = zbackends; step->name; step++) {
 		if (!strcmp(compress, step->name)) {
 			zbackend = step;
-			pr_info("using %s compression\n", zbackend->name);
-			return;
+			break;
 		}
 	}
-}
 
-static int __init pstore_compression_late_init(void)
-{
 	/*
-	 * Check if any pstore backends registered earlier but did not allocate
-	 * for compression because crypto was not ready, if so then initialize
-	 * compression.
+	 * Check if any pstore backends registered earlier but did not
+	 * initialize compression because crypto was not ready. If so,
+	 * then initialize compression now.
 	 */
-	if (psinfo && !tfm)
-		allocate_buf_for_compression();
+	allocate_buf_for_compression();
+
 	return 0;
 }
 late_initcall(pstore_compression_late_init);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
