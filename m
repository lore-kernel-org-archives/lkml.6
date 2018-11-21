Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3B5C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D14214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEdOH3uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D14214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbeKVFHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733171AbeKVFHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so6740914wru.4;
        Wed, 21 Nov 2018 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvVTPqTluJSo6gOOlAY6VgJ+dxiR1YqQ281vDq1n6pw=;
        b=nEdOH3uZePWuM8JdhBtTbSxyv4pLuEhPtE7ExViH4bH91E0Jv/atlzvzvVFBfOru41
         6EiDHQZ6BOMzUojOuqobEg9+khcQ2/86tlU0RJiJIu7D5E3oV5WN8VEkN1tA86RmRoly
         lSt3QDZ+n087MCAYGacmkJvDo77piyNG0TIHEz2jSETpftRm0+VBRv8rwfoAzNPrD5Xp
         vM3np86lFRS9Rfgu9OySrKrYkXhpJ3/DPAnAjCAz5xB5vmT2wtBiey31vUrbmdx0Kf1K
         5ybUtZntWEN5J+jE1OqO/CMmeoLAht5m+uCDAfp7eBGCDzMwTBduT5z70ye1jGWM+7n0
         FIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qvVTPqTluJSo6gOOlAY6VgJ+dxiR1YqQ281vDq1n6pw=;
        b=WMTsVXej818vi1Ru0IKEJqtixqKK79W70Inyop7o18mfs/SR0swBPWGu9ddr9yhK8k
         5LAUXDJUHowaoVPHRccJADBGlLjuXpGzlf6HPlFzVl2iFIb+X9AQ6mpelgrGDg2UUJBJ
         RJPVXh28LdzgekOWCSZQTkgtNreK557vGh3UB2nAzoceUDyFdFOEUSM3OngfE/Vw77jW
         IUHPDpmjml9zWFlcvyxWIryF5i3dA/qwoJJnjU2YLCTYUpKjwfHcIQdJPCkpR5qgiTGX
         6ARKB6O0ANbIfFa9b+5drpiX5LbU6d4CGgciRFgcgFyXLE7OotUpz4gTIEDpjMNm49aB
         5Fmg==
X-Gm-Message-State: AA+aEWb5VN4DMi4qPlWaEF23K57vEkL6fcaPBVIZjusNJOMD2vetNTu/
        9ypW+e3/O5E47a6iATQ4koYzvQ56rOo=
X-Google-Smtp-Source: AFSGD/VU+o9H+nHeCGtZ3uCa3HureUXSMFr2Q8JW22lmUdnl5FQ8M01nrlbU3tOGiLqMah9Y/MnDdg==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr7065656wrt.327.1542825108485;
        Wed, 21 Nov 2018 10:31:48 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:47 -0800 (PST)
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
Subject: [RFC PATCH v3 04/17] dt-bindings: interrupt-controller: Add suniv interrupt-controller
Date:   Wed, 21 Nov 2018 21:30:37 +0300
Message-Id: <d0942fe5b1bb83646af0fa1f475ac0b468e1612e.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Alwinner suniv F1C100s SoC interrupt
controller which is stripped version of sun4i

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index b290ca1..4043525 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -2,7 +2,9 @@ Allwinner Sunxi Interrupt Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-ic"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-ic"
+              "allwinner,suniv-f1c100s-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.7.4

