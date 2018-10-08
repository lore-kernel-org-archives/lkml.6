Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C0FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FC121479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn3wZ1Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FC121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeJIBya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbeJIBy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766602064A;
        Mon,  8 Oct 2018 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024085;
        bh=V1FSaMm+tIdrowsO/U1/NQ3WQ3NMmXDv6s5xajWARsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sn3wZ1TiqQCmaEJE7F4Wegv3JsJtnB7QAZNfkz3O6MnDsOanEootajf9z6pSX6VUo
         ca9Dj9P3QnjEQMN5QHNr8FfqE10L5YPHN3jy+p/iHfeQMRiDnyIVq47A3knaZGnOT1
         2fJA+bnxw/Pg6grtRkDCRlGlU46V1P6M0HpBsrI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 15/94] gpiolib: acpi: Switch to cansleep version of GPIO library call
Date:   Mon,  8 Oct 2018 20:30:56 +0200
Message-Id: <20181008175605.777453595@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 993b9bc5c47fda86f8ab4e53d68c6fea5ff2764a ]

The commit ca876c7483b6

  ("gpiolib-acpi: make sure we trigger edge events at least once on boot")

added a initial value check for pin which is about to be locked as IRQ.
Unfortunately, not all GPIO drivers can do that atomically. Thus,
switch to cansleep version of the call. Otherwise we have a warning:

...
  WARNING: CPU: 2 PID: 1408 at drivers/gpio/gpiolib.c:2883 gpiod_get_value+0x46/0x50
...
  RIP: 0010:gpiod_get_value+0x46/0x50
...

The change tested on Intel Broxton with Whiskey Cove PMIC GPIO controller.

Fixes: ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge events at least once on boot")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -247,7 +247,7 @@ static acpi_status acpi_gpiochip_request
 
 	gpiod_direction_input(desc);
 
-	value = gpiod_get_value(desc);
+	value = gpiod_get_value_cansleep(desc);
 
 	ret = gpiochip_lock_as_irq(chip, pin);
 	if (ret) {


