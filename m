Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47C1C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B45E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Og+PCila"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B45E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOOYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:24:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39336 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeJOOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:24:17 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9F6eLhY039260;
        Mon, 15 Oct 2018 01:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539585621;
        bh=8llY6uAKGX26O+gGuPEvyf9xBVyohB5/wn6OHWmeK7Y=;
        h=From:To:CC:Subject:Date;
        b=Og+PCilaZbjkFy86qU8oG432myv3h2fHae4Q8y3JA1rT0vfS8wXxyGpnw5ESFcTIz
         0pCUB4xYN4ZtSNNDRnzX3sYoUPq9kxK6c2NzRM7jl4W8bZZCm2ipe7XK1d2WC9WUyj
         qHopryviHbJDoHimQ1G3CGdfNE7sdQ4xtZpILT14=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F6eLKh005680;
        Mon, 15 Oct 2018 01:40:21 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 01:40:21 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 01:40:21 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F6eH4N023129;
        Mon, 15 Oct 2018 01:40:19 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/3] omap2-mcspi: Add slave mode support
Date:   Mon, 15 Oct 2018 12:08:26 +0530
Message-ID: <20181015063829.26978-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add slave mode support for TI's McSPI controller.

Slave mode tested on Beagle Bone Black with SPI0 in master mode
connected to SPI1 in slave mode. Tested with slave-time,
slave-system-control and spidev as slave clients.

Master mode tested on AM335x ICEv2 with a SPI flash for regression.

Vignesh R (3):
  spi: omap2-mcspi: Switch to readl_poll_timeout()
  spi: omap2-mcspi: Set FIFO DMA trigger level to word length
  spi: omap2-mcspi: Add slave mode support

 drivers/spi/spi-omap2-mcspi.c | 177 +++++++++++++++++++++++++---------
 1 file changed, 131 insertions(+), 46 deletions(-)

-- 
2.19.1

