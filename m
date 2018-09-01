Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042DC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1822B20837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2uCmjqt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1822B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIBApi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeIBApi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:45:38 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C1920843
        for <linux-kernel@vger.kernel.org>; Sat,  1 Sep 2018 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535833950;
        bh=mcCInMwE+RcKAtqp4f7g/o+m2GdTLajIZ/OZ+4/8aJc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2uCmjqt7A8rNqIvumkENn/XQBTJ/xmEWqCjSZ/tIqTLdsIaV5q6PGg15X9KtDnWqI
         wc9dlEfL1zClBN0Gk/EDbWqrADgBBCvKL+ERi4Af1PHzM49HFPijtHeOABUyLBTS4s
         ScOSeUxEmAxG9QN6vMliJ1jyB9CRl70Ws8rJHW1U=
Received: by mail-wm0-f54.google.com with SMTP id c14-v6so8074011wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 13:32:30 -0700 (PDT)
X-Gm-Message-State: APzg51AKJp8nVF9bIvY+P9Vx/dtqOfXlEto2LKlxvSCGKpFyL+uPd3hI
        P0wCDrIU43jfREE2VbP+LzOMmapMGEMiy2AUvX5kag==
X-Google-Smtp-Source: ANB0Vdbi99IOlDZ371gvygDUTAI/XCJsABIXSOWysnxqoE0pyg/zIzJ7nZT4gtHYrpLdh8rfrQxX+CTMsPli/AmWrNo=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr1448236wma.21.1535833948761;
 Sat, 01 Sep 2018 13:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 13:32:08 -0700 (PDT)
In-Reply-To: <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
 <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de> <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 1 Sep 2018 13:32:08 -0700
X-Gmail-Original-Message-ID: <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
Message-ID: <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 1:19 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey Thomas,
>
> I'd like to move ahead with my patchset and make some forward progress
> in LKML submission. If you've got something brewing regarding the FPU
> context on x86 and ARM, I'm happy to wait a bit longer so as to build
> on that. But if that is instead a far-off theoretical eventual thing,
> perhaps it's better for me to move ahead as planned, and we can switch
> to the superior FPU semantics whenever you get around to it? Either
> way, please let me know what you have in mind so our plans can stay
> somewhat sync'd.

I tend to think the right approach is to merge Jason's code and then
make it better later.  Even with a totally perfect lazy FPU restore
implementation on x86, we'll probably still need some way of dealing
with SIMD contexts.  I think we're highly unlikely to ever a allow
SIMD usage in all NMI contexts, for example, and there will always be
cases where we specifically don't want to use all available SIMD
capabilities even if we can.  For example, generating random numbers
does crypto, but we probably don't want to do *SIMD* crypto, since
that will force a save and restore and will probably fire up the
AVX512 unit, and that's not worth it unless we're already using it for
some other reason.

Also, as Rik has discovered, lazy FPU restore is conceptually
straightforward but isn't entirely trivial :)

--Andy
