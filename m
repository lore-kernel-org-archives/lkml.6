Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A22C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DED20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="K38Om2jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DED20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeK0CWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:22:40 -0500
Received: from plaes.org ([188.166.43.21]:49956 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0CWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:39 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 09268412D3;
        Mon, 26 Nov 2018 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246091; bh=5hAkv9e0QxqeuW+SKyUEctAb4c3snr9BKtdxWIlUSeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K38Om2jc5cRFbi5rpE3fb8iVaF3bOnxOeVcO0xjYElXT2klsIcZuhB+JajhyGL9vm
         bVddAFu10sWPPafBuauxNq0hCUtxzTfbEqSiqsmNKRRydlzNTUKUzCWdHur/vMJkwl
         096vCMEwjEEPmhPRXbWPJ+7OIgst/kB6mustRDVPNy07k+8fOBYB2l5O8Fps/sp5XN
         sZTFqQ6z5IEB0uBm4ZJBRcBtCRPKE33xdvnl/v8Ot8p4dGRDCuxdxAJRAUHhpqMc9C
         xDTZpDARuDW7qR3q32Qht+n5QaTYsIlnL2lEbVTTw9/V7ODIVFV8yWa3IUsWLM1Na+
         /fhte626D2D8A==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 03/14] regulator: core: enable power when setting up constraints
Date:   Mon, 26 Nov 2018 17:27:44 +0200
Message-Id: <1e2f8f5a5eeebd40431675675569012cb8e17473.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

When a regulator is marked as always on, it is enabled early on, when
checking and setting up constraints. It makes the assumption that the
bootloader properly initialized the regulator, and just in case enables
the regulator anyway.

Some constraints however currently get missed, such as the soft-start
and ramp-delay. This causes the regulator to be enabled, without the
soft-start and ramp-delay being applied, which in turn can cause
high-currents or other start-up problems.

By moving the always-enabled constraints later in the constraints check,
we can at least ensure all constraints for the regulator are followed.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/regulator/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b52..6e14610 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1158,17 +1158,6 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
-	/* If the constraints say the regulator should be on at this point
-	 * and we have control then make sure it is enabled.
-	 */
-	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
-		ret = _regulator_do_enable(rdev);
-		if (ret < 0 && ret != -EINVAL) {
-			rdev_err(rdev, "failed to enable\n");
-			return ret;
-		}
-	}
-
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
 		&& ops->set_ramp_delay) {
 		ret = ops->set_ramp_delay(rdev, rdev->constraints->ramp_delay);
@@ -1214,6 +1203,17 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	/* If the constraints say the regulator should be on at this point
+	 * and we have control then make sure it is enabled.
+	 */
+	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		ret = _regulator_do_enable(rdev);
+		if (ret < 0 && ret != -EINVAL) {
+			rdev_err(rdev, "failed to enable\n");
+			return ret;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 }
-- 
git-series 0.9.1
