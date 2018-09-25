Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524CCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C16206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jgjo+irO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C16206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeIZCim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:38:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44745 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeIZCil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:38:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so11990393pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLac7W9XSIdIZvwEVVVIPybCjtF8p3/rR3qvGrXzqBU=;
        b=Jgjo+irO4EMLQV5V0x3KsIYhUylO/Y0+Jc5BtabAveYhYkkF9fdRH3o7ZQmkiPPfCm
         wxShG04aOvqNygcggllO9MdZwyWHus0jOT9aioPerZQ1YVqvBIkAcQXjzwKpAuc09EfM
         uXAvXaa2oNOrCcR3V/Uo0terHlcRYsalw8iGOCPpTjx0S/9cy8rcwYuxkEw86jUf1xwu
         lbMCoBU+L0ZbamjGvY+U0ZnLUkVl67eHy6Z1YNVaGXfM1KaYN7vkfuRrRaTHxVn5SNJ9
         lhnq+gEBf85eIfEsHAKGrrswTcnxdN5q6/4mtohXEssGpRZ6tDyLzgG/WGT49OGqwblL
         LF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLac7W9XSIdIZvwEVVVIPybCjtF8p3/rR3qvGrXzqBU=;
        b=kn5bbu1ZVY37YTJkQZS1qXEYZrZjXhx4vKyyWuSRSQuuvDJ3AdNXun/6jUKVURSr6y
         BwmrTfTntiVWV6aeO0Jtv7wtme9VKYeDthVXL++85e7sZvKIFUSMivZXDSEPAbQLi5i+
         iu4rAqPrBNpKu9BJXwuJnXsoTf9vZoLQX4hoD9T0XlfGCOW3mPKf+u1ziuG4n0xVy4Qk
         ahRmA/GNpSj3a5ocXsjh9TecOxp33PRF6ontG1Z5oRku7AnRoyIJ0Uc/MUa3PDUN3TZE
         E+eP2I/QreU642wKGWri21MWxwL4SJD/0QsJ2Z6oArxwv1tDPYb98ni/rpJk01duo4yF
         pvZg==
X-Gm-Message-State: ABuFfohm2C6lTvqltPTT1m9KwHTqdpuUS6Pe4hTjJo5E2DnVDkwT20i3
        MFRc55p/izvHttAmBuFOY3TMxf7f95PwahzvNH0dROdM4ak=
X-Google-Smtp-Source: ACcGV61lka7hVqXrWZh940lrzeTdztba7Nnofebtil33mKNoqCPlXl4xj9Nho4AgLD8xquahPuP773a4DZtEQZoPGx0=
X-Received: by 2002:a62:1895:: with SMTP id 143-v6mr2679648pfy.227.1537907362918;
 Tue, 25 Sep 2018 13:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180925194459.13088-1-natechancellor@gmail.com> <CAKwvOdnzN0E0HD--3GmC9b=20fx3AE-8-x0iZ04-LEXnxh=YoQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnzN0E0HD--3GmC9b=20fx3AE-8-x0iZ04-LEXnxh=YoQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Sep 2018 13:29:11 -0700
Message-ID: <CAKwvOdnAhh-nKtbD9Fvxuf3AGcQVS0L6cGsEr3odZiDZ+eZk6w@mail.gmail.com>
Subject: Re: [PATCH] arm64: percpu: Initialize ret in the default case
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dennis@kernel.org, tj@kernel.org, Christoph Lameter <cl@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, psodagud@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 25, 2018 at 12:45 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns that if the default case is taken, ret will be
> > uninitialized.
> >
> > ./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
> > uninitialized whenever switch default is taken
> > [-Wsometimes-uninitialized]
> >         default:
> >         ^~~~~~~
> > ./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
> > here
> >         return ret;
> >                ^~~
> > ./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
> > 'ret' to silence this warning
> >         unsigned long ret, loop;
> >                          ^
> >                           = 0
> >
> > This warning appears several times while building the erofs filesystem.
> > While it's not strictly wrong, the BUILD_BUG will prevent this from
> > becoming a true problem. Initialize ret to 0 in the default case right
> > before the BUILD_BUG to silence all of these warnings.
>
> Clang does semantic analysis BEFORE inlining/optimizations, so I can't

s/I/it/

> determine that default is never reachable.  Nathan, thanks for this
> patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/arm64/include/asm/percpu.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> > index 9234013e759e..21a81b59a0cc 100644
> > --- a/arch/arm64/include/asm/percpu.h
> > +++ b/arch/arm64/include/asm/percpu.h
> > @@ -96,6 +96,7 @@ static inline unsigned long __percpu_##op(void *ptr,                  \
> >                 : [val] "Ir" (val));                                    \
> >                 break;                                                  \
> >         default:                                                        \
> > +               ret = 0;                                                \
> >                 BUILD_BUG();                                            \
> >         }                                                               \
> >                                                                         \
> > @@ -125,6 +126,7 @@ static inline unsigned long __percpu_read(void *ptr, int size)
> >                 ret = READ_ONCE(*(u64 *)ptr);
> >                 break;
> >         default:
> > +               ret = 0;
> >                 BUILD_BUG();
> >         }
> >
> > @@ -194,6 +196,7 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
> >                 : [val] "r" (val));
> >                 break;
> >         default:
> > +               ret = 0;
> >                 BUILD_BUG();
> >         }
> >
> > --
> > 2.19.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
