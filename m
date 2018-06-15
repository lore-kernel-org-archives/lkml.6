Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8088C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agzb6cmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA9620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756736AbeFOWiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:38:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37105 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeFOWiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:38:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so5011346pgv.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iIVvslsTepVL9ilO9RUuy9zGOTzVYQqOHZHXk5WXYeA=;
        b=agzb6cmOnrVrwtPwCMt9lXdL2mtNftbwtMMsDLMlY6xH6guyTQX/y8Aa2nN5/nORxG
         F2efdIpD1d66PC3+sgPW8SRCAsSm/aWUUNjA6Ehk9saazb+Mlf2AoCK4H0kYFdoiWfs4
         y1oxLeJVPR2F6DkPG+cm7wPZclbCuk4a0VHmRhRoh1YbfLNLRdfzFDLxJF/4tjhFwM8R
         jMBvt0OTno45A3PmYGBDNPq67TMRCDdsVT73o9Vl/V0ca7T/gpciq/hkZRBxoNPe5ppc
         ju5X5qnw7hGXlScsJUvM5RzrJjvzVr529Y6Zx9jldbix6JTfRIxlBkWCTr4zxcOpPgqv
         95wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iIVvslsTepVL9ilO9RUuy9zGOTzVYQqOHZHXk5WXYeA=;
        b=dXO3c0x2v4R9z20ydmLiz1BfuCEG4easZdrteySk6FMmALxZqTadRZr+ymzqh70G0y
         qmZVW3AS/Ss5vvlLSyLnaB+2KtQK+opWnnBAOUOJsaZ8bG4sTpVCvX/0TysFTDvonWfM
         eSf93qnE4mUmQXLIjkGMp0nveCe38pXrUhp6mIZXZXSxoeODOleUuQ41sIEkQvf6LPf4
         8tAps26yo6FP8ilqtHA6tOeOCrN58b0l7d7nWcwCm6msFU1zEhIfULeqyzv8jgkFIVzO
         R9nNtQ/eSd8czXO9g1Gy8pJf3vZB25ZKtpjtVH0v7xpKKFPiNj0MlMMLZ1qI3ijWtI6O
         nV2g==
X-Gm-Message-State: APt69E2XPM5BRH2FgtcXLoMonHJ3GFdYuELny1p/fcDIBlaEIKssN9gN
        uGXhn3HU/YvwKtN+mRADqfw5+w==
X-Google-Smtp-Source: ADUXVKIuArMnpcJCjL2xNHl07zqmg2ZbU3xHNjqjtDwWeWslOnREtWmVxq+R4/Cio3KKtC9QNyynhg==
X-Received: by 2002:a63:ac11:: with SMTP id v17-v6mr3281257pge.274.1529102285386;
        Fri, 15 Jun 2018 15:38:05 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id e192-v6sm14164603pfg.187.2018.06.15.15.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 15:38:04 -0700 (PDT)
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     thierry.reding@gmail.com, airlied@linux.ie
Cc:     Jagan Teki <jagannadh.teki@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: simple: fix -Wliteral-conversion warning
Date:   Fri, 15 Jun 2018 15:37:49 -0700
Message-Id: <20180615223749.149073-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit 8cfe83419cdb ("drm/panel: simple: Add
support for KEO TX31D200VM0BAA")

drivers/gpu/drm/panel/panel-simple.c:1250:27: warning: implicit conversion from
      'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
      [-Wliteral-conversion]
        .vfront_porch = { 6, 21, 33.5 },
                        ~        ^~~~
drivers/gpu/drm/panel/panel-simple.c:1251:26: warning: implicit conversion from
      'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
      [-Wliteral-conversion]
        .vback_porch = { 6, 21, 33.5 },
                       ~        ^~~~

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Alternatively, should these be rounded up to 34?  I'm guessing the
current behaviour (truncation) is correct since that's how the patch was
operating.

 drivers/gpu/drm/panel/panel-simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..12bcbd1dd77b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1247,8 +1247,8 @@ static const struct display_timing koe_tx31d200vm0baa_timing = {
 	.hback_porch = { 16, 36, 56 },
 	.hsync_len = { 8, 8, 8 },
 	.vactive = { 480, 480, 480 },
-	.vfront_porch = { 6, 21, 33.5 },
-	.vback_porch = { 6, 21, 33.5 },
+	.vfront_porch = { 6, 21, 33 },
+	.vback_porch = { 6, 21, 33 },
 	.vsync_len = { 8, 8, 8 },
 	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
-- 
2.18.0.rc1.244.gcf134e6275-goog

