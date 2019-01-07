Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E43E20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864541;
	bh=w0rKpo3ouhKZB5c94TbfanQnnPkK+YEXnb6d8xZzHck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aqp94i46MUJres+oQB4RadDfP2C+0hzMyHc84wFE7qjec0u9kKJB+k37GodCZphTX
	 YrPZg9KWz7VU4qzyOeNmiBivYA6+awb9eEAr8nSnaysDS+qEUTq1+xEmeHBMtx/woR
	 dhx8cgass+NJ3TFp0lxBB+utn6MN9H66cftrliL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfAGMfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfAGMfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692CA206BB;
        Mon,  7 Jan 2019 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864536;
        bh=w0rKpo3ouhKZB5c94TbfanQnnPkK+YEXnb6d8xZzHck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mTMM31dfqlooxNwPDjkUDsWfS0oMJJLhRxtNikVkgZ06UtwCCuyaGbYuuxi0ngdU
         eZyzsqqhW6y7CpkRjA4j5UfK/9CtnPSZkPA/KfLGvanyu08YzkCXzvzrD0ciqUbMy6
         NUwSwI7Ql22PdUabXwdjqWckLIppwnIQ3H0Rc1mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.20 043/145] Revert "usb: dwc3: pci: Use devm functions to get the phy GPIOs"
Date:   Mon,  7 Jan 2019 13:31:20 +0100
Message-Id: <20190107104443.053575332@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

commit 3004cfd6204927c1294060b849029cf0c2651074 upstream.

Commit 211f658b7b40 ("usb: dwc3: pci: Use devm functions to get
the phy GPIOs") changed the code to claim the PHY GPIOs permanently
for Intel Baytrail devices.

This causes issues when the actual PHY driver attempts to claim the
same GPIO descriptors. For example, tusb1210 now fails to probe with:

  tusb1210: probe of dwc3.0.auto.ulpi failed with error -16 (EBUSY)

dwc3-pci needs to turn on the PHY once before dwc3 is loaded, but
usually the PHY driver will then hold the GPIOs to turn off the
PHY when requested (e.g. during suspend).

To fix the problem, this reverts the commit to restore the old
behavior to put the GPIOs immediately after usage.

Link: https://www.spinics.net/lists/linux-usb/msg174681.html
Cc: stable@vger.kernel.org
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -170,20 +170,20 @@ static int dwc3_pci_quirks(struct dwc3_p
 			 * put the gpio descriptors again here because the phy driver
 			 * might want to grab them, too.
 			 */
-			gpio = devm_gpiod_get_optional(&pdev->dev, "cs",
-						       GPIOD_OUT_LOW);
+			gpio = gpiod_get_optional(&pdev->dev, "cs", GPIOD_OUT_LOW);
 			if (IS_ERR(gpio))
 				return PTR_ERR(gpio);
 
 			gpiod_set_value_cansleep(gpio, 1);
+			gpiod_put(gpio);
 
-			gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
-						       GPIOD_OUT_LOW);
+			gpio = gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
 			if (IS_ERR(gpio))
 				return PTR_ERR(gpio);
 
 			if (gpio) {
 				gpiod_set_value_cansleep(gpio, 1);
+				gpiod_put(gpio);
 				usleep_range(10000, 11000);
 			}
 		}


