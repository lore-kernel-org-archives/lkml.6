Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811FE20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SnJL19in"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811FE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJKHnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJKHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so3267003pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O55DFeS8ueFeZRsonWfjwV1xQL3qE86rj2SxIpnAmMg=;
        b=SnJL19inC1A4uT1F9hK0NVjaJHzq4ikuhyvQZjAdgvEZYbYPVBYF99u+kezQV7YvtS
         TRWhdqZoJNOwf1Xr5Vmkq1dYyTLwe1OnOzAs9UWA2CZooDhUDac9UEaTwJDdOEdoe9rZ
         r7bJlN7WfZYwNT3zKh6fTEO4BS3805PxuY51M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O55DFeS8ueFeZRsonWfjwV1xQL3qE86rj2SxIpnAmMg=;
        b=CarICtvftEzJ9qRxsyKpr/K5mQsBWIfFMg9dCU1RBOU/9XxRx5ChmMVhsKwaKexTek
         1uwH9yRArNEqpnDX/kpNQ25qv1L6lz6JuQewoVjLDNh83500sKjVYjCq5QEvw+XjrNbC
         /X0EWHBPx5Ycj3Pyht0kgmN8cVci1HDaeJs7ZQJ8Utj8YxpPDZ3w+bEXl55B7ldlItAk
         Fan+L+dCOiz0bBbjXVMRYqoyzFtAUj5nbyAy5PhBOkKowKexli2wmOaGxpACm7bQIQHv
         kSvF4YXXvf4Ae22hOGcbN+b4pzSbAkS9+WBaMKovPr34S87ZEp+u1tOHevfEapkpQ2um
         iVhg==
X-Gm-Message-State: ABuFfohHev7Crgc51UxkW7EcGD3smq7Xda862FuTLfLPBDE2QDQe8hBY
        RTfKJkExIrMWheIsCKK3qSX/gg==
X-Google-Smtp-Source: ACcGV62ySqYROrB5LLeSkAniSEvUin/jAQUthu9Z2hI8/66fd8ozoSTiVrhYKRl/r8/5x5QALVqtXg==
X-Received: by 2002:a63:fd09:: with SMTP id d9-v6mr32277270pgh.164.1539217144391;
        Wed, 10 Oct 2018 17:19:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b3-v6sm40544422pfc.178.2018.10.10.17.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:18:58 -0700 (PDT)
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
Subject: [PATCH security-next v5 09/30] LSM: Provide init debugging infrastructure
Date:   Wed, 10 Oct 2018 17:18:25 -0700
Message-Id: <20181011001846.30964-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with "lsm.debug" will report future details on how LSM ordering
decisions are being made.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 .../admin-guide/kernel-parameters.txt          |  2 ++
 security/security.c                            | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..32d323ee9218 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2274,6 +2274,8 @@
 	ltpc=		[NET]
 			Format: <io>,<irq>,<dma>
 
+	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/security.c b/security/security.c
index e74f46fba591..395f804f6a91 100644
--- a/security/security.c
+++ b/security/security.c
@@ -12,6 +12,8 @@
  *	(at your option) any later version.
  */
 
+#define pr_fmt(fmt) "LSM: " fmt
+
 #include <linux/bpf.h>
 #include <linux/capability.h>
 #include <linux/dcache.h>
@@ -43,11 +45,19 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static __initdata bool debug;
+#define init_debug(...)						\
+	do {							\
+		if (debug)					\
+			pr_info(__VA_ARGS__);			\
+	} while (0)
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		init_debug("initializing %s\n", lsm->name);
 		lsm->init();
 	}
 }
@@ -91,6 +101,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Enable LSM order debugging. */
+static int __init enable_debug(char *str)
+{
+	debug = true;
+	return 1;
+}
+__setup("lsm.debug", enable_debug);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1

