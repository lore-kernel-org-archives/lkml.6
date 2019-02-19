Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628DF20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfBSVu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:50:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40766 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfBSVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:50:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so25013504qta.7;
        Tue, 19 Feb 2019 13:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIi7SP097NI+Jlwck32jTDyccHzIjGksX74kWJWHo74=;
        b=jH3fLkQv2cxM060yIGgK2dDacyh5cVgaPJAVrlYxbMfjFN9ddKyuM444vb4+8buLpP
         2ZebQd1T4fIl7fPN2RDlcMxUHL4m6ybhkODcJtMrxllMj7V64AnHQ/chc8eAO80Uo0K9
         HTopYcTxFEwpGFTOTGHRdo3ewZYGc9F0oe0rN7a+DQJzEeuq4pmJ3rwCXIbE9CM5p9VG
         WYxfcr56zPKMcFossGRL9JL8jOuJxXSCB1N68pz4i0Cu/RKwDBExn1D0c4EIJZ2ksPs8
         kxOhlWkZ85XliLTvtAZrTr2Pm8jI9zH/wx/3NGJs0Lj0JbWjK7EeEJk9cUyJ8e0JIn90
         LPAQ==
X-Gm-Message-State: AHQUAubjNXM5J2YJr0wObUFnC9xFT3p2OU3dCeHLW/+Orqg28BFDtCsP
        J6ZidZQzDH99RMDjkog+ACPx7zhOFjodOxDYnlU=
X-Google-Smtp-Source: AHgI3IaIXAhmsVOjy1GbExfulk/EFs8bUQapPwAdAYu9gx3oJgkRcC0vWmUwdmnyiuuubjQNzURkAt5YMB/n24+IYdc=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr10223640qtb.343.1550613056004;
 Tue, 19 Feb 2019 13:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20190108025420.GA26093@flashbox>
In-Reply-To: <20190108025420.GA26093@flashbox>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 22:50:39 +0100
Message-ID: <CAK8P3a1Urc1tunFcd5vXybRpBGQ7tBVm5BC6qu3oEXM0C_NG4g@mail.gmail.com>
Subject: Re: Clang warnings in net/phonet
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:55 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> When building the kernel with Clang, this warning comes up in net/phonet.
>
> net/phonet/pep.c:224:16: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
>         ph->data[0] = oph->data[1]; /* CTRL id */
>                       ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
>
> I have taken a look at the effected code but I can't really figure out
> the proper fix for this warning (my knowledge of C just isn't there
> yet). Nick had suggested changing 'u8 data[1]' to 'u8 *data' in
> 'struct pnpipehdr', which seems logical but I can't say for sure. Any
> advice would be appreciated :)
>

A pointer wouldn't work here, as this is a network header with a
fixed layout. Using a flexible array at the end of the structure works,
but unfortunately all indices change that way. Sending an experimental
patch.

     Arnd
