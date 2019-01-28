Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFDAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251EB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wz9K7qR+";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wz9K7qR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1GIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:08:49 -0500
Received: from node.akkea.ca ([192.155.83.177]:59348 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfA1GIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:08:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id AC8324E2050;
        Mon, 28 Jan 2019 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655728; bh=m/0KSjSZb3yLWcTUdFGpt7bIw5sNECnqq18GM4Q9qRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wz9K7qR+fWUI4BqktUQSpxdvH8w5Ig1Cr0sk8cWhfx6r0PInWGQBqfxRi/8xc+qjC
         RdtEDmddCP3osmX9nL9e7+ySN3tbrjJwQv9nYPY8gYqxnbuC4KrtURYMs3kDgup4xd
         r2hjQgL3WlrbT8PXZONzB1rSIsPdm/r8SrsA165o=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZRdwEI2rSNAm; Mon, 28 Jan 2019 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id A549D4E204B;
        Mon, 28 Jan 2019 06:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655728; bh=m/0KSjSZb3yLWcTUdFGpt7bIw5sNECnqq18GM4Q9qRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wz9K7qR+fWUI4BqktUQSpxdvH8w5Ig1Cr0sk8cWhfx6r0PInWGQBqfxRi/8xc+qjC
         RdtEDmddCP3osmX9nL9e7+ySN3tbrjJwQv9nYPY8gYqxnbuC4KrtURYMs3kDgup4xd
         r2hjQgL3WlrbT8PXZONzB1rSIsPdm/r8SrsA165o=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v5 0/5] dmaengine: imx-sdma: add the sdma engine to the imx8mq
Date:   Sun, 27 Jan 2019 23:08:35 -0700
Message-Id: <20190128060840.31695-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdma support for the imx8mq

Changes since V4

Builds against 5.0-rc4.
Dropped device tree additions, will send a separate patch.
Fixed sdma1 alignement.
Dropped phandles in favour of of_nodes.
Refactored SDMA_H_CONFIG register fix.

Changes since V3

Builds against 5.0-rc3.
Dropped sdma device index matching in favour of phandles.
Corrected subsytem name to dmaengine
Devicetree fixes.
Fixed SDMA_H_CONFIG register bug.

Changes since V2

Dropped device tree bindings and added clock ratio check.
Fixed bug where incorrect sdma device was selected.
Added new compatible string for "fsl,imx8mq-sdma"

Changes since V1

Fixed to build against v5.0-rc2

Angus Ainslie (Purism) (5):
  dmaengine: imx-sdma: add clock ratio 1:1 check
  dmaengine: imx-sdma: add imx8mq sdma compatible parts
  dt-bindings: dma: fsl-imx-sdma: add fsl,imx8mq to the accepted
    compatible node
  dmaengine: imx-sdma: add a test for imx8mq multi sdma devices
  dmaengine: imx-sdma: fix consistent dma test failures

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 drivers/dma/imx-sdma.c                        | 29 ++++++++++++++++---
 include/linux/platform_data/dma-imx.h         |  1 +
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.17.1

