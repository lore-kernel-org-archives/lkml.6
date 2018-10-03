Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93277C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D12082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gUVhg7hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3D12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJCVAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:00:51 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44687 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeJCVAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:00:51 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 95ffe199;
        Wed, 3 Oct 2018 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=EpRT7R1fjgUa9iyAIGy9csfYLMw=; b=gUVhg7
        hykKqTANF2xVPovnkHe1bJ+Ii5fD0F0V0S2FxbcdexwCqEXpQObVSv3acykd/Ky7
        Hyb88SHqBG2irBYsbQdnRle3+ZFnQ45RlGCgHiIbQ8SNUyPW2JWlu9dSrRuAj3QM
        Em/ffRXDMf1Yx5TCJJkgVgT31HcKPwUiS4TNq2vLewUy6UeoWg2tOps66X2FT0E4
        s7d+WuKJdBitanZ3BgcMq0wlgt3fR6HdL7O0oVIYeNXq1cnQLyzM12HFYG4RhPU8
        pFwusg4OdvR0GTkXCqdqHjllH2ShlDpZ5gHlLqGjw1yBdW3esqtcXd9gDXGHLJpv
        IgrRtJpuEpNbU1vA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54e3eef3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 14:12:05 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id w81-v6so4604237oiw.9;
        Wed, 03 Oct 2018 07:12:16 -0700 (PDT)
X-Gm-Message-State: ABuFfojHBZgnQ9SUPm+DVZnYK9+L/xzGsNOP8TXZO78OxXE52R2Pq6nv
        5fdjFXgR62rxfrhSizICr8FVaZvy6cmBi9dD6WM=
X-Google-Smtp-Source: ACcGV63Yr+8oj/wG2+B4knM/8SgQ8wNIweI86ST6/sQYMasT2iMbr3mYvgYh3VWs5/IOVTqQXlM7XChc1YR/vYCraH8=
X-Received: by 2002:aca:b256:: with SMTP id b83-v6mr811430oif.235.1538575935594;
 Wed, 03 Oct 2018 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <CAKv+Gu-oCH4D_otvMk+R_6z_p73Le90PkdQUUPnT6q0kWVL4Jw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-oCH4D_otvMk+R_6z_p73Le90PkdQUUPnT6q0kWVL4Jw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 16:12:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9rWkLT=92QVhbYZd1oee5wYtVRnYu0BGHkGn3bXjN-OxQ@mail.gmail.com>
Message-ID: <CAHmME9rWkLT=92QVhbYZd1oee5wYtVRnYu0BGHkGn3bXjN-OxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Oct 3, 2018 at 1:15 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > +config WIREGUARD
> > +       tristate "WireGuard secure network tunnel"
> > +       depends on NET && INET
>
> I think you need to add IPV6 here

Nope. Like much of the net tree, WireGuard can function on ipv6-less
kernels. If you do find something in WireGuard isn't working in a
v6-less configuration, I consider that to be a bug that needs fixing.

Jason
