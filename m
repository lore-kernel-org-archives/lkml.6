Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A92733C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1A92733C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965478AbeF1Mmt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:42:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46862 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753260AbeF1Mms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:42:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 45EF220DCD; Thu, 28 Jun 2018 14:42:46 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id EC1ED206ED;
        Thu, 28 Jun 2018 14:42:35 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/4] net: mvpp2: Add big-endian support
Date:   Thu, 28 Jun 2018 14:42:03 +0200
Message-Id: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows to use PPv2 on system built as big endian.

The first patch fixes the way we represent TX and RX descriptors, so that
they used fixed little endianness as expected by the PPv2 controller.

The second reworks the way we handle the software representation of the
Header Parser entries, so that we don't use a union of arrays.

The last two patches fixes some incorrect byte swapping logic, that wen't
un-noticed on little-endian.

This whole series doesn't fix any existing bug for little-endian systems, and
since big-endian never worked for this driver, I didn't include 'fixes' tags.

This was tested on MacchiatoBin (Armada 8040).

Maxime Chevallier (4):
  net: mvpp2: Make TX / RX descriptors little-endian
  net: mvpp2: prs: Drop unions representing TCAM and SRAM entries
  net: mvpp2: prs: Drop unnecessary swab16 in vlan detection
  net: mvpp2: Use htons when checking protocol info

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      |  58 ++++-----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  43 ++++---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c  | 155 +++++++++++-------------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h  |  41 +++----
 4 files changed, 141 insertions(+), 156 deletions(-)

-- 
2.11.0

