Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2779BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F1120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WT0YX7zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F1120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIYGaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44442 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeIYGaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so2117110pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=na71TelZGQ6m9GWmFesTEQd4UFPGStcPcyELJo/B8RM=;
        b=WT0YX7zWHH6WAFUpHrLCf6WlHBYsAnIO+a8HgEj8X2cHErLyMHE4+4lURbnqC9RSWP
         OAI/QXRK7mPFoG6493qlcbXboTjzJt9RnSjNs6ynisvoaqJDem5XEBsJFacRmRblesy5
         zO8Y4O737dUtgCyCSBjo26tzCLDAdhdaVZOI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=na71TelZGQ6m9GWmFesTEQd4UFPGStcPcyELJo/B8RM=;
        b=GFvaIdvxfwYfhk6EUIspc3C2v5rjoWC4c7cuC8wZ6AYl2t2DNv+B6awaPx/DO5ZoE5
         0IJPAGgYNYY1IVKAOZ4hzUSd5vWBQt8dMla9pynfLyTwg1n15+oV35+pjWT34f+NQ90J
         YSR863temzUu/CYnEGclWcGOXkH5HPkiTHLMUamq+ZD2h0/hoXcd44pJ4O+JP7Q4tT/o
         43SyVBXmzIcS4PUA8ayX9IvyeN2M9apKz1AaRC96WYs/iqACKpQSiIJ5a/CyVgM4zeDC
         gqHKj7yHkkiXFmkU+4N0YEFLduFeDl6js7TGvVUC/+3I+r0BZ4yNXLbLT8O4Zqvc0rqd
         imVg==
X-Gm-Message-State: ABuFfohbyTRH+PdBplJ6hQZL5fUXzSuhYVo+NyuDEAU/bGzcn1+mnlAx
        BBBdlrdL5sjjUJ+8Zp5UtuIr8A==
X-Google-Smtp-Source: ACcGV63fiF8Usp5VDSHevpjSdzhvKONFzj5aTYfHcBlazhkjuEJWBw3JJudQ4OVRL0TAURsxjxz1Aw==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr936718pgu.259.1537835121914;
        Mon, 24 Sep 2018 17:25:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v190-v6sm547521pgb.16.2018.09.24.17.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:25:20 -0700 (PDT)
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
Subject: [PATCH security-next v3 20/29] LSM: Refactor "security=" in terms of enable/disable
Date:   Mon, 24 Sep 2018 17:18:23 -0700
Message-Id: <20180925001832.18322-21-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
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
index e325fcc41f00..a98549b334af 100644
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

