Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD9C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A820865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Azutjkkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6A820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeIKH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:28:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43747 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIKH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:28:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so11415667pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhWsM1uFegA3yqM6IdX1PUXA06hwvmU505oKPVKDDYw=;
        b=AzutjkkcFlMX7kVCqd2Bo1L1d1tzXJrROHwMrnoVkxxCvyoHHrb+ITgWAIzK7fdUfF
         CU5+60ayM6xzCAldwwafU2tqBn6L7TcL4SzweljYOwHpoG2v7QGXjRG96PAQfQTDbl+u
         dk11W36bg4rDWbrA6nbQS3GT41qMzw0y8Lhdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhWsM1uFegA3yqM6IdX1PUXA06hwvmU505oKPVKDDYw=;
        b=HYxizPVJi9NkFPXmvcL0SSCp54baUgZV0M87PWodDofjsaOFltKo8daoQTtE5jiMSh
         nwtGXryKBKhaKE7+zHzYpH2CsqCKs4jOE8az3QTRt7ShCZvlzhNp1T9mCDyr8R9VfUMk
         ZBa2y5xJSSFsPjErIEhYlnpnKpMBW/dENfZ9Ng241IcIGotUvaYj5gOhLrgs+NOJxANT
         06SDAKC3NKQnMNLOII79xE5i8x3xvwiDWpAd3xHd5wdEf81MDrusIjwuIoE4M6dZ1kvM
         hSIxz/vUSCMKJWOyyUbZpm3ANKu25IxX0pRkpbC4hZRJ/pRRX29qfrLkatpJVRMN8VDT
         H3Lw==
X-Gm-Message-State: APzg51CxjaQmWIZ4D9l4t6wGNJVQKUMHhHlsqhB2qM7fPSMyHE8+JVQD
        ufSq9svkL8CaVB9QAkintyZa
X-Google-Smtp-Source: ANB0VdaUKgLnuDBRvGuFvNn2QDLA/BEBhtVi9xU3GHvdbXRcr3C8c8U5kupMV1z5ZfHWRSxEGaCwtg==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr25756697pga.142.1536633066047;
        Mon, 10 Sep 2018 19:31:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7200:d313:f895:c3fd:ee92:ac72])
        by smtp.gmail.com with ESMTPSA id y85-v6sm27025893pfa.170.2018.09.10.19.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 19:31:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/4] dt-bindings: arm: rockchip: Add binding for Rock960 board
Date:   Tue, 11 Sep 2018 08:00:29 +0530
Message-Id: <20180911023031.4892-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Rock960 board from Vamrs Limited.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index acfd3c773dd0..4b6888a21db2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "vamrs,ficus", "rockchip,rk3399";
 
+- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
+    Required root node properties:
+      - compatible = "vamrs,rock960", "rockchip,rk3399";
+
 - Amarula Vyasa RK3288 board
     Required root node properties:
       - compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
-- 
2.17.1

