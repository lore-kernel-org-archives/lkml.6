Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93706C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C5D21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C5D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJRXHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:07:37 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.96]:40594 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbeJRXHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:07:36 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id AA0312624D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:06:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id D9s6gdLqLFxNhD9sDgwSsO; Thu, 18 Oct 2018 10:06:10 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:56400 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gD9s5-004Bvl-2t; Thu, 18 Oct 2018 10:05:57 -0500
Date:   Thu, 18 Oct 2018 17:05:54 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 0/2] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <cover.1539874459.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gD9s5-004Bvl-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:56400
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

Changes in v2:
 - Send the whole series to Kishon Vijay Abraham I, so it
   can be taken into the PHY tree.
 - Add Quentin's Reviewed-by to commit log in both patches.

Thanks!

Gustavo A. R. Silva (2):
  dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX + 1
  phy: ocelot-serdes: fix out-of-bounds read

 drivers/phy/mscc/phy-ocelot-serdes.c        | 4 ++--
 include/dt-bindings/phy/phy-ocelot-serdes.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

