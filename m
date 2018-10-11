Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74495C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFC520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U67kSwyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFC520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJKHnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeJKHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so3272700pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B2MT6Hr/No4vpDLMQ0LP9i/w9/IFVSU+eSeH5iht8h0=;
        b=U67kSwydciTfRVqGNMDeIqFUpcBJ162GM2d553kzz5RbZjIjzrSIO1iyYXPh2ZrTc6
         gulfyHT5dGoFdrzUFQwLz4na5qDwo2SB/8TYoDVyIzWmruj7V4bdPJVfGjS7PPi3Uiyv
         Y1m6ianmGcdPdRqoW8DaPRRPqT07RRQ0Yfb4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B2MT6Hr/No4vpDLMQ0LP9i/w9/IFVSU+eSeH5iht8h0=;
        b=WXvx2E5COqjF2vS75It18i/zYFoaxLGrd2tRAq8BUV+a6gkbqqxJf0+vcH5HDTRpGz
         /MzKHlfmsnvyWRrG9rf3aQAIJ99YaDcHSnpoqmAsI0w5J11a3/8SumAvlDoKMkxi43zg
         dED3i647fMUD43eaThj25VaygIq3ajA8OHYZTRkfRl6nVg82gj8B8AtuI20+xVXef5IN
         WSWjQ9vHfo5vbOxvemVYvWP+ZPYYhLp+3x+CTnK+RqJ7ZOQksuwMv8b/Z3uMfhZuJlsE
         Ju5JXJ9MUI1ISrWnIf64c0UQNWAj7a6+s+CVv8DfNMtn64sWDmmtqwSKbJ2xRIiRfsGb
         iE/A==
X-Gm-Message-State: ABuFfogPAYmTWx2eL9ARjXVeS7K6ubaBrQz5hRt7/HffP8gjKno3qpeX
        osZJQiFd3tAIB7PoL/TH385vqA==
X-Google-Smtp-Source: ACcGV6310duiuF1CQG4tNR5CeYEJfiN55QHgbhZ8qvhYNs1wQKuAfxlpd4rNTL7ACyGKDtThXGstEw==
X-Received: by 2002:a63:2807:: with SMTP id o7-v6mr31367120pgo.155.1539217151797;
        Wed, 10 Oct 2018 17:19:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k3-v6sm73024896pfk.60.2018.10.10.17.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:19:06 -0700 (PDT)
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
Subject: [PATCH security-next v5 21/30] LSM: Refactor "security=" in terms of enable/disable
Date:   Wed, 10 Oct 2018 17:18:37 -0700
Message-Id: <20181011001846.30964-22-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For what are marked as the Legacy Major LSMs, make them effectively
exclusive when selected on the "security=" boot parameter, to handle
the future case of when a previously major LSMs become non-exclusive
(e.g. when TOMOYO starts blob-sharing).

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index 1b1ee823457c..2c754968f98b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -129,14 +129,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
-	/* Skip major-specific checks if not a major LSM. */
-	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-		return true;
-
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_major_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -191,8 +183,28 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
+	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
 		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+	if (chosen_major_lsm) {
+		struct lsm_info *major;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (major = __start_lsm_info; major < __end_lsm_info;
+		     major++) {
+			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(major->name, chosen_major_lsm) != 0) {
+				set_enabled(major, false);
+				init_debug("security=%s disabled: %s\n",
+					   chosen_major_lsm, major->name);
+			}
+		}
+	}
 
 	if (chosen_lsm_order)
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-- 
2.17.1

