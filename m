Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E13920835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084141;
	bh=WJXz7QwBC63qIOh2nr3jeWzWYay5XmibKvu1pQltJ5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eNL5zzlA/uztb3m6FVOCEa+gx9FbFAKqYqRl8TLbQYVmV2oalgOVGu0YSsGpfllwb
	 dcW/hqZPjC/C+GlmdXiAY3m5xLvfF/19uQHP/KeBtwUF8WFHwdDyc0lsd/GKQgc+s6
	 LQp9i4VWNDTV5r3b+IVhhW2TpKj93rruJ6ntjN9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394321AbfBMSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405452AbfBMSkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:40:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9DC222D6;
        Wed, 13 Feb 2019 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083242;
        bh=WJXz7QwBC63qIOh2nr3jeWzWYay5XmibKvu1pQltJ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhsLEUF8jkN4tKfmo0Wj3LwibUd9Zlilz19Nj7EC4cqFHvDBnKInO0X/y7GRnxeW3
         KQeBH+gnzzwTIM7CU5VT7XslpViMMhALAIq0VrWnOELnjxSoTeGYsbTrK/P7JGYnrB
         shAhh0iCtxxc251H5YR3osnveKVs6oBoEFnqu5bQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH 4.14 01/35] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
Date:   Wed, 13 Feb 2019 19:37:56 +0100
Message-Id: <20190213183706.249476025@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

commit d5d27fd9826b59979b184ec288e4812abac0e988 upstream.

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

Fixes: 6f2a6a52560a ("mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND startup problems")
Cc: stable@vger.kernel.org
Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -168,9 +168,10 @@ int gpmi_init(struct gpmi_nand_data *thi
 
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
 
@@ -275,13 +276,11 @@ int bch_set_geometry(struct gpmi_nand_da
 
 	/*
 	* Due to erratum #2847 of the MX23, the BCH cannot be soft reset on this
-	* chip, otherwise it will lock up. So we skip resetting BCH on the MX23.
-	* On the other hand, the MX28 needs the reset, because one case has been
-	* seen where the BCH produced ECC errors constantly after 10000
-	* consecutive reboots. The latter case has not been seen on the MX23
-	* yet, still we don't know if it could happen there as well.
+	* chip, otherwise it will lock up. So we skip resetting BCH on the MX23
+	* and MX28.
 	*/
-	ret = gpmi_reset_block(r->bch_regs, GPMI_IS_MX23(this));
+	ret = gpmi_reset_block(r->bch_regs,
+			       GPMI_IS_MX23(this) || GPMI_IS_MX28(this));
 	if (ret)
 		goto err_out;
 


