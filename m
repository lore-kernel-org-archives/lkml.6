Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D146C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47F24374
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47F24374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDQFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:05:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38558 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeGDQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:05:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3792C287653
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     andresx7@gmail.com, torvalds@linux-foundation.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/2] Avoid firmware warning in imx-sdma
Date:   Wed,  4 Jul 2018 18:04:58 +0200
Message-Id: <20180704160500.22699-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I grabbed the first patch from patchwork from an 2017 patch series. As far as I
could see, their usecase vanished due to switching to sync FW API (that already
supports NOWARN). This series fixes a kernel warning in imx-sdma driver, which
works fine with ROM firmware (and already prints an info message about ROM
firmware being used due to missing firmware file). This has been tested on
arch/arm/boot/dts/imx53-ppd.dts.

Changes since PATCHv2:
 * Provide request_firmware_nowait_nowarn instead of generic function with
   flags as suggested by Luis [0]

[0] https://lore.kernel.org/lkml/20180628031332.GE21242@wotan.suse.de/

-- Sebastian

Sebastian Reichel (2):
  firmware: add request_firmware_nowait_nowarn function
  dmaengine: imx-sdma: request firmware with FW_OPT_NO_WARN

 drivers/base/firmware_loader/main.c | 40 ++++++++++++++++++++++++-----
 drivers/dma/imx-sdma.c              | 10 +++-----
 include/linux/firmware.h            | 12 +++++++++
 3 files changed, 48 insertions(+), 14 deletions(-)

-- 
2.18.0

