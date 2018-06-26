Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86606C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6FE26BFC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VaRPdpq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6FE26BFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965859AbeFZOLb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:11:31 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:9181 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965824AbeFZOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:11:28 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5QE9whF028784;
        Tue, 26 Jun 2018 09:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530022198;
        bh=riXaUQ0RWX88tr4TCDYpoWoyFN9Ihs6kvucDot5Lwr8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VaRPdpq8BH7Mu8eJRNUm1bfTNzLTbHfiG4QQm+cVufoqoWSY+NeXGNAwkPzbZv3u4
         WpBQnzhuEz4rE4f/tgbhADoE5KokB4nUWtxIdIu+ouZ5gr3lJHDhWfuYnpdi34PU8g
         zPGmCq4cWVxobfKlJLInrKJPEEd+hlttqlqXwIlo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5QE9wGI030836;
        Tue, 26 Jun 2018 09:09:58 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 26
 Jun 2018 09:09:57 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 26 Jun 2018 09:09:57 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5QE9iqC031944;
        Tue, 26 Jun 2018 09:09:44 -0500
Subject: Re: [PATCH v2 10/10] i2c: remove i2c_lock_adapter and use
 i2c_lock_bus directly
To:     Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-integrity@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-11-peda@axentia.se>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <4e0545e3-fee9-cf29-bae1-e442347e3cb8@ti.com>
Date:   Tue, 26 Jun 2018 19:39:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620051803.12206-11-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2018 10:48 AM, Peter Rosin wrote:
> The i2c_lock_adapter name is ambiguous since it is unclear if it
> refers to the root adapter or the adapter you name in the argument.
> The natural interpretation is the adapter you name in the argument,
> but there are historical reasons for that not being the case; it
> in fact locks the root adapter. Just remove the function and force
> users to spell out the I2C_LOCK_ROOT_ADAPTER name to indicate what
> is really going on. Also remove i2c_unlock_adapter, of course.
> 
> This patch was generated with
> 
> git grep -l 'i2c_\(un\)\?lock_adapter' \
> | xargs sed -i 's/i2c_\(un\)\?lock_adapter(\([^)]*\))/'\
> 'i2c_\1lock_bus(\2, I2C_LOCK_ROOT_ADAPTER)/g'
> 
> followed by white-space touch-up.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-brcmstb.c   |  8 ++++----
>  drivers/i2c/busses/i2c-davinci.c   |  4 ++--

On DM644x and DA850 EVMs applying this series does not seem to break I2C
functionality. So:

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
