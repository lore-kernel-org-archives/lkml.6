Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hq56IvN0GFsjKQAAmS7hNA
	; Thu, 07 Jun 2018 00:06:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3F1666089E; Thu,  7 Jun 2018 00:06:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 594E860290;
	Thu,  7 Jun 2018 00:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 594E860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeFGAGE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 20:06:04 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32280 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752257AbeFGAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 20:06:03 -0400
X-IronPort-AV: E=Sophos;i="5.49,485,1520895600";
   d="scan'208";a="330684581"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 07 Jun 2018 02:06:01 +0200
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hdegoede@redhat.com
Cc: kernel-janitors@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: drop test
Date: Thu,  7 Jun 2018 01:34:02 +0200
Message-Id: <1528328042-6461-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test selects between two identical values, so it doesn't look useful.
It turns out that the tested expression can only be true anyway, so drop
the test, the corresponding parameter, and the corresponding argument at
the only call site.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
@@

* e ? e1 : e1
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 2ee25b2..53d3bdf 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1352,7 +1352,6 @@ static void _PHY_ReloadMACRegisters8723B(
 static void _PHY_PathADDAOn8723B(
 	struct adapter *padapter,
 	u32 *ADDAReg,
-	bool isPathAOn,
 	bool is2T
 )
 {
@@ -1363,7 +1362,7 @@ static void _PHY_PathADDAOn8723B(
 
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("ADDA ON.\n"));
 
-	pathOn = isPathAOn ? 0x01c00014 : 0x01c00014;
+	pathOn = 0x01c00014;
 	if (false == is2T) {
 		pathOn = 0x01c00014;
 		PHY_SetBBReg(pDM_Odm->Adapter, ADDAReg[0], bMaskDWord, 0x01c00014);
@@ -1556,7 +1555,7 @@ static void phy_IQCalibrate_8723B(
 	}
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2T ? "2T2R" : "1T1R"), t));
 
-	_PHY_PathADDAOn8723B(padapter, ADDA_REG, true, is2T);
+	_PHY_PathADDAOn8723B(padapter, ADDA_REG, is2T);
 
 /* no serial mode */
 
