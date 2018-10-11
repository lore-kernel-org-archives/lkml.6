Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DD520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rf67tOqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DD520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJKHnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33627 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeJKHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so3288120pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IXAQXo8qYO7Phx51B4l5S6pXkNyNEOESCjmeHP9RP9w=;
        b=Rf67tOqoUk2qHal3un5WTqorj29nz8AyKs5MTTEF8x/ZfGgp9Nevu8RGAZlQ3thhwM
         RsbieZUz6RIPFR4ToLKiDTjetcZ8NmL0RrCp4Q4IJ0zOxVW40uKTVHXssxD8mWTvosDg
         wSQUDbSMKBxoKaeExNhjMwZKiiBj1hzae12BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IXAQXo8qYO7Phx51B4l5S6pXkNyNEOESCjmeHP9RP9w=;
        b=mEGD9Z2I6baPP33HWDW9WHkfO0/aidjI32dz3tPnW+TRvn40Mx8Uf0I/03GlM8uRsO
         uy0UAaTl2J0VpY1YZzCRPa/Zb2fjupXYB40+M0IU0i+x4Mt+s1zGZFGhT6nOweyIFtYT
         TQ2jujvLuMD01Rw4N6NlI31i7tsdzqmR8cstpx7l1mgyb+8dD/An3Rk4jmml4NM6QTxX
         /UpGKuvNKxUiUqc7dCWB25bXtXN18/pr/yuH68TDZeFeBRJnxlJeQKtFaxxDtbFhj3eR
         F4kVUFvDflBIPOEIeZjzBuWu1ADxvixvPxH0nNerPv12ONJTimwXCy6XRq/h/I/spAOs
         jidQ==
X-Gm-Message-State: ABuFfoj3kR9txOVfTXEiH+u/fc5Rt45KVKJ3DgsdPyZkf/Irhivjfe12
        0jYto5aqUZ/XYNM3oodfVRJwvg==
X-Google-Smtp-Source: ACcGV62RnoIOY3KKCh95g2kCjaBGDIMamXtAwijS3CkXs2DJ/nhOB3RRG/aRao0uxVeExnhiIBxB7g==
X-Received: by 2002:a63:a54f:: with SMTP id r15-v6mr31775160pgu.176.1539217136621;
        Wed, 10 Oct 2018 17:18:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t85-v6sm33788445pfi.73.2018.10.10.17.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:18:52 -0700 (PDT)
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
Subject: [PATCH security-next v5 01/30] LSM: Correctly announce start of LSM initialization
Date:   Wed, 10 Oct 2018 17:18:17 -0700
Message-Id: <20181011001846.30964-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a while now, the LSM core has said it was "initializED", rather than
"initializING". This adjust the report to be more accurate (i.e. before
this was reported before any LSMs had been initialized.)

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 736e78da1ab9..4cbcf244a965 100644
--- a/security/security.c
+++ b/security/security.c
@@ -72,10 +72,11 @@ int __init security_init(void)
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 
+	pr_info("Security Framework initializing\n");
+
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
-	pr_info("Security Framework initialized\n");
 
 	/*
 	 * Load minor LSMs, with the capability module always first.
-- 
2.17.1

