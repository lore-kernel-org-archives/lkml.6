Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FFEECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B985208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jh/fYOru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B985208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeIPF7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:59:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34044 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIPF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:59:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so6037483pgv.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2uODomYPzcjoTQQPESLleriIuqidQ5xqsN+C5mdVLUU=;
        b=jh/fYOrus0NcGv3zrDb+DvAW8rZwHjKGZcKpIKMJuLsff/l5JVlANpaOP070W9VMG8
         1UcOtTzXPlBDj7MfFCEPXQNWkZ0ZwX9D6yR7N1XDv6cxPRjQ1vfuqZqKeYPJ+PL6pgUn
         FqDdizPT+5O1jjmaSB2TS8cE0cPDgFTrVouNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2uODomYPzcjoTQQPESLleriIuqidQ5xqsN+C5mdVLUU=;
        b=Lb4MGnVHa1Syfkkz/XDszNt4Oz4wX/Mr7MW5SJ4FnuV2uV5UwkR74F/PP4/RC1nJPA
         IXTL2zHwuabDYlRxM6LQpad6+LWKhqZ6cmOxagA1AcO2WH3HcfIl4zBnnChvJbLJovrv
         ZZ9ksHr9/hturWdoxRSaSh+/ux0GvA3TjVTxpnZzWytjFb3dP1bEBBf60aO6euchUzhO
         Is8S0cQUr7pzwL3JEjHYS70zQ6UjOGDoNN3KOA04TIyuZmj70uq9jCrGltKT3qh86esr
         8K5PeTPoPtl/ZIytDE8LYnQQTpHeLyt3Xff5gOQsXApHdJy1s2fdJnrnS+QbfgxZ7O2a
         dLMg==
X-Gm-Message-State: APzg51DY6XZasQ/2/AOT4zyIVKTPCgZPu9zjJLh+zTzjzYf39ak6lkuL
        qd5zP9XxT4ghd94BX3oy5YBh9w==
X-Google-Smtp-Source: ANB0VdaLFr+t4RZrdeBw08gmHeu1924582FoaTeMwO3RjRxuIKCp1Zkl4V350pfuWSOg5TwBYktKPA==
X-Received: by 2002:a62:2c53:: with SMTP id s80-v6mr19015526pfs.154.1537058331240;
        Sat, 15 Sep 2018 17:38:51 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 5-v6sm14160058pgc.86.2018.09.15.17.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:38:49 -0700 (PDT)
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
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/18] LSM: Don't ignore initialization failures
Date:   Sat, 15 Sep 2018 17:30:59 -0700
Message-Id: <20180916003059.1046-19-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM initialization failures have traditionally been ignored. We should
at least WARN when something goes wrong.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 3b84b7eeb08c..a7796e522f72 100644
--- a/security/security.c
+++ b/security/security.c
@@ -203,11 +203,15 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 
 	/* If selected, initialize the LSM. */
 	if (enabled) {
+		int ret;
+
 		if (lsm->type == LSM_TYPE_EXCLUSIVE) {
 			exclusive = lsm;
 			init_debug("exclusive: %s\n", exclusive->name);
 		}
-		lsm->init();
+
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
 	}
 }
 
-- 
2.17.1

