Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899F3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E062098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4TLlttf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E062098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeIYGXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIYGXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so10097974pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qTlAiVyKmDi3nh8j1vnhRyGyfYh9dCrYAglaiQr2kEE=;
        b=Q4TLlttf9SWn5R1kA4WKpqdKlAuU/moC7pj+yvqlTzhZ9TjtdSCLF5usqIPtccSGoi
         OZy0pj6ErE+sjgLo47Aab7JIt8McPZewwEjok1ZFsQKb8RuaobSqi5WmzDB4ZMNZNU3u
         kOTs9NQ4HosS561qozeDshv+3XH966lxETk+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qTlAiVyKmDi3nh8j1vnhRyGyfYh9dCrYAglaiQr2kEE=;
        b=sPGmcR2sS51SljhEDFBAMsAVFGruAMBos3jwvgbT7BezCzRD6DRWq63Z7Y2RftNMrH
         Kt+AWdr0syxZ9UNCrWDr/Up9ZMr7qar18awvu3UU8tBej5Ufu+K9d146dpaf9FFVoaNg
         qXm6Qeo1mjxv5HTjtvVDongJVBF9TgCk/fBxtssyQG1rlbgPG3myXVqkMyJ8Qc8Jyn6m
         y6GQ3ksYpDbLUmb5DzulsoGSB3wXXNZKJy+81KLykrtZvHGzf30AX2lvrLUW/V+w5yMu
         3xSKZTdrxb7a15e6GjqwGk2m6RKlX1xQ6I/n0QxdUOxZ93nZIPaL9yy97xBuCedws/Df
         3oqg==
X-Gm-Message-State: ABuFfohUeS1cqnOIlyN1DLGRVIHGYRNBPj78vVsw9+wfp9Mg1CZx+FeO
        qi5YundNtWSmpnlvtDNatLYDMaDcQl0=
X-Google-Smtp-Source: ACcGV61BbY+qRvMi0uguvVPD4XNfbPTK2hiuRCRimHQGsL2x+DlosRZLJnDT4FbWIxBqTfLYeiTjLg==
X-Received: by 2002:a17:902:509:: with SMTP id 9-v6mr286688plf.155.1537834718469;
        Mon, 24 Sep 2018 17:18:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f184-v6sm594491pfc.88.2018.09.24.17.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:37 -0700 (PDT)
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
Subject: [PATCH security-next v3 01/29] LSM: Correctly announce start of LSM initialization
Date:   Mon, 24 Sep 2018 17:18:04 -0700
Message-Id: <20180925001832.18322-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a while now, the LSM core has said it was "initializED", rather than
"initializING". This adjust the report to be more accurate (i.e. before
this was reported before any LSMs had been initialized.)

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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

