Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F096C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5559D208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPR08gv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5559D208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965021AbeFNOHX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965005AbeFNOHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6BF208CB;
        Thu, 14 Jun 2018 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985239;
        bh=tb9UEx826B5Q1go3G42pzvLcCope3v8OPJz+2QYAEo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPR08gv93AFg86YKq7c6BVlNeSYH0+qZKJFXRQ7zbgKQpD5RwJJCdsSvkncN6BKHe
         q5r5OK9ZfzAbc41AX43j3cSeAmAApsNVwnWeG8q4kkxo7K2kW002Bw4nx/ht6m0zZr
         MoW9okIN8oj7sykADVeebGfEy3IfdSrxBvWNUO2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 23/45] usb: gadget: udc: renesas_usb3: should fail if devm_phy_get() returns error
Date:   Thu, 14 Jun 2018 16:04:14 +0200
Message-Id: <20180614132128.020041952@linuxfoundation.org>
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

commit 0259068f63f23a665ded28647f2f9cdb6b20dc72 upstream.

This patch fixes an issue that this driver ignores errors other than
the non-existence of the device, f.e. a memory allocation failure
in devm_phy_get(). So, this patch replaces devm_phy_get() with
devm_phy_optional_get().

Reported-by: Simon Horman <horms+renesas@verge.net.au>
Fixes: 279d4bc64060 ("usb: gadget: udc: renesas_usb3: add support for generic phy")
Cc: <stable@vger.kernel.org> # v4.15+
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2636,9 +2636,11 @@ static int renesas_usb3_probe(struct pla
 	 * This is optional. So, if this driver cannot get a phy,
 	 * this driver will not handle a phy anymore.
 	 */
-	usb3->phy = devm_phy_get(&pdev->dev, "usb");
-	if (IS_ERR(usb3->phy))
-		usb3->phy = NULL;
+	usb3->phy = devm_phy_optional_get(&pdev->dev, "usb");
+	if (IS_ERR(usb3->phy)) {
+		ret = PTR_ERR(usb3->phy);
+		goto err_add_udc;
+	}
 
 	pm_runtime_enable(&pdev->dev);
 	ret = usb_add_gadget_udc(&pdev->dev, &usb3->gadget);


