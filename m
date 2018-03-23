Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806358-2-14628215433181509005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806357; b=k8UpG7YH91Mix0lKbJAaBlU407z3hz/M5RzMidQs5Gcq2Qo
    vO9D9BRJGJw/ZxWN6zVPA4DtNbUd8a8Gs5lhKE7H3Rk6Kr59McCGAYSM45xyf0+o
    F8Snf0MoXjhclMX9m4t4WOV2+HOsGohgSHYuYsVbA03qmlErEyAGFz/fe8cfmUWx
    on5FrSu61fRC+iGhPIKtgmKI8HEWIJBHdrSZG+TTZ/nNlhFFVMQhOZFL/6uHtf73
    +Fhr1GV5hjYCC5oB9srSw6/WSY5LpYyNpXF0sBzDSMGOqW1HBS5tRPfoiKd3pwwq
    pzSpw5bbGQUWyh1pqVtJ3F4DWASJNY1Mjg3THSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806357; bh=YFpzbIJ2mwav2mx6IjzMlYiwIc
    ZFSJ2LclHXSmP7jc0=; b=gLADpXxNp3zX2hpqnJxF2RLYFA+z/yWWS1qhKg4p43
    fjCI312R0Q3Ey27/+7qiCq3z2x20HwURWzHb9ioLMoQnSwNwzp0ehNrhAvvC24dC
    7hk/B2mDmrNdI/Cbo1mL0pSnByZdw1fBHDt1mH2EiHziZHAEl97Gbve7Z2yDm4B+
    sZvXgu+tN1g3/h7MABzhub53OmsiSM7cS9fdQFSLE9X7UfQZZPmpKqXrtAult4iu
    vl9fLXidCVTgqitUg61hltVD2gead+nz6yEaeS+k7lJjsGP4wwqAizrvxgAGBBfI
    uyrdkR78+3pNI1ZnPDC6heliYmEVlT5jfz4jIToVFeZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbeCWKAa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753606AbeCWKAZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 12/77] spi: sh-msiof: Avoid writing to registers from spi_master.setup()
Date: Fri, 23 Mar 2018 10:53:46 +0100
Message-Id: <20180323094143.040247348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 7ff0b53c4051145d1cf992d2f60987e6447eed4f ]

The spi_master.setup() callback must not change configuration registers,
as that could corrupt I/O that is in progress for other SPI slaves.

The only exception is the configuration of the native chip select
polarity in SPI master mode, as a wrong chip select polarity will cause
havoc during all future transfers to any other SPI slave.

Hence stop writing to registers in sh_msiof_spi_setup(), unless it is
the first call for a controller using a native chip select, or unless
native chip select polarity has changed (note that you'll loose anyway
if I/O is in progress).  Even then, only do what is strictly necessary,
instead of calling sh_msiof_spi_set_pin_regs().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sh-msiof.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -55,6 +55,8 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
+	bool native_cs_inited;
+	bool native_cs_high;
 	bool slave_aborted;
 };
 
@@ -528,8 +530,7 @@ static int sh_msiof_spi_setup(struct spi
 {
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
-
-	pm_runtime_get_sync(&p->pdev->dev);
+	u32 clr, set, tmp;
 
 	if (!np) {
 		/*
@@ -539,19 +540,31 @@ static int sh_msiof_spi_setup(struct spi
 		spi->cs_gpio = (uintptr_t)spi->controller_data;
 	}
 
-	/* Configure pins before deasserting CS */
-	sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
-				  !!(spi->mode & SPI_CPHA),
-				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST),
-				  !!(spi->mode & SPI_CS_HIGH));
-
-	if (spi->cs_gpio >= 0)
+	if (spi->cs_gpio >= 0) {
 		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+		return 0;
+	}
+
+	if (spi_controller_is_slave(p->master))
+		return 0;
 
+	if (p->native_cs_inited &&
+	    (p->native_cs_high == !!(spi->mode & SPI_CS_HIGH)))
+		return 0;
 
+	/* Configure native chip select mode/polarity early */
+	clr = MDR1_SYNCMD_MASK;
+	set = MDR1_TRMD | TMDR1_PCON | MDR1_SYNCMD_SPI;
+	if (spi->mode & SPI_CS_HIGH)
+		clr |= BIT(MDR1_SYNCAC_SHIFT);
+	else
+		set |= BIT(MDR1_SYNCAC_SHIFT);
+	pm_runtime_get_sync(&p->pdev->dev);
+	tmp = sh_msiof_read(p, TMDR1) & ~clr;
+	sh_msiof_write(p, TMDR1, tmp | set);
 	pm_runtime_put(&p->pdev->dev);
-
+	p->native_cs_high = spi->mode & SPI_CS_HIGH;
+	p->native_cs_inited = true;
 	return 0;
 }
 
