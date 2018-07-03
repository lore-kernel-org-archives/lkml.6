Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322ECC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063B24943
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsZCEM4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D063B24943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934415AbeGCSGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:06:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43182 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934303AbeGCSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:06:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so5615986oib.10;
        Tue, 03 Jul 2018 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HOvxpIamCfWrqb3veb62sXsqUcVco5DGkrCxX8iHI08=;
        b=hsZCEM4z6ChxX9KRTJv5nbdWmrKHNYSOlQfAUaATmNuCVCKmtAVIald1/CMnB+pGqO
         KfhrvgbhTY+/ix1iKeaOsi4csACrQCb/nZo6SlbOsOZgDCo+b80Ee4ejl32+Cx9zFiN/
         D3kIPVhvEKGn9WpRgScsqovZ4GzQkYatnSkbmZS3ipqeKDFuSRtrpunI4mZdlqGt5fIo
         QIWP3EKC4KL4nIaDeUTWn+CYKvI+a7pJ3irRcvmhHnT0xd/bxqfAwZPcDHMjt4Wzqv6L
         +H0Z5fUBPyVhCoEUFXQpZRcvGOb+lzTXBqqOHoP6Fq4vEiFi45HvRipQnnAsWte50rkT
         ftFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HOvxpIamCfWrqb3veb62sXsqUcVco5DGkrCxX8iHI08=;
        b=Ia9QZ6bKUUvBo1FaEDlK0WA2ymUYhHjqS3An2XAhdvO0NEMKSAuVcz8cafboTlpEPY
         EM33wPcGLN0+EqjOenurMxbeQ2W7Ads/yVqkmRjYUE+e+EcFSQyhZrafpbyVcR91pGh9
         D9D/PPX5gVvOANcdkeyPm3LSlGrPLFw6g+pSogEt3NYEfoXw026o9/kx2FHbl5MBjglU
         h0NGFrovoPA1665F6Hw51mIaUMe83xPPstI8uWmAiwvgPHP7n8c8bYOceumzEM63H6IS
         d1Z/ZTl6OWEstsKQwe+0aV9RgXtg/v5MGjWX1MbRdrvXgjnzqlWgqdphht4xMsWWRfBD
         xr+A==
X-Gm-Message-State: APt69E22Iu+/bhMK5kBKQV9ZNazTCP0Rc3rxEi1BPLspi1ZO567ujlSx
        mxTTx1njn7UqTsLAZh70jqfmnhazLjNWRKDrVBc=
X-Google-Smtp-Source: AAOMgpdPnTHgil6457E52YnhnPUj/gTQqSAloPoD+1rJu0nSTmxVBH2OSDNiohQRHc/zVQ5tZO6pT4ktRGoYVoPVpWQ=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr23290752oif.9.1530641181462;
 Tue, 03 Jul 2018 11:06:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:06:21 -0700 (PDT)
In-Reply-To: <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com> <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 15:06:21 -0300
Message-ID: <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On Tue, Jul 3, 2018 at 3:01 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Besides that, it looks like we are hitting an undefined instruction. So
> my best guess is that we are somehow now calling a proper 64bit read
> when we should be calling two 32-bit reads.

Yes, it seems that's the case.

> Fabio, can you send your configuration?

This is a imx6 board built with arch/arm/configs/imx_v6_v7_defconfig

Thanks
