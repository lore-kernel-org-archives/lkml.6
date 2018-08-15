Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA20621567
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPezjwQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA20621567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeHOTE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:04:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHOTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Togc7bt58Igrfm0tmExX88bsaB5ErW/5bwddeZosfbY=; b=FPezjwQuue8U4DtBLrJJp8/7g
        ii7daqQc7XJQP6PLugpEdjguqI7MVVlO46dDqLv4PTZIbNpjwcYtB3rZdGGkSUgoJwnUn2gBgIfW2
        KA5X2gstNS0R+ev1+BCohU/NTnfkMbXrtXRfEGQqCSrc86x1GZJGUSBPhpdBdrw/jmf9p/0g6EdJm
        mxV97MOvn0an1TVd4dBB04F/t4jXCqTnPlOhFmXlFCmO9N/29Fy2HNmOwvtNndu94qmkWrgSQTc29
        kbKPc8ZyCfEqQwwyKci6rMnUjhhOJ4l00QBPNLYucvyOhTlbTbaSPQWdJ/cM12YWwmffMnsAiOhz0
        LHexlLO3A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpyP5-0008Du-Ug; Wed, 15 Aug 2018 16:12:12 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] platform/x86: fix intel_punit_ipc.c build errors
Message-ID: <aee82dc5-cc0f-0698-04a8-a5857fce9791@infradead.org>
Date:   Wed, 15 Aug 2018 09:12:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors by #including <linux/io.h>.

../drivers/platform/x86/intel_punit_ipc.c: In function 'ipc_read_status':
../drivers/platform/x86/intel_punit_ipc.c:55:2: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
  return readl(ipcdev->base[type][BASE_IFACE]);
../drivers/platform/x86/intel_punit_ipc.c: In function 'ipc_write_cmd':
../drivers/platform/x86/intel_punit_ipc.c:60:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
  writel(cmd, ipcdev->base[type][BASE_IFACE]);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zha Qipeng <qipeng.zha@intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
Found in linux-next but applies to current mainline also.

 drivers/platform/x86/intel_punit_ipc.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180815.orig/drivers/platform/x86/intel_punit_ipc.c
+++ linux-next-20180815/drivers/platform/x86/intel_punit_ipc.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <asm/intel_punit_ipc.h>
 


