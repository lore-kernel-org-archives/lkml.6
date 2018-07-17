Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A8FECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0FA20835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJjtK6qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0FA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeGQWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbeGQWiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:38:19 -0400
Received: from ziggy.de (144.pool85-56-49.dynamic.orange.es [85.56.49.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC42B20693;
        Tue, 17 Jul 2018 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531865018;
        bh=tP9h3bmWAPLaIuqHKzS2UZ7Qv4wPyPbizYow3kR3tyk=;
        h=From:To:Cc:Subject:Date:From;
        b=sJjtK6qCXiyXUXvK09aYB9+HQ/YbHMgMrTTOkYY+YqmozJYseR5tsmUkkWYeWWf/R
         lvBAAA7mYQ4hc5rRsCj4ZXVPoiCSenFonWbWsaXWuvag6A9huCYA+Emk2FNJJtJSic
         Clj4yCX2SZNL8beXAIAF/aw8NDoQirsX9w87yyQg=
From:   matthias.bgg@kernel.org
To:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab@kernel.org, rdunlap@infradead.org,
        pi-cheng.chen@linaro.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [resend PATCH v4 0/5] arm/arm64: mediatek: Fix mmsys device probing
Date:   Wed, 18 Jul 2018 00:03:23 +0200
Message-Id: <20180717220328.792-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
- use platform device to probe clock driver
- add Acked-by CK Hu for the probe deferred patch

Changes since v2:
- fix kconfig typo (shame on me)
- delete __initconst from mm_clocks as converted to a platform driver
  
Changes since v1:
- add binding documentation
- ddp: use regmap_update_bits
- ddp: ignore EPROBE_DEFER on clock probing
- mfd: delete mmsys_private
- add Reviewed-by and Acked-by tags
 
MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
used in the clk driver) and some registers to set the routing and enable
the differnet blocks of the display subsystem.

Up to now both drivers, clock and drm are probed with the same device tree
compatible. But only the first driver get probed, which in effect breaks
graphics on mt8173 and mt2701.

This patch uses a platform device registration in the DRM driver, which
will trigger the probe of the corresponding clock driver. It was tested on the
bananapi-r2 and the Acer R13 Chromebook.


