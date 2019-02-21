Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3AE2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="U3+OyKNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBUK4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:56:18 -0500
Received: from chill.innovation.ch ([216.218.245.220]:50860 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:56:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id C011764128D;
        Thu, 21 Feb 2019 02:56:17 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id E7-Bsr_WAYbQ; Thu, 21 Feb 2019 02:56:16 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch B09E16401A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1550746576;
        bh=q3Ok0ooPhxoTN5pkbjmEd6mSh6Qb9qHDOP8fWK5MHyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3+OyKNBWbAgW+cEko5l0AEAL9zhmA2Rr0yxxh8HWLKlBfeByReOhDUY9vp4lkzZU
         UACKkSBULWxFkGEeS7BKn2tw++ozXl38pYTu3bdpQ2A+aVSB4M8oz6ZhYpHrL4x8BC
         MRUMULcbpCNAwknDAPfu3bEf8xaMHmT9u9lzhiirMfzxABw20nLIZYgJYw0tPz48zv
         pVonggQxh59x/EJwrwOd7Txcm67qJ/DtkcUDktXlxcuwJNIbSiuFdMdDbR1XLkXZSS
         5Yq62MzPHrB9E/+44bM1hiHWiW8CaKC6SPWFfrQjmFD75IsFkkFEk8fNGLaVr/nh4/
         qtXGUibDL7sbQ==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v2 1/2] drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
Date:   Thu, 21 Feb 2019 02:56:08 -0800
Message-Id: <20190221105609.5710-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221105609.5710-1-ronald@innovation.ch>
References: <20190221105609.5710-1-ronald@innovation.ch>
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
index 9eeb8ef0b174..bc838e7bb7c8 100644
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

