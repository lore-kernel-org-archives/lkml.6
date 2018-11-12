Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26892245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JqxkEHVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26892245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeKMIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:07:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33589 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbeKMIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:06:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so4972590pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26ev3qUdhHe168g6YKc/sElZ0TK98Gp0wg9uJPpctwk=;
        b=JqxkEHVsTyd3LPmk790xjkZm0XG0U+21vtipyJf4IZknnpDADQmEE1of6Lc52lclZE
         gAsXoqwBqlYZYUjmWelj90HnP385aq79u76oYpZfyqfTiMbWIpyYdJnrZqzLHSR6QF8f
         Tfimo6SHWS8B+d825tz8k5QeAZgiuvmcwc86o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26ev3qUdhHe168g6YKc/sElZ0TK98Gp0wg9uJPpctwk=;
        b=oj5k2bIZrFRzAtwRjHabqxHXbNMwKnobp2JhOhQtyCG776jlSvFS8KzufobhIpMKzO
         o+Ek5MG1TFbFS/v1JvyTxjwpdq92exTTZNKGlpJS2DXjV2UHV0TPDI0wXIBn4z8JsyYr
         DF1kpgqAa9O7RVQQKXzWt5UEoYUFYp+Tc/C7cRYo/7bJ7AqcWw4YIXh8VZNzb/UDEyIN
         GN7LAQe7iXic1WwKxzNHpUAvIO4/I74ZusFEWYl10L3reC0f6xTK4ESgvGHMyFqJcmUA
         6gsfiYsdyPfzKo9cMOeGivKCqm0mODXoZNJQ+Mre9DVh3SKWouXtrspl+A7zZLfLNYp3
         cyKw==
X-Gm-Message-State: AGRZ1gITJosqb+4W7PD9k8Jbqr47p5+Kqc3rgX7UyPpyQyIe+VZ9hRv/
        Y6Xd6iiROr6+TUOnsbAZ2qg+/A==
X-Google-Smtp-Source: AJdET5f3IBCYS3dMBWmFCQegagEKx6gUpsRglHC+uuk8mn0nBLITce8CHLh20ro6/HVZOI/bKn6pvw==
X-Received: by 2002:a62:db44:: with SMTP id f65-v6mr2576275pfg.94.1542060712171;
        Mon, 12 Nov 2018 14:11:52 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z2sm16166706pgu.4.2018.11.12.14.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:11:51 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 1/2] dt-bindings: iio: vadc: Add unit address to ADC channel node in example
Date:   Mon, 12 Nov 2018 14:11:25 -0800
Message-Id: <20181112221126.27142-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181112221126.27142-1-mka@chromium.org>
References: <20181112221126.27142-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node has a reg property, therefore its name should include a unit
address. Also change the name from 'usb_id_nopull' to 'adc-chan', which
is the preferred name for ADC channel nodes.

Include headers for constants used in the example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- changed node name to adc-chan@
- added includes for constants used in the example
- updated commit message
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v5:
- patch added to the series
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index b3c86f4ac7cdb..c81993f8d8c39 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -140,6 +140,10 @@ VADC_GND_REF and VADC_VDD_VADC.
 
 Example:
 
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <linux/irq.h>
+/* ... */
+
 	/* VADC node */
 	pmic_vadc: vadc@3100 {
 		compatible = "qcom,spmi-vadc";
@@ -151,7 +155,7 @@ Example:
 		io-channel-ranges;
 
 		/* Channel node */
-		usb_id_nopull {
+		adc-chan@VADC_LR_MUX10_USB_ID {
 			reg = <VADC_LR_MUX10_USB_ID>;
 			qcom,decimation = <512>;
 			qcom,ratiometric;
-- 
2.19.1.930.g4563a0d9d0-goog

