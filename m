Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AAAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2B208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PsSdvkun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D2B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeFUNhr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:37:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932813AbeFUNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LM+ebVZ6Wf/drnJd5RVtHeUuiC8NCYZnWP7Xlwy03Fs=; b=PsSdvkunNvyJK2I0HOEWvMVaR
        PnCfO18LuxtfCwhHrG0fGhF2GrDOaSTu5sQ4muPnIWLJ3NEG1RnndDszfW9D/P+BeEaN1B49gG/qY
        dNAaU88el4IxR3zEsxVBq9OO7qBXMI4zoKbgcY7LQKDUeRouVEBHaQOIHreCR60Icarp7e9L8pgu7
        5Ou7TRKxW2pvoL0PI+syVhgLYUnOtgAW+Fc6jlUaFdpS3QSp868ebONSWW5IkoJNy/nUW+wPQcPfv
        97CnQvCeqAFYrSqIXUcyqUwWWky4+H8WuxFGP+EyP53tVHZTncrvuIogRHnykmkeYmezylnv50y0D
        n6UyD9UWg==;
Received: from 213-225-12-120.nat.highway.a1.net ([213.225.12.120] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVzmP-0000bR-Vr; Thu, 21 Jun 2018 13:37:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org
Cc:     mark.rutland@arm.com, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH] base: fix order of OF initialization
Date:   Thu, 21 Jun 2018 15:37:37 +0200
Message-Id: <20180621133737.14397-1-hch@lst.de>
X-Mailer: git-send-email 2.17.1
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
... which you get for every CPU on all architectures that use
CONFIG_GENERIC_CPU_DEVICES.

In that case, driver_init() calls cpu_dev_init() before calling
of_core_init(). Then we get the callchain:

  cpu_dev_init()
    -> cpu_dev_register_generic()
    -> register_cpu(cpu, i)
    -> device_register(&cpu->dev)
    -> device_add(dev)
    -> device_add_class_symlinks(dev)

... in device_add_class_symlinks, we we dev->of_node, and call
sysfs_create_link(), which fails because we haven't called
of_core_init() to register the sysfs devicetree directory yet.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[hch: updated the changelog based on review feedback]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Frank Rowand <frowand.list@gmail.com>
---

In case anyone is wondering why I send out this patch - I'm digging
through the RISC-V tree and trying to the patches required to let
a RISC-V kernel boot on qemu upstream.  I also got the previously
missing signoff from Wes offlist.

 drivers/base/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/init.c b/drivers/base/init.c
index dd85b05a6a16..908e6520e804 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -30,9 +30,9 @@ void __init driver_init(void)
 	/* These are also core pieces, but must come after the
 	 * core core pieces.
 	 */
+	of_core_init();
 	platform_bus_init();
 	cpu_dev_init();
 	memory_dev_init();
 	container_dev_init();
-	of_core_init();
 }
-- 
2.17.1

