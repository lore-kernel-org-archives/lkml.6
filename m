Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7622CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6842098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DsyIjfnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6842098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeIYGXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbeIYGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so2107752pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gU8yPNVAJgM0Xsl0Xg5cYn4RlLsSLFMLd0v2DDJ1qcc=;
        b=DsyIjfnmbUEIcckKSghwPU6vbUtA3jFBt7UXg0nenJyyTmedsS/1ngyUfKFE3uSifv
         6L3u3gAq24e8/rqldOC3FwmzYXXN8NvXuASwSOrovYWebTiwfT7r4sRg8UivsYBScKb9
         eVlnvx/ruLqfPFRcXrZHXO6xD4nqtaLFlFC7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gU8yPNVAJgM0Xsl0Xg5cYn4RlLsSLFMLd0v2DDJ1qcc=;
        b=E5ioi/QW6TDd/NrHhp/39Kn3AZseks9vv9zLdcPYT1WRRNqAY4BNnIDBVMKzy0wXnO
         MIR+uot3LFtDvy3UBGW9FDOSivdwb5QPjOWciNA3V4J5Qn1NpgSJywi7Z2Z1szJwcPm1
         wn3ZeW+O0R1JZ/bQgB72JNVwfNmb7tFQERc7H/eIIqKy+LmXPjdFGIblU4Guwogc2jwT
         9kPEJTlwPqTrIVWdSJdIhva6iHMVyopefFp5u6yh6kCQq/3ZlRauzp9WZ9fmyZ1Hshpg
         om2n0dDjzt2TsxkfDcONM+kuc2XT+oXOq/lIo614d5dsRDS0BhZGn3Oug5fSjQnvY8ER
         bIqA==
X-Gm-Message-State: ABuFfojN80rV20UFimQEqtxrrDGZi7zShZtkhRTJXLNBrNyPtp6UucOn
        /vEXBE4OaH0kefT+LKvTxMzT9Q==
X-Google-Smtp-Source: ACcGV61G2pnFUw/Q4F1NXTTg0KFo8jl0iUqoLOz6In9fV1XKgsmQsPAANPdQEU1hs8nNzJ7dovGUTg==
X-Received: by 2002:a63:4281:: with SMTP id p123-v6mr907162pga.91.1537834735149;
        Mon, 24 Sep 2018 17:18:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v2-v6sm516945pgf.58.2018.09.24.17.18.47
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
Subject: [PATCH security-next v3 23/29] LSM: Introduce "lsm.order=" for boottime ordering
Date:   Mon, 24 Sep 2018 17:18:26 -0700
Message-Id: <20180925001832.18322-24-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a way to reorder LSM initialization using the new "lsm.order="
comma-separated list of LSMs. Any LSMs not listed will be added in builtin
order.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 security/security.c                             | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 67c90985d2b8..c7c1a0d253ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2288,6 +2288,12 @@
 			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
 			boot parameters.
 
+	lsm.order=lsm1,...,lsmN
+			[SECURITY] Choose order of enabled LSM
+			initialization. Any builtin LSMs not listed here
+			will be implicitly appended to the list in builtin
+			order.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/security.c b/security/security.c
index e38df0314f5e..f1c3581d870f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,6 +44,7 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_enable;
 static __initdata const char *chosen_lsm_disable;
+static __initdata const char *chosen_lsm_order;
 static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
@@ -160,11 +161,14 @@ static void __init parse_lsm_order(const char *order, const char *origin)
 	kfree(sep);
 }
 
-/* Populate ordered LSMs list from builtin list of LSMs. */
+/* Populate ordered LSMs list from commandline and builtin list of LSMs. */
 static void __init prepare_lsm_order(void)
 {
 	struct lsm_info *lsm;
 
+	/* Parse order from commandline, if present. */
+	parse_lsm_order(chosen_lsm_order, "cmdline");
+
 	/* Parse order from builtin list. */
 	parse_lsm_order(builtin_lsm_order, "builtin");
 
@@ -324,6 +328,14 @@ static int __init choose_major_lsm(char *str)
 }
 __setup("security=", choose_major_lsm);
 
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm.order=", choose_lsm_order);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
-- 
2.17.1

