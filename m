Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF860C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E97A21924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr4lF3z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfBQQXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:23:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36263 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBQQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:23:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so7296019pfa.3;
        Sun, 17 Feb 2019 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPBS2GhpwmpEDgTVr1WkimnFnbT2vpcS3OkFjG9Zg54=;
        b=Sr4lF3z8Eo0Yjl+jXh463UV/0xgjxSvWVaxWccrn8/t2BlKS3+NU3uAPnFngoNNJwo
         elfzOoAfOvf+85iumwEi63sApLylsD/KCPHPtXyY9723O2RQUtfrTCNAxQkxOuHbt6jr
         ldqrpQ01Nz/Xwy/Z01a+zhldxkTT1tEvsxgtPB6KXeD60ppfYv6C5kFhq/BJQ+MOQFNA
         IAeUDtaFwC1yCS/czWFtPK2zEEHjLHssbKowVuJIxylvA1PkllB8zHkDxD7lJqhN5llH
         1a37IlIPcBEkhjoA5x5KwuQmuwYOlGesg9I/UBwYt4Th8l70Ht1RqGoTi4K+7HUCNc3z
         il1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPBS2GhpwmpEDgTVr1WkimnFnbT2vpcS3OkFjG9Zg54=;
        b=m49e6e4FIYlkc0fsX8ggFG7nf3sUr7VvUlwl2YxErOi7w8hzQSb0MWTsEmHYQq0s4i
         H3CpMUvOXamjyzQfdFGI3E+igKftJQ9dIKG3j+DkST/vvJ/Z0GzUemxxLyGa6ziDCiRD
         +suKmViVsg+hV3qfK6ANONS2fEVRRE1hES81CZvKUtO/JhNKscIBKCt3Aw+nJnuVZV/u
         Z4MgdcVKnS8Bh+ZcGGzDqFFrC919RWMCDBV37sQJQg3tNQ6dITVAH8FGoZ61xs2Stu/j
         O/gxZ1umtdNgBXSGka7Jo7r/zvhd7gvzPfuf8JJO2eGpM7FKiE0zmBCiPc5tD7+ziYM+
         5mDw==
X-Gm-Message-State: AHQUAuYz46gKOcmJZYlcSxAylIbEI+fe8fQi78RC/Ci+Det8OjGA5sSC
        7EzfUpWG3rPp8wg6uFprZxM=
X-Google-Smtp-Source: AHgI3IbTN4cYherFmGvph39bWwD1EtdaeRVZCpQV3H51+TIeDB0ZWYBPmaHvkENyPWilGd6s89koYg==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr12736853pfh.21.1550420609462;
        Sun, 17 Feb 2019 08:23:29 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l28sm18060247pfi.178.2019.02.17.08.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:23:28 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/5] nvmem: sunxi-sid: fix wrong description in kernel doc
Date:   Sun, 17 Feb 2019 11:23:12 -0500
Message-Id: <20190217162316.14111-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qfprom->sunxi-sid

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index 99c4ba6a3f61..d37017e343b1 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -12,7 +12,7 @@ Required properties:
 - reg: Should contain registers location and length
 
 = Data cells =
-Are child nodes of qfprom, bindings of which as described in
+Are child nodes of sunxi-sid, bindings of which as described in
 bindings/nvmem/nvmem.txt
 
 Example for sun4i:
-- 
2.17.0

