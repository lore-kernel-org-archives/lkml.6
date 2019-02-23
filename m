Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D54C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1A42085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpLLugPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfBWNII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37842 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfBWNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so4238122wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UlLUZKsUBvvlpp0PaigJ6mdmQK3TFOW7gecu0d4T2EM=;
        b=rpLLugPKE3VjBq8hpMgbn/E3iCQ7NrglNUKzVk7OB+Ts6AO7WX85rxwO7AJcRBbAfo
         a+PCya51ahL6LlJFQLBos6FSNC81J18r3l8YEzk/K8Gq2KRFseMfPaqIIgPNPEshZLZ5
         Hksga7o584Jo40Jl0zM0WTOYKyssIbts1+pH0ucV0dhwMOzERSstxP91oseJCp/rJPq/
         QZ2LqFca/dUgqoV5JZDw6tSHiXoiaoT3b666p6m+WzMHrAt/CVXfw0UYvJqslevAqKRn
         mrVXZeUzSd6NYTORtePhKGEK4lBNRxGu2i2PvHp0y4hlqJTXtqBayPt9snmahMiWi7lu
         /JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UlLUZKsUBvvlpp0PaigJ6mdmQK3TFOW7gecu0d4T2EM=;
        b=QMYkYbtNj64o48sZhEjMVItBYMSwmwO3FwLzeDlnXtn8XtSrq3OQlqDRXEnDtslQmm
         R+0OkHOJm09837f6e6YhmUcvGJFnHA/d9qFT/vFByPi6ccDMR/awS3Vxg+XbxR0wHPD5
         o3+1IPJWIZchPrF77vvjQaipqufNv4eJL+ppWKmx0pHEjiOZuef7ISLUsDsMv+j1E3Vs
         gkKIk/jS4LaRJ9d4a7R2jl3haBG8l4N3xS6ru9DH+ocU6LnG/VJjjv2p0gVVRU3hDE6B
         OqoMjSWjTfU08hhUz3mV3V75rWPHriZ83A9MntnDMIBqcyf7v2p6iGY4cmA70Aqth80H
         5NCw==
X-Gm-Message-State: AHQUAubaa2jo1Ik8gNwGfj/YgC4ya2bcAAKjrC228tAiR8P+pPJ494Jw
        AUcyYFaCpbHIYvaCT+7pva7fxg==
X-Google-Smtp-Source: AHgI3IaqR/dPx7WZkvryoweerYgPvxgdNo5+GB4qMlDx5oDBAqVDDbCw5QbpimUDCqoqEJbn0STK0g==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr5682743wmj.0.1550927283021;
        Sat, 23 Feb 2019 05:08:03 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 06/18] dt-bindings: timer: renesas: tmu: Document r8a774c0 bindings
Date:   Sat, 23 Feb 2019 14:06:54 +0100
Message-Id: <20190223130707.16704-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Document RZ/G2E (R8A774C0) SoC in the Renesas TMU bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 4ddff85837da..13ad07416bdd 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -10,6 +10,7 @@ Required Properties:
 
   - compatible: must contain one or more of the following:
     - "renesas,tmu-r8a7740" for the r8a7740 TMU
+    - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
     - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu-r8a77970" for the r8a77970 TMU
-- 
2.17.1

