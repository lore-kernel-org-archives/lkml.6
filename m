Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7AFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7261B20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7261B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbeGUPGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:06:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38248 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeGUPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:06:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so9105058pgq.5;
        Sat, 21 Jul 2018 07:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fblIki56x+SlEjLDe1Lo3w8jN20DL09E0AhLROPpVvI=;
        b=rrC7WXrCocke8g7ZioYLsiqesja/5c1C8GoDUcPPqzBdC/52ancmtKl9FrdHLLkVC+
         JKFh/WTuGoz7klXhzoHVa4CoiIlLbzkw+5O5NbM6MjoK1MSAe1aRtQQ21alWnCF1Yx28
         GP7tmdYT5QIo28ucFIGoAvdNfuBwu3iJ/0KiDLuNui+Q3LC5azSXyOB/yl/b8V0Fi50m
         wKV/rYcJF8kkcUyIn8zV8PuzpGk1RgLETpsnFjsFOjw5cvbbqIaNBSl7W0sN+UcU/btE
         k5pC9EK+UNy8SXr5B/cQo0248OIIg2TJQ77OQHkZvicVeQJgc/Wwd1/Nxqyh7vDcbIvB
         tB0w==
X-Gm-Message-State: AOUpUlH84rvWSPoyraK69osaXWWDY+qtYhXW4e15kW5elFkxhlhuo0Gj
        VNiZvhaf07U0piyTN/rOwcml331P6xc=
X-Google-Smtp-Source: AAOMgpekUE85btdXZszR0Vu0oNyk4iHhoXqpwSKx223F0wR9OQvOHn6kNF7yEnWIIoY1ADNNA1kfWw==
X-Received: by 2002:a62:c288:: with SMTP id w8-v6mr6234070pfk.92.1532182392109;
        Sat, 21 Jul 2018 07:13:12 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id t1-v6sm5033209pgp.32.2018.07.21.07.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 07:13:10 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-leds@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/2] Panasonic AN30259A support
Date:   Sun, 22 Jul 2018 00:12:25 +1000
Message-Id: <20180721141228.2283-1-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds DT bindings (patch #1) and the corresponding driver
(patch #2) for the Panasonic AN30259A 3-channel LED driver. AN30259A
uses an internal clock for controlling brightness/on-off cycles, but
also supports using an external PWM/clock input. This patch series only
implements support for the former.

The AN30259A is connected using I2C, and the datasheet is freely
available[0].

Changes since v3:
* Rebased on v4.18-rc3.
* Drop unnecessary DUTYMAX/MID calculations when blinking:
 previously I'd thought that the PWM duty values were expressed
 as a percentage of the maximum current output, but in reality
 they're a percentage of the current set in the LEDxCC registers. 
This simplifies the code quite a bit.
* Corrected MODULE_LICENSE declaration.
* Return -EINVAL from set_blink if the blink rate is unsupported in
 hardware.
* Fix more checkpatch --strict issues.

Changes since v2:
* Drop "an30259a:" prefix from bindings and add it in the device driver
 instead.
* Use led-controller instead of leds for sample DT binding.
* Use ":indicator" instead of ":notification" in sample DT binding.
* Merge an30259a_led_set and an30259a_brightness to
 an30259a_brightness_set (and same for blink functions).
* Explain the range limitations of the AN30259A's sloping mode
 in the code - the AN30259A only has a 7-bit PWM range in slope mode,
 and the bottom 3 bits are always set.

Changes since v1:
* Documentation formatting/grammar fixes.
* Use reg property instead of led-sources for leds.
* Add default-state support.
* Fix auto-probing when built as a module.
* Simplified DT parsing code.
* Use devm version of led_class_register().
* Fix LED naming scheme.
* Fixed checkpatch --strict issues.

Cheers,
Simon

[0]: https://www.alliedelec.com/m/d/a9d2b3ee87c2d1a535a41dd747b1c247.pdf

Simon Shields (2):
  dt-bindings: leds: document Panasonic AN30259A bindings
  leds: add Panasonic AN30259A support

 .../bindings/leds/leds-an30259a.txt           |  43 +++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-an30259a.c                  | 365 ++++++++++++++++++
 4 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
 create mode 100644 drivers/leds/leds-an30259a.c

-- 
2.18.0

