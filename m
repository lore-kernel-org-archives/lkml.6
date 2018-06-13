Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23E1CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4562086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4562086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbeFMENw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:13:52 -0400
Received: from muru.com ([72.249.23.125]:46900 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753924AbeFMENv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:13:51 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1196180E4;
        Wed, 13 Jun 2018 04:16:26 +0000 (UTC)
Date:   Tue, 12 Jun 2018 21:13:19 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: REGRESSION: "wlcore: sdio: allow pm to handle sdio power" breaks
 wifi on HiKey960
Message-ID: <20180613041319.GA112168@atomide.com>
References: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Stultz <john.stultz@linaro.org> [180612 22:15]:
> Hey Folks,
>   I noticed with linus/master wifi wasn't coming up on HiKey960. I
> bisected it down and it seems to be due to:
> 
> 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")  and
> 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
>
> When wifi fails to load, the only useful error message I see is:
> [    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> to get_sync(-13)

Sorry to hear about that.

> Reverting those two changes gets wifi working again for me:
> [    8.754953] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> [    8.761778] random: crng init done
> [    8.765185] random: 7 urandom warning(s) missed due to ratelimiting
> [    8.779149] wlcore: loaded
> ...
> [   12.945903] wlcore: PHY firmware version: Rev 8.2.0.0.237
> [   13.058077] wlcore: firmware booted (Rev 8.9.0.0.70)
> 
> 
> Any suggestions how to resolve this w/o a revert?

Sounds like we need to ignore also -EACCES if runtime PM is
disabled for MMC. Care to try and see if the patch below
helps?

Regards,

Tony

8< ------------------------
diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -155,7 +155,7 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 	struct mmc_card *card = func->card;
 
 	ret = pm_runtime_get_sync(&card->dev);
-	if (ret < 0) {
+	if (ret < 0 && ret != -EACCES) {
 		pm_runtime_put_noidle(&card->dev);
 		dev_err(glue->dev, "%s: failed to get_sync(%d)\n",
 			__func__, ret);
@@ -182,7 +182,7 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 
 	/* Let runtime PM know the card is powered off */
 	error = pm_runtime_put(&card->dev);
-	if (error < 0 && error != -EBUSY) {
+	if (error < 0 && error != -EBUSY && error != -EACCES) {
 		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
 
 		return error;
