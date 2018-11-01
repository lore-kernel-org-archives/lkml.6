Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98805C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718820840
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gy7KHkfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5718820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeKBI5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so94754pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xB00KxuZQEu8aN2blw/Q7Mwo860ndkfrw/IytwM8ixA=;
        b=gy7KHkfoUUuauKBG2j97dXJ1iEsHyYnsRri02wczhGLgP24jWmKaL+uqZ/diimN1F2
         tMaLAw0JuItlzzjav257nHTDLpjIluAXoUF0WogAEwau+19Pg7z7ogR0LVJaR9F41eNC
         4HTJiL9n2kQj8EudHcwlAjfAX4IZ+4Kkl6B24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xB00KxuZQEu8aN2blw/Q7Mwo860ndkfrw/IytwM8ixA=;
        b=BWXu3q1ELi6r4SGHV42zEMF+MvBnORD3H4e0uFoLjQr/UAFIk5jNxOSOZuL9/sBEku
         FQqdCQM/e+r+9zkFRvuI0cvpwBHNrzU8Xw5WVSZUYYoVL5xdiY6bktgZsS4z438ywBk2
         /6VTXq73r1NfNJ6V6JKGpjJDf310dji8XoA9QzM4a1F41pPxMIZS1RDYB7JZ6NM8OoQz
         gEqUjC39g2cfDKuLXCi0U0yfeintf9WFiICgzyCd7WnnGcY2LblyBeBYLfLA+45uP2ua
         tFXScNoz3YVRE/Kng5m5FldMJxc+DDvxqBg9eJOR8PA2+cLmIvZg8Bd/DI3QBB/BRknI
         zlDQ==
X-Gm-Message-State: AGRZ1gJSHFxwn9mDb3q2WODVBN68HXnsLWKnqbuOqwdn6sh1gtaTU+VO
        rNkxkxyiHXc5EQ2OsEv/6o292A==
X-Google-Smtp-Source: AJdET5eSBltK8jTER+WB2nOgkp1YApNM6UjvK5/+7Yxe/FJzLeeeJkb3w6K1qWS6OCNCc+Vcar8EJg==
X-Received: by 2002:a62:ce8e:: with SMTP id y136-v6mr9707999pfg.201.1541116325533;
        Thu, 01 Nov 2018 16:52:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u69-v6sm46766786pfk.68.2018.11.01.16.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH linux-next 1/8] pstore/ram: Standardize module name in ramoops
Date:   Thu,  1 Nov 2018 16:51:53 -0700
Message-Id: <20181101235200.28584-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
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

