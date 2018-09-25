Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DC02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQGOY/Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DC02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeIYGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44626 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeIYGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so9913976pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcnxUGdM4FO17eHYuUfeuK9JPR89ogJMNeQRUezwAjU=;
        b=AQGOY/Zdh0wpfhlnTaQch+gsKeEk2rOe2ektyYESqmESf62tM1EDmSsoYn5JLLhMdK
         9JTT3o7hxp+V3R+MkaEoprJW2RdJp6xsOqZiUW+kkUTc+7yXMlxIUNZ99LlmGuyRWG1I
         BZNXLBlfyMJjcLD/IL+KADS6U0NNut/sGwkw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcnxUGdM4FO17eHYuUfeuK9JPR89ogJMNeQRUezwAjU=;
        b=dhSZ/NcLWu7ir6nCABQhyOWeHzpjjQcnpdSrKgJiKHZELeTi3i4JZdFy1ZfsLEk/MW
         1vkSc/57XYSpVkMYHKomLJtAzVmnLYjhU0knvlmE6whPQVNlb99dPEzdXveTO+2ODdJG
         4AJ7YpuElEsfeZrQZQZ44KzKyINSY9F8XBm27lUEDDUU4tFiqzVMNFSN3kvZKLskTBMY
         K6kwlssMYjAVbi9ks5soYDA70NWLafRdVPbsN8VbVQc7E9TBwj2JdAY7YYxfg3uHwAF5
         o9XVM+pPeJmMSpfK3Gi/ID1IWYiA8HvWPcvjMwq7d3qgF7IOE0irRm79Ucxm12P0q9vz
         3Mgw==
X-Gm-Message-State: ABuFfoggW/aSLc+U94uc1vq2nOuvvidMQSSxKu4OF1MauhFBajdn7vOf
        il5n0mgvHgiQLe3H2dKR+gbp7w==
X-Google-Smtp-Source: ACcGV61HtB92YOXRXmkR76dq/+KIjtfUVl08OEqnkPLog6Kn7C2bYotCF2Fw84bvv1/Jn61is2xzkQ==
X-Received: by 2002:a63:e918:: with SMTP id i24-v6mr992063pgh.64.1537835119019;
        Mon, 24 Sep 2018 17:25:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g15-v6sm562058pfg.98.2018.09.24.17.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:25:16 -0700 (PDT)
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
Subject: [PATCH security-next v3 19/29] LSM: Prepare for reorganizing "security=" logic
Date:   Mon, 24 Sep 2018 17:18:22 -0700
Message-Id: <20180925001832.18322-20-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the string handling for "security=" boot parameter into
a stored pointer instead of a string duplicate. This will allow
easier handling of the string when switching logic to use the coming
enable/disable infrastructure.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index 456a3f73bc36..e325fcc41f00 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,18 +34,14 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
-
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
 static __initdata const char *chosen_lsm_enable;
 static __initdata const char *chosen_lsm_disable;
+static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
 
@@ -112,7 +108,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 		return true;
 
 	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
+	if (strcmp(lsm->name, chosen_major_lsm) != 0)
 		return false;
 
 	return true;
@@ -191,6 +187,9 @@ static void __init prepare_lsm_enable(void)
 	/* Process "lsm.enable=" and "lsm.disable=", if given. */
 	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
 	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
+
+	if (!chosen_major_lsm)
+		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 }
 
 /**
@@ -231,12 +230,12 @@ int __init security_init(void)
 }
 
 /* Save user chosen LSM */
-static int __init choose_lsm(char *str)
+static int __init choose_major_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	chosen_major_lsm = str;
 	return 1;
 }
-__setup("security=", choose_lsm);
+__setup("security=", choose_major_lsm);
 
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
-- 
2.17.1

