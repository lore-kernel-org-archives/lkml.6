Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295FC208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295FC208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeH0N41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:56:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22600 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727091AbeH0N41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:56:27 -0400
X-UUID: 695a0d47516246178c98830844b68f4e-20180827
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1942752243; Mon, 27 Aug 2018 18:10:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 27 Aug 2018 18:10:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 27 Aug 2018 18:10:18 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 00/16] Unify MediaTek pinctrl in preparation for MT8183 and MT6765
Date:   Mon, 27 Aug 2018 18:09:59 +0800
Message-ID: <cover.1535363951.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

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

Sean Wang (16):
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

 drivers/pinctrl/mediatek/Kconfig                 |   25 +-
 drivers/pinctrl/mediatek/Makefile                |    2 +
 drivers/pinctrl/mediatek/pinctrl-moore.c         |  813 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-moore.h         |   57 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 1407 ++++-----------------
 drivers/pinctrl/mediatek/pinctrl-mt7623.c        | 1441 ++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  510 ++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  281 +++++
 8 files changed, 3345 insertions(+), 1191 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7623.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h

-- 
2.7.4

