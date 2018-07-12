Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E18C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D50213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D50213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeGLMD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:03:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeGLMD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:03:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 030AE20731; Thu, 12 Jul 2018 13:54:42 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id AA061206A6;
        Thu, 12 Jul 2018 13:54:41 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 00/18] net: mvpp2: add RSS support
Date:   Thu, 12 Jul 2018 13:54:09 +0200
Message-Id: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for RSS on PPv2. There already was some code to
handle the RSS tables, but the driver was missing all the classification
steps required to actually use these tables.

RSS is used through the classifier, using at least 2 lookups :
 - One using the C2 engine, a TCAM engine that match the packet based on
   some header extracted fields, assigns the default rx queue for that
   packet and tag it for RSS
 - One using the C3Hx engine, which computes the hash that's used to perform
   the lookup in the RSS table.

Since RSS spreads the load across CPUs, we need to make sure that packets
from the same flow are always assigned the same rx queue, to prevent
re-ordering.

This series therefore adds a classification step based on the Header Parser,
that separate ingress traffic into 52 flows, based on some L2, L3 and L4
parameters.

Patches 1 and 2 fix some header issues, from the driver splitting

Patches 3 to 7 make sure the correct receive queue setup is used for RSS

Patches 8 to 14 deal with the way we handle the RSS tables

Patch 15 implement basic classifier configuration, by using it to assign the
default receive queue

Patch 16 implement the ingress traffic splitting into multiple flows

Patch 17 adds RSS support, by using the needed classification steps

Patch 18 adds the required ethtool ops to configure the flow hash parameters

This was tested on MacchiatoBin, giving some nice performance improvements
using ip forwarding (going from 5Gbps to 9.6Gbps total throughput).

RSS is disabled by default.

Antoine Tenart (3):
  net: mvpp2: fix a typo in the RSS code
  net: mvpp2: RSS indirection table support
  net: mvpp2: improve the distribution of packets on CPUs when using RSS

Maxime Chevallier (14):
  net: mvpp2: fix include guards in mvpp2_prs.h
  net: mvpp2: define the number of RSS entries per table in mvpp2.h
  net: mvpp2: make sure we use single queue mode on PPv2.1
  net: mvpp2: make multi queue mode the default mode
  net: mvpp2: fix hardcoded number of rx queues
  net: mvpp2: use only one rx queue per port per CPU
  net: mvpp2: fix RSS register definitions
  net: mvpp2: use one RSS table per port
  net: mvpp2: make sure we don't spread load on disabled CPUs
  net: mvpp2: rename per-port RSS init function
  net: mvpp2: use classifier to assign default rx queue
  net: mvpp2: split ingress traffic into multiple flows
  net: mvpp2: add an RSS classification step for each flow
  net: mvpp2: allow setting RSS flow hash parameters with ethtool

Yan Markman (1):
  net: mvpp2: use RSS only when using multi-queue mode

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      |  52 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 929 +++++++++++++++++++++++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  | 177 ++++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 127 +++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c  |  35 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h  |  18 +-
 6 files changed, 1307 insertions(+), 31 deletions(-)

-- 
2.11.0

