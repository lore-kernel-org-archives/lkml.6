Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F3DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938252064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938252064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJSRpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:45:53 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:42828 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeJSRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:45:53 -0400
X-Greylist: delayed 1313 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 13:45:53 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 6954A400D6CC1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 04:18:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id DQvegKBNPPvAdDQveg7jHU; Fri, 19 Oct 2018 04:18:46 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:50422 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gDQvd-000ms9-Ec; Fri, 19 Oct 2018 04:18:45 -0500
Date:   Fri, 19 Oct 2018 11:18:43 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3 0/2] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <cover.1539940387.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gDQvd-000ms9-Ec
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:50422
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to fix an out-of-bounds bug in
the phy-ocelot-serdes driver.

Currently, there is an out-of-bounds read on array ctrl->phys,
once variable i reaches the maximum array size of SERDES_MAX
in the for loop.

Quentin Schulz pointed out that SERDES_MAX is a valid value to
index ctrl->phys. So, I updated SERDES_MAX to be SERDES6G_MAX + 1
in include/dt-bindings/phy/phy-ocelot-serdes.h.

Then I changed the condition in the for loop from
i <= SERDES_MAX to i < SERDES_MAX in order to
complete the fix.

The reason I'm sending this fix as series is because
checkpatch reported an error when I first tried to
integrate the whole solution into a singe patch. So,
changes to dt-bindings should be sent as a separate
patch.

Thanks!

Changes in v3:
 - Post the series to netdev, so Dave can take it.

Changes in v2:
 - Send the whole series to Kishon Vijay Abraham I, so it
   can be taken into the PHY tree.
 - Add Quentin's Reviewed-by to commit log in both patches.

Gustavo A. R. Silva (2):
  dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX + 1
  phy: ocelot-serdes: fix out-of-bounds read

 drivers/phy/mscc/phy-ocelot-serdes.c        | 4 ++--
 include/dt-bindings/phy/phy-ocelot-serdes.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

