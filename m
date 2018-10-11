Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7194DC46462
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E2F20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYvDVjc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E2F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJKHnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJKHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so1060777pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eNmHSp4+Q45IaDkZQNXs6+kAcMRIeE3x4RWtQQ9mBQ=;
        b=DYvDVjc7Xan2EP/iEUqXrj2yKnSYlFhkr34DGSQencgIOy831Os9HD8kGEcDUqRW2h
         UOL8vxl7DRRzpkbIlRy98nY2vb37prMlBtAdV5CW1oBx4Fcq9fOA0MMLfYvLGRJNoexU
         bCKXaqd5HJ3BxFRz5OUOZpuy6tl1f0EMKGnbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eNmHSp4+Q45IaDkZQNXs6+kAcMRIeE3x4RWtQQ9mBQ=;
        b=ubPzMekLd4FFg330kNGKoY9hNMtAL5s6Vu9zCxczgh9pkQzrk7S5xayMGL2DpaiC1w
         ijDA8u0DwDoeCXoqA04IYJeswx0GLtEUgLhYIMQy2B4XRV8taseL+5s8r7PV8QjgvNci
         sUwBCDO8mReplb41b8yO0rDtEt/stYJotUOq88ieTRV9qywo6BUhh4BpHC5SYO/7dw11
         iCQV7eeDvUirnJZdSW6rwyvYFoVc3rGcVDaAdgNOFC1Rp7kppqHiLi/iAcpbUsjvGrfU
         1W9YYkozfAw8kIar5rVNGuCBZjwaSPBCnRAv4iiXBYeV2AhAJJc8GCaqElSJ0yWtmpXb
         DeiA==
X-Gm-Message-State: ABuFfogdzvTBQ3/GG7rWYhyk9r/iQzeF+K+trzpvadaIJ+eL295qhjgp
        DWyWvEo/DPJBOv/DFahVefB0OA==
X-Google-Smtp-Source: ACcGV63dDeOHLSBcNV01IpVUAP0l7q9lWEPVHsR2O3jUsO5dLyP0b5mqaSyhlTir4maRP3nKsSTw+g==
X-Received: by 2002:a63:5605:: with SMTP id k5-v6mr31688220pgb.189.1539217135713;
        Wed, 10 Oct 2018 17:18:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 72-v6sm49719749pfr.115.2018.10.10.17.18.52
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
Subject: [PATCH security-next v5 04/30] LSM: Remove initcall tracing
Date:   Wed, 10 Oct 2018 17:18:20 -0700
Message-Id: <20181011001846.30964-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit 58eacfffc417 ("init, tracing: instrument
security and console initcall trace events") since security init calls
are about to no longer resemble regular init calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
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

