Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5405DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAA6208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tf1ZTMBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAA6208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeIPFwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36744 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeIPFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so6029306pgo.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooUL0UzptcnBdxX1R2VjgwpCyouyAdeHqleI/GcdB9g=;
        b=Tf1ZTMBFd4yehERG+eoHASmfpTpolP9B/tda2lPrYfegaTZLOjGeleIVQqzOcdCQ7O
         R9OCWMjbGJG3qdpvG+Gf0um+sI7Ww0s1r9ndzWzRp3DKLxmVasG7UVsUKPccLh8+hK9u
         0+EpF03zYK9cWIdJDc9vsHLQn1qAJdJ/Ck61k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ooUL0UzptcnBdxX1R2VjgwpCyouyAdeHqleI/GcdB9g=;
        b=qvO+WLCQjF68gASk/id8fPr3RHxrHcG3WBFJnnKx8xR/opbgV/K1tIXVjH6itz/FyF
         22ScDLfw4Bkkoah+C3u4X/7lFf2P3ZnqEGxXPxqfOOF5CKC7bJ/OlApXjV4wphI5LCcs
         KxZVvte6vmvK+m+wA67t7uX2rBPZUcZI5m/0dWKXHsCbbIjRWbklR962M0YtVY/JOEGT
         qzXFMO2p13kP97qALKnudwGhhVRUn8hqxqjZYRMTr3HkgLzjXd+wCgl98ogupXFQWkD7
         lXQWZyuz04YsLXT9cUGbS9DQm99ubulm7uW3En2pQiZS48MR83E1c35hl+l5kCLNiVRy
         xXgQ==
X-Gm-Message-State: APzg51Asq5+lHz8uOMEjSfUVrPkp2vV5tnekoOBS5jNHtf3leOkFMQ1O
        4twQGzjvgIU7TGLhZe352vI9Fg==
X-Google-Smtp-Source: ANB0VdbWZ9c8s8j1sUQjCxqWqwP1maQw1nVS0V3ptqRUnYNgqz1LoDJsL04b20/GCVqusdhej3XzCg==
X-Received: by 2002:a62:d544:: with SMTP id d65-v6mr19236393pfg.107.1537057872047;
        Sat, 15 Sep 2018 17:31:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j22-v6sm13651495pfh.45.2018.09.15.17.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
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
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/18] LSM: Record LSM name in struct lsm_info
Date:   Sat, 15 Sep 2018 17:30:50 -0700
Message-Id: <20180916003059.1046-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ec3419b9b16f..a7833193e9e9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2045,6 +2045,7 @@ enum lsm_type {
 };
 
 struct lsm_info {
+	const char *name;	/* Populated automatically. */
 	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
 	int (*init)(void);
 };
@@ -2052,10 +2053,13 @@ struct lsm_info {
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
+	static const char __lsm_name_##lsm[] __initconst		\
+		__aligned(1) = #lsm;					\
 	static const struct lsm_info __lsm_##lsm			\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
 		= {							\
+			.name = __lsm_name_##lsm,			\
 
 #define END_LSM	  }
 
-- 
2.17.1

