Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 94DE0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CD3208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjvljjh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CD3208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966204AbeFNONR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966150AbeFNONN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FE6208E2;
        Thu, 14 Jun 2018 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985592;
        bh=EzjUklIMUnhZdOjLVF51oMpSkQs8WYYit9NHelp2a4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tjvljjh3EeT67y01JA7/fa7KxzKKiXtnFT4KXqVFDL2IY0XqJkSf58b1jFdSdWLzG
         Y/7ldykYm+sMmHEp4pomYcitq+yIuKB/ZWmhNdZJNbi5iE6wHOAxxyyWA9X4s8GhJf
         idYMAqL474dJ9I4bvJdmzeektR1AOq/e2ka98ask=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 4.4 15/24] gpio: No NULL owner
Date:   Thu, 14 Jun 2018 16:05:10 +0200
Message-Id: <20180614132725.096110374@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 7d18f0a14aa6a0d6bad39111c1fb655f07f71d59 upstream.

Sometimes a GPIO is fetched with NULL as parent device, and
that is just fine. So under these circumstances, avoid using
dev_name() to provide a name for the GPIO line.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2117,6 +2117,8 @@ struct gpio_desc *__must_check gpiod_get
 	struct gpio_desc *desc = NULL;
 	int status;
 	enum gpio_lookup_flags lookupflags = 0;
+	/* Maybe we have a device name, maybe not */
+	const char *devname = dev ? dev_name(dev) : "?";
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
 
@@ -2145,8 +2147,11 @@ struct gpio_desc *__must_check gpiod_get
 		return desc;
 	}
 
-	/* If a connection label was passed use that, else use the device name as label */
-	status = gpiod_request(desc, con_id ? con_id : dev_name(dev));
+	/*
+	 * If a connection label was passed use that, else attempt to use
+	 * the device name as label
+	 */
+	status = gpiod_request(desc, con_id ? con_id : devname);
 	if (status < 0)
 		return ERR_PTR(status);
 


