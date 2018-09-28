Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F45021733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PMvvxtX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F45021733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeI1I1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:27:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:52925 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeI1I1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:27:52 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8S25FOj028340;
        Fri, 28 Sep 2018 11:05:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8S25FOj028340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538100319;
        bh=XGojrsnwjAgD51xEtjfEzPRhMtXDHakaoCtK5KRPciE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMvvxtX2zfqvSn4GuMotZUyjSUP6Yl+KPKnBx4fSAaW8vu5tNNNW91TeEZfv5iD1g
         3G/nF17QbN2LmjADjlA1EdGsECT4mRWA9lSSVfXR0ev4iOM0/grwCnfzp21yhilHY4
         kCo0vak6PhGA8ib66d05UIKlFAP8qXudND27ugo4PqtMEcF9//RCNhunxpo4UYUezj
         Jf+3lEobltnT+SxLyMmQq4ZBsLHTc8f3Cx5KGorFoXlXVE+9F72Z71qy5yetN8Oani
         wgefCxh2tvNKQ4HM7OStThdt3pFs02bNcKnkTE1s2yuNrRhnjqkMnMWrwgSYflXBw0
         rDtVN8E0xTXsw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] serial: 8250_uniphier: add auto-flow-control support
Date:   Fri, 28 Sep 2018 11:05:09 +0900
Message-Id: <1538100309-24323-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dai Okamura <okamura.dai@socionext.com>

Add selective auto-flow-control support for UniPhier serial driver.

Signed-off-by: Dai Okamura <okamura.dai@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2: None

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

