Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623CFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EE5218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlSweSvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfBQQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:23:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34103 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBQQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:23:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so7227914pgd.1;
        Sun, 17 Feb 2019 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v77WHuWVJ9n6wbtheA1rJs8RZVqdPCnng0NLiMUvMxQ=;
        b=tlSweSvVXkKcOP8R5lzLVzGKM9lPcWBl5axNcBu6LnPg6MmMyRXcezAGVKX3um7oul
         e1Bai21qB/EpeOV6kAKFRr505Qf+Zb8KxGGsKsrGllrJxoqe9gzWkOVuLAtjlYt4DIZc
         Hh9MjWa/WSYDAZREa2j70rohw1ai7ifDqxtonhbIitr2ypxMbqBOua7eZe9TqDMyDZug
         nAahWYq31pMHSd3BnquRY2BxfDGwCKbin4TQzzj87xMSsHJDtJwOt/QqGCvr5o92bz29
         WBNqPLUuyBMXet/XDRqDGm4IeS8blwEszu3xgwYNlyYKAVJASvYMKNAIFTtwC3Mi/SrO
         amYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v77WHuWVJ9n6wbtheA1rJs8RZVqdPCnng0NLiMUvMxQ=;
        b=pGbinnVtTQ+xi7wliT/Hzbc/Mp1ZdY2fZmH5glXjdyqN9pbXJFRrg12phLJ5/zhNVv
         o0O3+bI7hzXcCQnciliGMlG2UUCyA9TYdkl4vyum118k9xQOcB1zG0SWavxwsmWRoBqQ
         v7zL35eROS+BwVPRz5/TH4suST9dwO/bJAeQVGEaMnJdahL94XgiijE1hAuRCsGcY2QL
         e6EgOAb1ZCv7D9hLHHWQRCPcxN95C85BrBsebQvhk5nCAIW5DpuUAULBtHyESVNdvzK9
         BMUo77kxQB36soQSopclvc6vZWt+U+yRn4XNcKUenBfob/vjtuGyU/IKrPSfMv5BcYgb
         7zQg==
X-Gm-Message-State: AHQUAua/3sgqLW7BSKCNsdah71qIhw0YyGXLBIIZut38Uck6asSRtGNa
        1DIcC3B66y6coAsSXkcLGFI=
X-Google-Smtp-Source: AHgI3Ib6zA9gcfCmqIwqd3zxgOlw4olUhTSpcqMgWWdRR+1C5plksRvth5wOy7EXDl7l17ylLEphbg==
X-Received: by 2002:a62:8a57:: with SMTP id y84mr19714966pfd.197.1550420622343;
        Sun, 17 Feb 2019 08:23:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b26sm17874576pfe.91.2019.02.17.08.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:23:41 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/5] nvmem: sunxi-sid: add binding for H6's SID controller
Date:   Sun, 17 Feb 2019 11:23:14 -0500
Message-Id: <20190217162316.14111-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for H6's SID controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d37017e343b1..cfb18b4ef8f7 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -8,6 +8,7 @@ Required properties:
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
   "allwinner,sun50i-h5-sid"
+  "allwinner,sun50i-h6-sid"
 
 - reg: Should contain registers location and length
 
-- 
2.17.0

