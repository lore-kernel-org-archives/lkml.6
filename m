Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C53213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gaA35ZXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfAJXZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:25:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35796 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAJXZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:25:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so11667533edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSH1MCyTs5Fq2rS1SuY9wqa78utN690zCnDgXG/iH7g=;
        b=gaA35ZXgNEMfycsvkzxmrXWXCPwUFxQq3ErYmM6gnNzW7+hGXnJhOFA2cupQ/aBmdD
         lSOqbDVoZrSdpb7fQEe5H60Bw7wqNM85AX4VQPGxTk8KPOk7sooqIppIXDd7pz1TO3fO
         x4RFuIfEzXRmTs5ozz9mIn3khkvfr8ir7OVJpL8ggbFCOnxz0+cyCDmZpMK/d9nhFjQ7
         +HALHz+Kd3NPO+JW3dYZDItmn1PfA1mx9TJtm+8JcpjM84VSAbyui6hElDssAMxZZumF
         SVMH2aTx6m4MoIOU9rWFKUZc7I6GdntS/PG7YooQoJRPusuYX9de1BDN6SDMRgXDhIVj
         lKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSH1MCyTs5Fq2rS1SuY9wqa78utN690zCnDgXG/iH7g=;
        b=haSPtRJLcwitt4XSQI/043bdb6RDnZNQjUJKHLna18Iv7yskz8p/61aPAiKc2Ji8zw
         zpL7K6iIL5kA22w+Cx+XVy5RADW1N1ISWdmFiF+i9N5fCONfzySlgZw95U5HsN/r67XF
         T6nPDDp9Pt3dhd+kxEhNXymtCZm3pG7wfD3SVnKq1cmB5tymJ22J4XgwdUmAerV/E3M2
         /UlWVQZPBqGfff2tkw7nOa/xjsS5U10kzWlQ43UkS3netn+PG+9Rhtm8c6+bE7BOqoww
         kRJlcaequYUXnJC6iWapv2rfw7PdyMZBZaY/12JOvkBmwYkRb2d6AWyrDElKSc5jIT2u
         qguQ==
X-Gm-Message-State: AJcUukc6l+e2sMLFJ5RrMlUZ+sb8MeixXqaKvOG+nByyQ4+cudwnzec7
        SHGETE/SYo4LtSMR7ozrHQ5XkQeFm1Otjg==
X-Google-Smtp-Source: ALg8bN7z96vT+Fs5BI+NE1VB+VK+LkDyIOEC/JVmt2uX3bYrPoACvTM2AuvEtBVkQFwSqj+3rLikQA==
X-Received: by 2002:a17:906:c30f:: with SMTP id s15-v6mr10114872ejz.169.1547162754165;
        Thu, 10 Jan 2019 15:25:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id b46sm2314765edc.57.2019.01.10.15.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:25:53 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH] binderfs: rename header to binderfs.h
Date:   Fri, 11 Jan 2019 00:25:41 +0100
Message-Id: <20190110232541.16294-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to call the header binder_ctl.h when its sole
existence is tied to binderfs. So give it a sensible name. Users will far
more easily remember binderfs.h than binder_ctl.h.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binderfs.c                              | 2 +-
 include/uapi/linux/android/{binder_ctl.h => binderfs.h} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/uapi/linux/android/{binder_ctl.h => binderfs.h} (100%)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7496b10532aa..b4ac9ecc16f7 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -30,7 +30,7 @@
 #include <linux/xarray.h>
 #include <uapi/asm-generic/errno-base.h>
 #include <uapi/linux/android/binder.h>
-#include <uapi/linux/android/binder_ctl.h>
+#include <uapi/linux/android/binderfs.h>
 
 #include "binder_internal.h"
 
diff --git a/include/uapi/linux/android/binder_ctl.h b/include/uapi/linux/android/binderfs.h
similarity index 100%
rename from include/uapi/linux/android/binder_ctl.h
rename to include/uapi/linux/android/binderfs.h
-- 
2.19.1

