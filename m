Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B1B21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDhrsbxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B1B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJBHpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43657 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeJBHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:04 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so267927ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0qW1uF7m4L1ZO2KeQqVjIZsOMVYw9XJu7Iz5ldDGsTM=;
        b=NDhrsbxuJpH8jCuXv4vA++uSz8lSj1sQmARm/JggoSeY5rzd+87LpdFJG6YVNE5JTC
         IuuqsE44RAfi7t/wqc2uh4MNhih7NpbPqGZRmhwOAB5T0RyMtBgOU7ui0H709C+WsAON
         wo4xmL7lr8nSw/gkCJpns1qLaabNLquiH0EM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qW1uF7m4L1ZO2KeQqVjIZsOMVYw9XJu7Iz5ldDGsTM=;
        b=lzEzAgKXYH0zW3ZYS2L70HYmTHoIQV9s95VY3IoUMFpcUhEvthgqgYIDXCjc2J8vx5
         Z3nhit4n4tQjJx0XvLir/I+kgAttjVrUWQ2fj7Ucm07k1gl8FTH1JUvZU4nMW4hmgSR+
         S1cQCpKJbj2ZjQmlAmMhBGPG4BAEg/+pdXgn8B/vOh6qxYN6lH4wlxt+JPQI87TmDH/x
         fFzEwPF6HYC/2rsGAIyHvTkyxtsiW6lRKAs92Lxr3tIwcof7yRKcZ1ApH2LvM11r9ETV
         A/VXykHjHyfKJC7mpIaLzVGaEdBHFA344SaqVipqetve9+BJRmjc9VX4g+EyfFiZOc1I
         OYWg==
X-Gm-Message-State: ABuFfojG1YNwdSqDhPuMNf4zsl/DEi2YS4Ky3GOs6VgtDr9b0D4ZEzTM
        SKSHvyu5Pyfa2epEayeAbkN/Fg==
X-Google-Smtp-Source: ACcGV605gnobaiJmFA16xtbVu/9AcHEdLAn7xCklyTmVNdo6+1o9hZHdekNSMlFgBvkhB8xVoYqVcg==
X-Received: by 2002:a17:902:b212:: with SMTP id t18-v6mr14398304plr.136.1538442273074;
        Mon, 01 Oct 2018 18:04:33 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p3-v6sm19540885pfo.130.2018.10.01.18.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 18:04:29 -0700 (PDT)
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
Subject: [PATCH security-next v4 20/32] LSM: Refactor "security=" in terms of enable/disable
Date:   Mon,  1 Oct 2018 17:54:53 -0700
Message-Id: <20181002005505.6112-21-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
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
 security/security.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index 455ba2767965..d7132c181ea6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -103,14 +103,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
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
 
@@ -188,8 +180,24 @@ static void __init prepare_lsm_enable(void)
 	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
 	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
 
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
 }
 
 /**
-- 
2.17.1

