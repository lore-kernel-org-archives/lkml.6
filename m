Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAB7ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539EA2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxlBTDbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539EA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIYGXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34730 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIYGXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so10129199pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4wsyr1NZn56YkQKjbjGcHjAWvwN5RbGtjsBeVsLDNU=;
        b=bxlBTDbgLZnuGDjbn673OVHYRF9df9W7Kt9ZUSjmDGl8IBbhkXqXfhXZUPKX1IR9a9
         wM58T7WMa4Zdl5QYmIQYFEaXzxK5RbTySNQ8ouMoeo+iVZuYzwu5hGQCvT/R77MXAzCp
         tNbtkA9iR5U7c48VWJ5CC67CtxMoohzURkOio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c4wsyr1NZn56YkQKjbjGcHjAWvwN5RbGtjsBeVsLDNU=;
        b=kra2cYWgIc9Nv42S19gipSppDXbOkp+cHJih4W1aeWVRlUQqEaHp5Uc7wOqgpnHIXl
         xqdndFbCqFX1HdkjnE30DkX0goLpmsvlaU9whdr1vnQKGBxjvMbnHnjz/MQeaFSOlNgP
         qzirkbtaPgnTbx4VLs+OJ8niQoRRkTcNIA0a5Q1coI1PVAvcr12Y7mjTTy65kMykb/tu
         1Vfkh41Lh7GOij+kO+Ka+eeVeNIXrhTW30DV8m0iOPYpqBTy9ZjAcB270O1avD16lB97
         bUCNjTn88MP0QGUn9qcF9o1OhWU7KQBYG25IGtfJnZeLZndtB7oXCibsXIofW5Pdt93n
         tpxw==
X-Gm-Message-State: ABuFfoi3ydtxFtG4bVsUT8CmjmLPr4GKZ/isHaa+8BCrEEj9QUG6O6W1
        rGSMsriaCZD30Rwe3rCg9S+qKA==
X-Google-Smtp-Source: ACcGV62ClFJfkD5dKmLg1O/5PQBsQ/21CN+/rBLxS+fFLVuAfwqKT3a3XEWOg1f9MkEy+JCioBzO/A==
X-Received: by 2002:a63:1245:: with SMTP id 5-v6mr882047pgs.299.1537834725518;
        Mon, 24 Sep 2018 17:18:45 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o17-v6sm520730pgc.30.2018.09.24.17.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <james.morris@microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v3 08/29] LSM: Record LSM name in struct lsm_info
Date:   Mon, 24 Sep 2018 17:18:11 -0700
Message-Id: <20180925001832.18322-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Cc: James Morris <james.morris@microsoft.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 02ec717189f9..543636f18152 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,16 +2040,20 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 struct lsm_info {
+	const char *name;	/* Populated automatically. */
 	int (*init)(void);
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
+	static const char __lsm_name_##lsm[] __initconst		\
+		__aligned(1) = #lsm;					\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
 		= {							\
+			.name = __lsm_name_##lsm,			\
 
 #define END_LSM	  }
 
-- 
2.17.1

