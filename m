Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE40C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421B620831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Hj1j3snd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421B620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJXTJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:09:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18303 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJXTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:09:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd04c520002>; Wed, 24 Oct 2018 03:41:22 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Oct 2018 03:41:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Oct 2018 03:41:32 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 24 Oct
 2018 10:41:30 +0000
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
        <stable@vger.kernel.org>
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
 <20181022095257.GD4014@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <38d9adb7-8a1a-3169-5401-f353a190f9c7@nvidia.com>
Date:   Wed, 24 Oct 2018 11:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022095257.GD4014@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540377682; bh=YlMD+oal1eunp4ZsnQn3UuQKsJNF2LuRwDgS8c4SMKk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Hj1j3sndxAs5SQLDdf1zJwaFih+Oc/QgAcL+XadYFpJp0RnNo2LfpC5UmebDj2NBw
         J4/BtW996fCKn4bnupndbie/bRLna+mnaY8H88rVLyBAOz59p/N9kXOxmsUZdzYonC
         2+ASFZK2tIsGjfijzn2TsXuvs3YUQSYdmxI7/idewzdGONIYL8g0CKnuiRK0oTLTT4
         ykrxVjFjdLlQ2PAMEJqqpBgcbeX/pjQnreP8m6x3+I2JAKU6ZaGcL7swhPvKiW0p5q
         oqCvGx1TJ7iO9rchSQDnHsU7l5TZBO3nanJeAkF91WXI4K6IrfVEnMF6jhO+mXNOwv
         XUD3VlqDVII6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/10/2018 10:52, Thierry Reding wrote:
> On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>
>> The tps6586x driver creates an irqchip that is used by its various child
>> devices for managing interrupts. The tps6586x-rtc device is one of its
>> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
>> a wake-up device from suspend, the following is seen:
>>
>>  PM: Syncing filesystems ... done.
>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>  OOM killer disabled.
>>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>  Disabling non-boot CPUs ...
>>  Entering suspend state LP1
>>  Enabling non-boot CPUs ...
>>  CPU1 is up
>>  tps6586x 3-0034: failed to read interrupt status
>>  tps6586x 3-0034: failed to read interrupt status
>>
>> The reason why the tps6586x interrupt status cannot be read is because
>> the tps6586x interrupt is not masked during suspend and when the
>> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
>> seen before the i2c controller has been resumed in order to read the
>> tps6586x interrupt status.
>>
>> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
>> suspend, which gets propagated to the parent tps6586x interrupt.
>> However, the tps6586x-rtc driver cannot disable it's interrupt during
>> suspend otherwise we would never be woken up and so the tps6586x must
>> disable it's interrupt instead.
>>
>> Prevent the tps6586x interrupt handler from executing on exiting suspend
>> before the i2c controller has been resumed by disabling the tps6586x
>> interrupt on entering suspend and re-enabling it on resuming from
>> suspend.
>>
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
> 
> So does this mean that the SPI interrupt for the PMIC can still be a
> wakeup source even if it is masked? This is slightly odd because now
> you're saying that this does work while it doesn't work for the RTC
> interrupt. So is this an implementation quirk of the LIC/GIC on Tegra
> which doesn't extend to the TPS6586x? Or am I missing something?

No it is not a quirk for the Tegra LIC/GIC, it is purely an issue with
the PMIC driver and this issue could occur on other platforms not just
Tegra.

During suspend, we want the PMIC's host interrupt to be masked in the
LIC/GIC level, but the wake-up for this interrupt to be enabled in the
LIC. Currently, the wake-up is enabled in the LIC, but the interrupt is
not being masked in the LIC/GIC which is the problem.

If the RTC interrupt within the PMIC is disabled, then the PMIC
generates no interrupt to the host (ie. Tegra) on an alarm. The PMIC
interrupt controller only has an interrupt mask for the various
interrupt sources within the PMIC. Therefore, if the RTC is
enabled/in-use we should never mask its interrupt within the PMIC.

Once the PMIC has been suspended, then it makes sense to disable its
interrupt, because it cannot be service until it has been resumed,
implying that I2C controller (ie. its parent) has also been resumed.

Cheers
Jon

-- 
nvpublic
