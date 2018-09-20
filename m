Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB97ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4832D2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H23tsq1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4832D2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbeITWID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38260 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbeITWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so4593133plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zg+yA6iBpUZzxZCfC7FbRgVPvRB/0N0Ik3Iu+95jWHE=;
        b=H23tsq1ToF0dxmUZ+HTryRkBaWmjTb71c3wjGIuwxZcwUogcbdfKloN5fXoL0DReiz
         6RnBfkuqUS3cXhotka6z/0XQCimbvlLtWXQcmGu0OOKmVKX9EfR2uUPpZLdOVizZ4S0o
         vN5OYaQjgaj7wy1XGKCtnyMIyvnJi2tka8WR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zg+yA6iBpUZzxZCfC7FbRgVPvRB/0N0Ik3Iu+95jWHE=;
        b=oxiPX4eUOCKPadx6dE+o3nEcAXHMNF1MOvyLG5gwXw6CMqh8u5c1dnPjMqUIqNgG6a
         bOMOhjJWqrSO7Lq8Gg/NNj34A2RuPBTGdopmNKJ95aePvBIZR7LK0a/HbCFFC9u7szEB
         DDYBiM8+JWNo3lXs9bh+0F5H3CJZdihuYI4h9BbTvQK3mJwFdMB8fuKNUi9sZ/xM/jTU
         Gt56oBnyw5JISl7knq56yICUMczOcY4LEtpLRyxugaIjaZDHhVMIZiIazCm5XCBIQuwE
         mOGhHMu7HFXWxy2eiTWSUJg2YqcfAEDtcEIV4uM6BbkX5Lm7sAso9B+jktU+AHEfJKZf
         1Wbw==
X-Gm-Message-State: APzg51A8c+f7225xLTlgKo9R3P2MYTYHr6J7ES4oNjflHtBm09p5EcJR
        9GC0KLSKoRTDUotHu9vX/St4q3mjqSk=
X-Google-Smtp-Source: ANB0VdbNXm/OIOfuzZqfwwbkUTCJXuevcYNHWasLdUBmfSIo7BtFySaQm1q2bWg7ymD89BrTcDIlww==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12-v6mr3044057pls.67.1537460627412;
        Thu, 20 Sep 2018 09:23:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a19-v6sm41547245pfj.38.2018.09.20.09.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v2 02/26] vmlinux.lds.h: Avoid copy/paste of security_init section
Date:   Thu, 20 Sep 2018 09:23:14 -0700
Message-Id: <20180920162338.21060-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..934a45395547 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -473,13 +473,6 @@
 #define RODATA          RO_DATA_SECTION(4096)
 #define RO_DATA(align)  RO_DATA_SECTION(align)
 
-#define SECURITY_INIT							\
-	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-		__security_initcall_start = .;				\
-		KEEP(*(.security_initcall.init))			\
-		__security_initcall_end = .;				\
-	}
-
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -798,6 +791,12 @@
 		KEEP(*(.security_initcall.init))			\
 		__security_initcall_end = .;
 
+/* Older linker script style for security init. */
+#define SECURITY_INIT							\
+	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
+		SECURITY_INITCALL					\
+	}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-- 
2.17.1

