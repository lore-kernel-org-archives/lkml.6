Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16541C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0BA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0BA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408012AbeHATSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436600AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E8A974;
        Wed,  1 Aug 2018 16:53:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.17 001/336] spi: spi-s3c64xx: Fix system resume support
Date:   Wed,  1 Aug 2018 18:45:36 +0200
Message-Id: <20180801165028.986932917@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit e935dba111621bd6a0c5d48e6511a4d9885103b4 upstream.

Since Linux v4.10 release (commit 1d9174fbc55e "PM / Runtime: Defer
resuming of the device in pm_runtime_force_resume()"),
pm_runtime_force_resume() function doesn't runtime resume device if it was
not runtime active before system suspend. Thus, driver should not do any
register access after pm_runtime_force_resume() without checking the
runtime status of the device. To fix this issue, simply move
s3c64xx_spi_hwinit() call to s3c64xx_spi_runtime_resume() to ensure that
hardware is always properly initialized. This fixes Synchronous external
abort issue on system suspend/resume cycle on newer Exynos SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-s3c64xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1260,8 +1260,6 @@ static int s3c64xx_spi_resume(struct dev
 	if (ret < 0)
 		return ret;
 
-	s3c64xx_spi_hwinit(sdd, sdd->port_id);
-
 	return spi_master_resume(master);
 }
 #endif /* CONFIG_PM_SLEEP */
@@ -1299,6 +1297,8 @@ static int s3c64xx_spi_runtime_resume(st
 	if (ret != 0)
 		goto err_disable_src_clk;
 
+	s3c64xx_spi_hwinit(sdd, sdd->port_id);
+
 	return 0;
 
 err_disable_src_clk:


