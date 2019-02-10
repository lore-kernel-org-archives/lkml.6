Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43866C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160EA21736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shnA5YvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBJSKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:10:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfBJSKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:10:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so7277259wmg.2;
        Sun, 10 Feb 2019 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H53iLR2iCpyMYpdFMBGZ4mLkB/ADB7v3sillutVHKU0=;
        b=shnA5YvP+qDhcNb3AMgZvjhoBK/m2Hw8ZftfHQTCJgaAiSAJuokiYbVAKoV7jReaZu
         zSQj3yHaDAYqkRVhjZnJkt/pWlTq3CGbg/NfDlhWrRhgx2NV/vo+4LCiAtXhgVtib317
         7CyzG8mEgcl/3JwyynfCAWry1GoTXsHa2ZlgpbPnQpoGlrQS3SEMAWJ/6613w30C3IYE
         oS6UNwCe2Q0qMg+zxqDpxPQpyXKesQk78qeB1Bc9otQ+soUrj0QF13I7Uy21fDg9nUvY
         e2uFKEEWt14cfxHilgOtM3vIQjkh887WKwZqAoivsfOE5k5vO4bJFjpCXAFIr0Z2jWLm
         6cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H53iLR2iCpyMYpdFMBGZ4mLkB/ADB7v3sillutVHKU0=;
        b=BAKpywXFha+5u0ka2EbJF2PltQASFZO7jKJIKrh+8PN9HCSr0iY7W6C8vJsfCdImD4
         Cl0YY7uW5Q99FcctRk5kGmiReqKt94dUpmgNpAcrUqFF5wX1fuu2VngfRMWYolUXtxoR
         Z0jJgt6XHqxeFH1RAG/8CS7xoOEJrNid37z9C+TIw/4ZM5+z1T66+BmRLMiqJLpgAfnm
         vhNRzj8pskLDRgWOltBOBwMHBXEE3GZWQD5GO0N0jW16hXQ5IJ/yCsvaiJSk97m9YfQB
         +LV6j+/V0QpRgEMswooQVJSqdnbYzzIYL8drOircJBELXm+I0AhlvU/1m/tQ1sxEXSWO
         FoOw==
X-Gm-Message-State: AHQUAuYPxT6CAlRLNRG9tIknZPVmTxGWf6bV8ccw9vDWfxvuNtyHdkDg
        yGDWtHJRAGrblA77h0z0kcg=
X-Google-Smtp-Source: AHgI3IZCnhhewDXSl1ExOfgpvn9kIw8xLAKEU1RB/uM6MIHC5cOXPkX5RuW83GTJJb+q+8/9EOSKtA==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr9037238wrs.2.1549822222380;
        Sun, 10 Feb 2019 10:10:22 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d05:e700:2436:5653:8de5:2886])
        by smtp.gmail.com with ESMTPSA id w125sm16918198wmb.45.2019.02.10.10.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 10:10:21 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: use tab instead of spaces
Date:   Sun, 10 Feb 2019 19:10:11 +0100
Message-Id: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
with this commit.

The issue was detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mimi, please pick up this patch. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf4965d6d5de..31950caabcaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8405,7 +8405,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linuxibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
-- 
2.17.1

