Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2F5C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713F521471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tz8qvHp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJBHfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:39 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39920 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJBHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:38 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so1057558itc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bIT+tXwbFhC2CafNKpV0+tN2sDk8GJo0u4BK9sb0Eh8=;
        b=Tz8qvHp3hxRFPV0bnG5Hj58E41gyvJnQh2r8vAH0P1D9HJAGjJEa3X6evdDXXGuuAS
         gmRQFCMre0fPm25KWaO7GeovUmXyx2F365gyFoYts9mQ/5aZaFlCGJEYQrMNbNE4ELQo
         bTBSoKvA7W/jq34KzqhNGno+0vWrFevvrDdZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bIT+tXwbFhC2CafNKpV0+tN2sDk8GJo0u4BK9sb0Eh8=;
        b=TZqV4bjgTzuSsDAtr4jCQn4V3BadJBpMHw5SVeVNsz3ZRpUvrzjrkUtnWRQG6tcGpV
         EjbVwNBSXNK2TzMwAa99DPnZxLkkBbuhTxM50gN1U2uw14jx3KHCPnVd2jhxDVGOpsGp
         igM6AKSjjkumgvRAQpwsheP/CZGWPAwdivTy9205EZOGPfOUYiSD3N6WgcX5vo+4/gnd
         aMRs0bz5+HDCJr2EK35Z9+79UJT8T7klkN0tm5HWA6r8wR4PtRWosMYI0rTXPtD8Vqod
         NOH/eCHWDK1PjpAEH8VcINPqFI+A08OB1+zks44qjTbAafFhKQ4cgt0sZwQS9iZLw3Hl
         Yo7g==
X-Gm-Message-State: ABuFfojT0pbdHCnL7tHY5w2EwarKnwNA3Auh3F/AUAexl4h7rSU1/WEL
        XMeECxESljACmTA7ylEWeS0PWA==
X-Google-Smtp-Source: ACcGV60a/X/a9MvokUO2/Y1Oz2x2K9ojPHg9s7U5exN/J2alUEsp0qSlBZ4iMJWE05KUN6kxefI81Q==
X-Received: by 2002:a63:6054:: with SMTP id u81-v6mr12048973pgb.74.1538441710527;
        Mon, 01 Oct 2018 17:55:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r1-v6sm20166862pff.145.2018.10.01.17.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:08 -0700 (PDT)
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
Subject: [PATCH security-next v4 04/32] LSM: Remove initcall tracing
Date:   Mon,  1 Oct 2018 17:54:37 -0700
Message-Id: <20181002005505.6112-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit 58eacfffc417 ("init, tracing: instrument
security and console initcall trace events") since security init calls
are about to no longer resemble regular init calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 892fe6b691cf..41a5da2c7faf 100644
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

