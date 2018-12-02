Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3952C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DFD20851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzmdAlgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DFD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLBUYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43608 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeLBUYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so10029770wrs.10;
        Sun, 02 Dec 2018 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+V2WbDnTTYDb5DheTPlD4ID/xDgu/F+Pl9HjYjs8x9s=;
        b=gzmdAlgscUYL21LnLlekT5aOUIsAwdn6tX96qbCodW9DGKkZFT40/EKT+Xv9/xMNUl
         0Vjuurbizu6q5Xq/a47UvjlY9mUlWaDFYTk+6WWiybiH/lwae5t+Dt3d0TS0MPRqy4iJ
         le2t5pxPRldKUNTBBuW92urVTjZtLQngeNs49LXoZWqC3mc8q2ATrs18VBN5FiyMdsgg
         MqylHFQ77uz9jnexx8vdSDvMXjzafQ1YhnhBBmVWGxGWSdwUPsD9AGzZbymjv8dxilJl
         nUFQgJFc5l5PCVPeyU980UOFkUdfF4VdQQAWta/46S3BYqFgh0emVWYWtk0F+V887dTN
         hmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+V2WbDnTTYDb5DheTPlD4ID/xDgu/F+Pl9HjYjs8x9s=;
        b=n5QXnQWgiiEOPvHJg9fFneq29qnLn0uTQWxYViS0vVC1705g5MH30li7YtkXh21rhs
         TBAp+c3pGf9CVtxPPf1lHuynYmB+oVVHqfUriV0TVubbTKg+Cbl5iq2LCfi2qP3VjMXy
         65WldFeUl2bWMiYoEIvuwJMUpUiFb3hEwbfxmkBYilJhupIYB3zvfzy2eKxT6i+/Qqy4
         7oZn90rnzPDogmmaU6i5UVQl6WM6DhEgsiKJw9Vhd7KXJ0RhSwzISjYcNS+3W+WxPVcu
         /WO7kcZB8tDvf6ymwQJE+Eigp4YPEJ8iF9J5A8gv1u1vmT4VicEwoPuTTXSDlj5C7p7Q
         SJPA==
X-Gm-Message-State: AA+aEWYXaak5SnpqZqiW7tvTdQ8CjkP7CXNReB3dc2jRRuSKAmoM2uPJ
        0ip8dCL+MLWOjqGgr/iorzvdusmHguU=
X-Google-Smtp-Source: AFSGD/UvqSUUDOejX6SjyUwczTcah8rkFmvGhQoVogLPun72q5lzEFpLT8WIyylrx395yFeAiioYlQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr11112960wrv.308.1543782253959;
        Sun, 02 Dec 2018 12:24:13 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:13 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v6 02/17] dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
Date:   Sun,  2 Dec 2018 23:23:36 +0300
Message-Id: <6fa3cf509379a0888388821eef3e322c014df5b8.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..f9ddc05 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -18,4 +18,5 @@ using one of the following compatible strings:
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
+  allwinner,suniv-f1c100s
   nextthing,gr8
-- 
2.7.4

