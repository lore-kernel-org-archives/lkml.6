Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4A42080D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dMbu+eAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4A42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbeKMC4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:56:46 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41565 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeKMC4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:56:45 -0500
Received: by mail-yb1-f193.google.com with SMTP id t13-v6so4177511ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FVcxuWarIL5Fi8KrKm+fPIdc/M2E1ZjxmUfxVtTpZTo=;
        b=dMbu+eAJNwYAnGXwyOe/49eKZvOYkokIFhjkRvyrWcsl+voBldB6BXAGLGCqfl+B/0
         Ed1dCuuLu7Qr+YynnhSmGYpnqHIsks7YL8mI9rtQDDw3xdQ3rorcxg4QuTf0DilTEEyP
         XS1MamDevR+Sea3PBMlaJgjBJvh0ubzrOkduc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FVcxuWarIL5Fi8KrKm+fPIdc/M2E1ZjxmUfxVtTpZTo=;
        b=gNSCcB5JUzoW54Ax3DiRYZTxGMYRIsRWzEO4mr8Ttd69HvV1iqVv+w8sMOkdiyK1Y8
         1dPmP+9C35QN2Bo1mNEv7SSwJHaYeMbI2frGhblcLpRBp/+RMiEqjjOBvGzk0TVhIRUI
         E66ssr7JS/GlSahUWggnSJj0w4gLkJLCqAEolxzSi8OoGCOmPhx5go5OSaM/3BrpjLXr
         hI05ZK71UZG7UPDUzu77uUMTSXVLGT2/ojFZvwE6r2iZ6yzw2lefoOcsE96jFD5mb4Vm
         tqVfUemyvYqFt7RfdSmAk6LGtjY25NG+kWaXvQ2ovJXO/i2XtdIV+DDeiltdj2ToSSal
         LHfw==
X-Gm-Message-State: AGRZ1gL2k2A56sqnBJRoSF1FXe/4/+31Dn6mmDTO5VUsXwbhxg1Hvj7D
        fO3yRLNEpiYiPUHUP1OwKgp8bAnfO40=
X-Google-Smtp-Source: AJdET5fSJ+M2kBBTuS+Ju4qjDfUq8mm8d0J+actk44+ebOQPByZ8D07P5lqqu0iVzMOt0C+0VGdmqg==
X-Received: by 2002:a25:6a45:: with SMTP id f66-v6mr1634141ybc.155.1542042158085;
        Mon, 12 Nov 2018 09:02:38 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id l8-v6sm2331399ywl.11.2018.11.12.09.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:02:37 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id p144-v6so4154378yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:02:36 -0800 (PST)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr1755338ybi.141.1542042156215;
 Mon, 12 Nov 2018 09:02:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 09:02:35
 -0800 (PST)
In-Reply-To: <CAK7LNAS8OCO8roYjS8w0_yoUmyUrEZBtnLe_D9y7qNwtGGbNUg@mail.gmail.com>
References: <1541992013-18657-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+Otsyy3g6BotjzAR3Ek1cTd8uspCqcR7-EpqPJ5xHawA@mail.gmail.com> <CAK7LNAS8OCO8roYjS8w0_yoUmyUrEZBtnLe_D9y7qNwtGGbNUg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 12 Nov 2018 11:02:35 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJMYW2wwKCVzHkiSbAkOCdtRboax5oxw6LgdCH7CicTSQ@mail.gmail.com>
Message-ID: <CAGXu5jJMYW2wwKCVzHkiSbAkOCdtRboax5oxw6LgdCH7CicTSQ@mail.gmail.com>
Subject: Re: [PATCH] x86: remove gcc-x86_*-has-stack-protector.sh checks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Joachim <svenjoac@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 7:54 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Mon, Nov 12, 2018 at 5:29 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Sun, Nov 11, 2018 at 9:06 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>> > gcc-x86_64-has-stack-protector.sh was introduced by commit 4f7fd4d7a791
>> > ("[PATCH] Add the -fstack-protector option to the CFLAGS") in 2006
>> > to work around buggy compilers.
>> >
>> > gcc-x86_32-has-stack-protector.sh was introduced by commit 60a5317ff0f4
>> > ("x86: implement x86_32 stack protector"), which did not clearly state
>> > whether compilers were still producing broken code at that time.
>> >
>> > Now, the minimum reuquired GCC version is 4.6, which was released in
>> > 2011. Probably, we can dump these old compiler checks.
>>
>> NAK. We need to keep this because we've seen recent regressions with
>> stack protection (e.g. gcc briefly used global instead of tls for the
>> canary, which silently broke the use of stack protectors). Since the
>> gcc/kernel "API" for the canary is so fragile we need to keep these
>> tests to make sure things end up where they're expected.
>
> Thanks for your feedback.
>
> I did not know this is still fragile even after ten years time.
>
> One more curious thing is, x86 is the only arch ever
> that has had this kind of script check.

Presently, yes -- x86 is the only arch with non-global canaries,
though something may be coming soon for arm64. However, that case may
be more detectable with cc-option. The trouble with gcc was that the
default switched at one point. :(


-- 
Kees Cook
