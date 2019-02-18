Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAB7217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499074;
	bh=YPCAAnrIDUZIqLMyNXBJQ4ZRMjdodKk+D0fIq4OmijI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dak2p9Py2fN2sMRnqLs1DX7wallenUp7uQqTBFno8P9xYTX+Ed0YRoKA2qmzic8Wg
	 +rUi4wM8w/gfnajm/N3XioylGQq5tEt6VNptChJ6vt77tXKSdXEeFmmDU9S7W+Lted
	 qpFLfxN7hA/uYak0G1zpIRLbRwGpQ7rkWVvYHdpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfBROLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391060AbfBROLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD5C217D7;
        Mon, 18 Feb 2019 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499069;
        bh=YPCAAnrIDUZIqLMyNXBJQ4ZRMjdodKk+D0fIq4OmijI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az35KRmrLsd04mytK+m1fsFBWoeBlaQRmA+e0YT1psqidvteSdejrzNrjCDOcUcQ8
         ZF8DSB0A0qlTxBDqmj5IsaRdPhTyQAUAQRBthaC89hasBHwOnCsqA/OKFjYnVjKhMx
         Qb+Sf4pqcWmZrEwcKDSUDmqBpRFGDoPVrfvSX/sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 067/108] usb: phy: am335x: fix race condition in _probe
Date:   Mon, 18 Feb 2019 14:44:03 +0100
Message-Id: <20190218133522.629204627@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -56,9 +56,6 @@ static int am335x_phy_probe(struct platf
 	if (ret)
 		return ret;
 
-	ret = usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
-	if (ret)
-		return ret;
 	am_phy->usb_phy_gen.phy.init = am335x_init;
 	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
 
@@ -77,7 +74,7 @@ static int am335x_phy_probe(struct platf
 	device_set_wakeup_enable(dev, false);
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, false);
 
-	return 0;
+	return usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
 }
 
 static int am335x_phy_remove(struct platform_device *pdev)


