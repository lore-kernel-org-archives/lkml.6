Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCFBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4417420857
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfA1R1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:27:23 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43393 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbfA1R1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:27:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so19099059qtj.10;
        Mon, 28 Jan 2019 09:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3eq4OeQiNL7g3hPaDevVdHlvfxoXgsQ3jv6q1rW2zo=;
        b=PJphdu0Qww5URtayjCM7Hto6N9lcv3CjW+wM4ivTqtPecdqUPm+0kYieL/JuTj8/Ux
         9I9W5mZgdryKatQjDVyyd9ePXCshw5bVRNhSBJXge/liOUoU1BBmhBe1Ie2gLhVkZUE5
         IrZVe+lLFAKRI/ELf3iTi9oTE4Nc6UHoIRko/9/SDnMrTMQPr7q1EZts7GGCc86usOBM
         UfFv63z4g1v6V7ZvSryoC8CZEYiqXR3SRRBYX6gSXJFTOMF/X+YvmWrTcJ+egsOsFQfE
         k+Wb8J7zpTwnLyNe4PJhek44zjhjx158emfpE8P/Cpp/NYsyFS28PEjYMyetBoPC5roI
         8bpg==
X-Gm-Message-State: AJcUukcB8A2yGz4JvmTJ9rEj6jWbmGpzp2hBgnvcZzjQV+ec+nWzTj3g
        4q+7BNnmXl/OoPuDZ7ogJVaGRWF8j4mJzAM2z0U=
X-Google-Smtp-Source: ALg8bN5SrsmMrjmQ9p9bl0cDHfPjup6VJ/WykMG29RJe4V66d5pzkYyoX9OKz0DL7eslgKCiJrRrPAQwjq/pgSTSqcQ=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr21272039qtm.96.1548696441239;
 Mon, 28 Jan 2019 09:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20190128154341.47195-1-sashal@kernel.org> <20190128154341.47195-175-sashal@kernel.org>
 <CAK8P3a3z8tOxz=Rem6N7m_0_8OaU9Sxf7yViZJP5fmYGeaxUvQ@mail.gmail.com> <20190128172111.GD3973@sasha-vm>
In-Reply-To: <20190128172111.GD3973@sasha-vm>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Jan 2019 18:27:04 +0100
Message-ID: <CAK8P3a1GM+kdKeiidy60PugWQYHRA=JzZ22vs_mMY6LZdbBn0g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.20 175/304] ARM: mmp: fix timer_init calls
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 6:21 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Mon, Jan 28, 2019 at 05:41:55PM +0100, Arnd Bergmann wrote:
> >On Mon, Jan 28, 2019 at 4:52 PM Sasha Levin <sashal@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> [ Upstream commit 12d3a30db4a3b3df5fbadf5974b9cf50544a9950 ]
> >>
> >> The change to passing the timer frequency as a function argument
> >> was a good idea, but caused a build failure for one user that
> >> was missed in the update:
> >>
> >> arch/arm/mach-mmp/time.c: In function 'mmp_dt_init_timer':
> >> arch/arm/mach-mmp/time.c:242:2: error: implicit declaration of function 'timer_init'; did you mean 'hrtimer_init'? [-Werror=implicit-function-declaration]
> >>
> >> Change that as well to fix the build error, and rename the
> >> function to put it into a proper namespace and make it clearer
> >> what is actually going on.
> >>
> >> I saw that the high 6500000 HZ frequency was previously only
> >> set with CONFIG_MMP2, but is now also used with MMP (pxa910),
> >> so I'm changing that back here. Please make sure that the
> >> frequencies are all correct now.
> >>
> >> Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Olof Johansson <olof@lixom.net>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >I did not think that Lubumir's patch was meant for stable,
> >but as you've picked that one already we clearly
> >want mine as well, so this is good for all stable kernels.
>
> I can drop both if you'd prefer that (they're both in this series).

I'd say let's keep them, unless Lubomir prefers to have them dropped.

      Arnd
