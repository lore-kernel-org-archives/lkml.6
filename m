Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA73C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA772085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hDlApqZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA772085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeKEUns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:43:48 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12382 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeKEUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:43:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be028780000>; Mon, 05 Nov 2018 03:24:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Nov 2018 03:24:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Nov 2018 03:24:32 -0800
Received: from [10.26.11.240] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 11:24:31 +0000
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, <stable@vger.kernel.org>
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4f636dde-674a-1793-7798-c475065615a1@nvidia.com>
Date:   Mon, 5 Nov 2018 11:24:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541417081; bh=Tc+9oZJ/by89gKxVGsJAa60VltBsE9XWTu+J/pKSPP4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hDlApqZslu5lVrM04PNBbRmsUUKkNXlBSCTeEebIDhEqGQbBezEz5AVuYrBAm0Ddu
         Z791f9PWqSgvDjUWqk0K07N9vFXVE9ZMO6oU921x1fh8eHBfiEjN5KZMMahqvDvWnj
         aYfDXG2pyJ4PjD0b5rXAjHYPnXSev5Dh/BoINQJLaX/p5ICWTpO7gOfK3+bBSVZrwd
         IdxiyQGWukjANcq1q06uRWSFPLyHchnc8UcKu//qZQUlLlODz5/yTjrFghUbwqdvqR
         rInLag0PY1J+FUWKZy0WLlVFaeBE1KuPDmmuoLqeU0t3NM6PZD2Lw8GSWag3733MD+
         LKOputUcDRQ5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 19/10/2018 14:22, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> The tps6586x driver creates an irqchip that is used by its various child
> devices for managing interrupts. The tps6586x-rtc device is one of its
> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
> a wake-up device from suspend, the following is seen:
> 
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>  Disabling non-boot CPUs ...Hi 
>  Entering suspend state LP1
>  Enabling non-boot CPUs ...
>  CPU1 is up
>  tps6586x 3-0034: failed to read interrupt status
>  tps6586x 3-0034: failed to read interrupt status
> 
> The reason why the tps6586x interrupt status cannot be read is because
> the tps6586x interrupt is not masked during suspend and when the
> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
> seen before the i2c controller has been resumed in order to read the
> tps6586x interrupt status.
> 
> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
> suspend, which gets propagated to the parent tps6586x interrupt.
> However, the tps6586x-rtc driver cannot disable it's interrupt during
> suspend otherwise we would never be woken up and so the tps6586x must
> disable it's interrupt instead.
> 
> Prevent the tps6586x interrupt handler from executing on exiting suspend
> before the i2c controller has been resumed by disabling the tps6586x
> interrupt on entering suspend and re-enabling it on resuming from
> suspend.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Thierry and Dmitry have acked/reviewed this, let me know if you have any
comments.

Cheers
Jon

-- 
nvpublic
