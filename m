Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A2CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D552064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0IdJt55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D552064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJFFvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:51:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43271 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFFvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:51:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so6293709eds.10;
        Fri, 05 Oct 2018 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ev/QCaVqmOoJJ8/PoigPeDf97iALAXDCj3dYztTupE=;
        b=f0IdJt55Hrct7sO4BjExI66PDLoEWGGm5CK82K/emR9fXws3/r+j/FHmESMwTtou9C
         fOKVsJitMfY27gnI/8Wb62tXE6eEyBHd+VUx+8rjHo+dp8N6Q76UM5EOZVcDXfOSHxOv
         La5Ky3JrPGWR29vmRRsjWVGzPmgNjCpz1eYXw4iuusMDzbRXVMyRD8CGK2dQMn8mtbtL
         cWHWk66jLVQFa0euJfNuIgbXIgOUcr5s0qbCCA68DxBGKi443JkU/XIb3GxS5J4Dyttr
         vyLVMZpz1bN4EW8um8zxmARKEr+eLVvkObxfp6atEH7T/3Nm8xOz4sxK3QrSGqsLWP/v
         eRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ev/QCaVqmOoJJ8/PoigPeDf97iALAXDCj3dYztTupE=;
        b=A10h75/681PTVj+8AGJJez/FiidWyy3uJh17HAqtBsus33tgkvTW+JnDyrGg9gVYZt
         zHxXRT5+0hfgzzNwgWbaX08fk6/bYWHFuZiz3dP+JpKeLa/BIiKhXXdiXT8rAqjUEui4
         1nQYv3CO7NHwyFeAualophdJa7UReeE9s1ocioAqwCjaUN7dnUTH/3QzRWOu5SdSzOhc
         T18IUE6E9ABcmY9gLrkCN8T5sz6rg8RxzHOhR98xktj6jZQe8FVVLOwu1NDuKXLVBrKH
         M2+w8QzHv5ocFRjF0UYFFa7llQalvylyNVmzmpqz4uzW3dBlRN9pg4dNslKQP6HNtfCM
         aC1g==
X-Gm-Message-State: ABuFfohmHM6l8GM3x5PMb6ukwrfkEXoBq6aNOZUnZLsm9Y2ADjEU0+My
        bPc4g7Vs3K2YWNd+3gJXEWo=
X-Google-Smtp-Source: ACcGV60R3d9IyilM+TxkV1n4S0wry7gd94TRCTNRdTWYooo1W26GBPFh0yJDopKgsJNhwaYh4YBI1w==
X-Received: by 2002:a17:906:504b:: with SMTP id e11-v6mr13568648ejk.48.1538779814361;
        Fri, 05 Oct 2018 15:50:14 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id d23-v6sm2600529eds.47.2018.10.05.15.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 15:50:13 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v11 1/3] [media] imx214: device tree binding
Date:   Sat,  6 Oct 2018 00:50:11 +0200
Message-Id: <20181005225011.3269-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for imx214 camera sensor

Cc: devicetree@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Changelog from v10:

Sakari Ailus:
-Re-introduce clock-frequency property

 .../bindings/media/i2c/sony,imx214.txt        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
new file mode 100644
index 000000000000..f11f28a5fda4
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
@@ -0,0 +1,53 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3200V. It is programmable through an I2C
+interface.
+Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
+throughput of 1.2Gbps/lane.
+
+
+Required Properties:
+- compatible: Shall be "sony,imx214".
+- reg: I2C bus address of the device. Depending on how the sensor is wired,
+       it shall be <0x10> or <0x1a>;
+- enable-gpios: GPIO descriptor for the enable pin.
+- vdddo-supply: Chip digital IO regulator (1.8V).
+- vdda-supply: Chip analog regulator (2.7V).
+- vddd-supply: Chip digital core regulator (1.12V).
+- clocks: Reference to the xclk clock.
+- clock-frequency: Frequency of the xclk clock.
+
+Optional Properties:
+- flash-leds: See ../video-interfaces.txt
+- lens-focus: See ../video-interfaces.txt
+
+The imx214 device node shall contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Required Properties on endpoint:
+- data-lanes: check ../video-interfaces.txt
+- link-frequencies: check ../video-interfaces.txt
+- remote-endpoint: check ../video-interfaces.txt
+
+Example:
+
+	camera-sensor@1a {
+		compatible = "sony,imx214";
+		reg = <0x1a>;
+		vdddo-supply = <&pm8994_lvs1>;
+		vddd-supply = <&camera_vddd_1v12>;
+		vdda-supply = <&pm8994_l17>;
+		lens-focus = <&ad5820>;
+		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+		clocks = <&mmcc CAMSS_MCLK0_CLK>;
+		clock-frequency = <24000000>;
+		port {
+			imx214_ep: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <480000000>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
-- 
2.19.0

