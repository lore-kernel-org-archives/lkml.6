Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100E121741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100E121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbeHNPlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:41:20 -0400
Received: from mout.perfora.net ([74.208.4.196]:49255 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbeHNPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:41:20 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M2exP-1g8Kho3fkL-00sRHh; Tue, 14 Aug 2018 14:54:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org
Cc:     Lucas Stach <dev@lynxeye.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v2] drm/tegra: hdmi: probe deferral error reporting
Date:   Tue, 14 Aug 2018 14:53:54 +0200
Message-Id: <20180814125355.29293-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:UwypYPOkSU0UORiPmTcL3TdIbomB2VnM0EWl2QauHTjCx/xqNOj
 fjGZ3P6a8XUmrxpdZh+L3d9zrwRMszdqqIff2xACR3SENsbF8i7pIFhqTmKj3xFPFYXWPWe
 xhY+3obDVnV2RXpWNLix705YjIrIAnsCXFiaMqSxUM3uP+DifIyMUifUTwO8froxOQumn9y
 dqr68wGFLI3UuGyRcOuog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yia1fQ2YtoY=:K36yW73Z3pTIBvX4JneVk0
 EiGcAyntzNj3CqO/M0iLHqdVVcH1Wem/bemMG6TxogarGk14P5hEwcZKLph6tdg/q4I3Y5ndw
 Qlzoc0QiyXn3xzyMYROX/YqAoqr/OQ/0SY2prb4fne1O0Ng+M9Cxj9dSyIMa623ZHebwP4DHU
 JSUWwBW27vpffJ4uK1ca9kHmpOyBG8sZIHOxJnSuU6H2JVTfT3QTPXEON2lRObwACoM4Lsf6c
 9XXub4z3homS37OoXXBXM+V2t8Day6/volrVAd4+fynyFMCUqjzzg+PzHoqQNc6/p0azd3vv6
 Vtujj5jpCiNZFRSPWNoAvKVVx+vFi78gTSCiOF5UFAVJfYSy5HC17hQTvg2eya8xCeoLV/+bI
 BarqPBKTVNHjSe4r80r3uu+al7yivlm/eP/fniI4ScQcVXE3IybmGSTnh7StCBu2eWv5FoVIM
 rryLUwgMIBmW4FtzmdjXbFOFWHosx/v4KjHnAtf3ryxvAkxaw9bP4D12gxFtbByB9TNfevgVg
 p5j2ud29QyRtU38MnlXkG+CdJu14dS1Q9VzmNfpCSwlNydykNJnZQQ47rMRhAkDtYMzQPTtCD
 W8czntk52yOaAR9a+3Cn5A5A9kPQpkFLo/RncRsjgFMtIsanPd/NgJ6Z7QBvVv6Lm2eh/c0Od
 39a6SzyE0XFEnBJJEJnCnxRJWZ3Ee7AgFblJEJI6xkwPVFn+N1HXe/jFAcwkQZl4BVpM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error code from devm_regulator_get() unless it
is just a probe deferral.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Silence probe deferral as suggested by Lucas.
- Fix line over 80 characters as reported by checkpatch.

 drivers/gpu/drm/tegra/hdmi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0082468f703c..073d54b7225e 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1693,14 +1693,22 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->hdmi = devm_regulator_get(&pdev->dev, "hdmi");
 	if (IS_ERR(hdmi->hdmi)) {
-		dev_err(&pdev->dev, "failed to get HDMI regulator\n");
-		return PTR_ERR(hdmi->hdmi);
+		err = PTR_ERR(hdmi->hdmi);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get HDMI regulator: %d\n",
+				err);
+
+		return err;
 	}
 
 	hdmi->pll = devm_regulator_get(&pdev->dev, "pll");
 	if (IS_ERR(hdmi->pll)) {
-		dev_err(&pdev->dev, "failed to get PLL regulator\n");
-		return PTR_ERR(hdmi->pll);
+		err = PTR_ERR(hdmi->pll);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get PLL regulator: %d\n",
+				err);
+
+		return err;
 	}
 
 	hdmi->vdd = devm_regulator_get(&pdev->dev, "vdd");
-- 
2.14.4

