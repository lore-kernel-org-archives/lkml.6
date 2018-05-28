Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424583AbeE1LPf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424566AbeE1LPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:15:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 233/272] sh_eth: fix TSU init on SH7734/R8A7740
Date: Mon, 28 May 2018 12:04:26 +0200
Message-Id: <20180528100259.961744303@linuxfoundation.org>
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

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit a94cf2a614f8bc5b2b33c708626ce695bf71e424 ]

It appears that the single port Ether controllers having TSU (like SH7734/
R8A7740) need the same kind of treating in sh_eth_tsu_init() as R7S72100
currently has -- they also don't have the TSU registers related e.g. to
passing the frames between ports. Add the 'sh_eth_cpu_data::dual_port'
flag and use it as a new criterion for taking a "short path" in the TSU
init sequence in order to avoid writing to the non-existent registers...

Fixes: f0e81fecd4f8 ("net: sh_eth: Add support SH7734")
Fixes: 73a0d907301e ("net: sh_eth: add support R8A7740")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/sh_eth.c |    6 +++++-
 drivers/net/ethernet/renesas/sh_eth.h |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -763,6 +763,7 @@ static struct sh_eth_cpu_data sh7757_dat
 	.rpadir		= 1,
 	.rpadir_value   = 2 << 16,
 	.rtrate		= 1,
+	.dual_port	= 1,
 };
 
 #define SH_GIGA_ETH_BASE	0xfee00000UL
@@ -841,6 +842,7 @@ static struct sh_eth_cpu_data sh7757_dat
 	.no_trimd	= 1,
 	.no_ade		= 1,
 	.tsu		= 1,
+	.dual_port	= 1,
 };
 
 /* SH7734 */
@@ -911,6 +913,7 @@ static struct sh_eth_cpu_data sh7763_dat
 	.tsu		= 1,
 	.irq_flags	= IRQF_SHARED,
 	.magic		= 1,
+	.dual_port	= 1,
 };
 
 static struct sh_eth_cpu_data sh7619_data = {
@@ -943,6 +946,7 @@ static struct sh_eth_cpu_data sh771x_dat
 			  EESIPR_RRFIP | EESIPR_RTLFIP | EESIPR_RTSFIP |
 			  EESIPR_PREIP | EESIPR_CERFIP,
 	.tsu		= 1,
+	.dual_port	= 1,
 };
 
 static void sh_eth_set_default_cpu_data(struct sh_eth_cpu_data *cd)
@@ -2932,7 +2936,7 @@ static int sh_eth_vlan_rx_kill_vid(struc
 /* SuperH's TSU register init function */
 static void sh_eth_tsu_init(struct sh_eth_private *mdp)
 {
-	if (sh_eth_is_rz_fast_ether(mdp)) {
+	if (!mdp->cd->dual_port) {
 		sh_eth_tsu_write(mdp, 0, TSU_TEN); /* Disable all CAM entry */
 		sh_eth_tsu_write(mdp, TSU_FWSLC_POSTENU | TSU_FWSLC_POSTENL,
 				 TSU_FWSLC);	/* Enable POST registers */
--- a/drivers/net/ethernet/renesas/sh_eth.h
+++ b/drivers/net/ethernet/renesas/sh_eth.h
@@ -509,6 +509,7 @@ struct sh_eth_cpu_data {
 	unsigned rmiimode:1;	/* EtherC has RMIIMODE register */
 	unsigned rtrate:1;	/* EtherC has RTRATE register */
 	unsigned magic:1;	/* EtherC has ECMR.MPDE and ECSR.MPD */
+	unsigned dual_port:1;	/* Dual EtherC/E-DMAC */
 };
 
 struct sh_eth_private {
