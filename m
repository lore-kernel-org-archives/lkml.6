Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8E7206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyWL68OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8E7206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404004AbeKLIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403928AbeKLIWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:54 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434CE223C6;
        Sun, 11 Nov 2018 22:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975577;
        bh=/b0wKblQwdoPzxYIm0U7dOyrKvcnqKfLHzOfT6sfox4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyWL68OTtY+qlVVUyT2QX8ifvVuhMj/PnlXfTLXzApsmgXaCiXirIwlrlfw4SZ87Z
         q3uhrNYXnDbVF27jyoeec2t+tgg5IDQIbK9+zup7LysUMS2+m2nE67Ptutggj/S9jK
         EtnbORD17v1YVancNw/HGmFEGFojLdoUun/sOgvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 161/222] iio: adc: at91: fix acking DRDY irq on simple conversions
Date:   Sun, 11 Nov 2018 14:24:18 -0800
Message-Id: <20181111221701.694468576@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@microchip.com>

commit bc1b45326223e7e890053cf6266357adfa61942d upstream.

When doing simple conversions, the driver did not acknowledge the DRDY irq.
If this irq status is not acked, it will be left pending, and as soon as a
trigger is enabled, the irq handler will be called, it doesn't know why
this status has occurred because no channel is pending, and then it will go
int a irq loop and board will hang.
To avoid this situation, read the LCDR after a raw conversion is done.

Fixes: 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/at91_adc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -279,6 +279,8 @@ static void handle_adc_eoc_trigger(int i
 		iio_trigger_poll(idev->trig);
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_ADC_LCDR);
 		st->done = true;
 		wake_up_interruptible(&st->wq_data_avail);
 	}


