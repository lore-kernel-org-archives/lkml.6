Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AABC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559A320854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="PNo5Yooz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559A320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeILXiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:17 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52430 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeILXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:17 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E6FAF5C0119;
        Wed, 12 Sep 2018 20:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=E651IZz3UG8pQia4ZoWmDyN3a9w9EAHAFjOfmtIWk1Y=;
        b=PNo5YoozVOXzQZRnPnSftPqIFqeq0Ml/IHyL9Yjwxw2CFnMzFbZalHSkqRuvS9fF0D0Q24
        gmUdoWLyPerjjcOAlrO0yP8rABWhoXPdyAUc0tJmTMSJQfE1q1k6rbFSvpWLRdizQDmynp
        OwFSpX5KvP8WOStRP3pN1GbaR1YHk4I=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/8] drm/bridge: add bus flag support
Date:   Wed, 12 Sep 2018 11:32:14 -0700
Message-Id: <20180912183222.25414-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v2 shifted a bit more to rework bridge timing support. While
my use case mainly cares about complete bus flag support, it seems
to me that bus timings have ended up to be more complex than
necessary. Patch 2/3 are an attempt to simplify bus timings. This
also aligns bridge timings with how display timings are specified
today.

@Linus Walleij, Laurent Pinchart: Since you have been involved in
the initial bus timings discussion, I would like to have your Ack
on at least patch 2/3... If we want to keep the setup/hold timings,
the patchset should also work without those two patches.

--
Stefan

Changes in v2:
- Rename bus_flags to simple_bus_flags
- Reword dt-bindings for de-active
- Add patch 2/3 which attempts to simplify bridge timings

Stefan Agner (8):
  drm/bridge: use bus flags in bridge timings
  drm/pl111: simplify bridge timing support
  drm/bridge: simplify bridge timing info
  drm/bridge: allow to specify data-enable polarity
  dt-bindings: display: add data-enable polarity property
  drm/imx: support handling bridge timings bus flags
  ARM: dts: imx6qdl-apalis: add VGA support
  ARM: dts: imx6qdl-apalis: add GPIO I2C node for DDC

 .../bindings/display/bridge/dumb-vga-dac.txt  |  2 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 28 ++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 72 +++++++++++++++++++
 drivers/gpu/drm/bridge/dumb-vga-dac.c         | 45 +++++++-----
 drivers/gpu/drm/imx/parallel-display.c        |  3 +
 drivers/gpu/drm/pl111/pl111_display.c         | 22 ++----
 include/drm/drm_bridge.h                      | 25 ++-----
 7 files changed, 142 insertions(+), 55 deletions(-)

-- 
2.18.0

