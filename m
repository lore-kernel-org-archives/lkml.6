Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79275C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349942083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349942083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeHAUNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:13:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404171AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 05DCD1209;
        Wed,  1 Aug 2018 17:08:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 252/336] ASoC: fsl_ssi: Use u32 variable type when using regmap_read()
Date:   Wed,  1 Aug 2018 18:49:47 +0200
Message-Id: <20180801165038.697310505@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 671f8204b12fae98dcc6fc5a5703a5c62cbea187 ]

Convert the sisr and sisr2 variable types to u32 to avoid the following
sparse warnings:

sound/soc/fsl/fsl_ssi.c:391:42: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_ssi.c:391:42:    expected unsigned int *val
sound/soc/fsl/fsl_ssi.c:391:42:    got restricted __be32 *<noident>
sound/soc/fsl/fsl_ssi.c:393:17: warning: restricted __be32 degrades to integer
sound/soc/fsl/fsl_ssi.c:393:15: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_ssi.c:393:15:    expected restricted __be32 [usertype] sisr2
sound/soc/fsl/fsl_ssi.c:393:15:    got unsigned int
sound/soc/fsl/fsl_ssi.c:396:50: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_ssi.c:396:50:    expected unsigned int [unsigned] val
sound/soc/fsl/fsl_ssi.c:396:50:    got restricted __be32 [usertype] sisr2
sound/soc/fsl/fsl_ssi.c:398:42: warning: incorrect type in argument 2 (different base types)
sound/soc/fsl/fsl_ssi.c:398:42:    expected unsigned int [unsigned] [usertype] sisr
sound/soc/fsl/fsl_ssi.c:398:42:    got restricted __be32 [addressable] [usertype] sisr

In other places where regmap_read() is used a u32 variable is passed
to store the register read value, so do the same here as well.

regmap API already takes care of endianness, so the usage of u32 is safe.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_ssi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -385,8 +385,7 @@ static irqreturn_t fsl_ssi_isr(int irq,
 {
 	struct fsl_ssi *ssi = dev_id;
 	struct regmap *regs = ssi->regs;
-	__be32 sisr;
-	__be32 sisr2;
+	u32 sisr, sisr2;
 
 	regmap_read(regs, REG_SSI_SISR, &sisr);
 


