Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC94C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A99206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A99206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbeJBUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:15:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbeJBUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:15:09 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 803FF5AA;
        Tue,  2 Oct 2018 13:31:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 008/137] misc: sram: enable clock before registering regions
Date:   Tue,  2 Oct 2018 06:23:29 -0700
Message-Id: <20181002132459.014159756@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit d5b9653dd2bb7a2b1c8cc783c5d3b607bbb6b271 ]

Make sure to enable the clock before registering regions and exporting
partitions to user space at which point we must be prepared for I/O.

Fixes: ee895ccdf776 ("misc: sram: fix enabled clock leak on error path")
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/sram.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -391,23 +391,23 @@ static int sram_probe(struct platform_de
 	if (IS_ERR(sram->pool))
 		return PTR_ERR(sram->pool);
 
-	ret = sram_reserve_regions(sram, res);
-	if (ret)
-		return ret;
-
 	sram->clk = devm_clk_get(sram->dev, NULL);
 	if (IS_ERR(sram->clk))
 		sram->clk = NULL;
 	else
 		clk_prepare_enable(sram->clk);
 
+	ret = sram_reserve_regions(sram, res);
+	if (ret)
+		goto err_disable_clk;
+
 	platform_set_drvdata(pdev, sram);
 
 	init_func = of_device_get_match_data(&pdev->dev);
 	if (init_func) {
 		ret = init_func();
 		if (ret)
-			goto err_disable_clk;
+			goto err_free_partitions;
 	}
 
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
@@ -415,10 +415,11 @@ static int sram_probe(struct platform_de
 
 	return 0;
 
+err_free_partitions:
+	sram_free_partitions(sram);
 err_disable_clk:
 	if (sram->clk)
 		clk_disable_unprepare(sram->clk);
-	sram_free_partitions(sram);
 
 	return ret;
 }


