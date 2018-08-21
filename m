Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837FBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DAD21854
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2QVljyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DAD21854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHUXRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:17:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47001 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeHUXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:17:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so15229311ljj.13;
        Tue, 21 Aug 2018 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DVE6PpUvFq4CLprqWo6Eq7kEfRGyHyMeIbkuOnlqoVM=;
        b=t2QVljyRVOUZfHdd3+38A9geIXIxptfDLvujhaluJzsnAdgDAJ6dMtlUX56swlW+wH
         RuNjAHt0LW7aleGLnKoyKw7c9DWjueL/wrL0TY5CPXyA4d4Tosa83nuigmYKtd6GHyJF
         kcjRc5HXIrBUIXfU/EIuJm9QFH6N8+16pLaVLQuTKipMejUinwkBkd8SOyrQeLQmiQXN
         tSEwKc4mkH0fNgO0hKyWZi4JztErCE16K6x2040lhQeDVNnkZ0KKdTPfdEcYRhNmBkQn
         t4wxPyOHnhAPQErI1dUcoLy4FjBvmnTMf0obt94ICFJFHwhAj2jQ5m/P0tFeDsLyjT69
         a56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DVE6PpUvFq4CLprqWo6Eq7kEfRGyHyMeIbkuOnlqoVM=;
        b=AyTg9XKJdCLFnuCYpGUhcOGOHhcAFl56s+CZoWFIXrbfEdVJ5GrjcwKmGsYOCcKJWf
         xDJgHN97XDFKunI0IzYfwllix2pgxGzJGSxitllSKFnVyRjltu3Yw7MYiJKG/IO05H96
         i3A3mqANWV5nDMOiyF4OQfr8vn+EckWdtQuOj/jV8gWfrrNPUYS4n3cdyR1Z1vkG0pdD
         NUVKDZ9g0borSnHEbQlakwk84drlD8JqK0VZiAWFX0KnbbXdllSGHLCINwWMqkEpdbzR
         vBw9RJBnoRQm4tq+/Mf0cwX7n50GYODTZGVfXmpaKslY4sG96HgiLlVnhJJsmJNHM6cy
         jrBQ==
X-Gm-Message-State: APzg51DnDOoYdSKkxVAcYjazI2/7S7aiEPpiiWb4G1qpJcj5u1tiOWLZ
        v9GH9znlsObylBgQsipYoQTwVj0uEh8=
X-Google-Smtp-Source: AA+uWPxovMc5FaeIeuZnFWnWt9c/3mVklbm0Nt08ESRmmxCaKLaEeyV/W+kVuXQpe+ljyScNA1FINg==
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr4745649lji.97.1534881331663;
        Tue, 21 Aug 2018 12:55:31 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id l141-v6sm2449374lfg.55.2018.08.21.12.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:55:30 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: dac: add bindings for ltc1660
Date:   Tue, 21 Aug 2018 21:31:25 +0200
Message-Id: <20180821193126.15733-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180821193126.15733-1-marcus.folkesson@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
with eight individual channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	- rename file, ltc166x -> ltc1660

 .../devicetree/bindings/iio/dac/ltc1660.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
new file mode 100644
index 000000000000..c5b5f22d6c64
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
@@ -0,0 +1,21 @@
+* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
+
+Required properties:
+ - compatible: Must be one of the following:
+		"lltc,ltc1660"
+		"lltc,ltc1665"
+ - reg: SPI chip select number for the device
+ - vref-supply: Phandle to the voltage reference supply
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 5 MHz.
+
+Example:
+dac@0 {
+	compatible = "lltc,ltc1660";
+	reg = <0>;
+	spi-max-frequency = <5000000>;
+	vref-supply = <&vref_reg>;
+};
-- 
2.11.0.rc2

