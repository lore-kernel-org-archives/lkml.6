Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1DECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86CD21508
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDUrBOFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86CD21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeIYGZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:25:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37311 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeIYGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id c14-v6so113914pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=grdTh6jgWyilD8yd1ADEbK7C00utpPYIiWkMyo43GXU=;
        b=WDUrBOFup3bgS3V1x1Go6KM1/ZIZHZznHJFiBJ2FwbSVplhb/hvi7CSZP6qHZUMbd/
         929mOJBuzYbyYOOE1oLY7DlyH+uPKZrIFsjGTrERVRghtfDhzvSqVAHqOYjsDNEzXktc
         VrutY4O+8Lb5M6lBhaAWe2/MVw0f9LAoNcb2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=grdTh6jgWyilD8yd1ADEbK7C00utpPYIiWkMyo43GXU=;
        b=TJPzTSjdqbwMvKaLsoWZO99yQr+ZvcG3DKl/Iyt9uGILliYP3ZwDnW79/zWzTkNPGW
         9h7JVP7Ziec4SkJF78MWiUMRCWb1v8XCS7rz224lbbFx9iDI3HaS7LLtWRJMEbHAdxZn
         CZIaila6+nL6i6hymabjqggcM0yjr/yWvz2CX1suuM49/O535AJnzcMHDkyr9oBG/pqM
         QlUMgpf+Wk924MmNhPN6bf6xH8S2IbLHnVYvnlQS+VZmwrNO5BcqqcQBWOgYnrMX2vuj
         Ao2qTFts8IBAbGTslYTXTTxDovU5Q4cHrO6wiKQA/7zkD22+mrn8LZXr05g7m02/SLi2
         TXDQ==
X-Gm-Message-State: ABuFfohb8Xw2+ufizYagsobmn1AQmeF26dQ9No/+GTm9DZZJuquMntCn
        AimjeERL7odxMUPR/Js6tnAn5w==
X-Google-Smtp-Source: ACcGV60Q+qQUcfOgrc942qlgSi/1M22qVFDImDAbsmJZ/SOrnCHJDrfeP/Y4IHCoF1FM5IPgnBcmVA==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr1006201pfa.96.1537834720182;
        Mon, 24 Sep 2018 17:18:40 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y85-v6sm560016pfa.170.2018.09.24.17.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Date:   Mon, 24 Sep 2018 17:18:07 -0700
Message-Id: <20180925001832.18322-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit 58eacfffc417 ("init, tracing: instrument
security and console initcall trace events") since security init calls
are about to no longer resemble regular init calls.

Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
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

