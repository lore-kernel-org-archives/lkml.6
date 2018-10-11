Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96833C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA8A20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h8CSwExu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA8A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJKHoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:44:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJKHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so3433502pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfu2i5vCbLXUhEgxVTjIKQVSKkT0aaheZInMAAU7pCg=;
        b=h8CSwExuRPJDsJrDiwuXEIyychgJe6pkvqcLZBNNK8I35pEFBC2JDMH9FmbCB5c4Hh
         2XqMoTa2jXCGVupBPQtfabThLm2M/nFsf9gez6PimPn0zhmC8QU6Ij9PGuhRlp60+KYy
         l24DA0UBAjTpm3PNbqWTTD4YzjRpiIPoV0N2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfu2i5vCbLXUhEgxVTjIKQVSKkT0aaheZInMAAU7pCg=;
        b=Ht35jlYIwjyQt943LP2f68UMMjhg55RXdYY8mYYnEsqBRzRQTao/Mnu8OUwwJJY13a
         IJgLfbe9LwK0YybETdPDB2PA3hsr7axah8Ggf7oyWIgkuaLsvAyCZNw4QtB7ieli4GJu
         FQ01qP/ah7W9l4qI8E8o2AF8HQuvf91MJ3w7VycVppxFt3gsT0fMOMsyaBmtSJcIb4Pk
         zBcFfJLl5/8Df+bE0VsngjRYxu6erukDz3gdrh7qirSG6L/s/I2C58Y3tlo8eih+fMjv
         NuGT3BTY5umGttItrtVcXgz8bNGDRKgocKd+wTd1BElrM/cy7uhtHVBZqDgHWQyO4YJf
         eagw==
X-Gm-Message-State: ABuFfogOYMd/0kGI/YnoRO4a5Qv15TTDUshYBWvv/7tVUPRN53HPSgD+
        oUsvWPRbAJnAFWJXAqrQd3WeAA==
X-Google-Smtp-Source: ACcGV63prjsFPCaTcde6dqOws5c/V8PiRq37SDg6xRRo82yu+prgVvu9t7835fjLP2q7ILQSj1HJJA==
X-Received: by 2002:a62:ccd4:: with SMTP id j81-v6mr37703628pfk.76.1539217142740;
        Wed, 10 Oct 2018 17:19:02 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k3-v6sm73024605pfk.60.2018.10.10.17.18.56
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
Subject: [PATCH security-next v5 10/30] LSM: Don't ignore initialization failures
Date:   Wed, 10 Oct 2018 17:18:26 -0700
Message-Id: <20181011001846.30964-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM initialization failures have traditionally been ignored. We should
at least WARN when something goes wrong.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 395f804f6a91..2055af907eba 100644
--- a/security/security.c
+++ b/security/security.c
@@ -55,10 +55,12 @@ static __initdata bool debug;
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
+	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		init_debug("initializing %s\n", lsm->name);
-		lsm->init();
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
 	}
 }
 
-- 
2.17.1

