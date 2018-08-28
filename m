Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B065C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FEC2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G2j6AlXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FEC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeH1PSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:18:40 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:33112 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeH1PSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:18:40 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7D15624E23D2;
        Tue, 28 Aug 2018 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535455648; bh=aN8zzZQ0BA2ndzTYT0yp7g0qhluSBS46Vc+R4A/Cl8U=;
        h=From:To:Cc:Subject:Date:From;
        b=G2j6AlXrkeMCw3DZEhpm+moqe2kfzG2jxGK7QhgVQ7/TORSjQgpDB1tR0AA2EszZY
         KJpQtlEcoLZFR+vypuzd/z0TAGQan+WL3TNmus+GNhEBhTEbz3klYUK8KHcE6YujDH
         nrFhix+o6BZEzd1HnkaL+iW1ABxSIi9VV/fWNhnslhUh+UuapSTFn6IUy/bUUsNxBx
         Txjcl2AEHo1vZ8CMg3uI7Nx3AU9QvnFhc3Z2CcKvOpFA69XC29MleB3fMus/06MwF2
         d+tbEqaBezWy/r1+lKza8AREwUp3CMsgp6F56KjjRXO9Jf43/uXx7kBMYLLBFuvN2+
         fZrQoc85zefxA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.36])
        by mailhost.synopsys.com (Postfix) with ESMTP id E83B65F93;
        Tue, 28 Aug 2018 04:27:24 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/2] GPIO: add single-register GPIO via CREG driver
Date:   Tue, 28 Aug 2018 14:27:19 +0300
Message-Id: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single-register MMIO GPIO driver for complex cases where
only several fields in register belong to GPIO lines and each GPIO line
owns a field with different length and on/off value.

Here is the example:

31            11        8         7        5         0   < bit number
|              |        |         |        |         |
[   not used   | gpio-1 | shift-1 | gpio-0 | shift-0 ]   < 32 bit MMIO
                   ^                  ^                     register
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
  GPIO: add single-register GPIO via CREG driver
  dt-bindings: Document the Synopsys GPIO via CREG bindings

 .../devicetree/bindings/gpio/snps,creg-gpio.txt    |  49 +++++
 MAINTAINERS                                        |   6 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-creg-snps.c                      | 242 +++++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
 create mode 100644 drivers/gpio/gpio-creg-snps.c

-- 
2.14.4
