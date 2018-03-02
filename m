Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519989335-2-6046506848647105249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989334; b=d4Ymbdz7bb6gWScoTB5q8J2ScnGJz+1POieWB0P+CuHESBG
    a5dMGc0EXSaR/X+T/Rqtrc15AYUiy+T8FWXca6jAJNoHHYXbNBSLpb1PtQl5oNlT
    WY6Wytk80V/VedF7P47y6b18tTrklJGSRT0d6zHSY81aldR2rC+Gy+tm1PUYjpj7
    cLdNSaPk4CR4jV+/Fa5UzGUJybMWRukcHebQ6xPoIbd0bM7/AipXWX1QhtGqRLYb
    8Mz/gGUnFr6NJAENW2MrrRCOQYvfJzvDIXCH9/n1ppca0TbhLEArsZeJW/L5lFKL
    Km0S1gB5TXYzEycQ3VddZLIpHN+KWXe0va65xcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989334; bh=OeBgKUn2/JT6ZSB5N0LTv7FhZ1
    y89VcwiuL1hGmb0iw=; b=w9RcdH56zzRrth387jO0aXra8KN9EKNdC+rDsZVGXL
    DdwGy+0WtUCUpmN2zGkSTKwBDW+BSEsiABlT2GErT45PEJcO5u+MwoxQRdoiiqOc
    FPsxCz7Rt3hWhUSb6Z56korCaQA9UXZXKXhjri2nG5hrk6uOHF9yo2cfjvKPqdYY
    xDcfXnL70eyepuDE1eHlGDjFk06S4fCzfEdIyIHydl/pWFND9fdQiuwVmmYAVpuK
    v1X1ulwU95W6i/3g8jsfXX6Ha8qWAivbQB6tVdICvVlSelPVRHB/g3MJSqz+JgR3
    XrgQWxq6sGPHal0NtdpcuEUgywPTsIdWUynzpwpeuiNw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423403AbeCBIx5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:53:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423387AbeCBIxx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Radu Pirea <radu.pirea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 06/24] spi: atmel: fixed spin_lock usage inside atmel_spi_remove
Date: Fri,  2 Mar 2018 09:51:03 +0100
Message-Id: <20180302084239.490259197@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Pirea <radu.pirea@microchip.com>


[ Upstream commit 66e900a3d225575c8b48b59ae1fe74bb6e5a65cc ]

The only part of atmel_spi_remove which needs to be atomic is hardware
reset.

atmel_spi_stop_dma calls dma_terminate_all and this needs interrupts
enabled.
atmel_spi_release_dma calls dma_release_channel and dma_release_channel
locks a mutex inside of spin_lock.

So the call of these functions can't be inside a spin_lock.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-atmel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1416,12 +1416,12 @@ static int atmel_spi_remove(struct platf
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
 	/* reset the hardware and block queue progress */
-	spin_lock_irq(&as->lock);
 	if (as->use_dma) {
 		atmel_spi_stop_dma(as);
 		atmel_spi_release_dma(as);
 	}
 
+	spin_lock_irq(&as->lock);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
