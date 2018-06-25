Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DE9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6598D25BC9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LcOmdowY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6598D25BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbeFYWty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:49:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36773 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbeFYWtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:49:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so3355008pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6rPgU9h4zlOWQeKmmluqpkKujuBTKpSYZM1yTZ394ko=;
        b=LcOmdowYFrZikDUJuK0A5k2fMUBL6UhMA/IUHDbLgTU8TI1zbi2ELWDRGFU7FHBFHd
         5+ZdyoEG7LOl4HrkB7SscJO4BJy8jIdwchbOr1bZ1BOIbR+azy14QxjjmGl/u4UrvlYk
         ZJ4+al58vt7IxfkSGBGwQlb4tB7UjwjJDEv/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6rPgU9h4zlOWQeKmmluqpkKujuBTKpSYZM1yTZ394ko=;
        b=Kfd2hbh+8oVqVJOL8AJzlRGdgLpjgPsXGnCruoI7RBAwX/FqwCto/kQ7sXwmSSdpx3
         EZWWfXd1Kzy73RPrCffzWrOfdt7bKqjbfWY4phYmVR1fPtpOheHUB2UTChpqUJvhTADO
         q7zEaBA+RmdAqNoFjXQl94LYeSDvuIMtBaGWdHov8ZDNCBsXLmP/6FG8A4SQI1+3Gsat
         rcFQmCOZGbyAn1boUyvhiW7uLlnZZJ7ucXhW53z4QqxlUan7Fk9z20eW6xaghCSRpMYz
         rY4BVgPEFsuf5eMtY6eHSilKDd2ALL7Jm0Ya+I9HpQnZhdka/p8jrSMigWRZAndPpuBS
         QWXg==
X-Gm-Message-State: APt69E3TXV5FfnixX5N9+luZbT4/KWvRIe0DFyVMeStl9+KEJWQiUuiG
        bhe3sMnTjraC5iqVDQoW9GSHpg==
X-Google-Smtp-Source: ADUXVKJy0Ci5jzMnjUBQHcFQHDt8z40FpO1fe0YtfImmCkIIA7zCmAnRDpLPX+tY360D81LiqUposg==
X-Received: by 2002:a63:d8:: with SMTP id 207-v6mr11744719pga.94.1529966992030;
        Mon, 25 Jun 2018 15:49:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h13-v6sm86365pgp.13.2018.06.25.15.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 15:49:50 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:49:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH v4 net-next] mdio-mux-gpio: Remove VLA usage
Message-ID: <20180625224949.GA48766@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates the values buffer during the callback instead of putting it
on the stack.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4: use struct_size() helper for allocation (Joe Perches)
v3: resend to netdev with Reviewed-by
v2: allocate array as part of structure (Andrew Lunn)
---
 drivers/net/phy/mdio-mux-gpio.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index 082ffef0dec4..bc90764a8b8d 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -20,23 +20,23 @@
 struct mdio_mux_gpio_state {
 	struct gpio_descs *gpios;
 	void *mux_handle;
+	int values[];
 };
 
 static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 				   void *data)
 {
 	struct mdio_mux_gpio_state *s = data;
-	int values[s->gpios->ndescs];
 	unsigned int n;
 
 	if (current_child == desired_child)
 		return 0;
 
 	for (n = 0; n < s->gpios->ndescs; n++)
-		values[n] = (desired_child >> n) & 1;
+		s->values[n] = (desired_child >> n) & 1;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       values);
+				       s->values);
 
 	return 0;
 }
@@ -44,15 +44,21 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 static int mdio_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct mdio_mux_gpio_state *s;
+	struct gpio_descs *gpios;
 	int r;
 
-	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
-	if (!s)
+	gpios = gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(gpios))
+		return PTR_ERR(gpios);
+
+	s = devm_kzalloc(&pdev->dev, struct_size(s, values, gpios->ndescs),
+			 GFP_KERNEL);
+	if (!s) {
+		gpiod_put_array(gpios);
 		return -ENOMEM;
+	}
 
-	s->gpios = gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(s->gpios))
-		return PTR_ERR(s->gpios);
+	s->gpios = gpios;
 
 	r = mdio_mux_init(&pdev->dev, pdev->dev.of_node,
 			  mdio_mux_gpio_switch_fn, &s->mux_handle, s, NULL);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
