Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F33208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZnQPCYrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F33208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIPFwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36464 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbeIPFwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so5933690pfo.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZygDN+GKMdmfwM3rhwi50SUesxIf3Y1MGUgzBmc4P3E=;
        b=ZnQPCYrrvnEUrw1AEs1QnIOLhqnKniP2gEILD8MCwlx0ZIUjOJUOsWj19vTjRUisJf
         PcAPlkf1igpkEHCXtF3VUeLdQXPIy7id8V6CsjF9cm51Qv5C+xPHziYnSlPOAa4vfAMv
         oT1Di4yXwwMVFyOOOxKPhHn04g/apqO1L/ers=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZygDN+GKMdmfwM3rhwi50SUesxIf3Y1MGUgzBmc4P3E=;
        b=PNb/SO/uEz+mbF2Q946pZPw8RhSSueNIfumfg8z/mCX5BqYOQ/mAk8UaiTLIn9p450
         77lQD+aJeO/puj9W+CPPHx99Rm/9BUin8Yvre8aC4h5wpTT2hxlagrmHFeLm/GgsQzMK
         0+QebjLjXkBVnsxUIgmb71tO47TGi3yiPpWyN+b3+H/aKCqj2DQC+jfVeLhxnP2oCBgT
         EYlCoSAiyUfCCXyjQT1TiYXkxhM7wIcmGIuzPN2ZRVPZncldRk0/YRWGNz95nTrERIXB
         wpfIdqH2qHSb4fi+iPQTQGZ9Ud/hre9O3zNQ0rRY9wwfnC/K56iasqU9URhh4pmU2kuV
         2ycA==
X-Gm-Message-State: APzg51D8DgJqTLNoLAG4grOcV2/iHQJX1qV4ukNat59tM4+zKOklPKLv
        r/AZxJhMcLQzA83qK0zeAyJJMg==
X-Google-Smtp-Source: ANB0VdbP3het6oYARDPqls52ntBFd/SJ5yaE0lenr89A9qW1H2Hnk7ngoTORUUUYY31z3ST8ER57/w==
X-Received: by 2002:a62:c008:: with SMTP id x8-v6mr19211170pff.149.1537057878544;
        Sat, 15 Sep 2018 17:31:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s3-v6sm16246688pgj.84.2018.09.15.17.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:14 -0700 (PDT)
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
Subject: [PATCH 15/18] capability: Initialize as LSM_TYPE_MINOR
Date:   Sat, 15 Sep 2018 17:30:56 -0700
Message-Id: <20180916003059.1046-16-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts capabilities to use the new LSM_TYPE_MINOR marking, as well
as the LSM_ORDER_FIRST position.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 2 --
 security/commoncap.c      | 9 ++++++++-
 security/security.c       | 1 -
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0564153130c8..f2949744a5d3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2101,6 +2101,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern void __init capability_add_hooks(void);
-
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 2e489d6a3ac8..44e7a9260f89 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1366,10 +1366,17 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
-void __init capability_add_hooks(void)
+static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
 				"capability");
+	return 0;
 }
 
+DEFINE_LSM(capability)
+	.order = LSM_ORDER_FIRST,
+	.type = LSM_TYPE_MINOR,
+	.init = capability_init,
+END_LSM;
+
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index c6ca07fc0771..67532326a0ce 100644
--- a/security/security.c
+++ b/security/security.c
@@ -124,7 +124,6 @@ int __init security_init(void)
 	/*
 	 * Load minor LSMs, with the capability module always first.
 	 */
-	capability_add_hooks();
 	lsm_init(LSM_TYPE_MINOR);
 
 	/*
-- 
2.17.1

