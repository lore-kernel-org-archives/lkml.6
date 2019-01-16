Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC987C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A8E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfAPHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:53:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:55863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388167AbfAPHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:53:42 -0500
X-UUID: 0c8637e80d2a4949a3074d5d4ff0879f-20190116
X-UUID: 0c8637e80d2a4949a3074d5d4ff0879f-20190116
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 481533881; Wed, 16 Jan 2019 15:53:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 15:53:31 +0800
Received: from mszsdaap41.mediatek.inc (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 15:53:30 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <sj.huang@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>
Subject: [PATCH] pwm: Add MediaTek MT8183 display PWM driver support
Date:   Wed, 16 Jan 2019 15:52:52 +0800
Message-ID: <20190116075252.24124-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the mtk_pwm_data struction to define different registers
and add MT8183 specific register operations, such as MT8183
have commit register, needs to enable double buffer
before writing register, and needs to select commit mode
and use PWM_PERIOD/PWM_HIGH_WIDTH.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 893940d45f0d..15803c71fe80 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -277,10 +277,21 @@ static const struct mtk_pwm_data mt8173_pwm_data = {
 	.commit_mask = 0x1,
 };
 
+static const struct mtk_pwm_data mt8183_pwm_data = {
+	.enable_mask = BIT(0),
+	.con0 = 0x18,
+	.con0_sel = 0x0,
+	.con1 = 0x1c,
+	.has_commit = false,
+	.bls_debug = 0x80,
+	.bls_debug_mask = 0x3,
+};
+
 static const struct of_device_id mtk_disp_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-pwm", .data = &mt2701_pwm_data},
 	{ .compatible = "mediatek,mt6595-disp-pwm", .data = &mt8173_pwm_data},
 	{ .compatible = "mediatek,mt8173-disp-pwm", .data = &mt8173_pwm_data},
+	{ .compatible = "mediatek,mt8183-disp-pwm", .data = &mt8183_pwm_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
-- 
2.12.5

