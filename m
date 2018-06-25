Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA6924701
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mtNNjkcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA6924701
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeFYWJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:09:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38180 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeFYWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:09:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so6670278pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lVu1CrTXGPht9UK74qhh+fBGxqTASE7jfuwJXfl62yU=;
        b=mtNNjkcntTMufcEX/vqRF41nml9OSK/pyx/MjpxC049qeN9HSyIaepZL4fbT76TNdg
         UZKDEW1QN1vcBRRomnP0wIi3JrC+kbNwO13K8yJKawXWJimhu9HOXMOFzr16OtnbKGvd
         ev/xGIFUh9uXJEQFz1rKOMgFNVOAZTEa1Ikf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lVu1CrTXGPht9UK74qhh+fBGxqTASE7jfuwJXfl62yU=;
        b=OYdU+Ls3/W8SNLv2O/d5ci6q0/hSUpIsDi54QSLG/5Q816HexIgEJvgcnYa1D8xULj
         Z6aFnQoUyo3K+kmEtlpdP9OizsJ23LDD6qqSt9lea85caY5go8ZmIPbaN14dGCSlUZsS
         mJahFtOBOYUKu/qMhVoihqw9+UfeuMpC8XANv9t1/g41rM7TKvEWncp8lI0aB0gBE6aP
         KGhK4QmiFhtayyK+ER/a6uGN2cU4uT4iZU1KtKoA525hUlxQfO0lYhcspq3TwD0WsHdM
         SlQEqqKKxJt0Qzx1TO4HpbK87HNrZydwTii0rOpDncvCKtyK39ABtsq63cSHt0IKwtnR
         qjsg==
X-Gm-Message-State: APt69E3sTnCB2sUSb66IGk/UFq2OGTKIkmgZCTYGsI7lRj7C8NGfRzUx
        kTXbet8dPVEXSEVPgKbnI1N/ew==
X-Google-Smtp-Source: ADUXVKKkj070fv3fnWiSqe/0kfTWwFIy1dx2orsZPyeNTMKiJfcSeDtmQigsABaC4ZhN8RpSME9qXQ==
X-Received: by 2002:a63:6f85:: with SMTP id k127-v6mr8627478pgc.108.1529964559993;
        Mon, 25 Jun 2018 15:09:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d65-v6sm38438pfj.20.2018.06.25.15.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 15:09:18 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:09:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
Subject: [PATCH v3 net-next] mdio-mux-gpio: Remove VLA usage
Message-ID: <20180625220917.GA25022@beast>
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
v2: allocate array as part of structure (Andrew Lunn)
v3: resend to netdev with Reviewed-by
---
 drivers/net/phy/mdio-mux-gpio.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index 082ffef0dec4..6b55e0ddef63 100644
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
+	s = devm_kzalloc(&pdev->dev, sizeof(*s->values) * gpios->ndescs +
+				     sizeof(*s), GFP_KERNEL);
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
