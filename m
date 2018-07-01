Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9B6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0500D22AE6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MaSDfffo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0500D22AE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031365AbeGARXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:23:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33083 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031084AbeGARXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:23:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so6079440pgq.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3sErEIs2TdQVU1vCbLuXOpei3kXzzcqD58jTzbNExU=;
        b=MaSDfffoerGmI+Bo1tCX+ZGDEJX7ped0O9TV7ameQuKICsxXs3a3McpMsqudtpWRhC
         gX2cOz8tz1JZ+CUKuB/9Ooq1WvkF0uQDUM71k3jYy243ccz5E0Y/lW9iOjd4xPRNh4Gh
         c3117//4+7y8R8B0mX/WtwXDDbKlCSP4ZVPWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3sErEIs2TdQVU1vCbLuXOpei3kXzzcqD58jTzbNExU=;
        b=FdZDRcGIcJ6/tG0U//aL3PzjVfhA86etsqnhSWsbkyUfniPc3T9ZlIqo+/3TuBJT34
         7OfAHUoT80J8kN09tlOANDWH9Ty6WyLuT+vPq2p9GLatn2iO6vTycdNyD3PIzt4Ah3g5
         MaOALDscTY938B/Luw5H7Kvpx5DXFm1+ofl1iDTf9EPMiDaHbWtdciFy6SsEG3M4HszO
         nvWhzpkiuLql2zey3osxS591FiLNK07JKywJbVZKDNYrhFUUtKuXpfXpUExxpYVHGlMa
         nsjNYurZlvNc0cALaMEadPpuyTwZnoo5csZSxL7f43HoDIRe5Wk6NKcVDLZ228dNv/TH
         6nMg==
X-Gm-Message-State: APt69E2IM+WsPmV5F4Pplq9uClo1SHdCbz6WnKJRJ8mHko6I5j5pBNuy
        V/WIKGwFyFF5W5eE1KI5FErh
X-Google-Smtp-Source: AAOMgpdcyjknHcSRvATYP5VlO9K35sY0r+GXlFeuBGZBOMv1FAVtHSgShmZZkX4uLw3K6gQDdF2fbQ==
X-Received: by 2002:aa7:8004:: with SMTP id j4-v6mr22178819pfi.174.1530465827900;
        Sun, 01 Jul 2018 10:23:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:ea77:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id f10-v6sm17989836pgr.30.2018.07.01.10.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:23:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/6] dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
Date:   Sun,  1 Jul 2018 22:53:00 +0530
Message-Id: <20180701172305.15663-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semiconductor Owl I2C controller

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
new file mode 100644
index 000000000000..b743fe444e9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -0,0 +1,27 @@
+Actions Semiconductor Owl I2C controller
+
+Required properties:
+
+- compatible        : Should be "actions,s900-i2c".
+- reg               : Offset and length of the register set for the device.
+- #address-cells    : Should be 1.
+- #size-cells       : Should be 0.
+- interrupts        : A single interrupt specifier.
+- clocks            : Phandle of the clock feeding the I2C controller.
+
+Optional properties:
+
+- clock-frequency   : Desired I2C bus clock frequency in Hz. As only Normal and
+                      Fast modes are supported, possible values are 100000 and
+                      400000.
+Examples:
+
+        i2c0: i2c@e0170000 {
+                compatible = "actions,s900-i2c";
+                reg = <0 0xe0170000 0 0x1000>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clock CLK_I2C0>;
+                clock-frequency = <100000>;
+        };
-- 
2.17.1

