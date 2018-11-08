Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92161ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586AB2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVtEg8x3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586AB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeKIHaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:30:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeKIHay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:30:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E4F20857;
        Thu,  8 Nov 2018 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714008;
        bh=NhpBTm/oRLe0nuBNiKKCgeoRKr/uUmuCh6seNyj/Uas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVtEg8x31cAvg3U9/ZlHRx/QAYsZ+9lehJu9AisQYagxueWpwJ4QkBw+P4aoCqAMQ
         JXXLNGpxYN9wejOwvEUX1vNY955hrIWpVW5W4wSmwgso5UfzyThpMS5XZnP5CfPUUQ
         7GrWgTsqD98yxCOIYLKrcvlujA/Aij7epnkSOmlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 002/144] mfd: omap-usb-host: Fix dts probe of children
Date:   Thu,  8 Nov 2018 13:49:33 -0800
Message-Id: <20181108215054.961454759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 10492ee8ed9188d6d420e1f79b2b9bdbc0624e65 ]

It currently only works if the parent bus uses "simple-bus". We
currently try to probe children with non-existing compatible values.
And we're missing .probe.

I noticed this while testing devices configured to probe using ti-sysc
interconnect target module driver. For that we also may want to rebind
the driver, so let's remove __init and __exit.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/omap-usb-host.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -558,8 +558,8 @@ static int usbhs_omap_get_dt_pdata(struc
 }
 
 static const struct of_device_id usbhs_child_match_table[] = {
-	{ .compatible = "ti,omap-ehci", },
-	{ .compatible = "ti,omap-ohci", },
+	{ .compatible = "ti,ehci-omap", },
+	{ .compatible = "ti,ohci-omap3", },
 	{ }
 };
 
@@ -886,6 +886,7 @@ static struct platform_driver usbhs_omap
 		.pm		= &usbhsomap_dev_pm_ops,
 		.of_match_table = usbhs_omap_dt_ids,
 	},
+	.probe		= usbhs_omap_probe,
 	.remove		= usbhs_omap_remove,
 };
 
@@ -895,9 +896,9 @@ MODULE_ALIAS("platform:" USBHS_DRIVER_NA
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
 
-static int __init omap_usbhs_drvinit(void)
+static int omap_usbhs_drvinit(void)
 {
-	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
+	return platform_driver_register(&usbhs_omap_driver);
 }
 
 /*
@@ -909,7 +910,7 @@ static int __init omap_usbhs_drvinit(voi
  */
 fs_initcall_sync(omap_usbhs_drvinit);
 
-static void __exit omap_usbhs_drvexit(void)
+static void omap_usbhs_drvexit(void)
 {
 	platform_driver_unregister(&usbhs_omap_driver);
 }


