Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B29FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADE32086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADE32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeIJQVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:21:33 -0400
Received: from shell.v3.sk ([90.176.6.54]:35747 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeIJQU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:20:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2230FB82E1;
        Mon, 10 Sep 2018 13:27:19 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OYGvoZ7pcHND; Mon, 10 Sep 2018 13:27:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1C9E9B82C8;
        Mon, 10 Sep 2018 13:27:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VFXi5nT3D4GG; Mon, 10 Sep 2018 13:27:00 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DA8CAB82C9;
        Mon, 10 Sep 2018 13:26:59 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/8] dt-bindings: olpc,ap-sp: add GPIO lines
Date:   Mon, 10 Sep 2018 13:26:48 +0200
Message-Id: <20180910112654.42061-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties describing the GPIO lines used by the keyboard controller.
The olpc-apsp driver will do happily without them, but they are still part
of the hardware description. The driver could still reserve the lines,
so that nothing else touches them.

This makes the device node almost compatible with "ps2-gpio". I'm not
adding a compatible property, because ps2-gpio would use a different
interrupt, so that we'd need to name it. And I haven't actually tried it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 36603419d6f8..2b1b1dbb54c1 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -7,6 +7,10 @@ Required properties:
 - clocks : phandle + clock-specifier for the clock that drives the WTM
 - clock-names:  should be "sp"
 
+Optional properties:
+- data-gpios : GPIO line used for PS/2 interface data
+- clk-gpios : GPIO line used for PS/2 interface clock
+
 Example:
 	ap-sp@d4290000 {
 		compatible = "olpc,ap-sp";
@@ -14,4 +18,6 @@ Example:
 		interrupts = <40>;
 		clocks = <&soc_clocks MMP2_CLK_SP>;
 		clock-names = "sp";
+		data-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
+		clk-gpios = <&gpio 71 GPIO_ACTIVE_HIGH>;
 	}
-- 
2.17.1

