Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 215B6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF80208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olbfk8il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF80208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965079AbeFNOHj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965022AbeFNOHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAF5208DB;
        Thu, 14 Jun 2018 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985256;
        bh=cqRfl50l9fVYnB7zKArQRXZ5fhF6IL2cQE+XD8gDmUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Olbfk8ilNvU6nPbzAOTvdQdZfCXBV7zNpg/gGE+CPkdazzMjpSYpgk873secQoWz9
         Kr2lzJEXGg5Ysmxxi8dyCvYmA5PFTJMzAb3KSuBMRc0jvNtx7V9Xss33cdwHXzQlWJ
         Vl1gPNWcYLa/fFZJj8JA5lJrnvEKJMkRCVw1YStA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 19/45] usb: gadget: udc: renesas_usb3: fix double phy_put()
Date:   Thu, 14 Jun 2018 16:04:10 +0200
Message-Id: <20180614132127.783713501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 8223b2f89ca63e203dcb54148e30d94979f17b0b upstream.

This patch fixes an issue that this driver cause double phy_put()
calling. This driver must not call phy_put() in the remove because
the driver calls devm_phy_get() in the probe.

Fixes: 279d4bc64060 ("usb: gadget: udc: renesas_usb3: add support for generic phy")
Cc: <stable@vger.kernel.org> # v4.15+
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2408,8 +2408,6 @@ static int renesas_usb3_remove(struct pl
 	renesas_usb3_dma_free_prd(usb3, &pdev->dev);
 
 	__renesas_usb3_ep_free_request(usb3->ep0_req);
-	if (usb3->phy)
-		phy_put(usb3->phy);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;


