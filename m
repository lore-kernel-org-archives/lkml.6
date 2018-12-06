Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D4FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A06220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="izBcePJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A06220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeLFNXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:23:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42281 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeLFNXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:23:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so452024wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lH8MSC1qJfoEJpVsttBDBCEiyuKYx7BBIW3tep4lLgE=;
        b=izBcePJwngom7M05Pi1POPhFnLrxIqyzp0/SrtubjB/rn8rIS71ucZU7r/+xku7YIZ
         ginbfiYIh2iOr1BDWUgtyKSoqynYP7XJFFbzejnLLDk5D1TWPgUjT4Y7JomAyJZU5wW7
         6deJXvK8lww4KcLr08rIuoIpxDtNmBE37PFcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lH8MSC1qJfoEJpVsttBDBCEiyuKYx7BBIW3tep4lLgE=;
        b=uUKi9y1uoM2KR4nOww+J7InlZulYV020PAJglpw9015YbyWjp7mkTLTnWIhxmNDxlp
         fveSvnKoc8RfmwLSWLiKXcAj5xSQh5ggfmsTtJgLOSHDkQA1iLHHw4WjVTWnf2Zlbn/J
         2NjafLNm1czsiIcAdNIla4TKxIb/UE+BMd51l3phdyYkgnerjl+ZrHQtVdQ8JyrQlqWb
         Qhf14hNKgEGW2wQ62aY/Sj1FflEJFKKM/OHUoXSR7Sa/XVXaD0bcOEK1ANw8QZdhS8JQ
         SsDXuLwTO/UNe757j74TaV0lEi00ouxJ93N/VNkVEFUxm2Iqf4lvwzsupKA/j0laY+dQ
         mWAg==
X-Gm-Message-State: AA+aEWYIBuEMoYpPSsXi+gyjUZN6aTn0h6Jf9nIppR23pyoAfm+KOnEb
        9GajK3k9qdbfS3Az2qMZv9MZKQ==
X-Google-Smtp-Source: AFSGD/UQgEyKM22wgolckkxm3SH0B2kK20abQuKDke00P/LEHKjHBfCCKFpvXH/bX0/6JvX9B+tE6A==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr26842238wrq.133.1544102593867;
        Thu, 06 Dec 2018 05:23:13 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id z13sm363769wrq.19.2018.12.06.05.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:23:13 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/3] dt-bindings: media: sun6i: Add A64 CSI compatible (w/ H3 fallback)
Date:   Thu,  6 Dec 2018 18:53:04 +0530
Message-Id: <20181206132306.11843-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3.

Add a compatible string for it with H3 fallback compatible string,
in this case the H3 driver can be used.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index eb5a14b828d9..5fb6fd4e2c7d 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -7,6 +7,7 @@ Required properties:
   - compatible: value must be one of:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
+    * "allwinner,sun50i-a64-csi", "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
-- 
2.18.0.321.gffc6fa0e3

