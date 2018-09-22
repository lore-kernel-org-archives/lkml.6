Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE81C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049382150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DspAyb7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049382150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIWCxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:53:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44070 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeIWCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:53:41 -0400
Received: by mail-io1-f66.google.com with SMTP id u12-v6so9944153ioc.11;
        Sat, 22 Sep 2018 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=DspAyb7OEE2TGkgUmXYaBBkmixn3zlpoNYCDnDBx4kqeemh3EwSW6z1qyyAEQGuziA
         AHpJw/wyJD7eAbkG41J3KCYgrQAQFWmqjacbsbVHxMA9lBPEk+SDEzfUOlrKlMLbgzUb
         WBAyFgttjRBvaXmCftmEo1P8ie75pIcWDB5ZygXugHg6Sx+uQbFDVRnh9FkAV7Aec2N5
         i7V1SYEuqiFpeOGHpYub19qnRrXhHi1RFAW3yh6vhNURajKzOctNfAGhDlVmo6gfkoLu
         1ndc/I0ylGctG2oNz+BNRaIoBlbP6JUCQD0pjm3TvMc6B+pIXhlM2h+XmNKdpQMbr5rp
         dYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=c6/54aRIJqXVkf6y5uUj73Cc7WSlVHwFnVLwZ7ndNuLfiO7Rjf1A7HZovJ3Z6nA1nP
         /SqnC/7M7r2VRQK0MQy12pFv13DrABtDVE8m3LwQIm1wPG+SGCjhFv3g3yuOzVO5IRRf
         FhA+eXMOoZ6/WBjbwYVGi/l64KI1T5DSKnk+NdOlxDnIkfJcvCvMb82I2E8EBB+J7GpY
         xbnh1Pa7zzzuUIjrFfsEwITmtVtj8uLyNsVwUNGU9wHErEKAEokdlHm5S2HfUGYnTDSX
         D1NaZ9dEa1KQbNBGhxuT4bQ7JJB38/O/gTKB3VyxGidA0TgELB/TTUJnaYvJOcP0/WUP
         Moog==
X-Gm-Message-State: ABuFfoiVG++69ZGVgNgJ0zOTpPk5nwt2AD5ayoR5WdNVRC4FJ0LH0wI/
        mpMB8fD8nVV5otEN4ASGWA==
X-Google-Smtp-Source: ACcGV607EOBs3GhnJNl+q1HDms+TtHcDYgNrpfyhQ8luV+5XfGoMDZF90AbrBORU/UYAiGcmnf1KFA==
X-Received: by 2002:a6b:b48f:: with SMTP id d137-v6mr2926733iof.163.1537649925577;
        Sat, 22 Sep 2018 13:58:45 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id k62-v6sm4465306itc.21.2018.09.22.13.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 13:58:44 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree binding documentation
Date:   Sat, 22 Sep 2018 16:57:53 -0400
Message-Id: <20180922205754.6100-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for ROHM BH1750 ambient light sensor driver.

Signed-off-by: ryang <decatf@gmail.com>
---
 .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
new file mode 100644
index 000000000000..468350cc7af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
@@ -0,0 +1,18 @@
+ROHM BH1750 - ALS, Ambient light sensor
+
+Required properties:
+
+- compatible: Must be one of:
+    "rohm,bh1710"
+    "rohm,bh1715"
+    "rohm,bh1721"
+    "rohm,bh1750"
+    "rohm,bh1751"
+- reg: the I2C address of the sensor
+
+Example:
+
+bh1750@23 {
+	compatible = "rohm,bh1750";
+	reg = <0x23>;
+};
-- 
2.17.1

