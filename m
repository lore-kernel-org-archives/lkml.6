Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62302082E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfBCP4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:56:32 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33168 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfBCP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:56:32 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 804845FD06; Sun,  3 Feb 2019 23:56:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>
Subject: mmc: sunxi: Fix eMMC usage on H5 boards
Date:   Sun,  3 Feb 2019 23:56:25 +0800
Message-Id: <20190203155628.16767-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Since the HS-DDR mode was enabled for the A64 eMMC controller, there
have been reports of eMMC failing to work on some H5 boards. It seems
that while the H5 and A64 share the same controller for eMMC, some H5
boards don't have trace lengths that work under HS-DDR with the default
delay chain settings. Unfortunately we don't support tuning them at the
moment, and these boards didn't seem to come with any settings either.
Instead HS-DDR just wasn't enabled.

The failure is typically a data CRC error on data reads, such as the
partition scanning when the device is first probed. While this in itself
would result in the device being unusable, there seems to be a timing
issue in the recovery of the MMC controller. After the CRC error, the
driver manually issues a stop command to the device, which also fails.
After this a following command would stall: the MMC subsystem waits for
the completion notice of the request, which never happens. The stall
also blocks udev, which kind of blocks the whole boot process. However
if I turn on debug messages to try to narrow down the issue, it recovers
just fine. Any help on this issue would be much appreciated.

I propose we turn off HS-DDR on the H5 (maybe even the H6, but I don't
have anything to test right now) by default, and enable it per-board
using the common mmc binding properties for speed modes.

Patch 1 disables HS-DDR for H5 eMMC.

Patch 2 adds a check blocking (force disabling) any modes the driver
doesn't support. In retrospect this should have been added a long time
ago.

Patch 3 enables HS-DDR for the Libre Computer ALL-H3-CC H5, which works
normally.

If possible please merge all of them as fixes.


Regards
ChenYu

Chen-Yu Tsai (3):
  mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
  mmc: sunxi: Filter out unsupported modes declared in the device tree
  arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V
    capable

 .../sun50i-h5-libretech-all-h3-cc.dts         |  4 +++
 drivers/mmc/host/sunxi-mmc.c                  | 27 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.20.1

