Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C22C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885E52087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543186;
	bh=jM1ZnS6O/x00Y+CTfJujThYY02CVMuhWjH+s5A3xR/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNhPVm/akqkzqrGxgjhagxpx4djzMbmeGQGjmGCja7UMJ6RReOiVYx8GdIPtqSIxQ
	 VMspIqgJlaHFfHWSHelf9o6jZ9Qv9bk8woDBugnDEjLWlEVFoY8+3xBV2R6hL1i16W
	 //2dj9LD+s88shTA08IG5MgD9Qf1AbYyHksqWooE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885E52087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeLKPqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbeLKPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A631C20870;
        Tue, 11 Dec 2018 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543181;
        bh=jM1ZnS6O/x00Y+CTfJujThYY02CVMuhWjH+s5A3xR/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtpakc/jpGRgBjURp89z2XVamY98DB/oWFhRdm1BLsvWRet1T+DQ7obn/ct0tKfkZ
         l3KfqL2nad+PO0ofLOwsUMHQX71RbGCLyKqe5HNz28kVFn2M0tLPJrZcKMksTYozSe
         +ZENHZfiZRHJHnSQYbcK1TWXjv50ryCo0U1ORXYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.4 16/91] dmaengine: at_hdmac: fix module unloading
Date:   Tue, 11 Dec 2018 16:40:35 +0100
Message-Id: <20181211151607.203912382@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Genoud <richard.genoud@gmail.com>

commit 77e75fda94d2ebb86aa9d35fb1860f6395bf95de upstream.

of_dma_controller_free() was not called on module onloading.
This lead to a soft lockup:
watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Modules linked in: at_hdmac [last unloaded: at_hdmac]
when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().

Cc: stable@vger.kernel.org
Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/at_hdmac.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2152,6 +2152,8 @@ static int at_dma_remove(struct platform
 	struct resource		*io;
 
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->memset_pool);


