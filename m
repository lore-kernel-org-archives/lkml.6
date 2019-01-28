Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85979C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE72173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="SD6rvHJl";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bkWcJZQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfA1QEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:38 -0500
Received: from node.akkea.ca ([192.155.83.177]:48224 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbfA1QEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 575A44E204E;
        Mon, 28 Jan 2019 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548691475; bh=TGsglsMNcGnDF0d6jP9ubSnPlqZvcEUC+9FikYH4jUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SD6rvHJlxbIX2sCljMuCyf8Pxc+ujjp7LxEilruAEKxYydmgWPI/Ci0VzFeVvIhxQ
         q5aVcBFZ+dFPkfq6k88Nt4zUQvaDgIp88jK1vutGAnZEBStS9u1iUCBA0qfzmRo094
         Hm4wzWYUfM3tMy30O/OWhByBh1LMPZOskKdcHu4o=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jPD-lxCjPMSW; Mon, 28 Jan 2019 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 5F6A24E204B;
        Mon, 28 Jan 2019 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548691474; bh=TGsglsMNcGnDF0d6jP9ubSnPlqZvcEUC+9FikYH4jUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bkWcJZQ8zSXj8knE7N+aNTwqeU+YZ/PPEMvd26z+FIM9tDsi827PlbXEfBZvtklh3
         5vWEO+qE7PtwpkhhHXTYj/ioH1s7HjzS1+r7F3OHPvONRxuRv2N18AsBeMjCY9SNmQ
         Zkb3QKlSXMvMoytDC91NOYfTo0oF7yri18yYlK9s=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v6 0/3] dmaengine: imx-sdma: add the sdma engine to the imx8mq
Date:   Mon, 28 Jan 2019 09:03:20 -0700
Message-Id: <20190128160323.28170-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdma support for the imx8mq

Changes since V5

Dropped device tree bindings.
Added reviewed by tags.

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


Angus Ainslie (Purism) (3):
  dmaengine: imx-sdma: add clock ratio 1:1 check
  dmaengine: imx-sdma: add a test for imx8mq multi sdma devices
  dmaengine: imx-sdma: fix consistent dma test failures

 drivers/dma/imx-sdma.c                | 25 +++++++++++++++++++++----
 include/linux/platform_data/dma-imx.h |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.17.1

