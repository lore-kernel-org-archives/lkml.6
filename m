Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA126C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBCF20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O5NHFOAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBCF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeJLR5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:57:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4477 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:57:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc076930000>; Fri, 12 Oct 2018 03:25:23 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 03:25:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 03:25:34 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 10:25:29 +0000
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        <linux-tegra@vger.kernel.org>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
 <CACRpkda+J6R99SQP9yFVH2HANJSi3M4GjT0duaHdv8wZcs7ahQ@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <71e2a853-2f44-e2db-8e43-dcde9f6864db@nvidia.com>
Date:   Fri, 12 Oct 2018 11:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkda+J6R99SQP9yFVH2HANJSi3M4GjT0duaHdv8wZcs7ahQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539339923; bh=KfCmdG19v/38Sn1HBhFExrHSIrvKcIPdDPlDQ2ITMAE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=O5NHFOAXjuN5SY1uY0vCmzhFLjCEaxU4/0DBZboFP8MEIJ37a1aAgsn8FfkVNsHp2
         /vPW/frDLa6aHz60dNTdtJSVYNJtz7jc2zsygILAO1OyxGF2bIJBAamAw8EjGebEOP
         b6ssmrh7A7q13tXND5xXG1tRIDeh5caKCrGhKKwnWiV4jOYM6fY5i1uQYKV8jXhI0N
         0xCMVjvNkfLqxvPlrvMVvPpKcv7RlYug9Syx081jXUcU/RuIPJdUxZiN4oXqnPVvxN
         Se5TaaOtjUk/IR7DhOXzFSOzDb/47HoYotpJzLPvOXIRw0A51rsNvANGITpjmVbf5Y
         N0lrZSxpbomYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 11/10/18 18:45, Linus Walleij wrote:
> Hi Jon,
> 
> On Thu, Oct 11, 2018 at 5:00 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> 
>> This also appears to be causing a regression on the Tegra124 Jetson TK1
>> that also uses a shared GPIO for two regulators. The 2nd regulator that
>> uses the GPIO now fails to probe [0] ...
>>
>> [    0.680021] +5V_SATA: supplied by +5V_SYS
>> [    0.683964] reg-fixed-voltage: probe of regulators:regulator@14 failed with error -16
>>
>> Not sure if you have one of these, but otherwise I can help test.
> 
> Would be great if you could test the patch I came up with for Marek:
> https://marc.info/?l=linux-kernel&m=153926854327176&w=2

Yes works for me! I will respond to your actual patch as well with
tested-by.

Cheers
Jon

-- 
nvpublic
