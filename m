Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CC8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94CB208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehBx1d8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94CB208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLCTlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:41:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeLCTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y1cnbX/J0Nz0q9+u6/6yEe6wMlQM7Y2RfshC0XQOvdo=; b=ehBx1d8EPWTkDEeyyMkaUW3i0J
        nqwQgbCgKvcFsu1sjrtaud/UQjCw2iAgVihXT9D2wSyITV931n1wU9k2aJZGzqyao1EaaoaFZcg6M
        T82Zvsr/RkFjrgFKHZlk7chFLdKHUZ6K2QGiLz3EA4/H4UQF3XSZZCqA3HHa/+44Q8ARnE7sVMAsv
        1GhyXtaXTuKSnDv8JBvKtDC4sjEmKU9rpw+59e8wy4xGBtobqflAUOa6l5Chnf1asTnZrJBetig7H
        fLQYKvmZS+qvtgiMSleBkeT6emwtwk83F4nxSOzdIevKzS6u4hJlgGQCZNxdRbn6p49u7gxwO6FiY
        9zcdI/BA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTu5t-0002YO-KG; Mon, 03 Dec 2018 19:41:25 +0000
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
 <20181203185344.3521-3-ayman.bagabas@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9d6d8211-6fdf-bfe4-82b5-272d67fbae23@infradead.org>
Date:   Mon, 3 Dec 2018 11:41:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203185344.3521-3-ayman.bagabas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 10:53 AM, Ayman Bagabas wrote:
> This driver adds support for missing hotkeys on some Huawei laptops.
> Laptops such as the Matebook X have non functioning hotkeys. Whereas
> newer laptops such as the Matebook X Pro come with working hotkeys out
> of the box.
> 
> Old laptops, such as the Matebook X, report hotkey events through ACPI
> device "\WMI0". However, new laptops, such as the Matebook X Pro,
> does not have this WMI device.
> 
> All the hotkeys on the Matebook X Pro work fine
> without this patch except (micmute, wlan, and huawei key). These keys
> and the brightness keys report events to "\AMW0" ACPI device. One
> problem is that brightness keys on the Matebook X Pro work without this
> patch. This results in reporting two brightness key press
> events one is captured by ACPI and another by this driver.
> 
> A solution would be to check if such event came from the "\AMW0" WMI driver
> then skip reporting event. Another solution would be to leave this to
> user-space to handle. Which can be achieved by using "hwdb" tables and
> remap those keys to "unknown". This solution seems more natural to me
> because it leaves the decision to user-space.
> 
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  drivers/platform/x86/Kconfig      |  16 +++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/huawei-wmi.c | 226 ++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 drivers/platform/x86/huawei-wmi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 87f70e8f4dd0..27db3ce7a1e1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1292,6 +1292,22 @@ config INTEL_ATOMISP2_PM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel_atomisp2_pm.
>  
> +config HUAWEI_WMI
> +	tristate "Huawei WMI hotkeys driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	select INPUT_SPARSEKMAP
> +	select LEDS_CLASS

but LEDS_CLASS is only available if NEW_LEDS is set/enabled, so it either
depends on LEDS_CLASS... or it needs to select NEW_LEDS, which is what other
drivers in this Kconfig file do, even though our b.d. has said a few times
that any one driver should not "select" => enable an entire subsystem,
so they all should be "depends on NEW_LEDS" IMHO.

> +	select LEDS_TRIGGERS
> +	select LEDS_TRIGGER_AUDIO
> +	help
> +	  This driver provides support for Huawei WMI hotkeys.
> +	  It enables the missing keys and adds support to the micmute
> +	  LED found on some of these laptops.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called huawei-wmi.
> +
>  endif # X86_PLATFORM_DEVICES
>  
>  config PMC_ATOM


-- 
~Randy
