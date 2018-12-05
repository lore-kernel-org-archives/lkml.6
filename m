Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F290C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0644208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0644208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeLEWLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:11:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:41694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbeLEWLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:11:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6740FAD05;
        Wed,  5 Dec 2018 22:11:48 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-input@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, agraf@suse.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] input: driver for RPi's official 7" touchscreen
Date:   Wed,  5 Dec 2018 23:09:01 +0100
Message-Id: <20181205220902.27682-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series adds support for Raspberry pi's 7" touchscreen. Which
alongside with the backlight driver are the last devices needed to have
a functional touchscreen upstream.

With this setup the board's VC4 firmware takes care of communicating
with the touch chip and provides data though a shared memory area
provided by the driver. The driver takes care of polling the firmware
whenever at around 60Hz since there is no interrupt line available.

The 1.0 revision of the touchscreen is based on the ft5426 chip.
Technically, with some changes in edt-ft54x4.c we should be able to
access the data directly through I2C. Yet this bus is meant to be owned
by RPi's firmware and might access it anytime. For example, to
configure RPi's camera device. As sharing the bus master interface is
not possible a series of alternatives have been tested unsuccessfully
[1]. It seems that we'll be unable to access the chip directly in a
"clean" way which leaves us with this firmware based solution.

The driver was rewritten based on the one available on the downstream
Raspberry Pi kernel tree: https://github.com/raspberrypi/linux/.

This series is based on v4.20-rc5 and was tested on a RPi 3 B+.

[1] https://lists.infradead.org/pipermail/linux-rpi-kernel/2018-December/008444.html
===

Nicolas Saenz Julienne (2):
  input: add official Raspberry Pi's 7" touchscreen driver
  Input: raspberrypi-ts - add devicetree binding documentation

 .../touchscreen/raspberrypi,firmware-ts.txt   |  25 ++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/raspberrypi-ts.c    | 252 ++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
 create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c

-- 
2.19.2

