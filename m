Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73C32089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866426;
	bh=lCbzVanza381aZjm1prDEJxoALCM4HIuhtojJLJ0jxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIDYGC6bOfbvrIaZG7881rmpc+uksOKvufiHCswnUDfMejl1p+HUl/Fz7b01b3Nfz
	 qthdtlCx3NEgfEUSh5kFitkrDoI64QYvhZ8EwjG9rVOXR9FR3tlWfXybxYRKeuTiQf
	 QNoHNGhE84Y1mEr85kD5XyNcT77gmPfQ8hqrQbUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfAGNHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:07:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfAGNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:07:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C442089F;
        Mon,  7 Jan 2019 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866423;
        bh=lCbzVanza381aZjm1prDEJxoALCM4HIuhtojJLJ0jxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfUUmwDrDpg+OLxTMGwyXtdXaUogtyxYJtVVhMcyC5lpTldAOsrW+fgt3b6jSiG4x
         Wz1LQa44cr0REx2RIzFXltJGmJ4U3wgxqUbc8O8VB59XSC4dXaGN+FFH4d7uLe+04O
         C7LzeLOXTmE+U1dGKskCGdk0xLssNs1ClXoRONIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 34/71] mtd: atmel-quadspi: disallow building on ebsa110
Date:   Mon,  7 Jan 2019 13:33:03 +0100
Message-Id: <20190107105334.709470586@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 2a9d92fb3a1282a4659f1bb6d5684018846537b7 upstream.

I ran into a link-time error with the atmel-quadspi driver on the
EBSA110 platform:

drivers/mtd/built-in.o: In function `atmel_qspi_run_command':
:(.text+0x1ee3c): undefined reference to `_memcpy_toio'
:(.text+0x1ee48): undefined reference to `_memcpy_fromio'

The problem is that _memcpy_toio/_memcpy_fromio are not available on
that platform, and we have to prevent building the driver there.

In case we want to backport this to older kernels: between linux-4.8
and linux-4.20, the Kconfig entry was in drivers/mtd/spi-nor/Kconfig
but had the same problem.

Link: https://lore.kernel.org/patchwork/patch/812860/
Fixes: 161aaab8a067 ("mtd: atmel-quadspi: add driver for Atmel QSPI controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -31,7 +31,7 @@ config MTD_SPI_NOR_USE_4K_SECTORS
 
 config SPI_ATMEL_QUADSPI
 	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
 	depends on OF && HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.


