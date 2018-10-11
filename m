Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B44C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617CE20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+MSroZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617CE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeJKHv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:51:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32937 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeJKHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id s4-v6so3311123plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lkpsct+7al6mQcKUWpOrrVGi/g6rgIy3oTqM5eABQTE=;
        b=i+MSroZgJnutX2Oav6Ml2tAnleP3kHJrhHKvvu3YVHAltkMlqHmaPfXnRW9ylM3WiJ
         P/Wyji4qgFeedpkFMpMAIfDWbYyfx6d7YkZFSXrvUtG6fOx5Au4Vga1698769wWXToFy
         ddZtslZkSp+KCWLtsNWZOpkKGMQ7+gsI7J6z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lkpsct+7al6mQcKUWpOrrVGi/g6rgIy3oTqM5eABQTE=;
        b=BnYkh4lB8hLB8rds7w9M9lqUcZpthUUVnn45UZYUHDl6RubXf6b1Ng7lfl1ieqlAgg
         W4zwKKAg0MZHnMiHPRGAsUaNQBAkDzC88Ui12xaLlAklf3J2B86NbrYV+NYrzvrPhxiY
         o599/y+sVODmLh1Zh59nTaOmqgimyHDtqwo6iYfVpwwttcl06J92vicpYfrjDZ1OO09p
         9QQdNpUnUi9QaTLCX0MKI0T36D5pKe2pXBCnQimmkaiAvGnKbeVp5fOsW95KlXzySpe6
         uUFhbubuWQwezKLTGNlAAgbqTtfLmYeBvDJTnbMdwD3X9aRmkW5fVKC3XLcMxEmTzYm0
         YM9w==
X-Gm-Message-State: ABuFfojLg1y15sm9dqstwaTmcQfJYMOiZl2zYuTYAtpe1kRViA1hV8rx
        x6PE76DiU5SJnIA3EyJfGQfY9A==
X-Google-Smtp-Source: ACcGV605NzkbnTPYziyIUkQrQljKwn9ZEDxCkvTvssMk4M8pDTaDpmzuuYKyWFVypmdhrdK7yfeOIg==
X-Received: by 2002:a17:902:b706:: with SMTP id d6-v6mr1661442pls.53.1539217548207;
        Wed, 10 Oct 2018 17:25:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k63-v6sm25901722pga.36.2018.10.10.17.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:45 -0700 (PDT)
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
Subject: [PATCH security-next v5 29/30] LSM: Introduce enum lsm_order
Date:   Wed, 10 Oct 2018 17:18:45 -0700
Message-Id: <20181011001846.30964-30-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for distinguishing the "capability" LSM from other LSMs, it
must be ordered first. This introduces LSM_ORDER_MUTABLE for the general
LSMs and LSM_ORDER_FIRST for capability. In the future LSM_ORDER_LAST
for could be added for anything that must run last (e.g. Landlock may
use this).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/security.c       | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 833ec0f03795..97898679a505 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2042,8 +2042,14 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+};
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
diff --git a/security/security.c b/security/security.c
index 2eb8afdd945d..004938eb8e70 100644
--- a/security/security.c
+++ b/security/security.c
@@ -174,6 +174,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "first");
+	}
+
 	sep = kstrdup(order, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
@@ -181,7 +187,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
-- 
2.17.1

