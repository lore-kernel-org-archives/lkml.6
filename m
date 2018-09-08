Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E4C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF020844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEF020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeIHPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbeIHPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:12 -0400
X-UUID: c6059b04d56e47ad80ec7912309c2dbd-20180908
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 222446201; Sat, 08 Sep 2018 19:07:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:39 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for MT8183 and MT6765
Date:   Sat, 8 Sep 2018 19:07:16 +0800
Message-ID: <cover.1536404280.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v2 and changes since v1:

add new patches
* Add additional patch 17 to 22 to support MT8183 SoC

update the existing patches
* Patch 2: Removed unnecessary blank line and headers included.
* Patch 4: Extended the size eint number can hold since it's possible more than 254 pins in certain SoC.
* Patch 11: Added cosmetic patch and fixed an error logic on invalid condition.
* Patch 14: Removed unused macro and given a better naming to the name of the default bases.

v1:

Irregular register arrangement and their logic access from various MediaTek
SoCs being introduced already causes pinctrl-mtk-common to bloat and became
really hard to maintain so that the patch creates pinctrl-mtk-common-v2 based
on the core of mt7622 pinctrl to try make the register operations to be simple.

The goals pinctrl-mtk-common-v2 want to achieve are to hopefully support
all of MediaTek SoCs, and two kinds of dt-bindings being supported,
Linux generic pinctrl dt-binding which mt762x like to support and MediaTek
vendor per-pin dt-binding the other SoCs support the MT8183 and MT6765 incline
to make use of.

The patch starts to refactor MT7622 pinctrl driver first with splitting
out these portable ways from there such as table-based register operation
and the other operations in common in the both kinds of driver.

Sean Wang (19):
  pinctrl: mediatek: add pinctrl-mtk-common-v2 for all MediaTek pinctrls
  pinctrl: mediatek: add pinctrl-moore that implements the generic
    pinctrl dt-bindings
  pinctrl: mediatek: extend struct mtk_pin_field_calc to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: extend struct mtk_pin_desc to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: extend struct mtk_pin_soc to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add driving strength related support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add drv register support to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add pull related support to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add advanced pull related support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add ies register support to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add pullen, pullsel register support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add MT7623 pinctrl driver based on generic pinctrl
    binding
  pinctrl: mediatek: use pin descriptor all in pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add multiple register bases support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: adjust error code and message when some register
    not supported is found
  pinctrl: mediatek: extend struct mtk_pin_desc which per-pin driver
    depends on
  pinctrl: mediatek: extend advanced pull support in
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: extend eint build to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add eint support to MT8183 pinctrl driver

Zhiyong Tao (3):
  pinctrl: mediatek: add pinctrl-paris that implements the vendor
    dt-bindings
  pinctrl: mediatek: add MT8183 pinctrl driver
  pintcrl: mediatek: add pull tweaks for I2C related pins on MT8183

 drivers/pinctrl/mediatek/Kconfig                 |   41 +-
 drivers/pinctrl/mediatek/Makefile                |    4 +
 drivers/pinctrl/mediatek/pinctrl-moore.c         |  689 ++++++++
 drivers/pinctrl/mediatek/pinctrl-moore.h         |   53 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 1407 +++-------------
 drivers/pinctrl/mediatek/pinctrl-mt7623.c        | 1441 ++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt8183.c        |  544 ++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  670 ++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  288 ++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8183.h    | 1916 ++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c         |  906 ++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.h         |   65 +
 12 files changed, 6833 insertions(+), 1191 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7623.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8183.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8183.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-paris.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-paris.h

-- 
2.7.4

