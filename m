Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC23C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC5520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790628;
	bh=lCk5TT7gvLkLAHMCK58lnJjAt+di1YWpriohpCrnglU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djoRJ5nWSi8E2lwYoio17kp4XlaB9yFpNFhT+2D7HZFRhwi7ePi+M2r9vR5+udjGd
	 hnQOn3pZGbuTCFnAm8pUgJCgFhXnllkNX8BDaif9NEy/f+FwrfIdhIjeF4cj4uWW9H
	 Tvu/er0WpmMS88p6st66ZAxGuJ6t3s6VP5Qegyds=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC5520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeLNMa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbeLNMKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20A42147D;
        Fri, 14 Dec 2018 12:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789408;
        bh=lCk5TT7gvLkLAHMCK58lnJjAt+di1YWpriohpCrnglU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQwiyo/5STD2HjOVGO5q+bW4WK25SPcxzBGkHhG5Wtfi7fKni9pTC9Gx8EhxU4GC0
         flGSe1bcHLiJlhIZkw4VATD85pBizS/2dlv5ywiV/fIOSz3cTuahE4tvWWJG6fG43k
         HwufhHRyaiEPXS5zc8iwCBaGCV1s4blMo0MNlXv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 48/89] USB: omap_udc: fix crashes on probe error and module removal
Date:   Fri, 14 Dec 2018 13:00:01 +0100
Message-Id: <20181214115732.044061312@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 99f700366fcea1aa2fa3c49c99f371670c3c62f8 ]

We currently crash if usb_add_gadget_udc_release() fails, since the
udc->done is not initialized until in the remove function.
Furthermore, on module removal the udc data is accessed although
the release function is already triggered by usb_del_gadget_udc()
early in the function.

Fix by rewriting the release and remove functions, basically moving
all the cleanup into the release function, and doing the completion
only in the module removal case.

The patch fixes omap_udc module probe with a failing gadged, and also
allows the removal of omap_udc. Tested by running "modprobe omap_udc;
modprobe -r omap_udc" in a loop.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 50 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index e515c85ef0c5..d45dc14ef0a2 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2612,9 +2612,22 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 
 static void omap_udc_release(struct device *dev)
 {
-	complete(udc->done);
+	pullup_disable(udc);
+	if (!IS_ERR_OR_NULL(udc->transceiver)) {
+		usb_put_phy(udc->transceiver);
+		udc->transceiver = NULL;
+	}
+	omap_writew(0, UDC_SYSCON1);
+	remove_proc_file();
+	if (udc->dc_clk) {
+		if (udc->clk_requested)
+			omap_udc_enable_clock(0);
+		clk_put(udc->hhc_clk);
+		clk_put(udc->dc_clk);
+	}
+	if (udc->done)
+		complete(udc->done);
 	kfree(udc);
-	udc = NULL;
 }
 
 static int
@@ -2919,12 +2932,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 	}
 
 	create_proc_file();
-	status = usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
-			omap_udc_release);
-	if (!status)
-		return 0;
-
-	remove_proc_file();
+	return usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
+					  omap_udc_release);
 
 cleanup1:
 	kfree(udc);
@@ -2951,36 +2960,15 @@ static int omap_udc_remove(struct platform_device *pdev)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	if (!udc)
-		return -ENODEV;
-
-	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver)
-		return -EBUSY;
-
 	udc->done = &done;
 
-	pullup_disable(udc);
-	if (!IS_ERR_OR_NULL(udc->transceiver)) {
-		usb_put_phy(udc->transceiver);
-		udc->transceiver = NULL;
-	}
-	omap_writew(0, UDC_SYSCON1);
-
-	remove_proc_file();
+	usb_del_gadget_udc(&udc->gadget);
 
-	if (udc->dc_clk) {
-		if (udc->clk_requested)
-			omap_udc_enable_clock(0);
-		clk_put(udc->hhc_clk);
-		clk_put(udc->dc_clk);
-	}
+	wait_for_completion(&done);
 
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	wait_for_completion(&done);
-
 	return 0;
 }
 
-- 
2.19.1



