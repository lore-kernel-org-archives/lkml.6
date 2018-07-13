Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9682089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9682089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeGMQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:35:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38909 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbeGMQfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:35:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C211E20922; Fri, 13 Jul 2018 18:20:17 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9502E2074F;
        Fri, 13 Jul 2018 18:20:07 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v2 0/7] A fix and a few improvements on mvneta
Date:   Fri, 13 Jul 2018 18:18:34 +0200
Message-Id: <20180713161841.11202-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series brings some improvements for the mvneta driver and also
adds a fix.

Compared to the v1, the main change is the a new patch fixing a bug
which is visible in net-next. Now the mvneta driver just crashes when
opening on Armada 37xx. As indicated in the patch, the bug was there
since many releases but the problem is only visible now.

The series had been tested on ARM32 (clearfog) and ARM64
(EspressoBin), with and without hardware buffer management.

Gregory

Chnagelog:
v1 -> v2

 - In patch 2, use EXPORT_SYMBOL_GPL for mvneta_bm_get and
   mvneta_bm_put to be used in module, reported by kbuild test robot.

 - In patch 4, add the counter to the driver's ethtool state,
   suggested by David Miller.

 - In patch 6, use a single if, suggested by Marcin Wojtas

Andrew Lunn (1):
  net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Gregory CLEMENT (3):
  net: mvneta: remove data pointer usage from device_node structure
  net: mvneta: discriminate error cause for missed packet
  net: mvneta: Allocate page for the descriptor

Yelena Krivosheev (3):
  net: mvneta: increase number of buffers in RX and TX queue
  net: mvneta: Verify hardware checksum only when offload checksum
    feature is set
  net: mvneta: Improve the buffer allocation method for SWBM

 drivers/net/ethernet/marvell/mvneta.c    | 412 ++++++++++++++---------
 drivers/net/ethernet/marvell/mvneta_bm.c |  15 +
 drivers/net/ethernet/marvell/mvneta_bm.h |   8 +-
 3 files changed, 274 insertions(+), 161 deletions(-)

-- 
2.18.0

