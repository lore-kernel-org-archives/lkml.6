Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCCECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB44E208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dbo5EBYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB44E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeIPFwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36456 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIPFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so5933600pfo.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jb16JJKYPrUkwwf+IIiV9x2fMWSaJBPCjHmkUCeoEUA=;
        b=Dbo5EBYAImPBD30afpw2UwkLCmYG0+qSGkSoO1j88KP43fd8dvD1lMtqISHtIwgDLP
         owuLG44J3rybcFPZaeQTsbn1XY7Fykn93fno4oHTrcUJ9ZrZTd1zQBsw0a0CiXgWlKu1
         F+5wDsTeC1uRGsiqOoBYEKBfRd5O7wCmyT5tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jb16JJKYPrUkwwf+IIiV9x2fMWSaJBPCjHmkUCeoEUA=;
        b=kTFmDEWiqanJqf8ucdmHyb8uCs/fec4WVAACPIwskEOieCZGfj1BsiWmjLT211z7Zr
         7+yqGG3xTzmRI3VXPkoQtzEfEyK9ZYDONmSpn5UYXJc37JIKj2n8LshtvTZ7aSbywutT
         q1XtcF2EcUtmM2rafFq2kaxgM/m2B3D5F/w0cCPXmHjw1JfeXWM2v1I13YMjHkmq5wLy
         dPuqeMEw2+jrlyiIK/JWMl7nUyQN6UbjQwfj8PTxiURtXQXo7UsPjbPpraKgyNXdGbuu
         9pKhwQX2FL4tEPAc+4pMU5uPAv0+evm3MJkcaTn5fGqeqhtB6i6+VZFVZjdXkECvlu56
         +scg==
X-Gm-Message-State: APzg51BEgZe3IzKkzZrPDa421P55/NUpP3yRchrvE5Td8UacxtwTQ7P8
        Y4GBFab8Svs4d36oGZQHjKtglg==
X-Google-Smtp-Source: ANB0VdZCrHk5TTxNgXYNU4F2E1hFoHAgchTPyT3QaN70sMbcGo15nl2AR6knA9I6gLFFDVYPvngAhw==
X-Received: by 2002:a63:6385:: with SMTP id x127-v6mr17867638pgb.413.1537057866487;
        Sat, 15 Sep 2018 17:31:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w5-v6sm12814326pfn.44.2018.09.15.17.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:03 -0700 (PDT)
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
Subject: [PATCH 03/18] LSM: Remove initcall tracing
Date:   Sat, 15 Sep 2018 17:30:44 -0700
Message-Id: <20180916003059.1046-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit 58eacfffc417 ("init, tracing: instrument
security and console initcall trace events") since security init calls
are about to no longer resemble regular init calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index d49d5ff8be4b..913eb73ff3f9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,8 +30,6 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
-#include <trace/events/initcall.h>
-
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
@@ -47,17 +45,13 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
-	int ret;
 	initcall_t call;
 	initcall_entry_t *ce;
 
 	ce = __start_lsm_info;
-	trace_initcall_level("security");
 	while (ce < __end_lsm_info) {
 		call = initcall_from_entry(ce);
-		trace_initcall_start(call);
-		ret = call();
-		trace_initcall_finish(call, ret);
+		call();
 		ce++;
 	}
 }
-- 
2.17.1

