Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13466C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE31E20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK9i8PtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE31E20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965961AbeFNOaq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965332AbeFNOL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E33208DD;
        Thu, 14 Jun 2018 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985485;
        bh=yBDGXPFtoxf+rAxtLP+x8n5ErD+qjMAfCEs8LX/cjO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WK9i8PtVtMvHG2wRQMZ5EWtVSZnX4eVHlf1sZoWBja1CsQ8cbHp9MS3luOtGM4pxM
         RqsLENJgiXqNvC4iGWwB8X4EltlR9TWXWzwN7X8BBDpU9hcL2Tfv54OHVwNA9lPE+8
         wHyfu/CsmTtlgGD2akPUOCJiBUzz9Ya+lCYmH2l8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 4.14 04/36] gpio: No NULL owner
Date:   Thu, 14 Jun 2018 16:04:27 +0200
Message-Id: <20180614132157.504015886@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3313,6 +3313,8 @@ struct gpio_desc *__must_check gpiod_get
 	struct gpio_desc *desc = NULL;
 	int status;
 	enum gpio_lookup_flags lookupflags = 0;
+	/* Maybe we have a device name, maybe not */
+	const char *devname = dev ? dev_name(dev) : "?";
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
 
@@ -3341,8 +3343,11 @@ struct gpio_desc *__must_check gpiod_get
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
 


