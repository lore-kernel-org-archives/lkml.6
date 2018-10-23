Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3C1C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76542081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="ZzpwxEyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76542081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeJXDUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:20:06 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45886 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbeJXDSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 43CDF1FB8F;
        Tue, 23 Oct 2018 20:54:07 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320846; x=
        1542912847; bh=pynibka8auirUqb0BTZoo/q8Z5wVAhJZgUGoIcWmgJM=; b=Z
        zpwxEyfc0BNtaduL2eN9Tn6MPM69ozM/IhLwQlBsI+Oz2qBxbrGEVLTwM9nruwYv
        s6kh/QvG7P9K1/OzTbZ2BwTUsJufPqpQQBwBq6VZJ/B8n7opfcFGtQ4BnWLg8SjE
        OJGo12YEU4nyDV7znHbWrmTu9Wa+2KQ5WNclu6y5PPuBZpvg0HginMkZUDr3Vfkm
        +L2iR0eVSdTfb/lpDKDZDe6fHom5cw6EeUoRfQgFaEIX+5mL2FmjGDrsTBmBfGb1
        JtLuT0wyA47/u8n8NSxcBV9eqzZMQu6FROcrELOZgbGWVlo8mJEb91Ws20MXnmh4
        dsCoKW9UownJD7WAfKv7O/vvFMPnG7/uvMWqcjWSflfL+j2m9CM2RzBHyEW9L9nU
        9Q5halLku4l0Z9JQC8EuMdUAnlfu0C3f0fcPCQfq11dm/88Bjszl3wQf8jMRZ+9B
        U8y0X+m73Nawaqf1CwoCeYZyhkpVjv65ZGXfrRcksKaO/IZvwwSnXtbsC5Mv60qE
        MCybpY118uI2svGFHeba0Y5RMKAKaoXPkBj4iYV7bvv+Tda4DApD0C7kb7TvddD3
        CY15o8/cdZ/X50eqcDMfLis7gpK1NOLqtR+GT6UiVEmyPwM8fHhB4Bh8wv8tIV+4
        1SqnfibnMy9d8oKzSwLSk7W8mQ2zosrHPYtYP2m9AI=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id abn3hQvZK61p; Tue, 23 Oct 2018 20:54:06 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id CB89E1F99A;
        Tue, 23 Oct 2018 20:54:05 +0200 (CEST)
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
Subject: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Date:   Tue, 23 Oct 2018 21:53:23 +0300
Message-Id: <20181023185330.10472-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803 ADC is compatible with AXP813 ADC, but add
specific compatible for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
index 7a6313913923..1dbd5e480acd 100644
--- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one of:
     - "x-powers,axp209-adc",
     - "x-powers,axp221-adc",
+    - "x-powers,axp803-adc",
     - "x-powers,axp813-adc",
   - #io-channel-cells: should be 1,
 
@@ -39,6 +40,7 @@ AXP22x
  2 | batt_chrg_i
  3 | batt_dischrg_i
 
+AXP803
 AXP813
 ------
  0 | pmic_temp
-- 
2.17.1

