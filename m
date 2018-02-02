Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591667-2-6418448335892380662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591666; b=uYp+QghNeaINPuw46u8AB0HSRRVYWwpEuDPpNhwXnYa/PUk
    H/O9kbcRzJmNC3BNPeCZZKOcCHySvx58I6BF4kdIHBW8OumZnMyjDxU7nyImtoHz
    U2ln0R0/+3nCyrmquIwCxYppiKRRTpdRXdDfZVJW7SpMeKl0+xABTXj26fTZvSww
    H4gwHhUMVGVqyV64qeyaOygXYCLYT/PT1x2Gu0M3MH9MCUNm7XDqkC8YI2OsZRNd
    +jLXOaGwzn6VsV29KxCuB+ogiKjmiK28FzyeshcST/mfY4Q8pTdHtOHV9Dc8PeGl
    CjSrbF2PcoLWr2+7Mu5RSlyb+wRuAa+lwI1X1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591666; bh=iFN0n0HwSdAF4Fn/4QGgYy3O+N
    Uw7ITnZUjbRB5lfXI=; b=HsurID/bgeAilNYH6j5hVWv46Y7lij4l0RsG0SQ5KU
    d8u2ST9WEU06dHp4sjikKjebbRcpGICIcRnmpWzzK3O9aqLUpupA+LVMV2xo3NmF
    H1pZgNzySoA6a3Od/+CH2GnwVrLbGOejTRqRIE41WE/A8+H3AFiiSEg/+3i3+1Wh
    4GxSo2uzR6v9dBkSCmH2Iy2M4Zli2Q3htgV2k2mXGXCl9A4EApLkggmpt7jkFQqa
    zSWHDPvpiEYGt9ZZoENDptv0R6k7RzWeKmIWJtpyHIdRQxcuLwxc8Af7FtSX1Lc/
    Yvjn3bpaEduaVlo7kJYPKK6eqCK+99RE7xeBUFQb/RIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeBBROZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:14:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbeBBRON (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:14:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 151/156] iio: adc: stm32: fix scan of multiple channels with DMA
Date: Fri,  2 Feb 2018 17:58:52 +0100
Message-Id: <20180202140847.189804360@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit 04e491ca9df60ffe8637d00d68e5ab8bc73b30d5 upstream.

By default, watermark is set to '1'. Watermark is used to fine tune
cyclic dma buffer period. In case watermark is left untouched (e.g. 1)
and several channels are being scanned, buffer period is wrongly set
(e.g. to 1 sample). As a consequence, data is never pushed to upper layer.
Fix buffer period size, by taking scan channels number into account.

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-adc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1314,6 +1314,7 @@ static int stm32_adc_set_watermark(struc
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	unsigned int watermark = STM32_DMA_BUFFER_SIZE / 2;
+	unsigned int rx_buf_sz = STM32_DMA_BUFFER_SIZE;
 
 	/*
 	 * dma cyclic transfers are used, buffer is split into two periods.
@@ -1322,7 +1323,7 @@ static int stm32_adc_set_watermark(struc
 	 * - one buffer (period) driver can push with iio_trigger_poll().
 	 */
 	watermark = min(watermark, val * (unsigned)(sizeof(u16)));
-	adc->rx_buf_sz = watermark * 2;
+	adc->rx_buf_sz = min(rx_buf_sz, watermark * 2 * adc->num_conv);
 
 	return 0;
 }
