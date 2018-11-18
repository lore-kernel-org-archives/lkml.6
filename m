Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA20020815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMdvQ+1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA20020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeKSAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeKSAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so16422987wrt.13;
        Sun, 18 Nov 2018 06:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NggC/1+6qSPNQtKp73ctTtSG3tW6ForFq+KhieOiSrc=;
        b=RMdvQ+1AkD0QLtnYBoQMeFMg5GMD+J5cEbSqa9VP28a/BuSlVx7kslaDnr62vMv3IX
         OaEdBxw1ddYvXtZEm3QaGvG7qdfv5JINNPHVgnwF3ZyeLJfpi+Ly+yHA5AfNXI5MLlmP
         RijO+rB33LaC9H8cDrJX5/pqSE9jldekpJbW/32YH6StJAaaz8EBnuynwAqcmb3D5hTo
         McPnYGJp06/tJsCJCNsrNSxq9pJgNZWf2ysJPiwa3mx2NyntUGk1Oma6x2uxr4+Vvpab
         JAvlTcZ/KDOfEC1bXju8/Q6FzYqTs2L3CEtal1CSKnln3GvNDh8D4ustYKC10krKnv4G
         GDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NggC/1+6qSPNQtKp73ctTtSG3tW6ForFq+KhieOiSrc=;
        b=oEStRJBfC8L47TMKJebyDbxLSsuS7SpU9N/8IbdJq5NAEFj4IouJaoNmJlehjD1bXs
         riK3x4xebTQ5bj8921iSMoPn2Ks9e/qk3/4oDBq79d+T/eTrAg06YusMnX7FryfRk3qs
         vZOIPESYbOmAEx2zqlB4zZWyTmWyTE4c/aqGQ0OEStWBsHXgyf22Y6r+EOIX4bLRymCV
         ETi6DRwK1cpTAidvAVtYtCkxy3fLNzakArvuaz69t4wSE4IUwyBr30Rt9GsibnkIjDtF
         dWIYBDdHEqx5Gkpml8gfovOZ2+CQ8m3XtoKW/2xoCQvY9CGeBNzUoQkSwzJwDSxdgoDC
         ugMQ==
X-Gm-Message-State: AGRZ1gLVinEpqdXELuRGs+MKFNRIY0KHpSntIf1TEp+HoWJ8vdHtDkbR
        r0Ktd49scjJNEE7Di8gxNUu0CkWxDvg=
X-Google-Smtp-Source: AJdET5cq/fmr3jN9xT7tct7iIUpA1P3FOAXxQXKSKalU8K3p+kOTk9RgnzX7A2Wvvt93JIqhNqy14Q==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr15674859wrg.24.1542550708118;
        Sun, 18 Nov 2018 06:18:28 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:27 -0800 (PST)
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
Subject: [RFC PATCH v2 06/14] dt-bindings: timer: Add Allwinner suniv timer
Date:   Sun, 18 Nov 2018 17:17:05 +0300
Message-Id: <64b7dbecd4479e0078ad0252af1218cbb4b2b409.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv timer which is similar to
sun4i timer.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
index 5c2e235..9c02a4b 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
@@ -2,7 +2,10 @@ Allwinner A1X SoCs Timer Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-timer"
+- compatible: should be "allwinner,<soc-familiy>-<soc-name>-timer" to identify
+	      Allwinner SoCs timer such as:
+              "allwinner,sun4i-a10-timer"
+              "allwinner,suniv-f1c100s-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupt of the first timer
 - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
-- 
2.7.4

