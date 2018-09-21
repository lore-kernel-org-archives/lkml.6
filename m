Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FDECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCEB21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCEB21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbeIUJyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:54:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8912 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389061AbeIUJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:54:43 -0400
X-UUID: 807b2057b45f46bdb50ce0650a1643d0-20180921
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 839456864; Fri, 21 Sep 2018 12:07:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 12:07:40 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 12:07:40 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/4] pinctrl: mediatek: fix static checker warning caused by EINT_NA
Date:   Fri, 21 Sep 2018 12:07:35 +0800
Message-ID: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 65AFECEC4204B721142E7DCE6902DEBE4EBEB91D766CB7AB5D6C60707F7371862000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

EINT_NA is an u16 number, so it should be U16_MAX instead of -1
to fix up drivers/pinctrl/mediatek/pinctrl-paris.c:732 mtk_gpio_to_irq()
warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))

Also happens in
drivers/pinctrl/mediatek/pinctrl-paris.c:749 mtk_gpio_set_config()
warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))

drivers/pinctrl/mediatek/pinctrl-moore.c:479 mtk_gpio_to_irq()
warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))

drivers/pinctrl/mediatek/pinctrl-moore.c:496 mtk_gpio_set_config()
warn: impossible condition '(desc->eint.eint_n == -1) => (0-u16max == (-1))

Fixes: 6561859b067f ("pinctrl: mediatek: add eint support to MT8183 pinctrl driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 10d33ec..b618042 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -18,7 +18,7 @@
 #define MTK_PULLDOWN   0
 #define MTK_PULLUP     1
 
-#define EINT_NA	-1
+#define EINT_NA	U16_MAX
 
 #define PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs,      \
 		       _s_bit, _x_bits, _sz_reg, _fixed) {		\
-- 
2.7.4

