Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A30C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8204921855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895244;
	bh=Bk+O1RQbFMW+8e+NNcY5/o11lv27BXUgu6HTXY3ReXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNgvQQDpkUQpOBS9XiMjBLRNSuelS0RlteGOyleD3+RGuOYH3X3iBZGyHuTGTcnvw
	 umSR1J1uIGvIsdZ1vYzK3iJzfinJF0nqFdExCA5n72sSSh+32ZpffzDI13b+MxR+Y6
	 OG+BFkmG8mddr4aC13Ki4tyx4njA28n0TaOZokpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfBKO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfBKO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE90120838;
        Mon, 11 Feb 2019 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895238;
        bh=Bk+O1RQbFMW+8e+NNcY5/o11lv27BXUgu6HTXY3ReXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hkk1SSdYmi+dyGvCRVbooKDdi+qTj2CQfT5xWZfsIBW9kn5e8pi7KAygosIIxSSlu
         SAlMRZs0AC8kh1tcmtxurXRBgdGRsWKA5EbSKvs+0nY+eCp+1eBXtYnKwwiRySbC1/
         /zbV4Og6+f/QjF2BZYMPZ+s/eXR7yJkNeic9j5v4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 112/352] usb: dwc2: Disable power down feature on Samsung SoCs
Date:   Mon, 11 Feb 2019 15:15:39 +0100
Message-Id: <20190211141852.920704641@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 35a6054132286a4ab92b536595093b82e6bdfcbc ]

Power down feature of DWC2 module integrated in Samsung SoCs doesn't work
properly or needs some additional handling in PHY or SoC glue layer, so
disable it for now. Without disabling power down, DWC2 causes random memory
trashes and fails enumeration if there is no USB link to host on driver
probe.

Fixes: 03ea6d6e9e1ff1 ("usb: dwc2: Enable power down")
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/params.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 38c813b1d203..24ff5f21cb25 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -71,6 +71,13 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 	p->power_down = false;
 }
 
+static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->power_down = 0;
+}
+
 static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -152,7 +159,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "lantiq,arx100-usb", .data = dwc2_set_ltq_params },
 	{ .compatible = "lantiq,xrx200-usb", .data = dwc2_set_ltq_params },
 	{ .compatible = "snps,dwc2" },
-	{ .compatible = "samsung,s3c6400-hsotg" },
+	{ .compatible = "samsung,s3c6400-hsotg",
+	  .data = dwc2_set_s3c6400_params },
 	{ .compatible = "amlogic,meson8-usb",
 	  .data = dwc2_set_amlogic_params },
 	{ .compatible = "amlogic,meson8b-usb",
-- 
2.19.1



