Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64962C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47C20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mNyLGuf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A47C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJKHu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46705 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJKHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so3280891plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/EXRqhMc1kFihgZuEZ0aZzlHiUobpIVUrAgL2D7PCk=;
        b=mNyLGuf7bZUAbbM2vwI42nUFhUZ6PjmRv3XC1G5aZQGlWBYiYjGxgxglQxB2mkxSHS
         XXISL8/WTRY5lDINv8C2QoHevX2QpKrsFAAUGHumt+5cqBBTiiDW5nYXp2i/Q3ii/Z7M
         QJY43whG8ngJ4q0RLA/BF4S0/umyDw6CgeiVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o/EXRqhMc1kFihgZuEZ0aZzlHiUobpIVUrAgL2D7PCk=;
        b=Kttza1EvMmoHSdHPg/5ZREhiI425KEAMTj4T3i5b10NB1yDrovyQ05Oxd6H9zdZX5k
         ls1VrF5oQGSlH7NX9NAUF5eg2vLZRerH2BBnywAQbXkWZDYy0awijnuKpevtFw560LzD
         N/U4wDHZ1mhWtXlXCIRbTjrAiNgjCd3Y+wm0VVgXJ+t5QuZC5fTwBs16nPLoHBAc7wuH
         giudmVm+Zx/33nVlZaIWbQPTWvRbXlIRYHdoRjsu+LvnZtaVQa2LQNdqig4RWY+llMkT
         kghpJCyCO34rNW5vi+dzBw2VE/scQ0S5gPNzlN9lvVR1+U94onhq9Kz3dGC3jeNgx3Ow
         2Jyg==
X-Gm-Message-State: ABuFfojyYLdqs4D0ubnfrx16zJjDSYZRfDLp11AMHy2gCGSIPTVFFrsd
        wuM4Uxrtu1iihSC4g8GwcjenqA==
X-Google-Smtp-Source: ACcGV62gtlSEYk6DttLToS0EZ4Auvn1R5JW2dXPCNh4rrFOK3yAHclxlz6Jw/dXRHO0LwV5Nrsx3Yw==
X-Received: by 2002:a17:902:1021:: with SMTP id b30-v6mr35637768pla.23.1539217551470;
        Wed, 10 Oct 2018 17:25:51 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w127-v6sm32878900pfd.112.2018.10.10.17.25.47
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
Subject: [PATCH security-next v5 26/30] LSM: Split LSM preparation from initialization
Date:   Wed, 10 Oct 2018 17:18:42 -0700
Message-Id: <20181011001846.30964-27-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already have to do a pass through the LSMs to figure out if
exclusive LSMs should be disabled after the first one is seen as enabled,
this splits the logic up a bit more cleanly. Now we do a full "prepare"
pass through the LSMs (which also allows for later use by the blob-sharing
code), before starting the LSM initialization pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/security.c b/security/security.c
index 4f52bd06705f..b40c4c212892 100644
--- a/security/security.c
+++ b/security/security.c
@@ -139,22 +139,28 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	return true;
 }
 
-/* Check if LSM should be initialized. */
-static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+/* Prepare LSM for initialization. */
+static void __init prepare_lsm(struct lsm_info *lsm)
 {
 	int enabled = lsm_allowed(lsm);
 
 	/* Record enablement (to handle any following exclusive LSMs). */
 	set_enabled(lsm, enabled);
 
-	/* If selected, initialize the LSM. */
+	/* If enabled, do pre-initialization work. */
 	if (enabled) {
-		int ret;
-
 		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
 			exclusive = lsm;
 			init_debug("exclusive chosen: %s\n", lsm->name);
 		}
+	}
+}
+
+/* Initialize a given LSM, if it is enabled. */
+static void __init initialize_lsm(struct lsm_info *lsm)
+{
+	if (is_enabled(lsm)) {
+		int ret;
 
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
@@ -230,7 +236,10 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		maybe_initialize_lsm(*lsm);
+		prepare_lsm(*lsm);
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		initialize_lsm(*lsm);
 
 	kfree(ordered_lsms);
 }
-- 
2.17.1

