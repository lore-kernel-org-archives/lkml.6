Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E458C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF11321721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="Ur/t8bFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfAVOUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:20:10 -0500
Received: from chill.innovation.ch ([216.218.245.220]:53096 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfAVOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:20:10 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 09:20:10 EST
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id AE581640133;
        Tue, 22 Jan 2019 06:13:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8QUEruu49GwV; Tue, 22 Jan 2019 06:13:54 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch C05C4640057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1548166434;
        bh=TKAwUeoQjXGxeCTzx/5U5pnah0OGN0utD5zaICWlxRE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ur/t8bFzQ1MgWZHotkmKjGQm+vzEyB3aznMOqR3Y2HB61lW8AUTq0roFgwy1nh0xE
         Io+KVLcIaEl4hD2BlE6OTlOncjrQAD5lU0XzgYX63onIGuP794pIxgZeQjkOLl7Ktf
         py+5uFytz8FFzNDx3jshB7OKNmyNzBfgftBwg/WG5kB+ONzIiolPUgMlMm4nt1PuK8
         ggXEHFoFZIzxBAvmsTxKY0k0xOulYgBzw38WMKDIqTJx9U9u1ToZxw9Ccye7/drdML
         nWoYMVELSPIPLAbrn29psbGscpFypekV96t7SaxHgOPR10KMPUz/6t1LYkgZVmt6bS
         +wDWbXuJLRntQ==
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
Date:   Tue, 22 Jan 2019 06:13:11 -0800
Message-Id: <20190122141311.10445-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
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

