Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE878ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9FB2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MxXn5o1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9FB2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbeITWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46595 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387866AbeITWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id t20-v6so1150776ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BZjzkTJ7R/6jxPCxq75uSj94glR2mULSvjebOSVz4jc=;
        b=MxXn5o1wdwyUuv3gmjvXz9NVRRSlP+x+Rz1IVveFVDlxx49jM8QkeGYTj+2lEj19Ck
         HyUGyqGRAHYTsoLpAVKXVO3oJSRTrQ9g04aCFM8tAsox+vUhAOv4lOGgT8jRe5nnyqaU
         q7TJK3kweWHBAT0eHuHhh9/o7VuN3z88+piyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BZjzkTJ7R/6jxPCxq75uSj94glR2mULSvjebOSVz4jc=;
        b=kDnxIS89oGX9FDCwA/ttlaYydliH4KOCS/V3jok3sfQ3iH6hYc1IhTxo4vkCwZXRcs
         GPfjAbKKq2QpVwbca6yzKw8938EG6ZD+AMDAtbrCLOi4++4sPnc5lDQ6S5XdgTrTdNRS
         5g7T0Po23yh5LbXhlGL44P/Hkn9QYKGfcHMaV/wP9A9nY0flxkjMIgr/46cwal5AO6hG
         BocOtWOar1Wko+1H9hJPPYLZ54QV/9NuGPLh/IyIeqY6RYH5Wb0cUN/6t9LqCXKi5XfT
         oOvlklSse29Q+fq+rJg+Fuu2V/eC6pieuhI07FmiHwUtuzoiHDjhj1UBec4MSF98Og7e
         3dkw==
X-Gm-Message-State: APzg51DIxLR87YaZIpR4pJUvzLy7lMFX/kGOr4G0xUaNftphvDGiUhkI
        VvN5HTUE0k9h2btL7d843n+qvw==
X-Google-Smtp-Source: ANB0VdZa8WAKhEBDZi6pTa87ak2DeTsRv+3CPD5AU53nh1/hTxqKn+W2wCm+b3ddirMYd5z3LH/PfQ==
X-Received: by 2002:a17:902:6b:: with SMTP id 98-v6mr4400899pla.258.1537460633220;
        Thu, 20 Sep 2018 09:23:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c1-v6sm31903041pfi.142.2018.09.20.09.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:48 -0700 (PDT)
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
Subject: [PATCH security-next v2 10/26] LSM: Don't ignore initialization failures
Date:   Thu, 20 Sep 2018 09:23:22 -0700
Message-Id: <20180920162338.21060-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM initialization failures have traditionally been ignored. We should
at least WARN when something goes wrong.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index ee49b921d750..1f055936a746 100644
--- a/security/security.c
+++ b/security/security.c
@@ -55,10 +55,12 @@ static bool debug __initdata;
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

