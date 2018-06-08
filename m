Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qlZsA8TyGluuKQAAmS7hNA
	; Fri, 08 Jun 2018 21:19:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AEBAE607E4; Fri,  8 Jun 2018 21:19:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uitscaXR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C3072602FC;
	Fri,  8 Jun 2018 21:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3072602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbeFHVTP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:19:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeFHVTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OmTE6LD7CgpgKQ2dlX+R3I1A9UKoo90ACaaBibqVX5M=; b=uitscaXRxhrF79YoGFWcfLxDVn
        98M6yH9/sDwcviwDkhpuENzbM89EDcVJNkLegdZphp8R6I8nT+ZUoCAqz9b3yUZXBSbu31VehYAuT
        CPG0HmrxvaCa/3OrWsCDwiequl+5mem5t8Tv3aSKCIWQzMVWNt3xzTFEfZtPhJd7ZUkISxJ0rD6LJ
        ClM1BCQ7aW/Tohrou5e3QDQ0OHtGTf8eVbclwG+5BEUeJhcEnZGwcc+NRSlmHQqu73A6L6ju8vhzd
        BPwcVV1UMnhBg8A6BqFIx87RwU3LVCHVlh1YZM6v7jd2Bwt1DHWoFRqGGRZAwyMYa6i9pozjyn9wG
        UtVfciXw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fROmq-0000jO-BT; Fri, 08 Jun 2018 21:19:08 +0000
To: linux-media <linux-media@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] media/platform/cadence: add <linux/slab.h> to fix build
 error
Message-ID: <2feda2a7-8008-f36d-67fa-a4aa38ea75ae@infradead.org>
Date: Fri, 8 Jun 2018 14:19:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add #include <linux/slab.h> to fix build errors.
This driver uses kzalloc() and kfree() so it needs to #include
the appropriate header file for those interfaces.

Fixes these build errors:

../drivers/media/platform/cadence/cdns-csi2rx.c: In function 'csi2rx_probe':
../drivers/media/platform/cadence/cdns-csi2rx.c:421:2: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
  csi2rx = kzalloc(sizeof(*csi2rx), GFP_KERNEL);
../drivers/media/platform/cadence/cdns-csi2rx.c:421:9: warning: assignment makes pointer from integer without a cast [enabled by default]
  csi2rx = kzalloc(sizeof(*csi2rx), GFP_KERNEL);
../drivers/media/platform/cadence/cdns-csi2rx.c:466:2: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
  kfree(csi2rx);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180608.orig/drivers/media/platform/cadence/cdns-csi2rx.c
+++ linux-next-20180608/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -13,6 +13,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
