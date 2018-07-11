Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3926D20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3926D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbeGKPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:46:09 -0400
Received: from foss.arm.com ([217.140.101.70]:38958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732452AbeGKPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:46:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3287A9;
        Wed, 11 Jul 2018 08:41:15 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653213F5B1;
        Wed, 11 Jul 2018 08:41:13 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:41:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] misc: vexpress: Fix potential NULL dereference in
 vexpress_syscfg_probe()
Message-ID: <20180711154110.GB10578@e107155-lin>
References: <1531315058-183762-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531315058-183762-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:17:38PM +0000, Wei Yongjun wrote:
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = platform_get_resource(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);

Instead of adding unnecessary check here, I would go with replacing it
with devm_ioremap_resource as it's designed to deal with that (patch inline)

Regards,
Sudeep

-->8
From a6de466984e657dad24dcbe87e5dde2d21cb8d35 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 11 Jul 2018 16:17:39 +0100
Subject: [PATCH] misc: vexpress/syscfg: Use devm_ioremap_resource() to map
 memory

Instead of checking the return value of platform_get_resource(), we can
use devm_ioremap_resource() which has the NULL pointer check and the
memory region requesting. devm_ioremap_resource is designed to replace
calls to devm_request_mem_region followed by devm_ioremap, so let's use
the same.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/misc/vexpress-syscfg.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
index 80a6f199077c..6c3591cdf855 100644
--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -258,13 +258,9 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&syscfg->funcs);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-			resource_size(res), pdev->name))
-		return -EBUSY;
-
-	syscfg->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!syscfg->base)
-		return -EFAULT;
+	syscfg->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(syscfg->base))
+		return PTR_ERR(syscfg->base);
 
 	/* Must use dev.parent (MFD), as that's where DT phandle points at... */
 	bridge = vexpress_config_bridge_register(pdev->dev.parent,
-- 
2.7.4

