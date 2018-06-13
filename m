Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 24612C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D386220891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D386220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935790AbeFMOmg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:42:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935345AbeFMOmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:42:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D30980D;
        Wed, 13 Jun 2018 07:42:34 -0700 (PDT)
Received: from [10.1.206.36] (e113632-lin.cambridge.arm.com [10.1.206.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A2B73F59D;
        Wed, 13 Jun 2018 07:42:33 -0700 (PDT)
Subject: Re: REGRESSION: "wlcore: sdio: allow pm to handle sdio power" breaks
 wifi on HiKey960
To:     Tony Lindgren <tony@atomide.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
 <20180613041319.GA112168@atomide.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1fc9a078-160d-b9ee-4eaa-9fb970520606@arm.com>
Date:   Wed, 13 Jun 2018 15:42:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613041319.GA112168@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/06/18 05:13, Tony Lindgren wrote:
> * John Stultz <john.stultz@linaro.org> [180612 22:15]:
>> Hey Folks,
>>   I noticed with linus/master wifi wasn't coming up on HiKey960. I
>> bisected it down and it seems to be due to:
>>
>> 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")  and
>> 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
>>
>> When wifi fails to load, the only useful error message I see is:
>> [    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
>> to get_sync(-13)
> 
> Sorry to hear about that.
> 
>> Reverting those two changes gets wifi working again for me:
>> [    8.754953] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
>> [    8.761778] random: crng init done
>> [    8.765185] random: 7 urandom warning(s) missed due to ratelimiting
>> [    8.779149] wlcore: loaded
>> ...
>> [   12.945903] wlcore: PHY firmware version: Rev 8.2.0.0.237
>> [   13.058077] wlcore: firmware booted (Rev 8.9.0.0.70)
>>
>>
>> Any suggestions how to resolve this w/o a revert?
> 
> Sounds like we need to ignore also -EACCES if runtime PM is
> disabled for MMC. Care to try and see if the patch below
> helps?
> 

I don't use wifi with my board (I have an USB ethernet adapter), but I do
get the same error message as John.

Reverting the patches works and I do see wlan0 being brought up. Sadly,
applying your patch doesn't seem to fix the issue - and actually it seems
to freeze my board on first boot with this error:

[   11.169127] wlcore: ERROR timeout waiting for the hardware to complete initialization

On second boot it finally comes to life, but issuing ifconfig freezes it again.

$ dmesg | grep wl
[    5.922661] wl18xx_driver wl18xx.0.auto: Direct firmware load for ti-connectivity/wl18xx-conf.bin failed with error -2
[    5.933904] wlcore: ERROR could not get configuration binary ti-connectivity/wl18xx-conf.bin: -2
[    5.949158] wlcore: WARNING falling back to default config
[    6.199806] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[    6.210738] wlcore: WARNING Detected unconfigured mac address in nvs, derive from fuse instead.
[    6.221644] wlcore: WARNING This default nvs file can be removed from the file system
[    6.235180] wlcore: loaded
[    6.820146] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    7.280611] wlcore: PHY firmware version: Rev 8.2.0.0.236
[    7.388339] wlcore: firmware booted (Rev 8.9.0.0.69)
[    7.409610] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    7.417815] wlcore: down
[   10.628867] wlcore: ERROR timeout waiting for the hardware to complete initialization


Seems like it's not getting powered on, which might be why those mmc_power_*
calls were in there originally ?

> Regards,
> 
> Tony
> 
> 8< ------------------------
> diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> --- a/drivers/net/wireless/ti/wlcore/sdio.c
> +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> @@ -155,7 +155,7 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
>  	struct mmc_card *card = func->card;
>  
>  	ret = pm_runtime_get_sync(&card->dev);
> -	if (ret < 0) {
> +	if (ret < 0 && ret != -EACCES) {
>  		pm_runtime_put_noidle(&card->dev);
>  		dev_err(glue->dev, "%s: failed to get_sync(%d)\n",
>  			__func__, ret);
> @@ -182,7 +182,7 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
>  
>  	/* Let runtime PM know the card is powered off */
>  	error = pm_runtime_put(&card->dev);
> -	if (error < 0 && error != -EBUSY) {
> +	if (error < 0 && error != -EBUSY && error != -EACCES) {
>  		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
>  
>  		return error;
> 
