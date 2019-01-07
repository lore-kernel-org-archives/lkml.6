Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7670C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F22E2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866179;
	bh=P+JfLNXWnwRM8LBNQZkL4TsYJZ2wkpBMsiSjkPjTetw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4D+ZOI2fCIQ59bmF+ByiREMv3LwceH1iPFgWAx1JEiEwRmoLGlTxhvoGdtMNzyr7
	 xm4OiDQpcPAJ5dUlh6es2YnH5VF/daOEtZPfQOV+rhuc7/REnJXbzkP+LwJ0XKxURK
	 dicn1t38ujHW1XJlUoSo36tGr5btcz4jnimOtTGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfAGNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbfAGNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D3A206BB;
        Mon,  7 Jan 2019 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866171;
        bh=P+JfLNXWnwRM8LBNQZkL4TsYJZ2wkpBMsiSjkPjTetw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAAqg9g/0LohoWMKpT0NxKug/lVHspKO5FUTAxDuXnJFr8D1y5kxZ0e7hprz6yrsk
         QRhfaTqNLZeYRl8lYjUa5feS5cpKD047l8eEXibwCGB51rMM3YlaHdFVC6lAtQLUS3
         ig9QB/l+CDk7ODFGEIcw0SrGAVbrNkoW88GySChk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 042/101] mtd: atmel-quadspi: disallow building on ebsa110
Date:   Mon,  7 Jan 2019 13:32:30 +0100
Message-Id: <20190107105335.210358914@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -41,7 +41,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL_QUADSPI
 	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
 	depends on OF && HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.


