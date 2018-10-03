Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825BAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7482098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JtWGHLSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7482098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJCVRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:17:48 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:50825 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeJCVRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:17:47 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b073a586;
        Wed, 3 Oct 2018 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=dqbOT3zL3DZVUEWXddhcf5Yx03o=; b=JtWGHL
        Sk9w0PDGhOi9POLOym6J9nHggVaJxM7UNZmFPkBMEuWj8h3lDIR0BZpjohB3PLwH
        uLU4IUqiCRambu4OcFVOdjy83HOw0KWaWoL5EW24RkexGQIg/qZR0wSD8gzVF5DC
        IB1h9i+7ZEKd/ef1PM4P6H+l/TnhWoEOjnGid2jagI4rfU++wYHLTpZA6OurBQsi
        SIFrtjsdIdyB3h0p8ABfk8qcaRlBzYV6jg79SAf11W+lr5NYHHWWh2eBUcLjjf8r
        bz4HmNgUqGqmgXN3EBDL1PshsD0nh4DR28xI7cyYi1MIcp2ZbYu9oHyPZSILCR3v
        LJ+X7f77+CbJXNAw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 610629c6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 14:28:57 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id i12-v6so5773223otl.1;
        Wed, 03 Oct 2018 07:29:08 -0700 (PDT)
X-Gm-Message-State: ABuFfog0isBxNt0Gt0LmUXZJwXX6ibjpyZXuTavf6E+jRIaW+mFol0WJ
        K+k2YUgRLNsWkfYOeTinQfb17E9f4VNVNDsegm4=
X-Google-Smtp-Source: ACcGV62JB0Um99eQWEU2NAlXlke4wefcolvvvnshaYveIiZbvOPySIcc6XGzP6f3X29BfHPQ8V59jRdeTDikUQ+Zi1U=
X-Received: by 2002:a9d:42c3:: with SMTP id c3-v6mr1029862otj.54.1538576947660;
 Wed, 03 Oct 2018 07:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <CAKv+Gu-oCH4D_otvMk+R_6z_p73Le90PkdQUUPnT6q0kWVL4Jw@mail.gmail.com>
 <CAHmME9rWkLT=92QVhbYZd1oee5wYtVRnYu0BGHkGn3bXjN-OxQ@mail.gmail.com>
 <CAKv+Gu9dOLbiBYKp9HG+GSPML0OJ-UuXnGsJO_re2S75ZF_qNA@mail.gmail.com> <CAKv+Gu-d07eqZTzh04dTtCjpnG-0fKsh7=k9BQYW_bx0Ju6gDw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-d07eqZTzh04dTtCjpnG-0fKsh7=k9BQYW_bx0Ju6gDw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 16:28:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9pQn3TJtwKuna=qrgm5Sc4sXN2VYEYXkGyKePezkQGu+Q@mail.gmail.com>
Message-ID: <CAHmME9pQn3TJtwKuna=qrgm5Sc4sXN2VYEYXkGyKePezkQGu+Q@mail.gmail.com>
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

On Wed, Oct 3, 2018 at 4:25 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> On Wed, Oct 3, 2018 at 1:15 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>> > +config WIREGUARD
> >>> > +       tristate "WireGuard secure network tunnel"
> >>> > +       depends on NET && INET
> >>>
> >>> I think you need to add IPV6 here
> >>
> >> Nope. Like much of the net tree, WireGuard can function on ipv6-less
> >> kernels. If you do find something in WireGuard isn't working in a
> >> v6-less configuration, I consider that to be a bug that needs fixing.
> >>
> >
> > OK. I hit a build error yesterday, and setting CONFIG_IPV6 fixed it.
> > Let me see if I can reproduce.
>
> I get
>
> drivers/net/wireguard/socket.o: In function `send6':
> socket.c:(.text+0x56c): undefined reference to `ipv6_chk_addr'
> drivers/net/wireguard/socket.o: In function `wg_socket_send_skb_to_peer':
> socket.c:(.text+0x904): undefined reference to `ipv6_chk_addr'
> drivers/net/wireguard/socket.o: In function `wg_socket_init':
> socket.c:(.text+0x161c): undefined reference to `ipv6_mod_enabled'
>
> if I build my kernel with WireGuard built in but IPv6 support enabled
> as a module.

Nice catch. Looks like the norm is adding "depends on IPV6 || !IPV6"
or the like. I'll play and make sure this works for v7. Thanks for
pointing it out.

Jason
