Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EDF208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kx9w9rMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EDF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeJEVfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35806 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbeJEVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so2176789wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DTMX8jL6TWNlZ6h6upwqRAMpW5ePKDtJanTF8iF+j0U=;
        b=kx9w9rMMGDfwLYVE/YHX+WA8PzcdNAKRVtPyKssEYG3x74BqD/9FZ7PHAU4s9qLJGl
         iscgrtF8C7pbHJnS06rKK2TtbYlTXVJBCUm3D0bFJUI8qbulfGHJPmE2Dv0nQQg23eV9
         k1YIL9qFt3XGzF/AfAO1W8425w8Ns82z2WPUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DTMX8jL6TWNlZ6h6upwqRAMpW5ePKDtJanTF8iF+j0U=;
        b=T71FhKm3bYRLcchh8FRbjtXfkRsuteEIpyBuFyw3urr/7m7WkdMUenBNTIdI7mlTlQ
         94KGpg5ATGaXESPo0KtqGzFNLxqLM70LcpF3kFyzoRmpGJpFd0tAZHsTvNd9hrphtd2X
         +Y0vaiPFmxF/QQrIjqayuwojemv2xU/RfhlgADxWcwMi38ymHRScU75ZmPGGu8Coj9dI
         YiMJNfRXKUZY4YliADBv+3kCNqh2G9jqQGUBZrEVSBzHPPR8fFV0NluYiGUSmeb2EJ1O
         yhEswtAE/6eM5sdcuHRrSUTiZAuvjpISryM9EuQxBWUqCO7kq00bqn2jaD50uiEQx5Pc
         yqpA==
X-Gm-Message-State: ABuFfohZZKN9m0SLmeL3c/HP651j0wCnrwXs95mktZxQ0eg+d6A2pYO3
        H901ElXDSO9HzeU4bU/9/cMhDA==
X-Google-Smtp-Source: ACcGV6212oBQa9BRNETzKbWS+BDYpFGryLJvyVmIjFefqqk5vckG3oAS3h8QuA7CZqEB7llnoldDow==
X-Received: by 2002:a1c:7ed0:: with SMTP id z199-v6mr5603041wmc.48.1538750178020;
        Fri, 05 Oct 2018 07:36:18 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 09/13] dt-bindings: timer: renesas: cmt: document R-Car gen3 support
Date:   Fri,  5 Oct 2018 16:35:38 +0200
Message-Id: <1538750143-4282-9-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Document support for the R-Car gen3 CMT types 0/1 bindings -- they seem
to be the same CMT types 0/1 as in the R-Car gen2 SoCs.

Also document R8A779{7|8}0 bindings as these are the R-Car gen3 SoCs for
which the initial support was done.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index b40add2..49948fc 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -34,6 +34,10 @@ Required Properties:
     - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
+    - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
+    - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
+    - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
+    - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
 
     - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
 		and RZ/G1.
@@ -41,6 +45,9 @@ Required Properties:
 		and RZ/G1.
 		These are fallbacks for r8a73a4, R-Car Gen2 and RZ/G1 entries
 		listed above.
+    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3.
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3.
+		These are fallbacks for R-Car Gen3 entries listed above.
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
-- 
2.7.4

