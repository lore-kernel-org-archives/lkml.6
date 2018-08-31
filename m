Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7041FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289DD20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xsL5jW22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289DD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeHaSjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:39:22 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:52188 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeHaSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:39:21 -0400
X-Greylist: delayed 24953 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2018 14:39:20 EDT
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w7VEUp9h030172;
        Fri, 31 Aug 2018 23:30:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w7VEUp9h030172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535725852;
        bh=jBo3wS4BA/zEKJYcB1wVpZfBl26y6JDoM9tDdtPZ9Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsL5jW22IxiUCteSf958nAur4ohTscf/fPVZQ7tws28ndKz/2aIgonD0lqzBV31Rm
         ok3u2z9KUVvd3l3iwIdesBXZseMkxkeJuk80rIZfzkOmt93idua8pr8/SZHWpyrF4U
         ZWx3fI2wnZ7D9ScHdcssudxoijyFIjsCdUfiIFLdsHKShyhkags+CdxowCFjRD4FX5
         UH+KKFOgAOLW0yGxoAU9fF5gk/dbh1C+mBoMdHbU55C/AxlJ43Bxb54QsVdFIJcK0p
         RPQRXJeRu8I5UGLnGNMC5kzMNKMs8GxhYgbvod16EbKdo9J2/81PACdnqy7suU+KbE
         zcoDo4StxgVjw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP
Date:   Fri, 31 Aug 2018 23:30:48 +0900
Message-Id: <1535725848-4076-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 9918bdd..a403e85 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -401,11 +401,8 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapter *adap,
 		return ret;
 
 	for (msg = msgs; msg < emsg; msg++) {
-		/* If next message is read, skip the stop condition */
-		bool stop = !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
-		/* but, force it if I2C_M_STOP is set */
-		if (msg->flags & I2C_M_STOP)
-			stop = true;
+		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
+		bool stop = (msg + 1 == emsg) || (msg->flags & I2C_M_STOP);
 
 		ret = uniphier_fi2c_master_xfer_one(adap, msg, stop);
 		if (ret)
-- 
2.7.4

