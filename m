Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FCC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22720673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9N9WHD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E22720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeK3KQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44820 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeK3KQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so1777323pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=diyfuOqdqP35URsXUdFafl/76ZP7Os651qTHk8Grkrg=;
        b=C9N9WHD+TdUB+zyJzkSp4v1TAJWGuSiaa44LFMs8TCSCMVNn40xY0ka/Or+chjPhzQ
         oWrZ8nw3YPd7JbXCzgJbf9Rl4+oMpeehlnQ7kEu7YKRCLhAFu5YTMifVtvwYiPdmLpWL
         InrarV3YVY6sTfIqnxpZjNSYt7WJfm1q7Y3tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=diyfuOqdqP35URsXUdFafl/76ZP7Os651qTHk8Grkrg=;
        b=dmPAlgaqRLQ51IcYogxPVHMw5kxnPEol8Tq01yhJTW8OxoNEny1Jtjvhx8w3ZBuEe8
         nvMJh7S7tnbCQbhu5ZEAn2Y1WYX886ZRREV/w3qfGUVaA/xlzrCq8klQD5hfIOvQvIg4
         TdY5mEzz56eq7zVslQK5FHNg7H+YxF14W1RMSDUoZOmxjpj5WxnLn6hXnqP18Ggyj5Ul
         OQLPRlQDA/Kjw0ktQPAP0RaZTKuwxnsfYpS6L9fNVhEhIJCu3K6aXeCVxU2xjcsSNR9x
         Cv7O4+SZuDw0Dj2acdLqINMCEmgptAWOP1/1I7VbyqniC0sHzcCvOpiLFpEz1EOdLPoo
         rwtw==
X-Gm-Message-State: AA+aEWaqfEin/ikarDdpfH31SQM3VJ3qA8bwUjQFOv2m97FUnjQUk4Va
        lKj6xkpWOsBhArAAhCQpwdFZnoND+mV25A==
X-Google-Smtp-Source: AFSGD/UwHQnpUgMQS6c9bgQnDnUh+R3wIaInj75tZ2rt4I3KgLk91eV4giDJxGSVGnBoteaNYPVENA==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr3428847pls.281.1543532932803;
        Thu, 29 Nov 2018 15:08:52 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f22-v6sm4360134pfn.177.2018.11.29.15.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Peng Wang <wangpeng15@xiaomi.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 04/12] pstore: Avoid duplicate call of persistent_ram_zap()
Date:   Thu, 29 Nov 2018 15:08:33 -0800
Message-Id: <20181129230841.29955-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Wang <wangpeng15@xiaomi.com>

When initialing a prz, if invalid data is found (no PERSISTENT_RAM_SIG),
the function call path looks like this:

ramoops_init_prz ->
    persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
    persistent_ram_zap

As we can see, persistent_ram_zap() is called twice.
We can avoid this by adding an option to persistent_ram_new(), and
only call persistent_ram_zap() when it is needed.

Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
[kees: minor tweak to exit path and commit log]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c            |  4 +---
 fs/pstore/ram_core.c       | 15 +++++++++------
 include/linux/pstore_ram.h |  1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index e02a9039b5ea..768759841491 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
 
 	label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
 	*prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
-				  cxt->memtype, 0, label);
+				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
 	if (IS_ERR(*prz)) {
 		int err = PTR_ERR(*prz);
 
@@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
 		return err;
 	}
 
-	persistent_ram_zap(*prz);
-
 	*paddr += sz;
 
 	return 0;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 12e21f789194..23ca6f2c98a0 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -489,6 +489,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 				    struct persistent_ram_ecc_info *ecc_info)
 {
 	int ret;
+	bool zap = !!(prz->flags & PRZ_FLAG_ZAP_OLD);
 
 	ret = persistent_ram_init_ecc(prz, ecc_info);
 	if (ret)
@@ -498,23 +499,25 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 
 	if (prz->buffer->sig == sig) {
 		if (buffer_size(prz) > prz->buffer_size ||
-		    buffer_start(prz) > buffer_size(prz))
+		    buffer_start(prz) > buffer_size(prz)) {
 			pr_info("found existing invalid buffer, size %zu, start %zu\n",
 				buffer_size(prz), buffer_start(prz));
-		else {
+			zap = true;
+		} else {
 			pr_debug("found existing buffer, size %zu, start %zu\n",
 				 buffer_size(prz), buffer_start(prz));
 			persistent_ram_save_old(prz);
-			return 0;
 		}
 	} else {
 		pr_debug("no valid data in buffer (sig = 0x%08x)\n",
 			 prz->buffer->sig);
+		prz->buffer->sig = sig;
+		zap = true;
 	}
 
-	/* Rewind missing or invalid memory area. */
-	prz->buffer->sig = sig;
-	persistent_ram_zap(prz);
+	/* Reset missing, invalid, or single-use memory area. */
+	if (zap)
+		persistent_ram_zap(prz);
 
 	return 0;
 }
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 602d64725222..6e94980357d2 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -30,6 +30,7 @@
  * PRZ_FLAG_NO_LOCK is used. For all other cases, locking is required.
  */
 #define PRZ_FLAG_NO_LOCK	BIT(0)
+#define PRZ_FLAG_ZAP_OLD	BIT(1)
 
 struct persistent_ram_buffer;
 struct rs_control;
-- 
2.17.1

