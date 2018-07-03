Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A254DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5C924B49
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="aJ0S6Yf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5C924B49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeGCNnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:43:55 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:52409 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeGCNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hf/UiK3oEuzW0ornStxkI8A3V1k5h2mnDyWpHrk0nsU=; b=aJ0S6Yf59m9ZM4b0fiY9hbATQ+
        eG6NT2Y8C6xwQS7bdjA5gFFhuKbjdavTzXWfKGGTeOf1muwVG5BlM9NznxHxy7D4ZFDdzSC/adC8s
        puk5z3fVMSr3WhFD0rfC1Ef3wZvV3pZ7sFtXvfs8uwFCTAXZwfGuQXeRQrC6ZPCkI7PMtwAlWm9EM
        aXYr5DNHobQMyscsMoEtVcsO9o37kvfn5xIIEHcajigG+Q4NJWPwlZJ9wMLa5XaHG0xTicgR2H9a9
        90qW106mJu+omq5SANk/zdwWNu00mNdG+/vH+qTNEzQ4SgSb0Bjk48Q0GI9wnr4zyqJ21gFgbqtaF
        xJAXipKQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37714 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1faLax-00D9d0-A1; Tue, 03 Jul 2018 13:43:53 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] fsi/sbefifo: Add dependency on OF_ADDRESS
Date:   Tue,  3 Jul 2018 06:43:49 -0700
Message-Id: <1530625429-5506-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls of_platform_device_create() which is only available
if OF_ADDRESS is enabled. When building sparc64 images, this results
in

ERROR: "of_platform_device_create" [drivers/fsi/fsi-sbefifo.ko] undefined!

Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/fsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 24f84a96b8b9..9c08f467a7bb 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -34,6 +34,7 @@ config FSI_SCOM
 
 config FSI_SBEFIFO
 	tristate "SBEFIFO FSI client device driver"
+	depends on OF_ADDRESS
 	---help---
 	This option enables an FSI based SBEFIFO device driver. The SBEFIFO is
 	a pipe-like FSI device for communicating with the self boot engine
-- 
2.7.4

