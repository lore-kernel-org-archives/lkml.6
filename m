Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EBC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180312081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180312081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJXPoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:44:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39388 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJXPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:44:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id g10-v6so4595893qtq.6;
        Wed, 24 Oct 2018 00:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUfE7UK4/4993o7af1RIjKubupPwwVSdCsKkJD48d7E=;
        b=JaYHMZzmlwxCYJh3XZx9vsQBR70H5CEn9o6eiLxyu/GiOS3J9qaYDUhQC6q9DpROTE
         kz9rQWbkXcf7e6zYyLYNco9LOe/4AjyYt5pvA4W/2p1wOndhEd6OLxRB7G8f/24rpCy5
         DTjKoSCyAxNiNHnVM7/TQRvPsSnekR4vz/HTVOwQdbz+01Gbjz7SMBOCkaXqo4n3rR2n
         ZZasGFJxwteB3ihD5oKE6Kb/SeFJgULtWeO7u36oZLctxpz+Zo1s6OQ3y7edgFgdg4l0
         67gmOw0u30QbSskF58bOv1F1LEhcJP3ppsF7rPSnOp4LfWdmHqMdF4Cm1xWOjKvhr1uM
         QEnQ==
X-Gm-Message-State: AGRZ1gLyJNraU6sNeExjLHukuQkzWlorZ4Rugd1N4HBW7gw8WYxFMIxP
        RiMM3IC5wcGaI2+oj7yjGDu01LiNSb25ILF+EXA=
X-Google-Smtp-Source: AJdET5d8+eEwc+5/FnfOmmTIEwMQlbcl9CvH+sh04lFD6lSEOpOwLfldhzYR1tUXjkGtgOYiFnb7Izn7fSayX8Jxk+k=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr1347874qvl.161.1540365484888;
 Wed, 24 Oct 2018 00:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a1wfeWboHvU1o_kooMc2hML8iWcNrz=mp6tYT52iGwfjw@mail.gmail.com>
 <20181018034117.GD15088@guoren-Inspiron-7460> <CAK8P3a0cFhBE1tX0xisP__MYiBfaAUQHsW6ZhkmTPocRf1Zb6w@mail.gmail.com>
 <20181018085751.GA21934@guoren-Inspiron-7460>
In-Reply-To: <20181018085751.GA21934@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Oct 2018 08:17:47 +0100
Message-ID: <CAK8P3a28SLy85pCq9eS-xnLuFo4XAJmnKCiy0XF9ZZtLxfaUDw@mail.gmail.com>
Subject: Re: [PATCH V9 21/21] csky: support dword access for get_user_size()
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 9:57 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Thu, Oct 18, 2018 at 10:34:00AM +0200, Arnd Bergmann wrote:
> > On Thu, Oct 18, 2018 at 5:41 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > On Wed, Oct 17, 2018 at 05:44:17PM +0200, Arnd Bergmann wrote:
> > > > On Tue, Oct 16, 2018 at 5:33 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > > >
> > > > > Support dword access for get_user_size and redesign put_user_size with
> > > > > the same style of get_user_size. It's Ok to use xxx_user_asm_common for
> > > > > all size of variable with ldb, ldh, ldw, ld.d
> > > > >
> > > > > ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
> > > > > follow abiv2 gcc ABI for dword access.
> > > >
> > > > Are you sure this is correct for this?
> > > >
> > > > static inline u32 get_64_to_32(__u64 __user *p)
> > > > {
> > > >       u32 ret;
> > > >       get_user(ret, p);
> > > >       return ret;
> > > > }
> > > >
> > > > If I read __get_user_asm_common() right, the ld.d would overwrite
> > > > two registers, but the caller only expects one, so it clobbers one
> > > > that might be in use.
> > > Ah... BUG! I only consider the get_user(u64, u64 *) :P
> > >
> > > Change to:
> > > case 8:                                                 \
> > > __get_user_asm_dword((x), ptr, "ld.d", retval);         \
> > > break;
> > >
> > > #define __get_user_asm_dword(x, ptr, err)               \
> > > do {                                                    \
> > >         u64 tmp;                                        \
> > >         __get_user_asm_common(tmp, ptr, "ld.d", err);   \
> > >         x = typeof(x) tmp;                              \
> > > } while(0)
> > >
> > > #define __put_user_asm_dword(x, ptr, err)               \
> > > do {                                                    \
> > >         u64 tmp = (u64) x;                              \
> > >         __put_user_asm_common(tmp, ptr, "st.d", err);   \
> > > } while(0)
> > >
> >
> > I think this will cause warnings for code that passes a pointer.
> >
> > The 64-bit __get_user() is really hard, and most 32-bit architectures don't
> > implement it at all. If you really want to add it, have a look at what
> > x86 and arm do. IIRC they both use __builtin_choose_expr(),
> Thx for the tips and I'll drop the patch first for the upstream.
>
> I want to implement it because of make allmodconfig and
> drivers/android/binder.c need it. I'll learn __builtin_choose_expr()
> and prepare patch next.

I think we should fix binder.c instead. Many other architectures
have the same problem.

          Arnd
