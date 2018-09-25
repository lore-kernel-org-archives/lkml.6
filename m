Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F1DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B986D214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C14BAFdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986D214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeIYGYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:24:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeIYGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so2503194pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5TLT0f4fZoyxcv+w2j50Rd/UuLy9YsMhEgdbx0R13nc=;
        b=C14BAFdTW+7Sl9Xf32WFlszgRZuVGPmijY0akk/QJJjWK3lsDRLqrKOSFJBQxkNfl3
         jKLsfF8s85yhgC+upLddcaYwJgIGRhsqMOhxzKLpeIfHtbm3KkH0gQRLGzqUGRz9CE6O
         R9fyZM7+mCvxqO/fIidnQg7SdX2mGfBToaHko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5TLT0f4fZoyxcv+w2j50Rd/UuLy9YsMhEgdbx0R13nc=;
        b=I0twrLNQKJSGMqtiQoTvnLNUrF5mLNsnIfR0RcamimkEfDoN5wYoMCYBpgAOPVsqpr
         Js2UPZhumRB05vJCbdK+vzSXEISdLztu7aTmMvFnsODyGUgEgXHz5p4QC81OWZdHeJKh
         ybS13OB0nkER9vDo300kXLj2ThfkK/KQORSZjBAtCup+ZLBok9875mzlXooKGOUwxKGL
         othNqRcPRh4Cd8p5INU+EZyT2M/fO7dRSuA7R6h+7t8rj+DDZbGw+HvtMaDn6PnUFgyO
         Jkx7ShM+JZYQviG2dsIQ5JLSqaMssp8l24asyKGWsPdL1DU2NHszD7+qMjygSNOEm/hA
         oG9g==
X-Gm-Message-State: ABuFfoixDeIBSZWRZipzz43k+n3GMjidjaWx3FEf6rV+4SE3L7aRixw+
        ZaOUTe600ICZvsvvf60duMRr/g==
X-Google-Smtp-Source: ACcGV60fon6EYbMauix+5f7kIUipMqq0AN0/oDIxWqrisXFl7T1gzUxR/+77R2b3QZVRYtgPMi+o0A==
X-Received: by 2002:a63:eb53:: with SMTP id b19-v6mr878850pgk.371.1537834729821;
        Mon, 24 Sep 2018 17:18:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q26-v6sm607948pfj.127.2018.09.24.17.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:48 -0700 (PDT)
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
Subject: [PATCH security-next v3 12/29] LSM: Provide separate ordered initialization
Date:   Mon, 24 Sep 2018 17:18:15 -0700
Message-Id: <20180925001832.18322-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a place for ordered LSMs to be initialized, separate from
the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
ordered_lsm_init(), but it will change drastically in later patches.

What is not obvious in the patch is that this change moves the integrity
LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
list, there is no reordering yet created.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/security.c b/security/security.c
index 1f055936a746..a886a978214a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,12 +52,30 @@ static bool debug __initdata;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info *lsm;
+	int ret;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
+			continue;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			continue;
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
@@ -87,6 +105,9 @@ int __init security_init(void)
 	yama_add_hooks();
 	loadpin_add_hooks();
 
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
 	/*
 	 * Load all the remaining security modules.
 	 */
-- 
2.17.1

