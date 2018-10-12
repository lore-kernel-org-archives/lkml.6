Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AE22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ew3vs3Hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AE22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJLSLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:11:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1702 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:11:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc079d50000>; Fri, 12 Oct 2018 03:39:19 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 03:39:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Oct 2018 03:39:25 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 10:39:16 +0000
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "zonque@gmail.com" <zonque@gmail.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "jmkrzyszt@gmail.com" <jmkrzyszt@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
 <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
Date:   Fri, 12 Oct 2018 11:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539337415.30485.21.camel@toradex.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539340759; bh=Bqvv93oIXApKInDsz6BpPeg5rplgBhk60O8xMd4CQpM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ew3vs3HkiKWa7w67CdxKlhIS2smLbATVOn8/WzhJ5byFydSHgVnewLmDAJg4Vrvnh
         bRZeDJZagyoTBLkQZz5uSCYkBaQtvUJKOny5PKzqTOH7wz9LJ413IZ/2Ly/vJJWK9o
         DzaiWjmXQ8pGLPMVF8ajiByoIaQbaDhr1kMhasHoHmJ40CgVZK1S97+DWncTUlFUog
         i3lEkMzzQdJ3XvRPU/CKVkRNhGCGmepCwnA45WL6jtXMYGwKd0i2+ftFCPUXiqA33A
         mM+IfpX44Yt10rXHEACWUT5h2pKsBUl0tKJ8qhoPRTYq31jpKytT1FHOR32IsVlfmz
         yHxQO5FhTkGIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/18 10:43, Marcel Ziswiler wrote:
> On Thu, 2018-10-11 at 19:47 +0200, Linus Walleij wrote:
>> On Thu, Oct 11, 2018 at 5:34 PM Marcel Ziswiler
>> <marcel.ziswiler@toradex.com> wrote:
>>
>>> I guess that is also what broke HDMI on Apalis/Colibri T30 causing
>>> me
>>> to submit a fix [1]. I may also help testing.
>>
>> I see there are many ways to skin this cat.
> 
> Yes, as a matter of fact I screened the kernel concerning this multi
> gpio stuff but could not quite find many examples and no mentioning
> anywhere whether or not this is actually allowed. So I kind of assumed
> that this may just not really be allowed and cooked up my patch which
> is anyway kind of a cleaner solution. I mean explicitly modelling the
> GPIO into some intermediate regulator supplying the others.

See the function 'regulator_ena_gpio_request()', it states that the same
GPIO pin can be shared among regulators.

We had the same situation for Tegra124 Jetson TK1 but I don't think that
adding a pseudo intermediate regulator is cleaner. If the GPIO controls
more than one regulator, I don't see why is it necessary to change the
DT. There are several other people reporting the same problem with
various different boards. So this does seem to be a common usage.

Cheers
Jon

-- 
nvpublic
