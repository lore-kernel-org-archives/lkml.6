Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3524C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7120881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763501;
	bh=yKjzKezuSGv5f8tAyC59tLC6LIAgxE504A+ByYr3yno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HndU3gdWSc7hOx2HlwIamvwnUgmAlNfzpJUBE4/yypD50maHdmTUHhfI/MpD8DwxT
	 J55u3hjaj3EJxwuTZzkx5/cYG++OPNvSpVPsMl2dGKjbV3ROCaiuGWRPYcGdQVBzGo
	 NtsVEjAYxOjNNofAr3JGx9bYXYjZR+inPRNdzHqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfA2MFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:05:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfA2Lmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7E920856;
        Tue, 29 Jan 2019 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762152;
        bh=yKjzKezuSGv5f8tAyC59tLC6LIAgxE504A+ByYr3yno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVAYpD6WW88a32vbjkaoVsvqEP6O7h3l5dUrCQNU/9H3mI+PXW07qCjeHppWMDmIQ
         WGkZwGjYbNRYnCOKo1zGRKkHj9yZCgxh+NyELAhgmBiRkCYPnYl0oePqhWR1FwxQiT
         37HexJh9YbsJG63e/USon37NXtFA7BHCP+kjakRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 001/103] amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs
Date:   Tue, 29 Jan 2019 12:34:38 +0100
Message-Id: <20190129113159.671535496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

[ Upstream commit 5ab3121beeb76aa6090195b67d237115860dd9ec ]

The XGBE hardware has support for performing MDIO operations using an
MDIO command request. The driver mistakenly uses the mdio port address
as the MDIO command request device address instead of the MDIO command
request port address. Additionally, the driver does not properly check
for and create a clause 45 MDIO command.

Check the supplied MDIO register to determine if the request is a clause
45 operation (MII_ADDR_C45). For a clause 45 operation, extract the device
address and register number from the supplied MDIO register and use them
to set the MDIO command request device address and register number fields.
For a clause 22 operation, the MDIO request device address is set to zero
and the MDIO command request register number is set to the supplied MDIO
register. In either case, the supplied MDIO port address is used as the
MDIO command request port address.

Fixes: 732f2ab7afb9 ("amd-xgbe: Add support for MDIO attached PHYs")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |    2 --
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    |   22 ++++++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -431,8 +431,6 @@
 #define MAC_MDIOSCAR_PA_WIDTH		5
 #define MAC_MDIOSCAR_RA_INDEX		0
 #define MAC_MDIOSCAR_RA_WIDTH		16
-#define MAC_MDIOSCAR_REG_INDEX		0
-#define MAC_MDIOSCAR_REG_WIDTH		21
 #define MAC_MDIOSCCDR_BUSY_INDEX	22
 #define MAC_MDIOSCCDR_BUSY_WIDTH	1
 #define MAC_MDIOSCCDR_CMD_INDEX		16
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1284,6 +1284,20 @@ static void xgbe_write_mmd_regs(struct x
 	}
 }
 
+static unsigned int xgbe_create_mdio_sca(int port, int reg)
+{
+	unsigned int mdio_sca, da;
+
+	da = (reg & MII_ADDR_C45) ? reg >> 16 : 0;
+
+	mdio_sca = 0;
+	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, RA, reg);
+	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, PA, port);
+	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, DA, da);
+
+	return mdio_sca;
+}
+
 static int xgbe_write_ext_mii_regs(struct xgbe_prv_data *pdata, int addr,
 				   int reg, u16 val)
 {
@@ -1291,9 +1305,7 @@ static int xgbe_write_ext_mii_regs(struc
 
 	reinit_completion(&pdata->mdio_complete);
 
-	mdio_sca = 0;
-	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, REG, reg);
-	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, DA, addr);
+	mdio_sca = xgbe_create_mdio_sca(addr, reg);
 	XGMAC_IOWRITE(pdata, MAC_MDIOSCAR, mdio_sca);
 
 	mdio_sccd = 0;
@@ -1317,9 +1329,7 @@ static int xgbe_read_ext_mii_regs(struct
 
 	reinit_completion(&pdata->mdio_complete);
 
-	mdio_sca = 0;
-	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, REG, reg);
-	XGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, DA, addr);
+	mdio_sca = xgbe_create_mdio_sca(addr, reg);
 	XGMAC_IOWRITE(pdata, MAC_MDIOSCAR, mdio_sca);
 
 	mdio_sccd = 0;


