Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4027C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C3217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKIsjDUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfA1Jt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:49:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42109 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA1Jt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:49:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so13639930lja.9;
        Mon, 28 Jan 2019 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+eBajr5sUT1GDkyX+f0iiPV/RgW5JIHLA40sMvxhUEo=;
        b=PKIsjDUMgb9Un4bJIAzhManLg8R5iDjxUNw9HRZSNp1SxTGrgpYrrUg75vyVB9MZud
         dQGrgUKLDAEXL8PDBn0756VwGwRTmTz3X4QxT9rCreMqMY7Qk+zMF1vJkor/0Q85rsZp
         M8rjsxiROe1JNVG/1KZ39rMv8ggNpIKGkdhMOgybB3JEO2P04+BKAUZP0YvOQZVjJSaz
         d/TaEab+CxDl7vZ3roYTvjlgYqv3oz+E7ZoSwuPgtPn5mM7sNiqNXfMP4wfLoBfN8WmT
         g/7UUfjnAn8quXLsofsi0/MMZ41RsYDEylUQFwZD7WFtRsLOi2ggPbpYDgcQ7W9nmC5x
         Wyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+eBajr5sUT1GDkyX+f0iiPV/RgW5JIHLA40sMvxhUEo=;
        b=KGcWimghtTClYCa8fJ1aBXas4cwIK31pYDMWnUZKGwXNwSyrRkwOZuK/b+YG+viKt6
         OtJO1t1I0TAw1LlaSwAsqr0uSNY+1l54zW8vljPhJyJXVRpoAa34hbk56LqS4B7OoRvV
         FDHQdwlm58flem6E+zAjVEwS5bpbzuHc+jffjmuYlSgfneGxD3bvbASLg2tk7O2b60xc
         7uJrRyso9xn4OLZX7DGwtEjkY1IT9g3+T9/gmeDr31VegMn7slkB5mG/q52cN4uyWC+U
         Po80Tu3xWn9QXDUubeB0MDDvw1BMdIScV+Guasqbq9wxBnUvSH0uUY+U9XmmzzsOOYNF
         i3/w==
X-Gm-Message-State: AJcUuke1Jd5v11ZYxg4woeRqz5dscK9mSgvhMOSc+RsUEW9deGaJhat5
        HzebgE1LD/KM3PzDopjL7SY=
X-Google-Smtp-Source: ALg8bN4g2ndzto95A+QrlgbsEzDbWlRWAt43DZaEmZQK3x9RZQ7CzLWypSOfnj9yNsWz6xqo/trPfA==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr16414441ljg.125.1548668993676;
        Mon, 28 Jan 2019 01:49:53 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id r29-v6sm2859053ljd.44.2019.01.28.01.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:49:52 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] iio:dac:dac7612: device tree bindings
Date:   Mon, 28 Jan 2019 10:49:31 +0100
Message-Id: <20190128094931.4430-2-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128094931.4430-1-ricardo@ribalda.com>
References: <20190128094931.4430-1-ricardo@ribalda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings for dac7612.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
 .../bindings/iio/dac/ti,dac7612.txt           | 29 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
new file mode 100644
index 000000000000..e1b8158fab35
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
@@ -0,0 +1,29 @@
+* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
+
+The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
+12-bit monotonicity performance over the industrial temperature range.
+Is is programmable through an SPI interface.
+
+The internal DACs are loaded when the LOADDACS pin is pulled down.
+
+http://www.ti.com/lit/ds/sbas106/sbas106.pdf
+
+Required Properties:
+- compatible: Should be one of:
+		"ti,dac7612"
+		"ti,dac7612u"
+		"ti,dac7612b"
+- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional Properties:
+- loaddacs-gpios: GPIO descriptor for the LOADDACS pin.
+- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+
+	dac7612@1 {
+		compatible = "ti,dac7612";
+		reg = <0x1>;
+		loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
+	};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 30ba5435906b..e28e5afaae16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14882,6 +14882,7 @@ M:	Ricardo Ribalda <ricardo@ribalda.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/dac/ti-dac7612.c
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.20.1

