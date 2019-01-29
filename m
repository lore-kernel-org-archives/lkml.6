Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DBEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CCA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="PFJf6mm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfA2PhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:37:18 -0500
Received: from mout01.posteo.de ([185.67.36.65]:41667 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfA2PhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:37:18 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 94569160064
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 16:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548776233; bh=QjXLibLmjk+oqmf8FmsAQxfwBGSD24Lymh6zHDlUTI0=;
        h=From:To:Cc:Subject:Date:From;
        b=PFJf6mm0q8nlh4WxOYIQzLS95Tp/F6XdpPeeEINIOGL/YWY6WF5fbVvajUapheB1W
         h/HYIRlsfFnDzQgTPMdcKkNgXsSb10K96AmzEC0g6/O5KV3qXsWCfPGQLBV1yMDOuc
         B3Xzmt9WAkOc05GsxHISz1ENEdSQJ/SFLTC8kliWO+91E99wDl2xKF/if8mpdoCwid
         q/QqMJXNBvMpblu3sr9jNSzUblED5S+az8tn6efyKT/jNuzVvgqhsKiyeE7kcCMwTk
         7WuOiuO4IgmNrLzTEuqJbrAGervIkIjZgisFREK+rUii+LCM/6ULSU5spTb/ydzZ5/
         PCVf9lT5s7Z8g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43prGJ191Vz6tmR;
        Tue, 29 Jan 2019 16:37:12 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     han.xu@nxp.com, bbrezillon@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: [PATCH] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
Date:   Tue, 29 Jan 2019 16:37:00 +0100
Message-Id: <20190129153700.18717-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Disable BCH soft reset according to MX23 erratum #2847 ("BCH soft
reset may cause bus master lock up") for MX28 too. It has the same
problem.

Observed problem: once per 100,000+ MX28 reboots NAND read failed on
DMA timeout errors:
[    1.770823] UBI: attaching mtd3 to ubi0
[    2.768088] gpmi_nand: DMA timeout, last DMA :1
[    3.958087] gpmi_nand: BCH timeout, last DMA :1
[    4.156033] gpmi_nand: Error in ECC-based read: -110
[    4.161136] UBI warning: ubi_io_read: error -110 while reading 64
bytes from PEB 0:0, read only 0 bytes, retry
[    4.171283] step 1 error
[    4.173846] gpmi_nand: Chip: 0, Error -1

Without BCH soft reset we successfully executed 1,000,000 MX28 reboots.

I have a quote from NXP regarding this problem, from July 18th 2016:

"As the i.MX23 and i.MX28 are of the same generation, they share many
characteristics. Unfortunately, also the erratas may be shared.
In case of the documented erratas and the workarounds, you can also
apply the workaround solution of one device on the other one. This have
been reported, but I’m afraid that there are not an estimated date for
updating the Errata documents.
Please accept our apologies for any inconveniences this may cause."

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

This is something we have in our tree for years and is running on
production systems and I hope that this helps others too.

thanks
                              martin



 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
index bd4cfac6b5aa..a4768df5083f 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
@@ -155,9 +155,10 @@ int gpmi_init(struct gpmi_nand_data *this)
 
 	/*
 	 * Reset BCH here, too. We got failures otherwise :(
-	 * See later BCH reset for explanation of MX23 handling
+	 * See later BCH reset for explanation of MX23 and MX28 handling
 	 */
-	ret = gpmi_reset_block(r->bch_regs, GPMI_IS_MX23(this));
+	ret = gpmi_reset_block(r->bch_regs,
+			       GPMI_IS_MX23(this) || GPMI_IS_MX28(this));
 	if (ret)
 		goto err_out;
 
@@ -263,12 +264,10 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	/*
 	* Due to erratum #2847 of the MX23, the BCH cannot be soft reset on this
 	* chip, otherwise it will lock up. So we skip resetting BCH on the MX23.
-	* On the other hand, the MX28 needs the reset, because one case has been
-	* seen where the BCH produced ECC errors constantly after 10000
-	* consecutive reboots. The latter case has not been seen on the MX23
-	* yet, still we don't know if it could happen there as well.
+	* and MX28.
 	*/
-	ret = gpmi_reset_block(r->bch_regs, GPMI_IS_MX23(this));
+	ret = gpmi_reset_block(r->bch_regs,
+			       GPMI_IS_MX23(this) || GPMI_IS_MX28(this));
 	if (ret)
 		goto err_out;
 
-- 
2.20.1

