Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B78C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D96206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6r5UfGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D96206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbeKVFH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeKVFH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so6759057wrw.1;
        Wed, 21 Nov 2018 10:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xURHP8XF2m49lsumRn2ju0nb1lR12xYG1OQRr1p01U=;
        b=j6r5UfGciouNBvBfAEOKoqkZPRnplijQfmOrUsxGaeXryvsoBV28Odimzdi8ceDElc
         6hmUtPdgCrLG4Lj8vu0q7Hyl3yXFVSeJ8N7Ml+4wLeZvmQBtY2YRgg+UrB+1483pM2kT
         b0CD19dOJZQ9A8j5AVH8C9ReaJIeK0IQgFq8zbVynLdfgF4MfhVw7k+iFfM9tdkBAQ2C
         nNWuPFxdoe+Wsv94gNFif6LtpyHlZNPjn+AuB4Zv2cF1B2ILJszQbiZXns8E7rBllWz7
         Dbji5GVaLBbTD8C1Do3nWBdEB8S9JNhUWAgtrIWil1oCxmbmYabzxbk0gmJdda7Iiorb
         l56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0xURHP8XF2m49lsumRn2ju0nb1lR12xYG1OQRr1p01U=;
        b=BUa7eGN0WQ6eyfkEzGTK87kllczSIvEwFc1zdA4LmMyQE5eRn77CrYvAAEmuABZGei
         o+/5BCLcDu7WryTLIHwWgM02GcCulOP6Z5ENVvRQvUuHhou26r/krozmWQGyuBD2HABR
         kv7dSNVj+m9DIvh9wIj2TZa4VK0SUI6ERzEWRI9tVN18KYMmOmX2ajNs9Ym0FJ3KoQxD
         rmcy2FNWJugVdWwihHa691GZ+v6hErLLzVMboJKHFFSCT1qs29yN0umYBZgAWbmYL6Uk
         BYwSOPUJ1J+CmScvzIX0x6bpO1HVgXXALe2gSlp9GYBDCbLtsQypOdNZ8vDQ0hrMes0q
         7Qgg==
X-Gm-Message-State: AA+aEWag4eWL+9lBW0p0qgghCau/RMt3WyiK5purjjBGXQCziuO0ypiY
        i/u20txsJL+vq3qBUnWH208vbCb4UxE=
X-Google-Smtp-Source: AFSGD/UxB9hXchm1FdkCAz1Zglqhnb6PInyW1DanfMhooj12ABAqb8wbnEBQL2Rtqb/DwK2TQdTJiQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr6619956wrv.308.1542825117134;
        Wed, 21 Nov 2018 10:31:57 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:56 -0800 (PST)
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
Subject: [RFC PATCH v3 08/17] dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
Date:   Wed, 21 Nov 2018 21:30:41 +0300
Message-Id: <70ac024bf3b6623dc41021ac4893c37adb85a97d.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv F1C100s SoC's pinctrl.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 258a464..a7f7133 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -29,6 +29,7 @@ Required properties:
   "allwinner,sun50i-h5-pinctrl"
   "allwinner,sun50i-h6-pinctrl"
   "allwinner,sun50i-h6-r-pinctrl"
+  "allwinner,suniv-f1c100s-pinctrl"
   "nextthing,gr8-pinctrl"
 
 - reg: Should contain the register physical address and length for the
-- 
2.7.4

