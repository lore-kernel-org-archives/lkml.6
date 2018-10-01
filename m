Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B80C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8B320684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf3br7zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8B320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeJATVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46954 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbeJATVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so3647082edg.13;
        Mon, 01 Oct 2018 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUdiv3GxcKIGRchs0tikWhabjt2xJ5EVou+ayt6rXzE=;
        b=mf3br7znLJYU1fQFlihgt2ZVhv1Y/B8LVOR4ShkcaOqBoUURpq9Ee3eTg376bfwe5L
         l0NSeCKgHf9KocP/DM/RDQgApIZ3xm5jX1gV/AMr2T8zHCuizA7Joo4D4q4NCRhxXwHN
         8fbS18kYZutoT8+sM/pNfT0dsQiTjwYt0K+EflSGdoDeF1ZkiBvZsNtcpQnBMTTQhlcY
         VCMD1vNKj16vM/5xePoXOuMIhitnB/t9xCbEhFeplQV7m1qgwwsYmciKlS598OYEE8rP
         zIfRtiXkKd0/zORSBe2E8WWQrlW20ThbsAVv9hJJ0iI++su9EuIi8tToCI/erktaTyqG
         +X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUdiv3GxcKIGRchs0tikWhabjt2xJ5EVou+ayt6rXzE=;
        b=hxEnxqnU/a+SVyxbuik0LRhkAiqwEZFGx+3YPzYPsWfse5zy0/6OyuAZ1rkoOhXi7c
         8gvNonxskLFJnwxDWlYHIntKwabKRLqWYDqL/QxLFDTPpi502huCmoLhkd9QOVM3iW4u
         5zdhx8mRCYFUo8GOPs9XRg3Bo2F7fR6e32iTb684pCDewBNRgRFkXIyaY1lZhIGlQRQ4
         UV0tghFgXZizc4A+bcocE66Vu7ALLHl4djFG3mBvs46/D51qRqWnqZUQkZP8NG48cA5G
         3X69t19i9bzks032pBGNQGISl1kKd1NVfo6wjydiGfOsQTri7G0K7gM71FsejK12IlZD
         BRyA==
X-Gm-Message-State: ABuFfoj2Cx02uEQl1SrVnJo6GSJEhb3gubVm+dj14upG1PxqD409kpdv
        twRJBeLiJTOeR++FH2Lv0D4=
X-Google-Smtp-Source: ACcGV63BtyOGEAf9psE9xpYOSr9gc4C882N23d8Ukl1B35N8I02wQ8tayHcs6e70Ob7l1G5DSasEyQ==
X-Received: by 2002:a17:906:33c7:: with SMTP id w7-v6mr1640776eja.28.1538397847000;
        Mon, 01 Oct 2018 05:44:07 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:44:04 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 7/8] dt-binding: mtd: Document gpio-addr-flash
Date:   Mon,  1 Oct 2018 14:43:50 +0200
Message-Id: <20181001124351.31615-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for gpio-addr-flash. This binding allow creating
flash devices that are paged using GPIOs.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
new file mode 100644
index 000000000000..5006a26e1753
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
@@ -0,0 +1,54 @@
+Memory Mapped flash with some address lines addressed using GPIOs
+
+Handle the case where a flash device is mostly addressed using physical
+line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
+to a 2MiB memory range and use the GPIOs to select a particular range.
+
+ - compatible : "cfi-gpio-addr-flash"
+ - reg : Address range of the mtd chip that is memory mapped, this is,
+   on the previous example 2MiB.
+ - bank-width : Width (in bytes) of the bank.  Equal to the
+   device width times the number of interleaved chips.
+ - gpios: List of GPIO specifiers that will be used to address the MSBs address
+   lines. The order goes from LSB to MSB.
+ - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
+   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
+ - #address-cells, #size-cells : Must be present if the device has
+   sub-nodes representing partitions (see below).  In this case
+   both #address-cells and #size-cells must be equal to 1.
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. Check partition.txt for more details.
+
+Example:
+
+	flash@300000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-gpio-addr-flash";
+		bank-width = <2>;
+		reg = < 0x00300000 0x00200000 >;
+		gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = < 0x0 0x200000 >;
+				label = "Golden Bitstream";
+			};
+			partition@200000 {
+				reg = < 0x200000 0x200000 >;
+				label = "User Bitstream";
+			};
+			partition@400000 {
+				reg = < 0x400000 0x200000 >;
+				label = "V4L Controls";
+			};
+			partition@600000 {
+				reg = < 0x600000 0x200000 >;
+				label = "Production Data";
+			};
+		}
+	} ;
-- 
2.19.0

