Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424682AbeE1LQW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424670AbeE1LQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 264/272] soc: amlogic: meson-gx-pwrc-vpu: fix error on shutdown when domain is powered off
Date: Mon, 28 May 2018 12:04:57 +0200
Message-Id: <20180528100302.315095207@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 87f88732d25e6175cb4faa8070658f604660d720 ]

When operating the system headless headless, the domain is never
powered on, leaving the clocks disabled. The shutdown function then
tries to disable the already disabled clocks, resulting in errors.
Therefore call meson_gx_pwrc_vpu_power_off() only if domain is
powered on.
This patch fixes the described issue on my system (Odorid-C2).

Fixes: 339cd0ea0822 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -224,7 +224,11 @@ static int meson_gx_pwrc_vpu_probe(struc
 
 static void meson_gx_pwrc_vpu_shutdown(struct platform_device *pdev)
 {
-	meson_gx_pwrc_vpu_power_off(&vpu_hdmi_pd.genpd);
+	bool powered_off;
+
+	powered_off = meson_gx_pwrc_vpu_get_power(&vpu_hdmi_pd);
+	if (!powered_off)
+		meson_gx_pwrc_vpu_power_off(&vpu_hdmi_pd.genpd);
 }
 
 static const struct of_device_id meson_gx_pwrc_vpu_match_table[] = {
