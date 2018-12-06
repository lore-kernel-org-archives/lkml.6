Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD55220989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HIOiqs8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD55220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbeLFNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:23:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46373 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeLFNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:23:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so424583wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6c2p5GS0n2B85+iY5/xmGhhqO6RfF4DQegwQl6h6Xc=;
        b=HIOiqs8xAKSR4DAOkGmINbTCXnUhDcnyRRpT9GverYSRb4JWPkdEdkZBE+9YISrw0R
         +z6biH6a3EiPT3AoQ2eALXvaA8yb/5YIo/5VgTJaqxJBVVQTs6RQneS/86FuM5inipia
         +ge9w2VXLGlhuDJKC8w4O1yIljWRJd7LcLYnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6c2p5GS0n2B85+iY5/xmGhhqO6RfF4DQegwQl6h6Xc=;
        b=GUb5HvdbGJd5bWZ8ValjpUa4a2YA9nmp3oTRDzIsB+lpLwagaasW90X6aF2/afSrTX
         c0Rp2oD2i3Vcy7QXcluElKZYO2qcoTFJPNGixsVbOmh99kGk/S2FksB/5NwljdVukXVM
         FX09xwvTLhND5bKWB2o3q7OpbavN0qqrG3TftdkThLXLnKadaYtD2IMp7dhUjBRvnusl
         9mpnMHEM7gQsjTTUSbVh3qCD6GSKUr/FofjQjmjFXF8bBRlR0Ux0CL4ZNpDcdsPZUgSa
         HAajzKE2YS/zRaDdaNsJTjISR9VJjqeKBteKm+PwuGuXq2GyJRpiMnOTbitR5uCcYi6c
         zGqA==
X-Gm-Message-State: AA+aEWae4WcUR0vZHYvIsKrVUWkTv9dbV5vase1HbJdhEs1Xw4+51IH0
        K784GfRjksVAxv2RbTI4cY5Ygg==
X-Google-Smtp-Source: AFSGD/VyF1KtVW5w4kBnrBCzvVN9RdGneh2hFOk8n4ZgdRZYPrSKB/NQJNw/ysnG/ycX4WnnUUJtig==
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr25496873wrs.156.1544102597199;
        Thu, 06 Dec 2018 05:23:17 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id z13sm363769wrq.19.2018.12.06.05.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:23:16 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
Date:   Thu,  6 Dec 2018 18:53:06 +0530
Message-Id: <20181206132306.11843-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181206132306.11843-1-jagan@amarulasolutions.com>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d7ab0006ebce..902b5238f1dd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3

