Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609F62184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="os/uGqYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfBZQNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:13:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54004 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfBZQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:12:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QGCuk8096065;
        Tue, 26 Feb 2019 10:12:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551197576;
        bh=v+4AFURw0oGtLn2+wC2ypAYKd3q4aLPGI+CmtIxM3vQ=;
        h=From:To:CC:Subject:Date;
        b=os/uGqYR+n7b9JGzUMEAv7RD+L1kdTvUkj/SmiqJeO1sGQ3MCKNB8utaI8dx9Se9R
         dx/X62DzGTKkM5FbUoOUT2Uxob5plHUrfb4yOqKqYKEQ4Mh9ZfpKPCNXQIjHbEfKXw
         PbgHSBFCN34nEREQ9KOId7uQPruqo2TDTHmBHBLU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QGCu5c059596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 10:12:56 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 10:12:55 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 10:12:55 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QGCrY6024164;
        Tue, 26 Feb 2019 10:12:53 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Fixes for command errors during tuning
Date:   Tue, 26 Feb 2019 21:46:04 +0530
Message-ID: <20190226161606.18569-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix the following error message in dra7xx boards:

[4.833198] mmc1: Got data interrupt 0x00000002 even though no data
operation was in progress.

Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
dra7xx-evm.

Faiz Abbas (2):
  mmc: sdhci: Add platform_cmd_err() to sdhci_ops
  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/sdhci-omap.c | 24 +++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 37 ++++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h      |  4 ++++
 3 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.19.2

