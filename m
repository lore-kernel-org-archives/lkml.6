Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1716EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA819218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwHCIeZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAYHQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:16:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35842 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfAYHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:16:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so3845505pgm.3;
        Thu, 24 Jan 2019 23:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9GVpEo5LqrgwqJj+OhnBHVqnVwMlvZt3InuYblIl+j4=;
        b=CwHCIeZhlXvrNF+ilBf+cJ5FmkD549IOyHAGVg2WOizcZq2ZaOLxC9YnpuLml01iXi
         kNyawF1dzltSA8aRwxCWqgO8Nr/RjoXQFQHU3g6kdVsIY1jQiN1LKypBBw+OZ0/CgU4E
         0QhLum3cCalZQ57JCAI416+0P5dFcs0H1hpwaaHwW4oa5Wn2L1h2dO1fz+Pm1zO9pZrt
         HK3ZJPZjGjZHnoY3LXHWKNafvcR1oWyJDHnRJtvfQTyjlydvv2SuYsX3d7fRJZomTF6O
         WB3vudJLz+sNjNlxlRT+KAhlNSqGPunj5zLRuGconlV8/he/IqXkd1uvryYJRP9/X0e+
         UN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9GVpEo5LqrgwqJj+OhnBHVqnVwMlvZt3InuYblIl+j4=;
        b=XW/I0aBRkUlS8sOxY2HcGJWChSJy/p4rhQJBBItpxnInkTBfQdPx+V+cA6W+vSbLHj
         MrEeTRBneCd6K9E4YKuQl8RhZEHyGsU4qa1GL+cyOFe3bUuVF7PRpepaEZgXL7NMcWpp
         6ZL2UDLZCatecrmLBGpXJ9OATCQE0rI91o+goiwoF1ZoIUwKuJiCnJrpIH3k2g4Qvott
         zy+5IrvSUm7uwER1FY5uL+RnJcZhZDu1O/VQG5sLanBdUpfk6Vdr9gPhf8CySUztjmtw
         halhK9OGokj2PKiuI3GWy5SJtngFPt2UdGKhiZj4vyn1thfb447eryOV4j+c1HI8X7Iz
         BYBA==
X-Gm-Message-State: AJcUukcVicqd2StHpcY4VGBUr4ipCju0qhiuXaXrTmcdydrrGbOtj+hU
        sMy8t0iEmeKDjVUCnO8D/5M=
X-Google-Smtp-Source: ALg8bN4GXKLZFo8L3nraKUYcfs7b/UwXGwTJ6WgoHLjX2gj4Jg05RLzH2OL4RnkIDrlqBMiW5YafhQ==
X-Received: by 2002:a63:fa58:: with SMTP id g24mr8739439pgk.390.1548400601982;
        Thu, 24 Jan 2019 23:16:41 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id p7sm34241321pfa.22.2019.01.24.23.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:16:40 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Geliang Tang <geliangtang@gmail.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: keys: add NULL checking for key->type->instantiate
Date:   Fri, 25 Jan 2019 15:16:14 +0800
Message-Id: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key->type->instantiate can be NULL, add NULL checking to prevent
NULL pointer dereference in __key_instantiate_and_link().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 security/keys/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 44a80d6741a1..ae3cc11be0d2 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -438,7 +438,8 @@ static int __key_instantiate_and_link(struct key *key,
 	/* can't instantiate twice */
 	if (key->state == KEY_IS_UNINSTANTIATED) {
 		/* instantiate the key */
-		ret = key->type->instantiate(key, prep);
+		if (key->type->instantiate)
+			ret = key->type->instantiate(key, prep);
 
 		if (ret == 0) {
 			/* mark the key as being instantiated */
-- 
2.17.1

