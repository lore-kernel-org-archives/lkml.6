Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C02C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8163A2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq9O6Z86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8163A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeJKXPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D055921470;
        Thu, 11 Oct 2018 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272841;
        bh=vRtNwNfaDSi4VU7+7aMP+dWvXhwOTRm4Zee6BoGjOow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aq9O6Z86P4OZxKZljED79ZYvOdzuHkYhbNo58vbBMYgBrydU1+8o2Q4tqB72BMED2
         4cyW8jUPbltSKBSNaTIUlSauCdlL3BYqH5/5w01AqLMVq2J//CQa37bcKW5kYLZM1S
         /OuhaVBJOJO2X4xerEYL2B/iq3H5qvNHQt8F9DGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.18 13/44] mmc: slot-gpio: Fix debounce time to use miliseconds again
Date:   Thu, 11 Oct 2018 17:39:51 +0200
Message-Id: <20181011152453.074825120@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 1b09d9c232cdaea59fb50ac437d3921ed1f1eafb upstream.

The debounce value passed to mmc_gpiod_request_cd() function is in
microseconds, but msecs_to_jiffies() requires the value to be in
miliseconds to properly calculate the delay, so adjust the value stored
in cd_debounce_delay_ms context entry.

Fixes: 1d71926bbd59 ("mmc: core: Fix debounce time to use microseconds")
Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card
after card is inserted")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/slot-gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -271,7 +271,7 @@ int mmc_gpiod_request_cd(struct mmc_host
 	if (debounce) {
 		ret = gpiod_set_debounce(desc, debounce);
 		if (ret < 0)
-			ctx->cd_debounce_delay_ms = debounce;
+			ctx->cd_debounce_delay_ms = debounce / 1000;
 	}
 
 	if (gpio_invert)


