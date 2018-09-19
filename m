Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73973ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F22098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dl0af6H3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3F22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbeISLGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:06:03 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:61287 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeISLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:05:50 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8J5Sefc016652;
        Wed, 19 Sep 2018 14:28:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8J5Sefc016652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537334923;
        bh=aj2NTGH4awcML9Bzx/x5Rd2Hsn7+iuu3rhlxtSTWjQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dl0af6H393me43YBwvD4cutxwf5MyhpKTu89gFd/n82ntifDSTARdBaH3CVBMFfVv
         X2TgQ9+eIZh6Hur1PQreJRuC0D6gt5BNtiwltSDF304NcfZxNqM28nHCmBh0mONhhp
         zpz2S1hGznFtadgcrQG4u4apQzqGqlonO4D2bFh6RJ3NR0H54hF9ngRtwf7R0zPX2w
         teOvUHlP8fKDhFQScLxxKG48r2DTxaP4DyHpcXhOWrklw+8xl8pLRJmhR/AQ3Hhyqm
         s7x1lYel3S3lJcWv9w9p+ixDL0xbcaNvOEKyOHUG7c4AJgm3qn6gbfJlNCTczmurQa
         BIYMDkJowRbSA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] serial: 8250_uniphier: add auto-flow-control support
Date:   Wed, 19 Sep 2018 14:28:13 +0900
Message-Id: <1537334893-26079-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dai Okamura <okamura.dai@socionext.com>

Add selective auto-flow-control support for UniPhier serial driver.

Signed-off-by: Dai Okamura <okamura.dai@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/serial/uniphier-uart.txt | 3 +++
 drivers/tty/serial/8250/8250_uniphier.c                    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
index 811c479..7a1bf02 100644
--- a/Documentation/devicetree/bindings/serial/uniphier-uart.txt
+++ b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
@@ -6,6 +6,9 @@ Required properties:
 - interrupts: a single interrupt specifier.
 - clocks: phandle to the input clock.
 
+Optional properties:
+-auto-flow-control: enable automatic flow control support.
+
 Example:
 	aliases {
 		serial0 = &serial0;
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 1028c02..164ba13 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -222,6 +222,9 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	up.capabilities = UART_CAP_FIFO;
 
+	if (of_property_read_bool(dev->of_node, "auto-flow-control"))
+		up.capabilities |= UART_CAP_AFE;
+
 	up.port.serial_in = uniphier_serial_in;
 	up.port.serial_out = uniphier_serial_out;
 	up.dl_read = uniphier_serial_dl_read;
-- 
2.7.4

