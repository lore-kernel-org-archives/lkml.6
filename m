Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F48C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E11120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgKo9pKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E11120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbeFRGZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:25:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43668 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFRGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:25:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so7632421pfm.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jiPl2EMttVFt16on49GND/kt1rQOx5pA0A0dTzzB/q0=;
        b=TgKo9pKKlV1x/qp1XcMdjdm4HqCtzEs24YIoAPlorqzMYOlkG6+8kSO/txtEQ3/ncs
         MYJxH9BicAIRU6ELkY3V7Mi9CktnaYi1IeJJ5UwmmFktReN/uD4n+1gRVAkyjSTX9ioM
         dWzXM72pQDkh7qedEwYRwOClmJaPMo7JcuwIxZldn040ZcVqr5o4TeHXs1mWVmpg7ig4
         Z7EMZkWGpgSDpXBw9QebO8BVEY52lqFe4IuJjp2TXlN010diPOvNk2rUCD6ttT3ELKKP
         LnhTHMqrrNZEIGhVGO60zjHM+QkMsGutA2L+C7j2n4GLCiS9oCJuh85Uxd4wzME2Zcyx
         izjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jiPl2EMttVFt16on49GND/kt1rQOx5pA0A0dTzzB/q0=;
        b=o5X5V/w32V6efH4oPfIpZfHEpQJ21+L2HM3lMo/UAudIgyHIMmbDDt8k/OPypVX5ka
         yD2fTcdTNv9wSmLFueKsNnIFUXpb4j4KznNUEDrT8iXCipW9nHKZWByJVg5DGM+xvWWj
         GUdPwKWBcEXeyrjARB+oc8xS5KO/gFWJvjQZGP/HmNwNnkhnFAaV1LWRwGvBhsTtXUlZ
         +FjC4lPIJ8TO554sFsO69Tg/LEn/7p/8HuoTUz+cLecdYZLa6asYcwgH3l98wj+4qN2L
         ixT0cJCUNuBD2rkOvDwC8+JmcKbdZ89AabYG+AEyeyT/rJkVXOnvLFnxmB2MZWA4w3nY
         e1Vg==
X-Gm-Message-State: APt69E06T5qI1mheY6cXaz+x4H6MAgszkpX/hAI9ty6NWa73s6ibo0vF
        s3ez7auVWqlxZpkY115XlFBqeu0DyRk=
X-Google-Smtp-Source: ADUXVKLUZVnSIiyPNH8bxgCu2DxM/ntN/w+0lUPxvIpBRwUzDCJpbQwdXUraRW84DGXoWLWZ4KjH5Q==
X-Received: by 2002:a65:538e:: with SMTP id x14-v6mr9822042pgq.330.1529303152518;
        Sun, 17 Jun 2018 23:25:52 -0700 (PDT)
Received: from localhost.localdomain ([106.208.157.247])
        by smtp.gmail.com with ESMTPSA id k9-v6sm23896776pgs.49.2018.06.17.23.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 23:25:52 -0700 (PDT)
From:   Janani Sankara Babu <jananis37@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 2/3] Staging:rtl8192e Fix Comparison to true is error prone
Date:   Mon, 18 Jun 2018 12:05:29 -0400
Message-Id: <1529337929-8947-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the comaprison to bool value in the code

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index ccd898a..c6de34a 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -365,7 +365,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pAdmittedBA = &pTS->TxAdmittedBARecord;


-	if (pAdmittedBA->bValid == true) {
+	if (pAdmittedBA->bValid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
 		return -1;
@@ -485,7 +485,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 {
 	struct ba_record *pBA = &pTS->TxPendingBARecord;

-	if (pBA->bValid == true && bOverwritePending == false)
+	if (pBA->bValid && !bOverwritePending)
 		return;

 	DeActivateBAEntry(ieee, pBA);
--
1.9.1
