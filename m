Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED70C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DA208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k85BW7ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407DA208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbeHWSa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:30:26 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33722 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732888AbeHWSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:30:26 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9EDD910C1B0B;
        Thu, 23 Aug 2018 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535036423; bh=4mO+DG2HJvLMr9/h2Hb7UT1MV+4SD2+EjpVKOIYZAE8=;
        h=From:To:Cc:Subject:Date:From;
        b=k85BW7gel1oTzR/ZxVu+LNh27qC40/8k9xTBmhCwDKKq0mjvJN41XX3aBR+GFMMhP
         8ApkP+ngbRnv41n8b6qOog21mlW/4elR+5Lbf/pzIKxpWN+KebjWm+s61DikY9st/F
         bv8GpCqbCBCTbN4AyCtJhw0asifGVg1656T5baq2sUa/6yvKQu1loynMEq7IKovsJB
         93+9cL648ePKaA9wobGXjAcDKJE4spfAnydbTbhvvTWYHwpN+/aMUNb8JzkBxJFKNt
         n8CUII9/X16Qp1EdBxo+BUr4eW3XAEZGPASSNmaGLGPQXAYopjLf03UKZpjRGbqUDD
         Dm0mbZ9hx9Hzg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.36])
        by mailhost.synopsys.com (Postfix) with ESMTP id AE83D3EB1;
        Thu, 23 Aug 2018 08:00:19 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/2] GPIO: add single-register gpio via creg driver
Date:   Thu, 23 Aug 2018 18:00:11 +0300
Message-Id: <20180823150013.21837-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single-register MMIO gpio driver for complex cases where
only several fields in register belong to GPIO and each GPIO
owns field with different length and on/off values.

Here is the example:

31            11        8         7        5         0   < bit number
|              |        |         |        |         |
[   not used   | gpio-1 | shift-1 | gpio-0 | shift-0 ]   < 32 bit MMIO
                   ^                  ^
                (3 bit)            (2 bit)
                   |                  |
                   |                  |
                   |           write 0x2 == set output to "1" (on)
                   |           write 0x3 == set output to "0" (off)
                   |
            write 0x1 == set output to "1" (on)
            write 0x4 == set output to "0" (off)

This is different from gpio-reg, gpio-mmio and gpio-74xx-mmio:
* They all don't support cases when GPIO output register have
  more than one bit per GPIO line.
* They don't support holes in MMIO register.
* They don't support cases when GPIO lines have different on/off
  values.

This driver supports GPIOs via CREG on various Synopsys SoCs/boards.

Eugeniy Paltsev (2):
  GPIO: add single-register gpio via creg driver
  dt-bindings: Document the Synopsys GPIO via CREG bindings

 .../devicetree/bindings/gpio/snps,creg-gpio.txt    |  48 ++++
 MAINTAINERS                                        |   6 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-creg-snps.c                      | 242 +++++++++++++++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
 create mode 100644 drivers/gpio/gpio-creg-snps.c

-- 
2.14.4

