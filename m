Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE85C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBF12177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfBSKPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:15:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44988 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfBSKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:15:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id r21so11656003qkl.11;
        Tue, 19 Feb 2019 02:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAC4AK+RjhxM05uPzc8fsZ90roIyu/l8gl2LuQDW5oQ=;
        b=hEuyis55hF0btZM62w1hPxMIf5notK7yDF9mNCXX7n8OuQBTVnFyU8aQYbjrFNevKf
         qLEXe2Jz1DwgypwGsrnTdsLuRes6rlbLT0ULT0fZLrLvvG/vYSqtKICGGLKuktsXS1EA
         z2879CVarM5XnlpUw87gFFz2nZWdWw2StN+FGzPJAnlCEbdFi/Ddbq1afVy/R4ZKaGgR
         Km9RRzB12sNx6OHia1TFTKYULj+wCpbfT6eJBoG/yR4c2m/uGUOElS88z7Ypm1CFPa1o
         R8LsTSSntgx8GiI//LwbP3ye2YRjk9+P14d5GDrHs2G+sx5dV/yP2CS9s/OW6nzGAeFV
         PWbA==
X-Gm-Message-State: AHQUAubXKnvOXChTs9q7gpQzN624HsYTX/RE7gUEdIQVnc+BhU5QAkSj
        IZISzo5jXPtppOqwX9LnzV6DBF7yReBtsdsPIUar+w==
X-Google-Smtp-Source: AHgI3IYiJNIVnlYFI3XAjp/vPobzcLP/8A/q3QPLhpKiPJBOTaHHfWcVEwW944fcwNf7CNQlUVXz+Io/pDH2mr5yeBs=
X-Received: by 2002:a37:d492:: with SMTP id s18mr18968561qks.343.1550571300759;
 Tue, 19 Feb 2019 02:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20190219173654.47e9bc36@canb.auug.org.au> <20190219074519.GA2294@behemoth.owl.eu.com.local>
In-Reply-To: <20190219074519.GA2294@behemoth.owl.eu.com.local>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 11:14:44 +0100
Message-ID: <CAK8P3a0omA-__7MLAw_SKuug_GZ0FfFPVr1Tsnx5Hb0sesv8gw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:45 AM Hugo Lefeuvre <hle@owl.eu.com> wrote:
>
> Hi Stephen, Arnd,
>
> > After merging the asm-generic tree, today's linux-next build (powerpc
> > allnoconfig) failed like this:
> > ...
> > Caused by commit
> >
> >   8e074c243ed3 ("iomap: add missing const to ioread*/iowrite addr arg")
>
> I have prepared a patch addressing this issue, and am currently building it
> with a powerpc cross compiler. I'll submit it once it's done. Please tell
> me if I should update the initial patch instead.
>
> > The const qualifiers are also missing in:
> >
> > arch/parisc/lib/iomap.c
> > arch/sh/kernel/iomap.c
>
> I also have patches for these architectures, but it is more complicated for
> me to test them with a cross compiler. Should I still submit them?

I'm not sending a pull request for this if it breaks any architectures,
so I think we need to fix them all, and I suppose we also have to
change all architectures in the same patch that changes the architecture
independent declaration, so it doesn't break intermittently.

At this point, I'd probably drop your patches from my asm-generic
tree  entirely to avoid the regression, and wait for you to resend
them all after 5.1-rc1, for inclusion in 5.2.

Can you elaborate on the original problem that you saw? Maybe
we can have a different workaround for it in the meantime.

     Arnd
