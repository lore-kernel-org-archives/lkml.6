Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05779C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C46214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="e6wOZmT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfBDIUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:20:02 -0500
Received: from chill.innovation.ch ([216.218.245.220]:56438 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfBDIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:20:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 09E0A6400E3;
        Mon,  4 Feb 2019 00:19:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tiHtHr6wnTQK; Mon,  4 Feb 2019 00:19:54 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 32E78640133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1549268392;
        bh=TKAwUeoQjXGxeCTzx/5U5pnah0OGN0utD5zaICWlxRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6wOZmT6XRhaaxHHHrOh3XHi9cpr2czk6EhVcHH8xogGwK5oLwXF4mAY8WetU6S37
         vdVgL43KL8A9/3WFxHJEeCZjO17OI5jHhgQkr7GQu2qZd2KKlahItn9NNw4nC2iYWN
         v7xBOvw24j/jimjF4Wujdv6Ji2wH9N3dmuTshPU7GZBAj9xMZ/V5apKWuduSJsfUZj
         kWfkxN49AmdjL6gKybBDWL41fefa4kx4kiOq6uagWuXbERihJZPbve+s5D7WpnUV/v
         wxdo0IqEIYpCjU+7Bl1yCnMCiOyBAtrEaIMKB/lYEjTeh64XKxI4Idw40qYujtxRzM
         Oe63WMXoY7RTg==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/2] drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
Date:   Mon,  4 Feb 2019 00:19:46 -0800
Message-Id: <20190204081947.25152-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204081947.25152-1-ronald@innovation.ch>
References: <20190204081947.25152-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
INPUT. However, this causes problems with other drivers, in particular
an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
future commit):

  drivers/clk/Kconfig:9:error: recursive dependency detected!
  drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
  drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
  drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
  drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
  drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
  drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
  drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
  drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK

According to the docs, select should only be used for non-visible
symbols. Furthermore almost all other references to INPUT throughout the
kernel config are depends, not selects. Hence this change.

CC: Inki Dae <inki.dae@samsung.com>
CC: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..eabedc83f25c 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
 config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
+	depends on INPUT
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
 	select RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
-- 
2.20.1

