Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C182154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSdqpVKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C182154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbeHBTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:10:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51667 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeHBTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:10:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so3395177wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4wbxk/n9WK646OOk+xWHw+425xgHexLf0Sb56gT10k=;
        b=pSdqpVKMEdeiCDCDbR3vzJfDUazFqGAdXsHVJtoH2f18WcVucjHGfxArJcVdhDVe+d
         2Jxe9nNyRKHoqZlb1a69vZhruNK+KfpCjeoNlHP2teKtOPj/AZay2zQD0gvUVz8NUrPf
         D1Pktfo+bKILNohX1A3SH7124zRuj43xsoDTBN3G2UYpXsR/gJYVJMLD3CEvhmousJEA
         mYF9oLI1OtRI4Q56pfZGiEvw/l1ARkWTeGrcDL+Q2CtLIVCNWnf3Wuhvege0kvvsGA13
         28laA6yYd0opd6PtLtok1XEylu1MNN5y6zb8FqAt/H1NhCqr4hXkDk7oN7ezZNZhl2c4
         k/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4wbxk/n9WK646OOk+xWHw+425xgHexLf0Sb56gT10k=;
        b=l2/NSWFa3ov2GtTI61Nd5350kN4nqVUQwDSwMtGSXxp1b97+MEmg5PVZXvTyU9LbeI
         ZV3h7St6xxKF5liNRSVqzQseZCsWTzuRZdmqV6x1bPgp5AGrjsLhfxThkxIH06q1wPdH
         DssXkmih97H+453AIrLrLSAKQhk33bhkZrC305YUnsQq25xAqkNFaN0tKriitWeveTSk
         gUYQbtniQc3r0EB1Gu/IzmFd4XVntWNOdi/lrv++qHrOM2MMsvuiLAB/iGdLqCE4Eyz7
         ypunSvLyw1oeO9p1Hz9hMiNrVHc+nF+SycBQGHpXhssq1Bw7RQWcpfVRzp/A8Jnp3Onf
         7JMA==
X-Gm-Message-State: AOUpUlHxUIlx7gurqRwCzA2P+9PUxChazPPSRp4Sme6bOF2YI+hNzWfX
        SSCnDFztnaFztCXdQX/bIzE=
X-Google-Smtp-Source: AAOMgpfUVW+Vone7AW2wvHeqGz8cRr5yAOPu8b0czD07PYTE+492hmiQZAfnq7NwFV9Hwiowx5CJNw==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr2454825wma.4.1533230325949;
        Thu, 02 Aug 2018 10:18:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3205081wrn.34.2018.08.02.10.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:18:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8188eu: cleanup block comment - style
Date:   Thu,  2 Aug 2018 19:18:20 +0200
Message-Id: <20180802171823.1571-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802171823.1571-1-straube.linux@gmail.com>
References: <20180802171823.1571-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup a block comment to conform with kernel coding style.
Also cleans 'line over 80 characters' checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 82fc5075e0a6..6925ec48dff1 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -43,9 +43,11 @@ static void rtl8188eu_cal_txdesc_chksum(struct tx_desc	*ptxdesc)
 	ptxdesc->txdw7 |= cpu_to_le32(0x0000ffff & checksum);
 }
 
-/*  Description: In normal chip, we should send some packet to Hw which will be used by Fw */
-/*			in FW LPS mode. The function is to fill the Tx descriptor of this packets, then */
-/*			Fw can tell Hw to send these packet derectly. */
+/*
+ * In normal chip, we should send some packet to Hw which will be used by Fw
+ * in FW LPS mode. The function is to fill the Tx descriptor of this packets,
+ * then Fw can tell Hw to send these packet derectly.
+ */
 void rtl8188e_fill_fake_txdesc(struct adapter *adapt, u8 *desc, u32 BufferLen, u8  ispspoll, u8  is_btqosnull)
 {
 	struct tx_desc *ptxdesc;
-- 
2.18.0

