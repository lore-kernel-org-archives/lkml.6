Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02343C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C6D20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 10:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C6D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeIIP2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 11:28:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46693 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeIIP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 11:28:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id t19-v6so8437441ply.13;
        Sun, 09 Sep 2018 03:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WtjxYmEXZlFDYUm6C5/IFEVd2yQ0iFIxxr14eyH1BH8=;
        b=GiscW+N8TXjgke5ay9m6DvuLkJvF8qWw0dp9BzvUt+BXjbVX6TamvwIYsO+p1v5/Xx
         2kxsZWrZ1J0c6ity0nzzbB9CATJnoSDuNKyhw2W2xpZLcVOfff/4MA2GZZb87AI3D0E6
         4A4YFmIzJYOq8Brp6K2dI7TvcUgMyRVGAlf1MrE1drjG719czXBJdQGsPfWgXfHxTkVw
         F6RsXm74YELcVl7E2TQPXOdp2nUja/USb0qiiL/tF2hEQziTuDax0t311yTBpXAodb1w
         qUpCbSaBUXj4++jct0X6C2BOjc2Ge5Xcxz/KBZUBvCQaXqIEhWKp2IBZHzFoDIGTvNcX
         +QMg==
X-Gm-Message-State: APzg51CRo8yxL+JaRqD0Uu0K28ziWPdOfVnH9jkHHRcB+FQom0EcGBOK
        Q+Jxxx/mO0WQ/S2V4PvSEDwN9nAWsGYwhQ==
X-Google-Smtp-Source: ANB0VdanmgjKhK3/lJqR52nTqLjp79SAadpnpOEGUucmT29SfNLzjjE+vCSnUkVUTBPBkhBc3Vg0Mw==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr16521076plo.292.1536489547592;
        Sun, 09 Sep 2018 03:39:07 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id q6-v6sm15984272pgq.19.2018.09.09.03.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 03:39:06 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-leds@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 0/2] Panasonic AN30259A support
Date:   Sun,  9 Sep 2018 20:38:23 +1000
Message-Id: <20180909103826.17793-1-simon@lineageos.org>
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

Changes since v4 (mistakenly sent as v3):
* Rebased on v4.19-rc2
* Namespace all macros with AN30259A_ prefix
* Fix trivial compiler/checkpatch --strict warnings

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

 .../bindings/leds/leds-an30259a.txt           |  43 ++
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-an30259a.c                  | 368 ++++++++++++++++++
 4 files changed, 422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
 create mode 100644 drivers/leds/leds-an30259a.c

-- 
2.18.0

