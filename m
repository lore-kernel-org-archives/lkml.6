Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4476C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CDF222AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897451;
	bh=oeLfXMbJj8jsMqm28z3wSKXeXA0T92LhK+1HMmgHWZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSC7o2eID4EGIBkozW+MU9yd3SvmMdGr6A17Ns9rVCc1Ejoe4GWU+U315sIPWCMGz
	 xAuPN4gNWR+66yQN2PHjCgYelRotPUxgN2rbwV81ux/kgu6Txi3T1/vL90uGB1kFBH
	 N8DPBFKI4RtScy0ln+F/zyTrY3GnEp64RP3z2sB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbfBKPEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390668AbfBKPEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63D2222A7;
        Mon, 11 Feb 2019 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897447;
        bh=oeLfXMbJj8jsMqm28z3wSKXeXA0T92LhK+1HMmgHWZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gq/ra6uk92AUyfRj4+LTg6ZNrzCOj5j6MD4v6xl3DAOtVbh8qkxj0TshfP2Di2WCl
         o0r03D5dTC8StXq+mB4nRK/kB//71SDMP0NaGS/4sCpTWoE+KpMfeYRIJhM9CzJVvI
         +nMqf4nDu0998W/6W9dB7YLQx68AkQn+9/HCALTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 185/205] usb: phy: am335x: fix race condition in _probe
Date:   Mon, 11 Feb 2019 15:19:43 +0100
Message-Id: <20190211141840.501419976@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

From: Bin Liu <b-liu@ti.com>

commit a53469a68eb886e84dd8b69a1458a623d3591793 upstream.

power off the phy should be done before populate the phy. Otherwise,
am335x_init() could be called by the phy owner to power on the phy first,
then am335x_phy_probe() turns off the phy again without the caller knowing
it.

Fixes: 2fc711d76352 ("usb: phy: am335x: Enable USB remote wakeup using PHY wakeup")
Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/phy/phy-am335x.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -60,9 +60,6 @@ static int am335x_phy_probe(struct platf
 	if (ret)
 		return ret;
 
-	ret = usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
-	if (ret)
-		return ret;
 	am_phy->usb_phy_gen.phy.init = am335x_init;
 	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
 
@@ -81,7 +78,7 @@ static int am335x_phy_probe(struct platf
 	device_set_wakeup_enable(dev, false);
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, am_phy->dr_mode, false);
 
-	return 0;
+	return usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
 }
 
 static int am335x_phy_remove(struct platform_device *pdev)


