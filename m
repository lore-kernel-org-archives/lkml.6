Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422894AbeE1LDF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422864AbeE1LCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jake Moroni <mail@jakemoroni.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 474/496] dpaa_eth: fix pause capability advertisement logic
Date: Mon, 28 May 2018 12:04:19 +0200
Message-Id: <20180528100339.880463103@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jake Moroni <mail@jakemoroni.com>

[ Upstream commit 3021efb440d02bf5b952b6d151c7ffee9bdd49fe ]

The ADVERTISED_Asym_Pause bit was being improperly set when both
rx and tx pause were enabled. When rx and tx are both enabled, only
the ADVERTISED_Pause bit is supposed to be set.

Signed-off-by: Jake Moroni <mail@jakemoroni.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -211,7 +211,7 @@ static int dpaa_set_pauseparam(struct ne
 	if (epause->rx_pause)
 		newadv = ADVERTISED_Pause | ADVERTISED_Asym_Pause;
 	if (epause->tx_pause)
-		newadv |= ADVERTISED_Asym_Pause;
+		newadv ^= ADVERTISED_Asym_Pause;
 
 	oldadv = phydev->advertising &
 			(ADVERTISED_Pause | ADVERTISED_Asym_Pause);
