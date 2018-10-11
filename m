Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC91C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2F2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATJmINTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B2F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJKHue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJKHue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so3273681pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IKJr22+ArqQau5eHRp/gArdrGaRS+9hQmMHuu8m9jEg=;
        b=ATJmINTA5StSNCj0pPjYkH38S5HIB4GmfSh05agNfZdmcdk4MUyJrFyx/DxH1t1spX
         aVZQ947MBmkicK/he7Zuo+0ykRQosImfjSgS+gTA9IGfXDi82jpv0OgSlyFoJpCqROxM
         Vvwe7L8cr23Fp+F2kL7eTw5AZbTY8D0kL1LDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IKJr22+ArqQau5eHRp/gArdrGaRS+9hQmMHuu8m9jEg=;
        b=FxQeulCMuBwxXqJ/E1ZLdQTqoAdPKTWAekUju7U/NiH/lZV3qqWT8LTFNO9D+hdktO
         eTiZH9VwJJ1/KIMnK1+X1MJ2ONvGbZMnHt9LelhkluEW2O9YwIvfsWMTKb6yBhRB+MUa
         ecJdqdAKx3wh9ziY5JmwWClU3FBJ3ELFQ57uSvKJ3UpDPTLpnXQo6CMYucDRKwV1mIDC
         SVmIO6jYX2iMewGaHyxhb9K6EcpIwCC01lcq8FQT7xffo6CSArPC/5yIniIHGFYZzyJ/
         I5cDrrW9t3T6Ar1Y8gWDDfYSOgcxrhiwHd/VqrZc8TJWrHvybMyFD4eOb+mVnNy0kyBd
         5YXw==
X-Gm-Message-State: ABuFfojdoGvDFQh2w2mPQYCiJf8h+oV4CeSRMLO45xgksXhc+sdy1FRy
        7I2tDMF/yaLpeslHGCg8loPQMw==
X-Google-Smtp-Source: ACcGV61MxGFAZ6VzFBml2hAhCO+suhwicMkrIZ7kzEMbWjJwCJ+cB4CkCQZwUi2dvqkZMT+DhJ6/Qw==
X-Received: by 2002:a62:3047:: with SMTP id w68-v6mr12340587pfw.19.1539217557357;
        Wed, 10 Oct 2018 17:25:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q24-v6sm22973712pff.83.2018.10.10.17.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH security-next v5 19/30] LSM: Tie enabling logic to presence in ordered list
Date:   Wed, 10 Oct 2018 17:18:35 -0700
Message-Id: <20181011001846.30964-20-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, any LSM without an enable storage variable was considered
enabled. This inverts the logic and sets defaults to true only if the
LSM gets added to the ordered initialization list. (And an exception
continues for the major LSMs until they are integrated into the ordered
initialization in a later patch.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  2 +-
 security/security.c       | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9ecb623fb39d..b6b05d351eb4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/security.c b/security/security.c
index 70cb2d0004e9..f3777ed4ca80 100644
--- a/security/security.c
+++ b/security/security.c
@@ -63,10 +63,10 @@ static __initdata bool debug;
 
 static bool __init is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled || *lsm->enabled)
-		return true;
+	if (!lsm->enabled)
+		return false;
 
-	return false;
+	return *lsm->enabled;
 }
 
 /* Mark an LSM's enabled flag. */
@@ -117,7 +117,11 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
 		return;
 
+	/* Enable this LSM, if it is not already set. */
+	if (!lsm->enabled)
+		lsm->enabled = &lsm_enabled_true;
 	ordered_lsms[last_lsm++] = lsm;
+
 	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
 		   is_enabled(lsm) ? "en" : "dis");
 }
@@ -210,6 +214,10 @@ static void __init major_lsm_init(void)
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
+		/* Enable this LSM, if it is not already set. */
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+
 		maybe_initialize_lsm(lsm);
 	}
 }
-- 
2.17.1

