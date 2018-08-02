Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B789C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57C72156B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skM0HNDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57C72156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeHBVcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:32:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33474 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbeHBVcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:32:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so2959363ljj.0;
        Thu, 02 Aug 2018 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ge/zeuHLhzqn0+May1kmBAFJppyTrc6eNmZG/rAT9k4=;
        b=skM0HNDe21vLBkZjqI/qaTfJx7QZd+QPeEx8nQWc6l+Kko6YrG9VHZJ1EPqjJ+3tzb
         DKq2i4ElkdZa+y4zIX8KLc76O/VYJCF/XpnCII5vTLSuir7icEx/ado/GCgzQKYf6shS
         xsaYBnMX0AvA1fFb6fs8szauslFc88Gd0vYSciCJI1F2+seq4aZ2D92hPhzZAaCjRo8v
         IXACz0UfyEdFtLPjjGPi3oNW4hlwn6TxEPJtPLJd8foqH2NsEqrIiHJjGfWmcyPz5mcX
         KArsV4/n1BjDknC26ejnrt79IXHxw1uhD9vwmCxmWB3pqEYVSHEmlFKfy0kDX97CvFM0
         /1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ge/zeuHLhzqn0+May1kmBAFJppyTrc6eNmZG/rAT9k4=;
        b=MjH+BD3u/ell1lxXEFxHSj2z1z1lXup+jF/DfNX+MoywgWkOEiGKbBh+G/r8DCalHe
         EN0GnWB9w+jDZswBsPr3p5wz9/+qjWAHsjAbYtOuZy3dl6V3xeRjDXbjj7TiEtdUo5aZ
         QJN6BlbaY0KHhIgnAlbkUoI6SnKQ0TGwJqaF9j0S06+R/r7v5dX1hNKEoSS8y4hswoxf
         qjb9lC5fpD5uN700UxVLE7Ww4HUR4ZMuEPGrpxPg7Ja5IX/BDbKK98WrfcNzysJ3gn1v
         J7NIxJNpVtywmcrZScDb952a0+HwBxVGbDm/Fd+ZUBKpAAAvUy3idG8rZKEGixfX9OeL
         bRgA==
X-Gm-Message-State: AOUpUlF9Yu32aQF/eZdn9X5HzOcCyt3isXw4UHMKqa3U7x3Pve5LMiup
        zPMaSB6wHeCsYFIvmfPpwiw=
X-Google-Smtp-Source: AAOMgpevMtjFUatyWtTz+5VFpDynf1H4h1bYI0V0xRUezfSTee4/B2Gb1b/KjbnVijuswvpr/M4JtA==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr3327960lji.11.1533238784476;
        Thu, 02 Aug 2018 12:39:44 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f15-74736162.cust.telenor.se. [46.194.111.21])
        by smtp.gmail.com with ESMTPSA id m71-v6sm534508lje.84.2018.08.02.12.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:39:43 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Date:   Thu,  2 Aug 2018 21:15:53 +0200
Message-Id: <20180802191554.20176-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180802191554.20176-1-marcus.folkesson@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---

Notes:
    v3:
    	- add bindings for interrupt
    	- prefix device-addr with `microchip`
    	- drop `clock-names`
    v2:
    	- drop channel width
    	- drop `external_vref`
    	- replace `external-clock` with proper clock bindings

 .../devicetree/bindings/iio/adc/mcp3911.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
new file mode 100644
index 000000000000..432da7a28783
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
@@ -0,0 +1,32 @@
+* Microchip MCP3911 Dual channel analog front end (ADC)
+
+Required properties:
+ - compatible: Should be "microchip,mcp3911"
+ - reg: SPI chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 20MHz.
+
+Optional properties:
+ - clocks: Phandle and clock identifier for sampling clock
+ - interrupt-parent: Phandle to the parent interrupt controller
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - interrupts: IRQ line for the ADC
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
+	same SPI bus. Valid values are 0-3. Defaults to 0.
+ - vref-supply: Phandle to the external reference voltage supply.
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3911";
+	reg = <0>;
+	interrupt-parent = <&gpio5>;
+	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+	spi-max-frequency = <20000000>;
+	microchip,device-addr = <0>;
+	vref-supply = <&vref_reg>;
+	clocks = <&xtal>;
+};
-- 
2.11.0.rc2

