Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30794C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CB32087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XPe1rB0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CB32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJKW17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:27:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5220 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKW17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:27:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbf65850000>; Thu, 11 Oct 2018 08:00:21 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Oct 2018 08:00:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Oct 2018 08:00:26 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Oct
 2018 15:00:22 +0000
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
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
        linux-tegra <linux-tegra@vger.kernel.org>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
Date:   Thu, 11 Oct 2018 16:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539270021; bh=yulZ6WpRxcx9tdz/Joqw9RtVXaMU62yVBp3RP3uhvVQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XPe1rB0gEWOJ68DovNua67OZcfE0OLYVPFUnAowHrYMAFDYL6JJKbLliXwy5nXk5q
         vkSWjtvwQgqh60ROOY2ioZw9rjFFneoQtUoPiUTauOtHa4QDCPJxECkTTVv33TUsL8
         YX7Jx9ZObD1B6O9bInPtB1QPE28GkocuAGJjD/wtdf4HbMWqBLvpCi2bdbTzFW5S34
         DB4qqc2AclSy25/7f5DFBSes93RPtsM2W2aguzZsgkWMOvwkj2ovZv75lSHiPjG0Ua
         wXTqvunhMfJxKThWXVsPRBuZG8jx+23QRyUu5YMplOBYnzkwULnQcwogtbw7/PW4vY
         VdTxt1jJY/ORA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 11/10/18 10:29, Linus Walleij wrote:
> On Thu, Oct 11, 2018 at 11:01 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> 
>> I've just noticed that this patch causes regression on Samsung
>> Exynos4412-based Trats2 board. Conversion to GPIO descriptor breaks
>> operation when regulators used shared GPIO:  sii9234 i2c driver
>> is not able to get vcc33mhl regulator (it uses shared GPIO enable
>> line with vsil12 regulator).
> 
> So I guess this means that this physical GPIO line will enable the
> vcc33mhl and the vsil12 regulators at the same time?
> 
>> This issue has been already pointed in case of commits:
>> 37fa23dbccbd97663acc085bd79246f427e603a1
>> d1dae72fab2c377ff463742eefd8ac0f9e99b7b9
>> ab4d11e2c2329cf7cb7be31ff22489aae4dee5dc
> 
> A big sorry for my ignorance, I guess the information overload
> on the mailing list just makes me miss the important points.
> I'll try to be better, sadly I constantly fail to keep everything
> in mind and constantly break things like this.
> 
>> Maybe it would be better to first solve the handling of shared enable
>> GPIO in the descriptor-based interface before converting more regulators
>> and stepping into this issue again?
> 
> I am trying to solve it, but I just don't have systems to reproduce all
> kinds of things. It's a bit stressful since this is one of those runtime
> things that is hard to test when devising a patch for systems I don't
> have.

This also appears to be causing a regression on the Tegra124 Jetson TK1
that also uses a shared GPIO for two regulators. The 2nd regulator that
uses the GPIO now fails to probe [0] ...

[    0.680021] +5V_SATA: supplied by +5V_SYS
[    0.683964] reg-fixed-voltage: probe of regulators:regulator@14 failed with error -16

Not sure if you have one of these, but otherwise I can help test.

Cheers
Jon

[0] https://storage.kernelci.org/next/master/next-20181011/arm/tegra_defconfig/lab-baylibre-seattle/boot-tegra124-jetson-tk1.html 

-- 
nvpublic
