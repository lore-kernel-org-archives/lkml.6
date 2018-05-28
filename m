Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423751AbeE1LJX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423710AbeE1LJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 088/272] bnxt_en: fix clear flags in ethtool reset handling
Date: Mon, 28 May 2018 12:02:01 +0200
Message-Id: <20180528100248.519273033@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Branden <scott.branden@broadcom.com>

[ Upstream commit 2373d8d6a7932d28b8e31ea2a70bf6c002d97ac8 ]

Clear flags when reset command processed successfully for components
specified.

Fixes: 6502ad5963a5 ("bnxt_en: Add ETH_RESET_AP support")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2552,16 +2552,20 @@ static int bnxt_reset(struct net_device
 			return -EOPNOTSUPP;
 
 		rc = bnxt_firmware_reset(dev, BNXT_FW_RESET_CHIP);
-		if (!rc)
+		if (!rc) {
 			netdev_info(dev, "Reset request successful. Reload driver to complete reset\n");
+			*flags = 0;
+		}
 	} else if (*flags == ETH_RESET_AP) {
 		/* This feature is not supported in older firmware versions */
 		if (bp->hwrm_spec_code < 0x10803)
 			return -EOPNOTSUPP;
 
 		rc = bnxt_firmware_reset(dev, BNXT_FW_RESET_AP);
-		if (!rc)
+		if (!rc) {
 			netdev_info(dev, "Reset Application Processor request successful.\n");
+			*flags = 0;
+		}
 	} else {
 		rc = -EINVAL;
 	}
