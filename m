Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A83C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697452;
	bh=tAftwgvVwNYf09AEPtjoLSojZmmZvOYFDmJpoQTxpvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylbRLKAYpREgKptr7Q4f42n+/1ky6dxq/i47EZkyKgD6AkccnbdoZCkRdmp4Hy2E+
	 UiyvP6JzKGMCDNv1B1rJ7abQa9GHJ4eE0HfzqynbI7cq+4pnzcy3E+YVmL1x9YdFTA
	 RBuvBWlmWPDDbyaoiF/XiqbuQa2f5aMFrgQqrRs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfA1RoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfA1PtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747A921741;
        Mon, 28 Jan 2019 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690549;
        bh=tAftwgvVwNYf09AEPtjoLSojZmmZvOYFDmJpoQTxpvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhxhIon6HAmnwB0LYV8lu4Aervq60Ey1pRq4asa0zlKqCVCWxn911gllwwnDRoWrq
         OFICDupkXFPgzuDDGcpqko9tGlmwnTaIt90jUJaCJ5m+gBKgDoWPwO96Z3Hzn0uqcd
         RdEymzIDHmErP5KGbYqX2GY/2nhbIT64jyCDpZxo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 121/304] usb: dwc2: Disable power down feature on Samsung SoCs
Date:   Mon, 28 Jan 2019 10:40:38 -0500
Message-Id: <20190128154341.47195-121-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

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

