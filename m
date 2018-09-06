Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_SUBJ_BRKN_WORDNUMS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58585C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB8020652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB8020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeIFRH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:07:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47822 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbeIFRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:07:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxtSB-0007hI-NS; Thu, 06 Sep 2018 12:32:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: check for i out of range before accessing szLine[i]
Date:   Thu,  6 Sep 2018 13:32:07 +0100
Message-Id: <20180906123207.20164-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently szLine[i] is being accessed before the index i is being
ranged checked.  Fix this by checking the range first.  Also, evaluate
the length of the string szLine just once rather than multiple times and
move the loop variable i to an inner scope and make it an int.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 0d2c61b67d0e..0833cce43dd3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -2919,7 +2919,6 @@ int PHY_ConfigRFWithTxPwrTrackParaFile(struct adapter *Adapter, char *pFileName)
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 	int	rlen = 0, rtStatus = _FAIL;
 	char *szLine, *ptmp;
-	u32 i = 0;
 
 	if (!(Adapter->registrypriv.load_phy_file & LOAD_RF_TXPWR_TRACK_PARA_FILE))
 		return rtStatus;
@@ -2958,8 +2957,10 @@ int PHY_ConfigRFWithTxPwrTrackParaFile(struct adapter *Adapter, char *pFileName)
 				char band[5] = "", path[5] = "", sign[5] = "";
 				char chnl[5] = "", rate[10] = "";
 				char data[300] = ""; /*  100 is too small */
+				const int len = strlen(szLine);
+				int i;
 
-				if (strlen(szLine) < 10 || szLine[0] != '[')
+				if (len < 10 || szLine[0] != '[')
 					continue;
 
 				strncpy(band, szLine+1, 2);
@@ -2973,7 +2974,7 @@ int PHY_ConfigRFWithTxPwrTrackParaFile(struct adapter *Adapter, char *pFileName)
 				if (!ParseQualifiedString(szLine, &i, chnl, '[', ']')) {
 					/* DBG_871X("Fail to parse channel group!\n"); */
 				}
-				while (szLine[i] != '{' && i < strlen(szLine))
+				while (i < len && szLine[i] != '{')
 					i++;
 				if (!ParseQualifiedString(szLine, &i, data, '{', '}')) {
 					/* DBG_871X("Fail to parse data!\n"); */
-- 
2.17.1

