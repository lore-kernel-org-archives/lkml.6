Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A317C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EB42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="tL8GagX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EB42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeJXDSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:48 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45854 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeJXDSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 8B2491F984;
        Tue, 23 Oct 2018 20:54:06 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320845; x=
        1542912846; bh=k+kTbGl1n+ueOP3o5mm0IoFq297iGo/lnnK2RBhrLtY=; b=t
        L8GagX/zVygEwXH/aNXTWCk+XnQLTyYNRMkljuhrjpcM65o/VPVCuxzzN10TpVe/
        GEGt5n40utUkn75UPsNbDKyIpURE7c4c0gxnEgN1Ze0aFPh4i2hUSYD1e9JKB5fh
        qhrg7ImbxS8U5pbIYM02SjCMyZxTyXeBY8LNTz2fE4tJzuX8SHBugspNxr0t+llL
        vfhkIV1JMm0nILudk8/SBeoqvPz69kjsFVH1DbLdJzCWYRSKf+et7L7u6BiIkcvC
        Xvz1dTCeTP0YqUUxrRuyMLLGqcqfh4c4vsaKeog6I4OwxqtPoaNrBie0+cEWBgfp
        rW8H+QlYuDh0QVUCFgevMn0knK10yY+H2cZPxdxR6Q0q5jzHxabxQ3upLpbBI8r+
        CCMd2PC+fzY90/8s7leEpcyqAawOL7ah2NwkEO7gaPUospWRJKYv16Ua7ganGZX3
        TRvaRlr6e2pdOyQ+Vbk7D0jgFSBLePjBdHk/kK2GwakxaItb4VSPAcpviDAjmn+h
        ShOMaeRna2fH5bH1Kg5a7bdPMTykaVOM+dMWRLxDaZ/kCfwldAoH+8hW+xsTl5kL
        uVmlFPWTdKOEvBljbg3G/EJEO1NkTIyWlgv+fOtS+hYsaZJTLjpbT8eog0N649q5
        OW+ZRuFvZ2vCNfZ33p5bjhu+OdTlH4vQzq6HzdhbTY=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OqTG2bZUFDN8; Tue, 23 Oct 2018 20:54:05 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id F13AA1FB8C;
        Tue, 23 Oct 2018 20:54:04 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
Date:   Tue, 23 Oct 2018 21:53:22 +0300
Message-Id: <20181023185330.10472-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803 GPIO is compatible with AXP813 GPIO, but add
specific compatible for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index fc42b2caa06d..5337a21d7bcf 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -11,6 +11,7 @@ This driver employs the per-pin muxing pattern.
 Required properties:
 - compatible: Should be one of:
 	- "x-powers,axp209-gpio"
+	- "x-powers,axp803-gpio"
 	- "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
@@ -67,6 +68,7 @@ GPIO0	|	gpio_in, gpio_out, ldo, adc
 GPIO1	|	gpio_in, gpio_out, ldo, adc
 GPIO2	|	gpio_in, gpio_out
 
+axp803
 axp813
 ------
 GPIO	|	Functions
-- 
2.17.1

