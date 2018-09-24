Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58EAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8911821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8911821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeIXS0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbeIXS0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C1FB1097;
        Mon, 24 Sep 2018 12:24:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 156/173] gpiolib: Respect error code of ->get_direction()
Date:   Mon, 24 Sep 2018 13:53:10 +0200
Message-Id: <20180924113126.730832814@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

[ Upstream commit 36b312792b97933dc07abe074f50941199bd357c ]

In case we try to lock GPIO pin as IRQ when something going wrong
we print a misleading message.

Correct this by checking an error code from ->get_direction() in
gpiochip_lock_as_irq() and printing a corresponding message.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2811,6 +2811,12 @@ int gpiochip_lock_as_irq(struct gpio_chi
 	if (!chip->can_sleep && chip->get_direction) {
 		int dir = chip->get_direction(chip, offset);
 
+		if (dir < 0) {
+			chip_err(chip, "%s: cannot get GPIO direction\n",
+				 __func__);
+			return dir;
+		}
+
 		if (dir)
 			clear_bit(FLAG_IS_OUT, &desc->flags);
 		else


