Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25527C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC9B20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ll3mtLZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC9B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLCXh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:37:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38362 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so13435922otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyDG218rgIFybHNrgDEBPy8enPTdienRTs/e6OpZYIM=;
        b=ll3mtLZECNXKUefz+LfpQ5B5D/vNUCrq0QfjUo1+QwYXO8ZlLA02TEJRKFAe9Yze8D
         3qYgwTY3b3JHiMoltp46atzV4DkoY6hPVuRdLtczeGZ08U0lYba8nn9Gmo3eDXOWjGAL
         eVGPWYARjCOMJorjbuvjemJQjtJ9aW9VrXdudLqvtv5vxi56gwIDBdeIDAAXTaIhrrjF
         kKA25VQ2wd3nFuRmrRgvKBWuhU49+AtI+hsb70U4yrANAOgxoHkGI5c58ZiRi5kAjHI4
         F/QXZOKMoNhOkwIa5ib+OTDcAra/4+4hk6M8jASg0ouDS6HzLbRvWtifd95x0aKUksRh
         uqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyDG218rgIFybHNrgDEBPy8enPTdienRTs/e6OpZYIM=;
        b=SVO2Wm055MPvNt/3OkdaHO8a4+o2Q3q67fApr/fL5kZRfT3PgEXI5CP6FknG4peLeH
         ryhNY41xHZLSI8KiOOPNZWSLf/bv7bh8RyXCnTEEVEBdr9zKz3/kMBeKKNs7U+DWW+sV
         GaBKy5N9Y+ikHc6ZnYbBfTMmptmIzvnWYk2lPWFlDSxhWrdif9JKlpZcECzUiIXdCcIN
         qjKTLECI4hDF9PmkJjAUJBn7+at/VfsZsb/GtMD3N+Jbvp9154u/Ku+J5Rj+rT0O9UsN
         Lrxf2IoLTN8ldwqvz9sk9Dsq6ZktRRITBfBcQuP8yJNFcCDoDOWrb5btf1qd6AyJA6m1
         LXbA==
X-Gm-Message-State: AA+aEWZw5eaKHqrUSPhLqQDVWvRT0Gv6Ao12aPWwm0ltDi/UaolBeAkG
        EOUdyqbzO7RSFI2le/mvRhcTPLgTf5vUml2zZLdpUQ==
X-Google-Smtp-Source: AFSGD/XpCpq8AVR4w7p1WEYMmbFrEiYFQR+RPBSvQCgXoHc5M0n5nRfjJEyok0goCYWQB+ZhYKnqm7AZeUXngqBpepU=
X-Received: by 2002:a9d:966:: with SMTP id 93mr10472193otp.25.1543880244748;
 Mon, 03 Dec 2018 15:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com> <20181130034135.GN18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034135.GN18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:37:13 -0800
Message-ID: <CAFd5g45+1wHteYs5YiL19x=L=g=oab5uJrabdKO8q_jS4-ojbg@mail.gmail.com>
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
To:     mcgrof@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:41 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> > +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> > +{
> > +     current->thread.fault_addr = fault_addr;
> > +     UML_LONGJMP(catcher, 1);
> > +}
>
> Some documentation about what this does exactly would be appreciated.
> With the goal it may be useful to others wanting to consider support
> for other archs -- if that actually ends up being desirable.

Yeah, I should. Should this go in the wrapper around the abort() hack?
Or do you think I should write some documentation on how KUnit works
under Documentation/ ?
