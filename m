Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C647ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB30B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FG2tj/TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB30B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIPFxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:53:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46559 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbeIPFwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so5770212ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b0Z1CYwKLnLjlLuTRAvVqGb4C3/ai0Sv79Sf+0Od5TU=;
        b=FG2tj/TLjj08QzPFUMh+IrjNW2vaWgk1rc4ucne41pTb5ALMdVqOtR0xwQapDuzsrQ
         CKhlh3UdY6GWxqvwhrI1zsaY1fh0M9EWJL5JiDmvjdn0LwqgjwWSBDMG/GtejC3S2xla
         zbkJyHD1im5YZFYyfSxt9z6bEnajjJ0pOunQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b0Z1CYwKLnLjlLuTRAvVqGb4C3/ai0Sv79Sf+0Od5TU=;
        b=CDcNVwhVp0LWc6VrSfwNafh1tFvUs5ZPUzZfSfo6pu1bwD4h3J9txbINrw0FGhXgX0
         0pulGyfi+PSaRfPdbj/F0tTD3rLr23uuapaRuysEpywsDxAz9vj0pmZfUmEBOxFXscSC
         primYVuAveE7h61AC584hW3UORImBvgOlsfGLR2ECmUcxJZhFOg3jnJrwpRB6KA3DBgT
         J07wf1bNrADXuoqp5SOFQgKUgRay11o8m49UvvkC65Z8OBvWkuHeQNcby8T+1I8bQzft
         MoXKMTG7WuaoI/diKHHHEyGfVtj3NyYyyYsnXyrwhGQYAlFL8jTVHU9wQvvPyX/KnLXz
         jQqw==
X-Gm-Message-State: APzg51BlkyvkNtQN0sMpuzSaSjL+/CxhkaHHvCmBVyE2wIKAlCE0gpZu
        7FCvISEZHriFCGGoLZvHVHOYnw==
X-Google-Smtp-Source: ANB0VdbdA+vOkq09PGWOLzclADc4ZMf1SBNlH4qbG+Ru7y7AiMoiNCVtFQO6hKfWoxjz/9mJrgx4BQ==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr18129539plp.14.1537057871185;
        Sat, 15 Sep 2018 17:31:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h132-v6sm15349764pfc.100.2018.09.15.17.31.06
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
Subject: [PATCH 08/18] integrity: Initialize as LSM_TYPE_MINOR
Date:   Sat, 15 Sep 2018 17:30:49 -0700
Message-Id: <20180916003059.1046-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The integrity LSM isn't really an LSM in that it never calls
security_add_hooks(), but it uses the early security init because its
hooks need to run before the VFS layer initializes. This is the very
definition of a non-exclusive LSM, so mark it as such.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/iint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 20e60df929a3..d886183848c4 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -176,6 +176,7 @@ static int __init integrity_iintcache_init(void)
 	return 0;
 }
 DEFINE_LSM(integrity)
+	.type = LSM_TYPE_MINOR,
 	.init = integrity_iintcache_init,
 END_LSM;
 
-- 
2.17.1

