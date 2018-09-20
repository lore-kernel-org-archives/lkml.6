Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061AEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6FD2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFR75zUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6FD2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbeITWN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:13:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35470 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbeITWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:13:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id 205-v6so3734881pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=41JHmeDth85/sNORiIQtTjoZxJboPyIhG2VUHSXPrw4=;
        b=TFR75zUMSBYV6OzQ8u3KsAh7xal3TluRRyzCQLFAJSMAKoYAAV3M6kgk/YYUMghamW
         akAKBaq8KzANA9fQtvmAbpse10jx1isEpkGT0gSYCv4f8sdW1dStxj9Prkz2OQj7Gzo7
         g1Vh/SqzTjgvW9OmOiMOTGaeec56bLp2wKXwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=41JHmeDth85/sNORiIQtTjoZxJboPyIhG2VUHSXPrw4=;
        b=Z6nXWmuBw3x/HolSQdHkvQvDwCrfHyxWjLJF5yLnc/DVtAIpyIKP5QKnI3fixlcBKM
         3tMn6zD2nhLCRjbLS4qnVC0s8tbvwTnTgMexkqtV6J5e1pReHH1OFydzl1ZFYXuGhgTZ
         AI+UcxoI31bDcmJAAV2W6OZRp2p0uOkwtVkrFXTJkN4/58aao5JrHeLzOWE9hJlxZ8dP
         afEl1RMW11xhR4sGGL2H/eqQFRoZo91ZUrmu1lN1DtBWypL5+k7TfrqJvE9s+XYyRF9B
         dRdh9BdSbg++2ekno2JwwK+/49fCIh8AkErwWNfJHrVRBKR/Jx3wmm4D9wfdyTumrEMc
         6s4w==
X-Gm-Message-State: APzg51APdue/fMkeUlL+YQ7bGVsaKbFcKJvigDn/xEYWt1j4GIoIZmpl
        qKl7amRHCRzek8qe6FvBgsVJwQ==
X-Google-Smtp-Source: ANB0VdYGQequYNqg7c2EkZwIpIiquIJI+a/sd93UBEOLXGlgfGTjqtmeUJc52hzjUAAqriiQ6CoSBQ==
X-Received: by 2002:a63:70e:: with SMTP id 14-v6mr2838215pgh.70.1537460981100;
        Thu, 20 Sep 2018 09:29:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h69-v6sm58906828pfh.13.2018.09.20.09.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:29:39 -0700 (PDT)
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
Subject: [PATCH security-next v2 17/26] LSM: Refactor "security=" in terms of enable/disable
Date:   Thu, 20 Sep 2018 09:23:29 -0700
Message-Id: <20180920162338.21060-18-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For what are marked as the Legacy Major LSMs, make them effectively
exclusive when selected on the "security=" boot parameter, to handle
the future case of when a previously major LSMs become non-exclusive
(e.g. when TOMOYO starts blob-sharing).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index 5cacbcefbc32..25a019cc4a2b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -81,14 +81,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (lsm->enabled && !*lsm->enabled)
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
 
@@ -150,8 +142,24 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
+	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
 		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+	if (chosen_major_lsm) {
+		struct lsm_info *lsm;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(lsm->name, chosen_major_lsm) != 0)
+				set_enabled(lsm, false);
+		}
+	}
 
 	/*
 	 * Load minor LSMs, with the capability module always first.
-- 
2.17.1

