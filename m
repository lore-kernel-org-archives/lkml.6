Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A466C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04231218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfABOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:10:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39997 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729498AbfABOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:10:41 -0500
X-UUID: 9b4dce0da76648e0a34fe008980aabd2-20190102
X-UUID: 9b4dce0da76648e0a34fe008980aabd2-20190102
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 352485292; Wed, 02 Jan 2019 22:10:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 22:10:26 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 22:10:26 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for active state of scpsys on mt8183
Date:   Wed, 2 Jan 2019 22:09:51 +0800
Message-ID: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchsets add support for MediaTek hardware module named DVFSRC
(dynamic voltage and frequency scaling resource collector). The DVFSRC is
a HW module which is used to collect all the requests from both software
and hardware and turn into the decision of minimum operating voltage and
minimum DRAM frequency to fulfill those requests.

So, This series is to implement the dvfsrc driver to collect all the
requests of operating voltage or DRAM bandwidth from other device drivers
likes GPU/Camera through 2 frameworks basically:

1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
   requirements from different clients
2. Active state management of power domains[1]: to handle the operating
   voltage opp requirement from different power domains

[1] https://lwn.net/Articles/744047/

Henry Chen (7):
  dt-bindings: soc: Add DVFSRC driver bindings
  dt-bindings: soc: Add opp table on scpsys bindings
  soc: mediatek: add support for the performance state
  arm64: dts: mt8183: add performance state support of scpsys
  soc: mediatek: add header for mediatek SIP interface
  soc: mediatek: add MT8183 dvfsrc support
  arm64: dts: mt8183: add dvfsrc related nodes

 Documentation/devicetree/bindings/opp/mtk-opp.txt  |  24 ++
 .../devicetree/bindings/soc/mediatek/dvfsrc.txt    |  26 ++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  42 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  29 ++
 drivers/soc/mediatek/Kconfig                       |  15 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c                  | 473 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  |  60 +++
 drivers/soc/mediatek/mtk-scpsys.h                  |  22 +
 include/dt-bindings/soc/mtk,dvfsrc.h               |  18 +
 include/soc/mediatek/mtk_sip.h                     |  17 +
 11 files changed, 727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
 create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
 create mode 100644 include/soc/mediatek/mtk_sip.h

-- 
1.9.1

