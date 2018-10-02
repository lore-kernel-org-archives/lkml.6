Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C2C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639E721473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVblWbAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639E721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeJBHgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:36:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38072 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeJBHft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:49 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so253194ioc.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K8Z4hRQ9RjNB3cw7dID4X7rT0mlxEqRr67feJ2NB/9c=;
        b=LVblWbAN149pKjvi/TQyVOztj+MqZCELBs+pFQ9zZZ3rdPQ6OerOCyG+HZhHoBDDjl
         1NVwR//kQ8OUuQWlwoAJ4UCW8/0/iPcqdVvmX1BNm/AeUZa1CEUyYmx5vPGGuWpXyxW9
         +ZAoaVcHw740JE62LbcteksEmFJ+XduA8WsdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K8Z4hRQ9RjNB3cw7dID4X7rT0mlxEqRr67feJ2NB/9c=;
        b=E8+YTHblWAezk6D4kCsj3o31Q2QSzNhX60gdaUMDkfSbKGg79ZAPt04KLh7ScY+wOZ
         vY7W+rGZaVFyuX2KnvTA3mnAedW77lbX9G2CLaXIFRRDl0TZdv7r5K8PfU7R054TEHQn
         XqrbW31XxCezAPMf7pYsGxuKbR/hBsMRyRR2btzvFvTo1NN1UcQuY4OUHzPHGVCy6yPx
         2pDyZzTvHHtTNVGi7mVdjKcRIlM49y3rs7A+MZPvOW54AWP66AiO3t8RKGH1XND4h1EI
         7H8wAzIojUds81V5gJ+6pEcOwHFPavJwmt2894iYBgO6oU+FfykJIPAigIeeuL4wlYHq
         hQLg==
X-Gm-Message-State: ABuFfohDp/ijkNTGmYykU60VagrzokVIt3abo44gFhJSQnPxBm1WODad
        e1X7Hu+KPxAhcJsdVndGwbPV1Q==
X-Google-Smtp-Source: ACcGV61Yh5odpPljfpf/x5pe7VMxniMUxoCMKTJVM9vJoaM2HKQGI3bYyKYfYszwYr7bvyCBRp8WpQ==
X-Received: by 2002:a62:8490:: with SMTP id k138-v6mr13802325pfd.177.1538441720500;
        Mon, 01 Oct 2018 17:55:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z22-v6sm19576710pgk.21.2018.10.01.17.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:16 -0700 (PDT)
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
Subject: [PATCH security-next v4 12/32] LSM: Provide separate ordered initialization
Date:   Mon,  1 Oct 2018 17:54:45 -0700
Message-Id: <20181002005505.6112-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
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
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/security.c b/security/security.c
index 2055af907eba..ebbbb672ced5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,12 +52,30 @@ static __initdata bool debug;
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

