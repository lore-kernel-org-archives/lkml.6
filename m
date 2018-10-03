Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DC7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D94820684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="FcSVKPjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D94820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJCOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:37:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33796 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeJCOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:37:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id x23-v6so4939207qtr.1;
        Wed, 03 Oct 2018 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0DuBfrTnfQCiyuMwCJZZ3CnYAFbgXosdK8G7lLtCDQ=;
        b=FcSVKPjvo+41ArJUhTph0/YbGs+njhFP2RsRWfIwvl/eNBaLL7hUaN/5Y/kHh/xCqP
         Oa/ryGGFx325Tt4f5b4mUiyChyfD7VOUaRGHN+naxPtOZLxeNYhsmGSvIJodHcfkQgbr
         bGFTTcJr8EN5tXsLHduz0314UQoDAhCsL9KcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0DuBfrTnfQCiyuMwCJZZ3CnYAFbgXosdK8G7lLtCDQ=;
        b=VN3owQQ/nHU32mBBFpBDMKcPXpFTd0E25Q1O3Ga61InELJUMnVTsIONGuD4wmX19ct
         9avHC+qOAzeYMKSAcEHNirHCBZaAflNH37WmrI+dax/WbUkraqOPT9BreuPUTwBMr994
         yQtRdhN/1HYDwDZSN+8OyMpuWY8Ia2z9lK6qP1G2qyyfoDtofXHM5oQ47Z96OeRsh3zV
         yXVlhjW6uQpI2Z570whwPM24rFebJFHdNC7DdZQVaIV+lC3uxuTXzudyeZczwTANhbQC
         +iaFWqLDdGg1JhSF4EGPRfVmsEunJLiDnuDnkAnWCNQLZ5ktg8rpM/8eQxSC4FucgInW
         SnTw==
X-Gm-Message-State: ABuFfogEtD5TZ45gHF5MLf7/PBrrhUmfSfj9iZJbFABj4udR84zfsUdr
        aLcb3WIUF8fKN3KfTmoVnXU/fgyFG3sdq5zCEac=
X-Google-Smtp-Source: ACcGV62smntijufm1xMOhQTmPSjD6t65hLUHwJRBSbty48oML6aocL876NiDvTV26XReumK2b8Lg/MneH5b1mKBD6Fc=
X-Received: by 2002:ac8:4145:: with SMTP id e5-v6mr211383qtm.330.1538552994425;
 Wed, 03 Oct 2018 00:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com> <20181001202748.8030-3-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20181001202748.8030-3-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 3 Oct 2018 09:49:41 +0200
Message-ID: <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
Subject: Re: [PATCH i2c-next v4 2/3] i2c: aspeed: Add 'timeout' DT property
 reading code
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jae,

On Mon, 1 Oct 2018 at 22:28, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds reading code of the 'timeout' DT property to set
> bus timeout value in adapter configuration. This value still
> can be configured through an I2C_TIMEOUT ioctl on cdev too.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 8dc9161ced38..6d31f54a6653 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -885,6 +885,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         struct clk *parent_clk;
>         struct resource *res;
>         int irq, ret;
> +       u32 timeout_ms;
>
>         bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>         if (!bus)
> @@ -918,6 +919,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>                 bus->bus_frequency = 100000;
>         }
>
> +       ret = of_property_read_u32(pdev->dev.of_node, "timeout",
> +                                  &timeout_ms);
> +       if (ret)
> +               timeout_ms = 0; /* then adap.timeout will be set by i2c-core */

Is it possible to implement the parsing of this property in the i2c
core instead?
