Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B6120661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8YZWafT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfBWNIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45635 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfBWNID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so5159008wrn.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4hvqmBcDEXpGFW/EoS27NZ2ZFW8t9Sep0ptzXoc9+DY=;
        b=F8YZWafTyNupAq6B2kPaBN/5HWTiipQYpz0DKKQM/13aVeOwA3GCtcjatAQA8J1Das
         6jNqtb/Y59JS1WCZi0MYeqOoSYM6vwxC+YYeeFqWH8+vdL8NPCjTFhXFEEgGgRpmMNUo
         fR+6gKN3To8WZGEj/m50DSeyxiLJcneKrrQDhjgnNq3Mn2bP0JRZdcn8CMjxyypJQ8KK
         Tquk1H3/+4TveXIhdcy/OmYxnw9O8Rq7DLGEjVrRuTC/v8jle5Fbkh5j0I/gXpG7AR5b
         V42zsaCCogxxCqERY23zROr23feOVPfMX9VKFzAf0Im1plrZ2o/C6MNKku50PyVtv2zH
         IoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4hvqmBcDEXpGFW/EoS27NZ2ZFW8t9Sep0ptzXoc9+DY=;
        b=VaJ2S5tE33HlkmUph0gJVcTRt0ojD3R3YG8MxsDuY8xWYVdA6P2t/S6p5sl9EbQzU0
         F3393GmsQZaIbP+4LON6bLogsc/YG85qPzJ4AmdWHImb2jnz9EZ2meaDyihuG/W6AHKA
         aRcjHS4h6QmTcvzFQtOXCmmOLbsnfLHjNqJpJ77OcFkPp60oN367kopS8N+qQmW5vYqK
         seE7hN6KFxVmVGlX4WZfn5vkxdy7wGKAHMmB9u9q+/mVnvvgEuUsFYSHwTZgryKkh0lq
         hXonUnleCiucRaRMKcP1UfTdZvRaFi5mljut62Jk6h4SfUed6swtAptopWJO5hTkaLWw
         UHdQ==
X-Gm-Message-State: AHQUAuYdyB56BVSF5kS87D5USH/WtkURYiGILRzleh02VG4iOObPf5Ah
        cW+BQ3EIAdiXseVVlVcCq+/Bbjws9Lw=
X-Google-Smtp-Source: AHgI3IZ/HAUBY/MY9/2rPGch3Jp3J2OlOkrYuvAi4fej5L+WtG4ANxOsW1unOwJHAwwA/wTs7nUjaw==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr6692721wru.286.1550927281435;
        Sat, 23 Feb 2019 05:08:01 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:00 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 05/18] dt-bindings: timer: renesas, cmt: Document r8a774c0 CMT support
Date:   Sat, 23 Feb 2019 14:06:53 +0100
Message-Id: <20190223130707.16704-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Document SoC specific bindings for RZ/G2E (r8a774c0) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 862a80f0380a..c0594450e9ef 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -32,6 +32,8 @@ Required Properties:
     - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
     - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
     - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
+    - "renesas,r8a774c0-cmt0" for the 32-bit CMT0 device included in r8a774c0.
+    - "renesas,r8a774c0-cmt1" for the 48-bit CMT1 device included in r8a774c0.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
-- 
2.17.1

