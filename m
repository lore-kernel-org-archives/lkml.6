Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36824C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEA0214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNNbG8uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEA0214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeIYGXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35221 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbeIYGXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so9924524pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BZjzkTJ7R/6jxPCxq75uSj94glR2mULSvjebOSVz4jc=;
        b=BNNbG8uPI9yLlnm9bM2zwXaCF/XBmEWbJjn9xZEAbieTjylutvTpiIRrB09MnUUyPB
         CHDp1Xjdcd8xVUMX0nGtNfDuCF2qNnyHOiMsfxG5c4sosLkTI51FzQMHbCY/pFTyDjnB
         +bek+O4WCxBfiN1CLFKM5JlOlTajjUiCxIY/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BZjzkTJ7R/6jxPCxq75uSj94glR2mULSvjebOSVz4jc=;
        b=g2GhbKQ7OBpZUVB4e7WPCwZ6nZwfl0UahRiUiovowVpgoh3eZc8iTahRK/y6/rY8vP
         CPot6WWiFy7iBl/rY8K5CsRvOJG81mnIYbKVueOXFZP5h+2mjG07pJ24/6NYqgGScnp1
         VeopQogIo61Q+sYoi84K17CyEU26lOuOQY4WWIHVLvHavWtiLybAKG5Cu45bwFHuzZEi
         uAvkN8ChlUAxbdcb1l1DPUGtmNGEqJAoKIJUIM/7B+EBavvobNz/SlUOch3fq+4gQUwa
         nKN0DvhCSDuEvymr3j+jqpp0e6Gp/4lhu9En2n1dZlnry8kEmRJtpdVXJ184mrM23hpi
         4VkQ==
X-Gm-Message-State: ABuFfoiOlIDLcg/uPqS2Rs3ktLeMFZEO1YKzFfPi3j8k5gb6jDIy9snT
        795mxzrw7Morep3fgPVVrI9tWA==
X-Google-Smtp-Source: ACcGV61weHh6Rkf3lXBEDGSwP3d0UGjz94RyIHcmJKttOEiM08pEeVvVuUzhZO2jIDRZz+1wFEgwjQ==
X-Received: by 2002:a63:f941:: with SMTP id q1-v6mr870290pgk.213.1537834728294;
        Mon, 24 Sep 2018 17:18:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z25-v6sm605485pfl.58.2018.09.24.17.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:42 -0700 (PDT)
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
Subject: [PATCH security-next v3 10/29] LSM: Don't ignore initialization failures
Date:   Mon, 24 Sep 2018 17:18:13 -0700
Message-Id: <20180925001832.18322-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
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

