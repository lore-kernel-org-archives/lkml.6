Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AF120855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543846;
	bh=LzuLOL//eRySN5GTQahMf/2sUKHjGyp24eX8rsQsZzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eNpWsPfAOUqyzMUApuPhu95iniE/vQfOiYi4J3b7kZdPJc3s0cAdheVL2pEkHOYCo
	 BcBWKB/w8IpNngR6VhH+MWeJ6sqUok70cb4MlO7bDMuH2KBHoTkUcMqoRBN7/AXOIv
	 I5D03BXlf9yWyToS4eROP/xSXIkIaJ0PbKj+r8m0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AF120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeLKP5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbeLKP5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEBFF20855;
        Tue, 11 Dec 2018 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543842;
        bh=LzuLOL//eRySN5GTQahMf/2sUKHjGyp24eX8rsQsZzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIK+kWVWTPtd6H/oC7jg5Kn2oCY7TshjTpKuxBQIgcq5tOAL/iWYoxJqcq+kD+6lW
         HrzvK5bg1HFSDhNstv61akvt29MrTmsmdqUcjBq+VOgbcwO9AIaaYE7WkSkghP8vUZ
         oIxDdekzoK01+lUQJ66l6ny4gNNWx9vTmotls7vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 086/118] dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations
Date:   Tue, 11 Dec 2018 16:41:45 +0100
Message-Id: <20181211151647.742040024@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

commit 64068853bc77786d1a28abb4087d6a3e93aedbe2 upstream.

DMA buffer descriptors aren't allocated from atomic context, so they
can use the less heavyweigth GFP_NOWAIT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1214,7 +1214,7 @@ static int sdma_alloc_bd(struct sdma_des
 	int ret = 0;
 
 	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
-					GFP_ATOMIC);
+					GFP_NOWAIT);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;


