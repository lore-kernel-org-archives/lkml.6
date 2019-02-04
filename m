Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95872C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483E2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278023;
	bh=OFBlZJ0INi3iFeiHqQWlwS/H4nZXX9Rrx53LLXQuOEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=En5PYr5FuBwDOEoDu94GQv80Ivr7bggOr6sArDwHij8c17UPi9uXL8GYfD4O9fBlW
	 8e/qkV5ECZUn5nbna2J2rpe9p/H1Ex0BlIisIFts4QHsFv7sTO0JigKw69AK1RhNq8
	 bBYwa9esyTy2Nf4ESeO3bmenyl2zzJmYIBkk9Kv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbfBDKtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfBDKtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22122070C;
        Mon,  4 Feb 2019 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277350;
        bh=OFBlZJ0INi3iFeiHqQWlwS/H4nZXX9Rrx53LLXQuOEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xS6Tz94HxXIoGhFBWwi5jzpCfIStV7BH4Cyri4fwS5vSJPxdz+I7TxyUIZ63UCNaa
         uINKP2eXZ50ihrfYSTF4UxGhanfCnJaKoQPE6jCaVaI/1LBD/WEyQ/khvh+h7yTwNg
         hfn22lhBcmVcxt/LR9kCVjR79KVkhZhSVcf6yfDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 58/74] mmc: sdhci-iproc: handle mmc_of_parse() errors during probe
Date:   Mon,  4 Feb 2019 11:37:11 +0100
Message-Id: <20190204103627.525273529@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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
@@ -279,7 +279,10 @@ static int sdhci_iproc_probe(struct plat
 
 	iproc_host->data = iproc_data;
 
-	mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err;
+
 	sdhci_get_of_property(pdev);
 
 	host->mmc->caps |= iproc_host->data->mmc_caps;


