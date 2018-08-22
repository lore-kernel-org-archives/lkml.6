Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5345C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF421528
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FF421528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeHVPR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:17:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54914 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeHVPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:17:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so1748321wmb.4;
        Wed, 22 Aug 2018 04:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yj98eCbA6LNn9QDvsvhE7UUg9v3UDy2HARpERvHAyT4=;
        b=jMHlA/MiuWuktoZJ9ER0NUhwc81szwmhoA2ssy24lt35lAB1vCezXjvgmIQq3YBo7f
         QgiECv/B9KIj0IUXFC8FuFW8P/LQT/kw0i9nD2hMhcJDWhtRU4Oxuo+csY1LiIskhhAP
         5vwESuE0f0S9y92mf0aHkVSyeTZ2cAOyGLH2nF9RMywF/aiokXJDbariZtYb96XCzXzZ
         KZ3mjfdbuMpbjbfDnklwdZet7sot1RgAAw1erYTpY2LQzNQNKfx9p+LEUyegFht4Ng7V
         CPHSAD7Z7nGS/Cd5gIAR3cteDJFDdkIhCI33qSaCzKpcpur4W6dMGM+WKqnpr4mG5POY
         a8ug==
X-Gm-Message-State: APzg51CKyGvJp0FCMKs7nZGiU+1zWyd2z2WH/m81guZTKlm6VAhfxIvO
        8dxjnNkAWIXTFm9BRVSy2fqh2oRpkHY=
X-Google-Smtp-Source: ANB0VdYT4AZ8WAVlqv4nWzbo93EjvX8aWgb65kYvQkZI/UaV3NU9+yjQlPftySybjdiSVGxX9srXGw==
X-Received: by 2002:a1c:e455:: with SMTP id b82-v6mr2339796wmh.93.1534938770791;
        Wed, 22 Aug 2018 04:52:50 -0700 (PDT)
Received: from localhost.localdomain (eap108146.extern.uni-tuebingen.de. [134.2.108.146])
        by smtp.gmail.com with ESMTPSA id p89-v6sm2591738wrc.97.2018.08.22.04.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 04:52:49 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     serge@hallyn.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH v1] security/capabilities: remove check for -EINVAL
Date:   Wed, 22 Aug 2018 13:52:40 +0200
Message-Id: <20180822115240.18196-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bprm_caps_from_vfs_caps() never returned -EINVAL so remove the
rc == -EINVAL check.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0 -> v1
- non-functional changes:
  adapt commit message to reflect the fact that
  bprm_caps_from_vfs_caps() never actuall returned -EINVAL.
---
 security/commoncap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4c33abd9959..6012f0cd8157 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -684,9 +684,6 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 	}
 
 	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
-	if (rc == -EINVAL)
-		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
-		       __func__, rc, bprm->filename);
 
 out:
 	if (rc)
-- 
2.17.1

