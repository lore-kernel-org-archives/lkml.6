Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6CFECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A65208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTuvNzJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A65208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeIPFwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35363 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeIPFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so5932050pfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skFzPzxzOZl4iyQuC6Z8yj0y3sADXmPouVrNkO4jtDo=;
        b=eTuvNzJn6KqDg8oPBKc/yDGccl+470XP8MInsGrUdrso5dzfm3rh7EwCrZVGO9o59u
         rfDH04CEdgK60Hj/r29SJzXbanLzEuMbJdrTaHBAz4kcxSeELUHB80W9CDnP6QT1gxuQ
         5Vjcz8hkS5JlrJUxsTkJQNk19l/wSz5OMlmr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skFzPzxzOZl4iyQuC6Z8yj0y3sADXmPouVrNkO4jtDo=;
        b=fRS9sAOlXi/26ZDcXovVA3Z8Lg17/pLYrSDjVgEbfxAAIzGv22BLwL8N0P+S76AraG
         rFoX5wVm5K4NvMMnC3NnUhsBQQ/F8L4xRSf9c7Ca0mUfAvSvcF/g86PCi/L0RgdrsVPS
         HGMYq/XJOg7XXS0ve8WfKm8FijRDWyRiMlzvot4JjX0zgUlILXecQ4jCj7SZd7ehCbpg
         T+Oa29cdePbx+szlcj2NCh2DBj9/0mp0Ymm3J4Ee8NGeiPYigLGKMFmDkUV6blS1o3oy
         kXTZHe4XOiv/O0oIwSEax6AJtdv0iSUcpwPo05sUAilai0Vn7HcB2r6bjIono++fqgf7
         A6Bw==
X-Gm-Message-State: APzg51Diqx5Xl/dFFlP+807B99JnI7kSLbaR/yxklu2Ayem4FTtzA6Mn
        Ru67lAh49DkeaWSNht22GdMRqA==
X-Google-Smtp-Source: ANB0VdaklE4oYTRRxZdtYi52bqjpzgVT1XrzalPwtMJV6zIZx9Iplzd5cfut8vFMATM+rx/1cB668w==
X-Received: by 2002:a63:f751:: with SMTP id f17-v6mr17924670pgk.410.1537057876820;
        Sat, 15 Sep 2018 17:31:16 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c78-v6sm14842149pfc.188.2018.09.15.17.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:14 -0700 (PDT)
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
Subject: [PATCH 12/18] LSM: Introduce ordering details in struct lsm_info
Date:   Sat, 15 Sep 2018 17:30:53 -0700
Message-Id: <20180916003059.1046-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only minor LSMs have any ordering currently, but only capabilities
actually need to go first, so provide either "absolutely first" or
"mutable" ordering currently. Default order is "mutable".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 7 +++++++
 security/security.c       | 9 ++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e71e1c47fa1..89e6ec8eac07 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,10 +2044,17 @@ enum lsm_type {
 	LSM_TYPE_MINOR,
 };
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_MAX,
+};
+
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
 	int *enabled;		/* Optional: NULL means enabled. */
 	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	int (*init)(void);
 };
 
diff --git a/security/security.c b/security/security.c
index 3fedbee5f3ec..19afd7949426 100644
--- a/security/security.c
+++ b/security/security.c
@@ -96,10 +96,13 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 static void __init lsm_init(enum lsm_type type)
 {
 	struct lsm_info *lsm;
+	enum lsm_order order;
 
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->type == type)
-			maybe_enable_lsm(lsm);
+	for (order = LSM_ORDER_FIRST; order < LSM_ORDER_MAX; order++) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (lsm->type == type && lsm->order == order)
+				maybe_enable_lsm(lsm);
+		}
 	}
 }
 
-- 
2.17.1

