Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616AEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC03214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="O9T76Xx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC03214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeHVOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:24:44 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37824 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbeHVOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:24:44 -0400
Received: by mail-lj1-f169.google.com with SMTP id v9-v6so1109609ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwAmXHn+OcU5IqUJoOuP/J1m7ew5O3BBQGtvvhwIDFE=;
        b=O9T76Xx5DKbhQU4v0kO3AfC656Ia+Odl9DOSdXw3WTvhsaMt3buGyTcwXe28MNUJ25
         xIBGxy3cbup/bJD4/lRTCEas+m4E85DYPDyJoP4J6OQFFS/pgnQPVDFXoUIXVPUEzN1x
         PF06gZNGlA+/p3DHs+VRiWop0+tTiAxJ/vZZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rwAmXHn+OcU5IqUJoOuP/J1m7ew5O3BBQGtvvhwIDFE=;
        b=hYoRHrj++dfGd0iWqBrdhzc/nftgs8tMtnd566X98T2C/JVj5FdhTT6dVBR3kyPZ5t
         5AcYqJQBXc0It5ZEm7U3L28xMZL1B7k7Au3n+SJCg4hT022lJYw/zU/kudbC9sX751BH
         OEqHv0IaGnFuB/TgOXghjUSYArvNIjuNn4gO1DdEQfBkj4LKvIIk9KzFIjGWNRDuu0ic
         uQpyThKSBDwz7DxingFU34CfacoByyI0k/MF0UETEg2bZTrozwWdCsuqNWiJHWCGvaXt
         DRQMpu0lGStOYmzIVP6JgFfSkCymyx+Oo8CBvX7fHU8gbMAbt1s/4QYSQ37iAf7AEjYu
         zO8g==
X-Gm-Message-State: APzg51Dyk3NOi3hknyCs5kun9yt81/YA5eXM/WLfcoib0UZ4GPgQNMoJ
        GsHjTQVgVqrApSaiwnYKUsy2aw==
X-Google-Smtp-Source: ANB0VdZCLRaFfPPkK9S9rv7fGuEgFkf+UTa6zOVfbRf8pV62GdJvWWlWk38twY5pQud9GmsWSdhSOg==
X-Received: by 2002:a2e:8652:: with SMTP id i18-v6mr1848976ljj.43.1534935617742;
        Wed, 22 Aug 2018 04:00:17 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y5-v6sm234273ljj.75.2018.08.22.04.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 04:00:17 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/4] kernel/, init/: avoid const-laundering warnings
Date:   Wed, 22 Aug 2018 13:00:09 +0200
Message-Id: <20180822110009.17583-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
References: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though str*() launders the const away for us, we should and do not
modify the buffer through the returned pointer, so might as well declare
it const.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 init/do_mounts.c | 2 +-
 kernel/module.c  | 2 +-
 kernel/params.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2c71dabe5626..6eea8bfc8f82 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -122,7 +122,7 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 	struct hd_struct *part;
 	int offset = 0;
 	bool clear_root_wait = false;
-	char *slash;
+	const char *slash;
 
 	cmp.uuid = uuid_str;
 
diff --git a/kernel/module.c b/kernel/module.c
index b046a32520d8..8d7ead11a10f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4061,7 +4061,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 unsigned long module_kallsyms_lookup_name(const char *name)
 {
 	struct module *mod;
-	char *colon;
+	const char *colon;
 	unsigned long ret = 0;
 
 	/* Don't lock: we're in enough trouble already. */
diff --git a/kernel/params.c b/kernel/params.c
index ce89f757e6da..8744aa1e7d8f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -816,7 +816,7 @@ static void __init param_sysfs_builtin(void)
 	char modname[MODULE_NAME_LEN];
 
 	for (kp = __start___param; kp < __stop___param; kp++) {
-		char *dot;
+		const char *dot;
 
 		if (kp->perm == 0)
 			continue;
-- 
2.16.4

