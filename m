Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23668C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22082083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBGQ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:29:10 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:51873 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:29:10 -0500
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6DDDE100010;
        Thu,  7 Feb 2019 16:29:06 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/5] gpio: add support for pull-up/pull-down configuration
Date:   Thu,  7 Feb 2019 17:28:54 +0100
Message-Id: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As we started discussing in [1], it would be useful to have a way to
configure pull-up/pull-down resistors for simple GPIO controllers that
don't have any pinmuxing capability, and therefore no interaction with
the pinctrl subsystem.

This is a second iteration of the patches (the v1 was posted at
https://patchwork.ozlabs.org/cover/1020392/).

Changes since v1:

 - Add a comment in the binding that explicitly states that the new
   bit 4 and 5 should only be used for HW with a simple on/off
   pull-up/pull-down configuration. More complex HW should use a pin
   control binding. Suggested by Linus Walleij.

 - Change gpiod_set_debounce() and gpiod_set_transitory() to use the
   new gpio_set_config() helper. This is done in a new, separate
   patch. Suggested by Linus Walleij.

 - Add error checking in gpiod_configure_flags() to make sure pull-up
   and pull-down are not both enabled on the same GPIO. Suggested by
   Jan Kundrát. Jan suggested to put this in the code converting from
   DT properties to internal flags, but it actually makes more sense
   to do it in gpiod_configure_flags(), independently from DT parsing.

 - Add a check in gpio-pca953x driver that pull-up/pull-down is indeed
   supported by the underlying HW in the
   pca953x_gpio_set_pull_up_down() function. Noticed by Linus Walleij.

 - Move the changes in include/dt-bindings/gpio/gpio.h to the
   dt-bindings patch, as suggested by Rob Herring.

Rob: due to the changes in the dt-bindings patch, I have not kept your
Acked-by.

Thomas

[1] https://marc.info/?l=linux-gpio&m=154491873506701&w=2

Thomas Petazzoni (5):
  dt-bindings: gpio: document the new pull-up/pull-down flags
  gpio: rename gpio_set_drive_single_ended() to gpio_set_config()
  gpio: use new gpio_set_config() helper in more places
  gpio: add core support for pull-up/pull-down configuration
  gpio: pca953x: add ->set_config implementation

 .../devicetree/bindings/gpio/gpio.txt         | 12 ++++
 drivers/gpio/gpio-pca953x.c                   | 66 ++++++++++++++++++-
 drivers/gpio/gpiolib-of.c                     |  5 ++
 drivers/gpio/gpiolib.c                        | 50 +++++++++-----
 drivers/gpio/gpiolib.h                        |  2 +
 include/dt-bindings/gpio/gpio.h               |  6 ++
 include/linux/gpio/machine.h                  |  2 +
 include/linux/of_gpio.h                       |  2 +
 8 files changed, 127 insertions(+), 18 deletions(-)

-- 
2.20.1

