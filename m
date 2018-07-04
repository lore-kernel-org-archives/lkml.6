Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF560C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D89D21887
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvWMALNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D89D21887
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeGDAGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:06:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46985 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeGDAGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:06:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so7315731oie.13;
        Tue, 03 Jul 2018 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zLgK9b+YDHme6ZjuO6j3WhxCO230LNovQwhgJnc5YUs=;
        b=cvWMALNQdfAA5p8/ykA2PLU4wr8ofHUg3ICAnjPUQIaE3YVlxZBaXgFu88+ZBFwB2x
         K0tYYpmYcjilkN2oNVXYx9WKjSaMowa4XVlJIbNGPzOVFpyuscwmX+v0pT72a72meivP
         9etu9uotdIU7y+iX6o3pIhhBwxDSaUu77lolvH1PTxa7Mw9Oor76M4NJwBEUEYVG6vKx
         FknsMNxjNQDhOUD2u10jOBYaNeLDDU8AYOeOe3YeHL2GKeLrjOhUKkQyxusvK3o9y1GZ
         CATDAhmXGJJYV60NNPj/wZtzI6M+lonuDSSqRvt7RQhbRL2PT2fhSRaxdiVud7T+yRLK
         l6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zLgK9b+YDHme6ZjuO6j3WhxCO230LNovQwhgJnc5YUs=;
        b=Scn+z9tyLB9WoMVZv45bUtz44/SWC0JI7EgGhq7WgLSET6cqlfYgpNmGaoeYb1R/Gq
         iFmNFd3rA72nplEiwrQlRbc758E7L2q6vx532qWxoYwLWB9AEghbK+sK/VLRhS7FsLwt
         z3iDXzDPKnirUYCmUKlhFzZnHPlets1/5Ll3rUAckAA5FwmcEtroxWELK9z6MDQWDYxV
         1kb83XXLNrcAg/k/ROno9VFmFJIe8NaqbXzUNf4+VcZlwPc+hM+b92bsYizvj3BkgoQr
         GEIYZsdpELtSTSCyEArqR/dUVt2tJ6fHWKviPgiOP0meNybecUDtcrNkaoP/NkV/o+rd
         lTmw==
X-Gm-Message-State: APt69E1wYUq/r276k24WIgxOUY+5juHpifwoXUCRaYjAXPV0fqa10wLb
        grkwD8+b7W4hsMjMc0ET9uzipLH+pjZ+tINDCrE=
X-Google-Smtp-Source: AAOMgpfoeoOba+IQoU0NK/PybKopOuOePDnw9eIgiCUcXVY7Po/+r3GhimdoLabtxknLKpgcul4AyPvlvD01p1wdLa8=
X-Received: by 2002:aca:3ac6:: with SMTP id h189-v6mr24341661oia.336.1530662789935;
 Tue, 03 Jul 2018 17:06:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 17:06:29 -0700 (PDT)
In-Reply-To: <6d8df4be-a2da-5ddb-3b13-ca47d903ac80@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com> <6d8df4be-a2da-5ddb-3b13-ca47d903ac80@deltatee.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 21:06:29 -0300
Message-ID: <CAOMZO5CPPZ0mmmZYct7wTWnd=psZqLNP1B3UVnMhrEWD9E7JbQ@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 9:02 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Actually, scratch that: try this patch as I forgot the read side on the
> previous one.

Yes, this fixes the boot regression, thanks!

You can add:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
