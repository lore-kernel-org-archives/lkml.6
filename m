Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34386C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DD5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MjZLp3Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DD5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeJSC6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:58:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41819 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJSC6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:58:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so15299122pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZNBmNNmy1In2QXYGi7lnks4sJB+Sf3UG23P3bjVyfk=;
        b=MjZLp3Hbe1U793Vc6tAKyEKVQut6paThKP3bgACiiOSAj7UWRZhagJMoq9YmQ4lVBk
         tnoWCpL2cHQVLg+qub1bs/XLrZxX5Yn24KXkDg5K52c/qwghvH8CoppsRKxQQEpT9afh
         EIZiWO3P+hj6rPIbFik/0lbwh0EvPNK61vlTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZNBmNNmy1In2QXYGi7lnks4sJB+Sf3UG23P3bjVyfk=;
        b=KN23zZqaP36UERs7poxdb8rCH14GJV5P/f/VtD9h7Ygf4L5qmDsK1pan8cDF3CybRG
         A7Eo8UxXG8C/YoRf5IUS5Fw1LGggjRcmTgiOL6LfEJWiXp2rDmw0bwge4CjYza7K5ERb
         hXJbtm6qfn00g2zqrMna3foLsO58aew2/8kikaiv01S44VFwK0S6VEaCjIzgHOw1T7r7
         PN3YqglKOanKJTtkAvgPAPhbuRA3mYJctZd7mX7whC5UANZ+f5Wf7nmSA4g6FWNwJ16M
         0Iw1w4w9SZ02uY6fC+PxXg1g5LqJeJ3eYhH5l+IoyfUZ6Wcm+0Bbgp9JP/x7+MfajF3v
         n5Ew==
X-Gm-Message-State: ABuFfohC2ezNuvbf+4FfvB8zhUioMGkYg8AXCmI1uty4lfbep2AXHRiP
        U249ti3glxy6Io3vI3gBoHD5OhAx7yk=
X-Google-Smtp-Source: ACcGV61/KckTXGQ9gtXAjTSWfVjT9mSkNI3gZhhnFrFiqB/fYnchsB/FCRbTaA41bachSyiC8/iE2g==
X-Received: by 2002:a62:3641:: with SMTP id d62-v6mr22679156pfa.97.1539888982518;
        Thu, 18 Oct 2018 11:56:22 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e3-v6sm27790891pgc.71.2018.10.18.11.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:56:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH pstore-next v2 3/4] pstore: Refactor compression initialization
Date:   Thu, 18 Oct 2018 11:56:15 -0700
Message-Id: <20181018185616.14768-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018185616.14768-1-keescook@chromium.org>
References: <20181018185616.14768-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors compression initialization slightly to better handle
getting potentially called twice (via early pstore_register() calls
and later pstore_init()) and improves the comments and reporting to be
more verbose.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 48 ++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 578f178a695f..b821054ca3ed 100644
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
@@ -774,7 +794,6 @@ void __init pstore_choose_compression(void)
 	for (step = zbackends; step->name; step++) {
 		if (!strcmp(compress, step->name)) {
 			zbackend = step;
-			pr_info("using %s compression\n", zbackend->name);
 			return;
 		}
 	}
@@ -791,8 +810,7 @@ static int __init pstore_init(void)
 	 * initialize compression because crypto was not ready. If so,
 	 * initialize compression now.
 	 */
-	if (psinfo && !tfm)
-		allocate_buf_for_compression();
+	allocate_buf_for_compression();
 
 	ret = pstore_init_fs();
 	if (ret)
-- 
2.17.1

