Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F96C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94F02075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s2dy79bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94F02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756302AbeFSIWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:22:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44923 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756310AbeFSIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082001euoutp02c75b27a64f20d2c267248ae9d68dde20~5gexz7asy1480614806euoutp02d;
        Tue, 19 Jun 2018 08:20:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619082001euoutp02c75b27a64f20d2c267248ae9d68dde20~5gexz7asy1480614806euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396401;
        bh=g1pzJh3WA3mUqKmeX9FEzvLX8jXy2N5Lqa+rp0K1ySc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=s2dy79bDC+Hr66drf8tG4X7wWHqKXS8HMbf2CdGLBnRNHsha6NjlSAJB6KUmn782R
         2SFgGyB8Ylf6kvXUKRbNMHl9KFfodX2Zi8m1tNMeXjHXsn0p+4RWrcxIXx313qKzAF
         tSnkgLJguM9/iOsCnbB4HQP104KPIZro2fsfFCMs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619082000eucas1p2258c5a62acddd065b561f27e3455f23b~5gew7KWLR0178901789eucas1p2_;
        Tue, 19 Jun 2018 08:20:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.AA.05700.FACB82B5; Tue, 19
        Jun 2018 09:19:59 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e~5gewNjq1I3063530635eucas1p1Z;
        Tue, 19 Jun 2018 08:19:59 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-23-5b28bcafc308
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.56.04178.FACB82B5; Tue, 19
        Jun 2018 09:19:59 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:19:59 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 3/9] drm/exynos: enable out_bridge in exynos_dsi_enable()
Date:   Tue, 19 Jun 2018 10:19:24 +0200
Message-id: <1529396370-18761-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSayyVcRjvf96rM8feHeRPMjutMS3S+vBvtdZKej+w6UtE0ok3zLXzomTT
        SYlD5FKRTthciikcoiRGFlYcJ6XYDkk4bnNXPnRxvHz7/Z7f5dmzPTQmVRE2dGhkDKeIlIfL
        SDHe8H5du7+62dHvQGOLCxp60UugjN5uEUpKnSNQbX41gYo6NmafV+dJlDOShSPDsA5H98Zm
        MKTV1lCoJ2mWQqrsUgppxgYI1N+kJlG+tkWEiqeGcPS8Q0+hsq86EUp+20Gh/NwpEq03FeLH
        LdmqwirA9mdmiNjXBXqKfZz6iGA1lSqSbVz7TrAj6Z0itq70BptZXwnYZY2dl9hXfDSICw+N
        4xQuxy6KQ1r7PpLRS8y1rrUGUgkyzdKACQ2ZQ3C6S42nATEtZZ4BODxuoASyDGByXhu+7Uop
        bBcJQjmAWfOLW65/AKpKjBGaJhknWJUSYJxbMJUA1n2bA0aCMQ8I2Fc0QxirzBkP+OPm4mYt
        zuyFy6oayogljBus0GQTwjo7ONirwozYhDkFC5782lwNmVwK6rsekoLJDS7Pj24FzOF0Zz0l
        YFuoSm0TCTgBVkw9xYWwEsAVfT8mCEfgu07dZhhjzGBOQx5mPAEyEph6RypYWKjsvguEM/MB
        rMmYB1nAuhjsqARWXCwfEczxrpHcVWdeHsHHRgY7B0ZFaMDGg3z427n0Cqx+utQOGBrITCXK
        Wgc/KSGP4+Mj2gGkMZmF5GWZo59UEiSPv84pogIUseEc3w520bjMSnLBMdFXygTLY7gwjovm
        FNuqiDaxUQLvRl63x7bPxH8Sb9HfP2kupk9MFI8Z7ANNfey143B2+suC2lPn46pKH20579Hj
        tXPBQS2ld9ed7jJM3HYIS0x3NJTH+hIJnvvkJQR3a7LJReKuH6zOPpPQ5hE62yoDdr/L94Sc
        XTjn3jziXzfQgS1kH/x55bCl2ttm5c3lP9YynA+RuzphCl7+H3u5aWQcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xa7rr92hEG5x9z2txa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBn7L5xhK/gkUHHi2za2BsY+vi5GTg4JAROJ9nmHmLoYuTiEBJYwSjTsuMcGkhAS
        aGSSmHVdoIuRg4NNQEtiTXs8SI2IwCpGial/77CDOMwCs1klXj2awAjSICzgI/Go8SMLiM0i
        oCrxuXMDO4jNK+AisXLTRFaIbXISN891MoPYnAKuErPmfmeCWOYi8WL1FaYJjDwLGBlWMYqk
        lhbnpucWG+oVJ+YWl+al6yXn525iBAb+tmM/N+9gvLQx+BCjAAejEg9vw0b1aCHWxLLiytxD
        jBIczEoivFuXakQL8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi
        4JRqYCyeqXa39+fbhtXm6k3McuI+R/n5FYX5bn837WdaMf+k/csd2eqnOEu5SpV4NNWy424I
        7Z8Y2BG3I7Fxptr5zrmvly0NeFWRtz3Sdt0XJp0HL+SibryY+qLY9Rvr/e/HPM7JpH79+Lz+
        iPDZIJu4uiJ9w3UOqznuTRH4e5B18fHlBS67/R3TvZVYijMSDbWYi4oTAY/Tvw14AgAA
X-CMS-MailID: 20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the out bridge will not be enabled directly by the framework,
it should be enabled by DSI. Exynos_dsi_enable() should handle a case,
when there is an out_bridge connected as a DSI peripheral.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index c0408c0..8aa7ace 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1386,25 +1386,33 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 
 	dsi->state |= DSIM_STATE_ENABLED;
 
-	ret = drm_panel_prepare(dsi->panel);
-	if (ret < 0) {
-		dsi->state &= ~DSIM_STATE_ENABLED;
-		pm_runtime_put_sync(dsi->dev);
-		return;
+	if (dsi->panel) {
+		ret = drm_panel_prepare(dsi->panel);
+		if (ret < 0) {
+			dsi->state &= ~DSIM_STATE_ENABLED;
+			return;
+		}
 	}
 
+	if (dsi->out_bridge)
+		drm_bridge_pre_enable(dsi->out_bridge);
+
 	exynos_dsi_set_display_mode(dsi);
 	exynos_dsi_set_display_enable(dsi, true);
 
-	ret = drm_panel_enable(dsi->panel);
-	if (ret < 0) {
-		dsi->state &= ~DSIM_STATE_ENABLED;
-		exynos_dsi_set_display_enable(dsi, false);
-		drm_panel_unprepare(dsi->panel);
-		pm_runtime_put_sync(dsi->dev);
-		return;
+	if (dsi->panel) {
+		ret = drm_panel_enable(dsi->panel);
+		if (ret < 0) {
+			dsi->state &= ~DSIM_STATE_ENABLED;
+			exynos_dsi_set_display_enable(dsi, false);
+			drm_panel_unprepare(dsi->panel);
+			return;
+		}
 	}
 
+	if (dsi->out_bridge)
+		drm_bridge_enable(dsi->out_bridge);
+
 	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
 }
 
@@ -1418,8 +1426,10 @@ static void exynos_dsi_disable(struct drm_encoder *encoder)
 	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
 
 	drm_panel_disable(dsi->panel);
+	drm_bridge_disable(dsi->out_bridge);
 	exynos_dsi_set_display_enable(dsi, false);
 	drm_panel_unprepare(dsi->panel);
+	drm_bridge_post_disable(dsi->out_bridge);
 
 	dsi->state &= ~DSIM_STATE_ENABLED;
 
-- 
2.7.4

