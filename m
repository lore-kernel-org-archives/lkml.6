Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F531215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F531215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeI0R4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:56:06 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:51884 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0R4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:56:06 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id gbeC1y0063XaVaC01beCgA; Thu, 27 Sep 2018 13:38:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UcV-0001Uv-VL; Thu, 27 Sep 2018 13:38:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UcV-00080I-TH; Thu, 27 Sep 2018 13:38:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3] gpio: Fix VLA removal fallout
Date:   Thu, 27 Sep 2018 13:38:07 +0200
Message-Id: <20180927113810.30721-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch series fixes various (mostly harmless) issues introduced by
commit 3027743f83f867d8 ("gpio: Remove VLA from gpiolib").

As per the "one patch should fix one issue"-policy, this series contains 3
patches, although they all have the same Fixes: tag.

Changes compared to v1:
  - Rebase on top of gpio array rework.

W.r.t. propagating errors: while gpiod_set_array_value_complex() and its
callers can now return an error code, this is currently limited to -ENOMEM.
Actual failures setting a GPIO output value cannot be propagated, as
gpio_chip.set() still returns void.  Do you want to change that?
E.g. gen_74x164_set_value() can fail.

Feel free to fold patches if deemed appropriate.

Thanks!

Geert Uytterhoeven (3):
  Documentation: gpio: Fix return type of gpiod_set_raw_array_value*()
  gpio: Propagate errors from gpiod_set_array_value_complex()
  gpio: Restore indentation of continued lines

 Documentation/driver-api/gpio/consumer.rst | 32 +++++++-------
 drivers/gpio/gpiolib.c                     | 50 +++++++++++-----------
 drivers/gpio/gpiolib.h                     |  8 ++--
 include/linux/gpio/consumer.h              | 46 ++++++++++----------
 4 files changed, 70 insertions(+), 66 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
