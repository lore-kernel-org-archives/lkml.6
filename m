Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B9E20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="shEHo6iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B9E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbeKLIQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbeKLIQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:56 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0E821527;
        Sun, 11 Nov 2018 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975221;
        bh=THj1rSwX4VFd+pnZMngCpUq9mDKO2297d6Yhj5E4EG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shEHo6iXIdjDbORqFwFTrs4U3vpugJx5PxSCVb2ZlmF/duvpV6VNEhuyeQvfW2hQU
         1c6SMkMNk84qMzBY3AJhRIVv6wh1/Cufkv8HJUzeIEMvKPropxyyKPX11FHl6ZMJzp
         4ObltwfUw73Q2FOwmgBgwzdkNc9pi33fu8yhFpls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Janusz Uzycki <j.uzycki@elproma.com.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/361] gpio: mxs: Get rid of external API call
Date:   Sun, 11 Nov 2018 14:15:50 -0800
Message-Id: <20181111221620.601778585@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 833eacc7b5913da9896bacd30db7d490aa777868 ]

The MXS driver was calling back into the GPIO API from
its irqchip. This is not very elegant, as we are a driver,
let's just shortcut back into the gpio_chip .get() function
instead.

This is a tricky case since the .get() callback is not in
this file, instead assigned by bgpio_init(). Calling the
function direcly in the gpio_chip is however the lesser
evil.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Janusz Uzycki <j.uzycki@elproma.com.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mxs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index df30490da820..ea874fd033a5 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -18,8 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
-/* FIXME: for gpio_get_value(), replace this by direct register read */
-#include <linux/gpio.h>
 #include <linux/module.h>
 
 #define MXS_SET		0x4
@@ -86,7 +84,7 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	port->both_edges &= ~pin_mask;
 	switch (type) {
 	case IRQ_TYPE_EDGE_BOTH:
-		val = gpio_get_value(port->gc.base + d->hwirq);
+		val = port->gc.get(&port->gc, d->hwirq);
 		if (val)
 			edge = GPIO_INT_FALL_EDGE;
 		else
-- 
2.17.1



