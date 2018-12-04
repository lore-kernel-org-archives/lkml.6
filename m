Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB348C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB7120850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uERg4bFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB7120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLDAOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:14:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39172 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:14:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so12696085oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxU7iuvpMz5tJ+jdeGB6M6X1XxTpbvLdXpAKxVq3j7s=;
        b=uERg4bFg80VH9bBb5HhJVr4KGpcuk1qGB0kNpsoMojmKaA+M1PRJ6ggtW4IDpmceW4
         8J6Lnz97IwlTASa9Kss1/adGr59u2JqHa/uNXs6IBQOHtTSbbLBaNB986e4mtUYLxVhK
         nMro95mBWMCgVjaJizLNmfSaTXD2NOTReuUWc8PZwA8hfNQ1fzFfWlPo5T688+lzCN4h
         S+Jse5JXlqm6NuTeoc6SQB7t63viHjYIH7Q7Htybvui3+7zvzd69t5DeXEAC1Ln2jbAK
         Wg05/jEXH5LUZO6445ucqX/srKp+lYwoYS2f0q4AxztZKwwEUuQcbIXh5bkYAtBDAqsZ
         eObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxU7iuvpMz5tJ+jdeGB6M6X1XxTpbvLdXpAKxVq3j7s=;
        b=n/+CqXsg84fX+KnpO6HTEDU4yuM6W+qTygoWOT+rcq7ordEVMutvs6KPXjJnAf3D9C
         NEZwnRkIqNAGhwSaE4BvCMkLmlvxntYZQ2GpLXPGshUMGXm4XlggYnuPdiBqTpFSJ2mv
         a3BMSgQIcSYxkgeBwwUgFd/lG5rlAfsb2stsvMY/4Q/5GfvfLSbBwUZuFQrv+k/XSrhH
         W4KGe/CwmfAafADnHjztBjCPqQXyhlz7DlLIeJlkgnXSC79+ZrnXmkEC6dD0E2Tetdrx
         1YWeuhVT3RecR3Q25LNpRYk335cwwuJzezat/YYHzJexHQ53r+HoMheewpgP9HC1Haiq
         Pkag==
X-Gm-Message-State: AA+aEWa4viUO59Xv/1ogiRqCoZQw4j02PKhxi6vEBn1IbJoCHEDvmvo6
        9iyCWWfyVr0V+vjkqPy0tKfhfX3hsxmtiVd9zHJHbg==
X-Google-Smtp-Source: AFSGD/WH6cIrBDliz/3s1IEr1z66AfTarDU1D+9xmF/tgJd6G3TTbWGp1FF/Tb+yHiGvJyBxug6jcBWfC1NguQRvfOY=
X-Received: by 2002:a54:440d:: with SMTP id k13mr9148355oiw.263.1543882449083;
 Mon, 03 Dec 2018 16:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org>
In-Reply-To: <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 16:13:58 -0800
Message-ID: <CAFd5g475RK9v9X4qxmXwuHiPMOs05WrZAw6EJWNdVoAHQWguFQ@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 4:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/28/18 12:56 PM, Rob Herring wrote:
> >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> >> index ad3fcad4d75b8..f309399deac20 100644
> >> --- a/drivers/of/Kconfig
> >> +++ b/drivers/of/Kconfig
> >> @@ -15,6 +15,7 @@ if OF
> >>  config OF_UNITTEST
> >>         bool "Device Tree runtime unit tests"
> >>         depends on !SPARC
> >> +       depends on KUNIT
> > Unless KUNIT has depends, better to be a select here.
>
> That's just style or taste.  I would prefer to use depends
> instead of select, but that's also just my preference.

I prefer depends too, but Rob is the maintainer here.
