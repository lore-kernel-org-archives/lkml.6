Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B8C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8651021471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EN7ERBx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8651021471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeJBHhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:37:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53238 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeJBHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:45 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so982666itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfu2i5vCbLXUhEgxVTjIKQVSKkT0aaheZInMAAU7pCg=;
        b=EN7ERBx7G3tMC/5w6RjPKfD+AauITpVAZP0y6FiAaakJrL+elpACCvX/EujWWyfkyV
         CJdnUgg7PIj75Z0CheloOsJ6M+vE8XPxuapNzS7I5lI6yfFOE1E0GXdivGI3mKpy5L72
         iGz+2LqYpFV5uD7Yaa1RCBrFqchmdl9z84roM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfu2i5vCbLXUhEgxVTjIKQVSKkT0aaheZInMAAU7pCg=;
        b=i6JaPjbSbL/0iZWOstdg37fKutvAyaa+J4r5ZTZ448fHj/SyOqtAR4nA9d91fM1nKY
         tDITI4mM94U1xq0hq2ZyubAhU2hh3k2PvBD8gvXpJ6qGGmiPh3pqtHarlsFOXMKKI+hN
         nm34qeQJmvtOW6HNrfQwUmGtyqj5yaZQLeFR8LtuUxBrFO7dR4BOEJmO/FGmV8KYy2JB
         cEzvpuAYnqFsOXQE6c8sux6WZI51HOAjNa8ZqruS6d/JmVbFBtC8pcgwcGMxYRAdQhcd
         EzspVONTh1psb2JBOCbMx/Vk7euP9IVOAjcWas+69FiseF+mPZ7ym3ly9FzU5BBROLE9
         WMIA==
X-Gm-Message-State: ABuFfohKbaYyQKHLyN+Bsp7owN5EXhpxHOZ3uRK1V4cg1WCF6PSoK5/P
        Z6bTwSp7CX2RosjOyie5qnQu5w==
X-Google-Smtp-Source: ACcGV62l9Phm+SSQ90SYg/dGHI3gTmsMXZ4QTSA7P5mRLR1+PMsps4PiKZ/PmWjFolewbfJk43Ehog==
X-Received: by 2002:a63:4e4e:: with SMTP id o14-v6mr12527508pgl.181.1538441717308;
        Mon, 01 Oct 2018 17:55:17 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e7-v6sm24885837pfk.3.2018.10.01.17.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:13 -0700 (PDT)
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
Subject: [PATCH security-next v4 10/32] LSM: Don't ignore initialization failures
Date:   Mon,  1 Oct 2018 17:54:43 -0700
Message-Id: <20181002005505.6112-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
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

