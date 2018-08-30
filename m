Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27791C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6892082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qi9dUqFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6892082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeH3XFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeH3XFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so9031855wrc.0;
        Thu, 30 Aug 2018 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYF4vw+H13TqDhRHDPAO494ldTC/en088YlLmd8H0Lk=;
        b=qi9dUqFQ0tN5DJbV79V9Kio4t1mQfMyfMCviV1Nr9GRk51JH8S21uNzT+UoVRXvK7S
         EdG2YCFNWtMJ01um9n/4TztLeqdxY//dsKd+1m17PNIH1pRQLBW60hjQVRC/dnyHMf/I
         pzWhHymJLuimSDBzx4o7s/GHCXojDNuXzwgo2eI+7+RJsj+VnaRP8w/FiQwexS7AfXVM
         cTUXI8MWvmumb4CfwwmRVbDBQbwgtV6LihGBELT4NreQLhK1wwdIJueXwK2lef7zxe0J
         0Tgccu6YnV6W1WGwiZzD0PGfL2Fuwji+zu6rhLxGF69tzdtyW9TQsRKDvrbTnalgIXkY
         K3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYF4vw+H13TqDhRHDPAO494ldTC/en088YlLmd8H0Lk=;
        b=nmCa3sPP7cDIi2ttDmjq+fbWBgvFNjnS7oogt6ZEeS/HLcJihBmEwv4j/muwHDsq1d
         zky9Pq0lbi31E6bQJ+EydTjInTxTQe3WTeRIXKYa9v44eXzhHq6AyZwhej6xx4RAstS9
         Jr9pzQ02oBeXMB2DuwfwPtnIvORSAOs3sRagB8k6i5klmE0gUbbArfhGV+uPXZ3+W5HR
         g12h5Swihw91wJAU/yvM/gqNf6zUZsAAVlUZ0PjjpoL0/C9/YxAGmjVqdlWuoXnYXo8b
         6tDcW4LzuS1AnBXvRMfw2pnbHm2eX6upraHozP+tPbd1mgXb1ljsDiRMsB0rGAw4GLqa
         TP+Q==
X-Gm-Message-State: APzg51DAWxic4ii5LBabNQOK4COQoR6pCfrKnsDk50Jb43EjbBPcG9r1
        ddrgkdIEWjmsJUZq+X1hpB8=
X-Google-Smtp-Source: ANB0VdZkBUeh5YNoWk6eGEk0v4LP31uLIqZhjPS/6SCQwo6hXW7TvNRnTwspikAs8Unuhl84TlTbwg==
X-Received: by 2002:adf:9e06:: with SMTP id u6-v6mr8392154wre.51.1535655705436;
        Thu, 30 Aug 2018 12:01:45 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:44 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 11/13] ARM: dts: sun7i: a20: add sata-port/sata-phy nodes
Date:   Thu, 30 Aug 2018 21:01:18 +0200
Message-Id: <20180830190120.722-12-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert sun7i-a20 sata to the new binding which use a sata
phy node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8f7e1e29841f..8ff28f7afa85 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -667,6 +667,19 @@
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata_port: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy>;
+			};
+		};
+
+		sata_phy: sata-phy@1c180c0  {
+			compatible = "allwinner,sun4i-a10-sata-phy";
+			reg = <0x1c180c0 0x200>;
+			#phy-cells = <0>;
 		};
 
 		ehci1: usb@1c1c000 {
-- 
2.16.4

