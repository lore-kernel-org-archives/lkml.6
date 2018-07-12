Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2598FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB64C20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB64C20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeGLF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:58:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49429 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726911AbeGLF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:58:06 -0400
X-UUID: 8398a40f49f040cab38ddbedded558e7-20180712
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 287653363; Thu, 12 Jul 2018 13:50:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 12 Jul 2018 13:50:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 12 Jul 2018 13:50:02 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] pinctrl: mt7622: fix probe fail by misuse the selector
Date:   Thu, 12 Jul 2018 13:50:00 +0800
Message-ID: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

After the commit acf137951367 ("pinctrl: core: Return selector to the
pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
selector to the pinctrl driver"), it's necessary to add the fixes
needed for the pin controller drivers to use the appropriate returned
selector for a negative error number returned in case of the fail at
these functions. Otherwise, the driver would have a failed probe and
that causes boot message cannot correctly output and devices fail
to acquire their own pins.

Cc: Kevin Hilman <khilman@baylibre.com>
Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver")
Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl driver")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 2411c384..6f931b8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1538,7 +1538,7 @@ static int mtk_build_groups(struct mtk_pinctrl *hw)
 		err = pinctrl_generic_add_group(hw->pctrl, group->name,
 						group->pins, group->num_pins,
 						group->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register group %s\n",
 				group->name);
 			return err;
@@ -1559,7 +1559,7 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 						  func->group_names,
 						  func->num_group_names,
 						  func->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register function %s\n",
 				func->name);
 			return err;
-- 
2.7.4

