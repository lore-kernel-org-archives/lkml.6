Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889E320855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896764;
	bh=z/zdSozROqFdSxxBgVQbo1jUzj5nXKLfMOllmMyiBLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FndTtdJsFzaTVKKL5frn34Zna2EpswknEnQt/edciIn0xs+EjoEPoRGK3dmxEM1m3
	 hLwHD1F85bp713FdJtZJWuBbGtoYc/TlvQGPHrQopixDFVhAT0P12rOAo1dsipqIvz
	 AHS6mSe7Felckn6Np2L6rAAaGDLBzYNP9q3NtEiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfBKOwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbfBKOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC70218A3;
        Mon, 11 Feb 2019 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896761;
        bh=z/zdSozROqFdSxxBgVQbo1jUzj5nXKLfMOllmMyiBLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KnqaGShbF+Xdnv8yAUTPUsEp6PYAtYim2AgBW3a3CPlxNnlPOvdxVEC0nd3VET31
         ZXW8EaYrZ73NS+FxpDrKsLYizn+pjt68aZn07K4Mpu8Tn2JLppDwRAGRnAMe0oCWP8
         a1eh6bsLW1mat8EOPdIWkGGdO+b8TKKG8gS//d20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 293/313] usb: phy: am335x: fix race condition in _probe
Date:   Mon, 11 Feb 2019 15:19:33 +0100
Message-Id: <20190211141912.615740359@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
@@ -61,9 +61,6 @@ static int am335x_phy_probe(struct platf
 	if (ret)
 		return ret;
 
-	ret = usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
-	if (ret)
-		return ret;
 	am_phy->usb_phy_gen.phy.init = am335x_init;
 	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
 
@@ -82,7 +79,7 @@ static int am335x_phy_probe(struct platf
 	device_set_wakeup_enable(dev, false);
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, am_phy->dr_mode, false);
 
-	return 0;
+	return usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
 }
 
 static int am335x_phy_remove(struct platform_device *pdev)


