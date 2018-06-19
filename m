Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7X/4YQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858A32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937514AbeFSJzR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:55:17 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46660 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756818AbeFSJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:55:10 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so10658701pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CnSy/kO71XHt4vBwBXiUfk+jIrW8H4VtHcwbkY2pyjk=;
        b=a7X/4YQi66o7AdO0gVfOwwCLl71qyiT2HBptq2NN86E7P+uhb/P888m/zqFw8UqCdm
         9PMWfUiYQFxWflpZmRxxEK9eCuIUraBcFHMA3BaBma+wIC9oQM1a84hYRD5pFAeX1eT5
         /mtHJkAWXAJfVVEWk3GIUHr5xAg9ib/gG6jUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CnSy/kO71XHt4vBwBXiUfk+jIrW8H4VtHcwbkY2pyjk=;
        b=J4cyDtBmm/EE1nMD/OdmTmZAiqx33zI5A9Z4LbsvKXE1YtJYudNRzSmREa+tekcw6y
         TsMCbJstda4wDaoQVVtbRSPd58StMZfsZrtDS/RGa3fRoA6CSTfKjG8CNiSSQA25p+X4
         8PRbT2JtGVNC1Zt4GORALCh1GXVqxb9d2S9FZt40BmffZVUEDeEcvVOYbOmFKT/x/Wxz
         LMF6UWNdj5WQ1XvrRB0IZESy8m3cMEmJ/RVpVWosCgXv6EiGH/I3A5UpuNuBzLmrYo2g
         wcpcpmGuMpHzeSsgFZg6evyKxWJhpZgXhCmspoDdl6s5dDyVE77mjLuZDQOdRviYjEo8
         KZbg==
X-Gm-Message-State: APt69E2X6X8KK5Fbfwk8N/SQ+gnMQWDDYl2ZnXfnXH//3r8ICWrXaqoe
        mKP+R6/d0BzN0WAS49DcUQr+Kg==
X-Google-Smtp-Source: ADUXVKKWfCuPDsHjVXJZPYVtGsB9RV9mBvUwxLnHwfHl15wy1Uiqxs5M8H97a4ZbTRq3PnoU7TPLHw==
X-Received: by 2002:a17:902:b216:: with SMTP id t22-v6mr18147390plr.199.1529402109867;
        Tue, 19 Jun 2018 02:55:09 -0700 (PDT)
Received: from localhost.localdomain ([106.200.222.147])
        by smtp.gmail.com with ESMTPSA id c17-v6sm21182034pgw.11.2018.06.19.02.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 02:55:09 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        vinod.koul@linaro.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: rng: Add new compatible qcom,prng-v2
Date:   Tue, 19 Jun 2018 15:24:29 +0530
Message-Id: <20180619095430.26358-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180619095430.26358-1-vkoul@kernel.org>
References: <20180619095430.26358-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later qcom chips support v2 of the prng, so add new compatible
qcom,prng-v2 for this.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
 Documentation/devicetree/bindings/rng/qcom,prng.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/qcom,prng.txt b/Documentation/devicetree/bindings/rng/qcom,prng.txt
index 8e5853c2879b..03fd218bd21a 100644
--- a/Documentation/devicetree/bindings/rng/qcom,prng.txt
+++ b/Documentation/devicetree/bindings/rng/qcom,prng.txt
@@ -2,7 +2,8 @@ Qualcomm MSM pseudo random number generator.
 
 Required properties:
 
-- compatible  : should be "qcom,prng"
+- compatible  : should be "qcom,prng" for 8916 etc
+              : should be "qcom,prng-v2" for 8996 and later
 - reg         : specifies base physical address and size of the registers map
 - clocks      : phandle to clock-controller plus clock-specifier pair
 - clock-names : "core" clocks all registers, FIFO and circuits in PRNG IP block
-- 
2.14.4

