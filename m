Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47CC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A9F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="djJNATBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A9F20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJBHpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33247 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJBHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:07 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so304600ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2PrWkBQw+7KkRjKU4t11PQdbbEVewWsM4UkLQzJpM9s=;
        b=djJNATBLK5z3FwGJIzUXfO8/Y8qnE+FM0+JLbKssnzbHrYKr7+A7aUTRjC5+WJyO/o
         46QlkC9qA/1C/Z6Hl5gAetM6A6/U+mI3ekPs9G+sbFqsvQFubUbhaIpKJEO1kDmqaub1
         sO2ESHy4N82d3uanV3/rwTJca9ADxT52XtbtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2PrWkBQw+7KkRjKU4t11PQdbbEVewWsM4UkLQzJpM9s=;
        b=R5p0GvPLUWKBoNbKmS7XAuFPKsBQf3yjfcfxCFKwVUU+e1W1OgDkbfjqdsZOMt7sjv
         a3dTnWHJTNXWlwwMpLak0zN3TfOLcNtUiXz5v3ZfQbmjpWgcJcmg7MzJWln9Zw4ksoOg
         jRZyQ/aUeZLMuEqh/5R4XMPFfhm4k4toIC/f+Ol+bVsRQD0I0zwILKYxfII+Ip7GsQuT
         x6s7nycNuvDHIt+7XE6ankxp8vzSXwpXkN8fTQT5mD7Rxs0ZBoyyhfoPLDHDnRp52hOQ
         9TiVqaB0XptebQAXZ+qPZR7s6pkm9vJWIdCkghHT1FJkEDtnZmp7mSlKU7z3aWW410kX
         wyUA==
X-Gm-Message-State: ABuFfogWbOvOvrfUKeX9zAHqoiBC76+Z2hHuGrV4pLvALjtQJWG27JDc
        Dddv3u38S4CB/aacT3BhOlRYyg==
X-Google-Smtp-Source: ACcGV63bDwZzJJS3BKhoNCrEgeBXlTv77oyYZaw1nKc7t/drdZeqwt9FHKZQsuk8tDWLhjHZFLMN2Q==
X-Received: by 2002:a62:c957:: with SMTP id k84-v6mr14049139pfg.205.1538442275676;
        Mon, 01 Oct 2018 18:04:35 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h5-v6sm12219070pfo.135.2018.10.01.18.04.28
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
Subject: [PATCH security-next v4 28/32] Yama: Initialize as ordered LSM
Date:   Mon,  1 Oct 2018 17:55:01 -0700
Message-Id: <20181002005505.6112-29-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts Yama from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 5 -----
 security/Kconfig          | 2 +-
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 8 +++++++-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 098ccf2caa0e..63a6caaee8e6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2086,10 +2086,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index e59cb9296316..c459d2b4c7bd 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -293,7 +293,7 @@ config LSM_ENABLE
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "loadpin,integrity"
+	default "yama,loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/security.c b/security/security.c
index 6957f5f50483..44c23d23158e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -296,7 +296,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..eb1da1303d2e 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -477,9 +477,15 @@ static void __init yama_init_sysctl(void)
 static inline void yama_init_sysctl(void) { }
 #endif /* CONFIG_SYSCTL */
 
-void __init yama_add_hooks(void)
+static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
 	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
 	yama_init_sysctl();
+	return 0;
 }
+
+DEFINE_LSM(yama) = {
+	.name = "yama",
+	.init = yama_init,
+};
-- 
2.17.1

