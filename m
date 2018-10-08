Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED9C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D067C2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D067C2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJHRSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:18:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38913 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHRSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:18:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4E56D208E7; Mon,  8 Oct 2018 12:07:49 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0ABC3207CC;
        Mon,  8 Oct 2018 12:07:39 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 0/6] net: phy: mscc: various improvements to Microsemi PHY driver
Date:   Mon,  8 Oct 2018 12:07:22 +0200
Message-Id: <20181008100728.24959-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsemi PHYs have multiple banks of registers (called pages).
Registers can only be accessed from one page, if we need a register from
another page, we need to switch the page and the registers of all other
pages are not accessible anymore.

Basically, to read register 5 from page 0, 1, 2, etc., you do the same
phy_read(phydev, 5); but you need to set the desired page beforehand.

In order to guarantee that two concurrent functions do not change the
page, we need to do some locking per page. This can be achieved with the
use of phy_select_page and phy_restore_page functions but phy_write/read
calls in-between those two functions shall be replaced by their
lock-free alternative __phy_write/read.

The Microsemi PHYs have several counters so let's make them available as PHY
statistics.

The VSC 8530/31/40/41 also need to update their EEE init sequence in order to
avoid packet losses and improve performance.

This patch series also makes some minor cosmetic changes to the driver.

Thanks,
Quentin

v3:
  - add reviewed-by,
  - use phy_read/write/modify_paged whenever possible instead of the
  combo phy_select_page, __phy_read/write/modify, phy_restore_page when
  only one __phy_read/write/modify was executed,

v2:
  - add patch to migrate MSCC driver to use phy_restore/select_page,
  - migrate all patches from v1 to use those two functions,
  - put the multiple lines of constants writes in an array and iterate over
  it to write the values,
  - add reviewed-bys,

Quentin Schulz (4):
  net: phy: mscc: migrate to phy_select/restore_page functions
  net: phy: mscc: remove unneeded parenthesis
  net: phy: mscc: shorten `x != 0` condition to `x`
  net: phy: mscc: remove unneeded temporary variable

Raju Lakkaraju (2):
  net: phy: mscc: add ethtool statistics counters
  net: phy: mscc: Add EEE init sequence

 drivers/net/phy/mscc.c | 352 +++++++++++++++++++++++++++++------------
 1 file changed, 255 insertions(+), 97 deletions(-)

-- 
2.17.1

