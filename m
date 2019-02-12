Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C54AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD4B222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCfFjWCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfBLWjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:39:18 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41334 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfBLWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:39:17 -0500
Received: by mail-ua1-f68.google.com with SMTP id z24so118799ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFMKNvnJ3kQYFBT3u+6m2xpocwP0rFyQ6m2jTIkI53g=;
        b=fCfFjWCVZvK//Azw02gHCq2Wf+TZyzQo67PjdK4cZacIFv71S2Z88FtQXX3fKTBpKP
         09egXjQE+WgB9m24FrKqUeXC9Wmv7R1TozcnA7aWOgsJazvsA8JJftiYgf64Zajp4I0D
         vPdV4Vxq+YQkzTFZITS1EP8feXnIFOX9/9N+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFMKNvnJ3kQYFBT3u+6m2xpocwP0rFyQ6m2jTIkI53g=;
        b=S2743z2EhdVFjm8rEeKnRMeMJ2hCvW/n0Q+ZBRdRGbQDKP3tKALceJVa1Fl0+Y/Qn0
         buZDwQUL6lLjCxyrwJQu9H3/zvlI7zhGQaj9asz6L3FMPodO7MLHzKo1vWIOWElG+r6d
         rBfpCChQ2F0j9elfAVirKlDX9nzHauxuAF2hDLEHCbo65JRVATLanXVQL9JRrulQvnsW
         c3Ep914nvolI6scxunVZDV+uDNOFfqkxG5T2U0/XRuWogDYmHKjn6FFYDcab2+oyXthR
         RA6BQyALR3M1IE3tUvOElDmEJQZmfYO4olR9tCW8ZR+SUh7xY3D7zaqgQT9NeFc6Xg7E
         Kqfw==
X-Gm-Message-State: AHQUAuZnYBW7wAjsz3fbOk0sw3g+JEKSa+7D/cfKHXA7fuk2b+QWaxCl
        j6YbBX5FzpLWR8tX+Yf3jEBG1pQ78cc=
X-Google-Smtp-Source: AHgI3IbFbHWAwRE2af1pS2UPlDdgUxvaPgJ7APjgNXAzQHaN/JNn2r/CcDSlI24gvY8WI7qBeqM0Xg==
X-Received: by 2002:ab0:6995:: with SMTP id t21mr2468263uaq.124.1550011155391;
        Tue, 12 Feb 2019 14:39:15 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id o8sm2676373vsd.27.2019.02.12.14.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:39:14 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id e10so246577vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 14:39:14 -0800 (PST)
X-Received: by 2002:a67:eb4a:: with SMTP id x10mr2523974vso.172.1550011153602;
 Tue, 12 Feb 2019 14:39:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549927666.git.igor.stoppa@huawei.com> <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
 <25bf3c63-c54c-f7ea-bec1-996a2c05d997@gmail.com> <CAGXu5jLqmYRUVLb7-jPsN4onO5UNH+D6qOF=9TOiVjJa-=DnZQ@mail.gmail.com>
 <CAH2bzCRZ5xYOT0R8piqZx4mSGj1_8fNG=Ce4UU8i6F7mYD9m9Q@mail.gmail.com>
 <CAGXu5jLRJZuWjnwEuK=7AMeCrj-eioVGksPL9dE9pbzHM=+Rmg@mail.gmail.com> <29cd9541-9af2-fc1c-c264-f4cb9c29349a@gmail.com>
In-Reply-To: <29cd9541-9af2-fc1c-c264-f4cb9c29349a@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 14:39:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJyWb7aTJpDfBPD3GqMmNaJVT0pajdrPV93xnLoOa=0Vw@mail.gmail.com>
Message-ID: <CAGXu5jJyWb7aTJpDfBPD3GqMmNaJVT0pajdrPV93xnLoOa=0Vw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/12] hardening: statically allocated protected memory
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
> wr_assign() does just that.
>
> However, reading again your previous mails, I realize that I might have
> misinterpreted what you were suggesting.
>
> If the advice is to have also a default memset_user() which relies on
> put_user(), but do not activate the feature by default for every
> architecture, I definitely agree that it would be good to have it.
> I just didn't think about it before.

Yeah, I just mean you could have an arch-agnostic memset_user() implementation.

> But I now realize that most likely you were just suggesting to have
> full, albeit inefficient default support and then let various archs
> review/enhance it. I can certainly do this.

Right.

> Regarding testing I have a question: how much can/should I lean on qemu?
> In most cases the MMU might not need to be fully emulated, so I wonder
> how well qemu-based testing can ensure that real life scenarios will work.

I think qemu lets you know if it works (kvm is using the real MMU),
and baremetal will give you more stable performance numbers.

-- 
Kees Cook
