Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D08C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA820844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761941;
	bh=Z9Ld+ntMBv1HVcn5BkUYuCVLOzm8c9Bmuisbare3BTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MUc/TTWMuG73CIZCRyLKVcwNvcMe7VeVq9m3db2YGm9NhB0MhRwr1JZXGYS8u8ApB
	 a53VGMvx8FOe7s7TMk00NDtlpthjJSOEhG7c0iNZ0we6zYWyCbbZuWhZF7hknN1rht
	 2Ypy0/l5sDpxxujZHtwKUTiB0KbjDurNgEqdXYAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfA2Li7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfA2Liy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39BB320857;
        Tue, 29 Jan 2019 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761933;
        bh=Z9Ld+ntMBv1HVcn5BkUYuCVLOzm8c9Bmuisbare3BTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LPtT9fHZOSV175JiwThg+Y/3r+jT1Sx3nhp/Jok6iidR4/xdsxy1ghefPndQInln
         HwpcQTKHJoayPO+Tnq967+vHcCGDTAEe3BscId+M3TkilweJhTDLFaSXoacDeOxpwn
         pf/9EZDl8n8Q3KvC4OrGupxDPB0LS87yAAwCFQMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 051/117] mmc: sdhci-iproc: handle mmc_of_parse() errors during probe
Date:   Tue, 29 Jan 2019 12:35:02 +0100
Message-Id: <20190129113210.170304135@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

commit 2bd44dadd5bfb4135162322fd0b45a174d4ad5bf upstream.

We need to handle mmc_of_parse() errors during probe.

This finally fixes the wifi regression on Raspberry Pi 3 series.
In error case the wifi chip was permanently in reset because of
the power sequence depending on the deferred probe of the GPIO expander.

Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-iproc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -296,7 +296,10 @@ static int sdhci_iproc_probe(struct plat
 
 	iproc_host->data = iproc_data;
 
-	mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err;
+
 	sdhci_get_property(pdev);
 
 	host->mmc->caps |= iproc_host->data->mmc_caps;


