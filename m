Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A0CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F59205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbfAPKIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:08:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34670 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbfAPKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:08:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 996F82639AE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     heiko@sntech.de, groeck@google.com,
        kieran.bingham@ideasonboard.com, kishon@ti.com,
        kernel@collabora.com, bleung@chromium.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2] phy: phy-rockchip-inno-usb2: drop reading the utmi-avalid property
Date:   Wed, 16 Jan 2019 11:08:23 +0100
Message-Id: <20190116100823.24938-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That property is no used in mainline and is not documented. The only
board using that property is the rk33-99-evb-rev1 and -rev2 in the
vendor kernel. The existence of a further -rev3 (which also looks way
better cared for compared rev1+2) indicates that the older ones are
probably some sort of preproduction models, where some wiring (on the soc
or board) may have gone wrong.

It is also not clear why this is a hardware-description or a DT
property, so, as noboby seems to care of this just drop reading that
property.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Hi all,

This patch was send for the first time within these series [1], but
might have more sense sent alone as doesn't depedends on the rest of
the series, so, remove from these series and send a second version
that can be applied independently.

Best regards,
Enric

[1] https://lkml.org/lkml/2018/8/15/141

Changes in v2:
- Split from the first version and send as a separate patch.
- Include the research that Heiko did in the commit message.

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a1f2253d60c1..ba07121c3eff 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -168,9 +168,6 @@ struct rockchip_usb2phy_cfg {
  * @phy: generic phy.
  * @port_id: flag for otg port or host port.
  * @suspended: phy suspended flag.
- * @utmi_avalid: utmi avalid status usage flag.
- *	true	- use avalid to get vbus status
- *	false	- use bvalid to get vbus status
  * @vbus_attached: otg device vbus status.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
  * @ls_irq: IRQ number assigned for linestate detection.
@@ -189,7 +186,6 @@ struct rockchip_usb2phy_port {
 	struct phy	*phy;
 	unsigned int	port_id;
 	bool		suspended;
-	bool		utmi_avalid;
 	bool		vbus_attached;
 	int		bvalid_irq;
 	int		ls_irq;
@@ -545,12 +541,8 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 	unsigned long delay;
 	bool vbus_attach, sch_work, notify_charger;
 
-	if (rport->utmi_avalid)
-		vbus_attach = property_enabled(rphy->grf,
-					       &rport->port_cfg->utmi_avalid);
-	else
-		vbus_attach = property_enabled(rphy->grf,
-					       &rport->port_cfg->utmi_bvalid);
+	vbus_attach = property_enabled(rphy->grf,
+				       &rport->port_cfg->utmi_bvalid);
 
 	sch_work = false;
 	notify_charger = false;
@@ -1024,9 +1016,6 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
 	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
 
-	rport->utmi_avalid =
-		of_property_read_bool(child_np, "rockchip,utmi-avalid");
-
 	/*
 	 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
 	 * interrupts muxed together, so probe the otg-mux interrupt first,
-- 
2.20.1

