Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0451C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B63B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLk757S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B63B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeK3KQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46437 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeK3KQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so1596350pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xB00KxuZQEu8aN2blw/Q7Mwo860ndkfrw/IytwM8ixA=;
        b=KLk757S+QT2gg/0HtZ5p20n9LoB9fxOQO74mVfGpnvhkchl/ieEusz8uMx3wU7C7kB
         aLDEWT1xAAYZhjx5LfI8p7y2JRIBeo1zV5Sh/1roe4+GunlukdXaMzcL08Ur/hU3Tf2o
         +o3NqNu5gVo/oFZTGxnrclUguwussIQAJBlgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xB00KxuZQEu8aN2blw/Q7Mwo860ndkfrw/IytwM8ixA=;
        b=lTBZ26Bt4s7IqSwApaN8Ymgf2854T6tpma2Hh/FdY9CrOh9Q4AM7AkmmcoMP98Ve/v
         hWqD9EjZF6pXlO+sGpIniiCJwz4mmKvfeo0WEyrkM8GWrLXY1lx2Z57tYa9TkP1VosEk
         Mv6wGNionha7rgU7Hnyu2M5nV5nAJGwMgh6ZNdQKuv4aZ4kl3nkMIUJGDamXytqIqC6F
         S3J6kwansJM6pWdl0ss7K0K3wPDvNdvoG8pSasAQOvRbq1rpIHKwFwpkxyxNbj1VM+kH
         7ltC6HjL+SGEFAZy/eN+sUgyUTNyylNDFljXHYX3tGSBbnyUYcdggL4kqg7SseQGIp6n
         kCUQ==
X-Gm-Message-State: AA+aEWb8P+3HxAY7YYWzURIpP3GTFJuaFqIdal4r0k8NUjBNzQkOUUQC
        FrwalJUtZBwYF/JT2TjJ+kFoXg==
X-Google-Smtp-Source: AFSGD/VL6gadzATXMEw0F99o2WQFjWZOc9UutvDrN+3YGMvscFFfGhS5mvm9fHebBgzEdWRjuWi2xQ==
X-Received: by 2002:a62:26c7:: with SMTP id m190mr3369401pfm.79.1543532936769;
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c13sm4285561pfo.121.2018.11.29.15.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:55 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 05/12] pstore/ram: Standardize module name in ramoops
Date:   Thu, 29 Nov 2018 15:08:34 -0800
Message-Id: <20181129230841.29955-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With both ram.c and ram_core.c built into ramoops.ko, it doesn't make
sense to have differing pr_fmt prefixes. This fixes ram_core.c to use
the module name (as ram.c already does). Additionally improves region
reservation error to include the region name.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 23ca6f2c98a0..f5d0173901aa 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -12,7 +12,7 @@
  *
  */
 
-#define pr_fmt(fmt) "persistent_ram: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
 #include <linux/err.h>
@@ -443,7 +443,8 @@ static void *persistent_ram_iomap(phys_addr_t start, size_t size,
 	void *va;
 
 	if (!request_mem_region(start, size, label ?: "ramoops")) {
-		pr_err("request mem region (0x%llx@0x%llx) failed\n",
+		pr_err("request mem region (%s 0x%llx@0x%llx) failed\n",
+			label ?: "ramoops",
 			(unsigned long long)size, (unsigned long long)start);
 		return NULL;
 	}
-- 
2.17.1

