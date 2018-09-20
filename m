Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C333EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768642147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcJsP5U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768642147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeITWIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbeITWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so4622141pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5TLT0f4fZoyxcv+w2j50Rd/UuLy9YsMhEgdbx0R13nc=;
        b=NcJsP5U7+6EjbMYMW/1hKk0ViAKeIKbOwSryqKk9/eHnu/JNS3v455kWl9dqpuTSad
         n1PM/V5avOJVVhiZNSOP29Lu+gwCBWTDm7IuaVNDeJ3mqZ74bFvrebnJkJ+ya3E7i47b
         K1VdaGsa0XsaJcgdETZ5UzHBZ0beZPmKkGiMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5TLT0f4fZoyxcv+w2j50Rd/UuLy9YsMhEgdbx0R13nc=;
        b=hVFXoGPB2FnXri0E7M4+FGY/QYBNyhsl2q4FL/SWs1Eb+M45DdHwRwXwuntBl/uJyd
         N/UGXPXn7tlJHHMI7crasKnVF8NP/AG8H85QHHvW+oXoYyX5dnlJxsFsTv6mu1whY3sM
         97zyzYCKFgCQsQMcq3Kr3PORcS4E9CReHjAjnwudQmrlpzeKESbu7FbdCZzL/bXledfj
         YiuxomkdUWgwbnYNT18XDodZliEk1y/2BNyzS/p28H4yD4NHkv19G7iXxxhultGyUPyt
         DZFcdNljzMOawunfLxW+GFXydOmejcHv8T444XLY/ij1eySWNuJiazvojs5yTD+1S0hC
         N4gA==
X-Gm-Message-State: APzg51DDL6yr38eLaDc2jrjijpkvF6z+y9jRdoaAobz6MCawZfmPAdjg
        XNPLt7jgAyKbryuWx/Q4KhxrmA==
X-Google-Smtp-Source: ANB0VdYW0MALpG9oTE9XugslpbedkEsOoy0kcbuST9d9nAaqNY9z2OOA7lkuvgfGacPYikmr/Q4DBw==
X-Received: by 2002:a62:1e81:: with SMTP id e123-v6mr42012574pfe.24.1537460636734;
        Thu, 20 Sep 2018 09:23:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x23-v6sm35186397pge.61.2018.09.20.09.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:55 -0700 (PDT)
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
Subject: [PATCH security-next v2 12/26] LSM: Provide separate ordered initialization
Date:   Thu, 20 Sep 2018 09:23:24 -0700
Message-Id: <20180920162338.21060-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
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

