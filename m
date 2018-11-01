Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F182CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CF92064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skfPbAwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CF92064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeKBAwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:52:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34974 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeKBAwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:52:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id z2-v6so6950297pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+nzSpjhirIgOnM9aiQS4IAW1CiSfyP/BJdXa6N8+gSY=;
        b=skfPbAwGkj6WemK+aY/Lzoc48eoqGqOURcxmh1AfPm32P50Feml9GZoI9nTCLrFf/Q
         pwIpGndL1Ln06tmA0bOZrRGSzyOgbBfjvnXNUpdzkaGWpcOL3u8ZoKLWBCJFpr1R54Dy
         zNL+RfCBJ4MxjGsQx4aHyKE+tFCUp+/452zVkkATuUO2Ay61F8CUhWNDITERbFUDgtPm
         hIpexBz634XZmgjOieDtDXeK5YbDid9WZ90yjXthtkkcI96W04nwzioVNDVoZFTpajH7
         Q1AL0KPH+F26U/YFVAYGrIjDDjnqQIWFqneQZC3Iej/BfYtwx0Z3QH88HQtps2WvD7cP
         f+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+nzSpjhirIgOnM9aiQS4IAW1CiSfyP/BJdXa6N8+gSY=;
        b=Fsb9Afs+k2ntKS9tlSqjyFVXG9rgFtr/rvcyTZJCaJjqohkq0Q07rR9jfGINA3O7m/
         H06REJB5d41h7QeR0V5BYrIylOvRmtKZSf/PHmyO/iaeVoIUxhT4UBkIllcY7o0O4B8s
         nCd2JYajHqoLbFE0OK/72SgOWKiOxP0hzDBlyUT/8bQfATOMEKp9x96/BkiiSrk5f/Zo
         2Z41TuYsE01yQIZwOl6MxIKHDtC6f+jmeHl8ZU70NHd5GsmtjSd+TwVUB1exnxXtw5Fv
         hHeldaLSfonUU310Bdhom22ATlp9kSv6VcKCmv8fK16O44LU2CoK4yTzLrKJ2q+bIc0p
         dJWg==
X-Gm-Message-State: AGRZ1gKq8HJSXOG0P+amMwNATlB/4v2PWBHaF9QhIfUDWAHUgVETI9Qe
        B5xmbWvvGgPITFC2IbqYW7Q=
X-Google-Smtp-Source: AJdET5ee1TRUFQTr8TTpx/YMNifjZ03QcobuGF2soTju4XC/LZ5zPNHi1brTOrIZlNdKlGwRzkx2mg==
X-Received: by 2002:a63:2214:: with SMTP id i20mr1358719pgi.83.1541087322324;
        Thu, 01 Nov 2018 08:48:42 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t11-v6sm35301688pgn.38.2018.11.01.08.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:48:41 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, natechancellor@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] staging: fix some typo
Date:   Thu,  1 Nov 2018 11:48:38 -0400
Message-Id: <20181101154838.23220-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_cmd.h       | 2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 24da2ccea04f..37960b04beee 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -434,7 +434,7 @@ struct getrfintfs_parm {
  *
  *	mac[0] == 0
  *	==> CMD mode, return H2C_SUCCESS.
- *	The following condition must be ture under CMD mode
+ *	The following condition must be true under CMD mode
  *		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
  *		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
  *		s2 == (b1 << 8 | b0);
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 1530d0ea1d51..7dc5bf050839 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -543,7 +543,7 @@ struct Tx_Beacon_param
 
 	mac[0] == 0
 	==> CMD mode, return H2C_SUCCESS.
-	The following condition must be ture under CMD mode
+	The following condition must be true under CMD mode
 		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
 		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
 		s2 == (b1 << 8 | b0);
-- 
2.17.0

