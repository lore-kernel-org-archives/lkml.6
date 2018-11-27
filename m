Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37DEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD92620989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NiQKl+6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbeK0XAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:00:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32934 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbeK0XAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:00:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so7554856pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 04:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48JQhctEJOoIDWxAa76+1Gc2OHJ05xQ1fJBQHON4z9Q=;
        b=NiQKl+6swRF51v8ax65q0KNW369dXl08FhBgedrF+JwaJ8y4wjEulJkfmQJGiPaB+g
         RC/u2aBKEyq6hV7jwDNmQZ+Rj5k6xq/BBzX4puGi2Zq8IsdIMM78nfOFvzb1WnCSQVCC
         gUtNHwocybIfmVRZqSWs+NVuFs62MTKk721bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48JQhctEJOoIDWxAa76+1Gc2OHJ05xQ1fJBQHON4z9Q=;
        b=Zrc6RtKfYJYaKBDAS0ttKFPXOTuqjRc3lQPhMuUaAFYKhSDpt8W0eTLNhCR76f0eQK
         Y6XtW1u3oYGKJNU/Wh3xQ7qi6kewrOe8+B/4H9cyArwzT3K0C4Tr4/V5bosOvD9YYFVz
         v1a9FnzRSPpULD44p841Gi3EatjLFUfBTfqxVKpJkdIZ/b6iimOROuEfXDNGM47eizr8
         sAD9BQ+T4N9HJfsT/y4rYiFZrsJl9f3HY32hCH0fekLXh6sPwTMhoG0Cy10cO+nu7xtI
         Cfi5ioyCZHCV+BMFPlQ7lM88c2G5vak7/Vr+BSSj0e9hUm3TknDLZe7mKRfTH+DUAoju
         T5Tg==
X-Gm-Message-State: AGRZ1gKUe6beq8xlFLc2IcTCB8yMjMTIDQqWCf/vyQkEC9/9KZA/1Yqz
        n9c/bMgxll12GBDLx6MUVFh0I+js7po=
X-Google-Smtp-Source: AJdET5dupqCEC+w7EsbNX+X6sXfpAqLEErWP4qzuG6gzZlCw1uJEHTSE6Q8Nw0b99i55WZY0Zrue5g==
X-Received: by 2002:a62:32c4:: with SMTP id y187-v6mr32619461pfy.4.1543320154963;
        Tue, 27 Nov 2018 04:02:34 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id m85sm8312778pfj.171.2018.11.27.04.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 04:02:34 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 2/3] ASoC: Documentation: Add google,cros-ec-codec
Date:   Tue, 27 Nov 2018 20:00:40 +0800
Message-Id: <20181127120041.90759-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181127120041.90759-1-cychiang@chromium.org>
References: <20181127120041.90759-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 24 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
new file mode 100644
index 0000000000000..57718382b3a36
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -0,0 +1,24 @@
+* Audio codec controlled by ChromeOS EC
+
+Google's ChromeOS EC codec is a digital mic codec provided by the
+Embedded Controller (EC) and is controlled via a host-command interface.
+
+An EC codec node should only be found as a sub-node of the EC node (see
+Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+Required properties:
+- compatible: Must contain "google,cros-ec-codec"
+- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
+
+Example:
+
+cros-ec@0 {
+	compatible = "google,cros-ec-spi";
+
+	...
+
+	cros_ec_codec: ec-codec {
+		compatible = "google,cros-ec-codec";
+		#sound-dai-cells = <1>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 91b4218195aac..5cf8ab296cc61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3552,6 +3552,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
 
+CHROME EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

