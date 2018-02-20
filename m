Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBTIVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:21:02 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:39003 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750820AbeBTIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:21:01 -0500
X-CTCH-RefID: str=0001.0A0B0203.5A8BD925.01EE:SCFSTAT16437741,ss=1,re=-4.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: [PATCH] mtd: nand: gpmi: fix edo mode for non fully ONFI compliant
 flashes
To: Han Xu <han.xu@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Message-ID: <2e12a84b-b4cb-f0ff-f3c9-173def6b5bd2@ginzinger.com>
Date: Tue, 20 Feb 2018 09:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.1.106]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-ORIGINAL-SUBJECT: [PATCH] mtd: nand: gpmi: fix edo mode for non
 fully ONFI compliant flashes[NOSIG][NODISC]
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In enable_edo_mode the timing mode feature is set according to previously
read capabilities of the parameter page ("Timing mode support"). After
the value was set, it is read back to provide a "double-check".
If the "double check" fails, the whole function returns with an error,
which leads to a very slow (non-edo) fallback timing.

The problem here is, that there seem to be some NAND flashes, which are
not fully ONFI 1.0 compliant.
One of these is Winbond W29N04GV. According to datasheet and parameter
page, the flash supports timing mode 4 (edo), but the timing mode feature
is simply missing.

It seems that setting a non-existing feature is simply ignored. The real
problem occurs, when the feature is read back: W29N04GV always delivers
zero, which causes the "double-check" to fail. This leads to very slow
timing and therefore to poor performance.

To solve this, we simply remove the double-check, which is a paranoia
check anyways.

The modification was intensively tested on i.MX6 with linux-4.1, Winbond
W29N04GV and Micron MT29F4G08ABADAH4.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
index 97787246af41..40fba96df215 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
@@ -939,16 +939,9 @@ static int enable_edo_mode(struct gpmi_nand_data *this, int mode)
 	if (ret)
 		goto err_out;
 
-	/* [2] send GET FEATURE command to double-check the timing mode */
-	memset(feature, 0, ONFI_SUBFEATURE_PARAM_LEN);
-	ret = nand->onfi_get_features(mtd, nand,
-				ONFI_FEATURE_ADDR_TIMING_MODE, feature);
-	if (ret || feature[0] != mode)
-		goto err_out;
-
 	nand->select_chip(mtd, -1);
 
-	/* [3] set the main IO clock, 100MHz for mode 5, 80MHz for mode 4. */
+	/* [2] set the main IO clock, 100MHz for mode 5, 80MHz for mode 4. */
 	rate = (mode == 5) ? 100000000 : 80000000;
 	clk_set_rate(r->clock[0], rate);
 
-- 
2.11.0
