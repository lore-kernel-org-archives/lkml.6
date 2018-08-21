Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06CDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605C72183D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dCmbA1jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605C72183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeHUW0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:26:17 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36470 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeHUW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:26:17 -0400
Received: by mail-yw1-f65.google.com with SMTP id w202-v6so2431320yww.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WIVOPBqjzJaK2vcDq0BM+iWm6htld8vMomalx81vGP4=;
        b=dCmbA1jzBCGAcBTZJEUBOS6spz6tWSycPLmQsDK6w0WjJ9t101KtCgm/tIBILcaQp3
         Kod8RFibaZo/NM3BP31R/RVI95eo4jYjxHRqoQz0a4n/0nxp/uPFQiAFstqoWlWiAbYo
         8HFErENP179R8gMOi/oAvTv7sjTfSSQy6IuNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WIVOPBqjzJaK2vcDq0BM+iWm6htld8vMomalx81vGP4=;
        b=Hsx/On5f26Rti0AqPyo1pYNaBuGcAefPGAR5AMesKrbNUsQsx/x5HS3qlvGrdvcexf
         GML5BnlpdsgM5Xt/sgTgevxVam4wGDKwpgIGgiQAiqZU3m418is0MxMURHRbXhUozIL8
         3DMrOGQ+iA1q0r1+t3qka/S9RTX5eJ3sor3e74J+3QmI1Cxz2CRgLrEmz2IsWuWb3zDf
         0KA0fCTMQUpoNnbdF7I7bbkbf1KmnPtaBDdjTBsK7IVVSLvQXx33oMBB5I7llwzNM3Xx
         vdRvqkfqtgiRpshgr+R6XJ0NocVayI6p9Fn/P3mH1OEJ25qG8CNO8GCThUxWkPkkxtbJ
         dczg==
X-Gm-Message-State: AOUpUlHec0+Wuw5mb865rFcI/Ws5hhv+77M2+Ii/02K2OmTvEfhlMNJW
        eo7brD9yn3GlcsYvHEQqxybkga+b/CI=
X-Google-Smtp-Source: AA+uWPyxmU3rH1AAcL2H7rQ69vNEdoi4DKc+0lpN33fyNXFnnf+h41iPyON9TAK9iK12shyNdCgsbw==
X-Received: by 2002:a0d:e387:: with SMTP id m129-v6mr27166304ywe.315.1534878294472;
        Tue, 21 Aug 2018 12:04:54 -0700 (PDT)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com. [209.85.213.179])
        by smtp.gmail.com with ESMTPSA id e134-v6sm11904719ywa.59.2018.08.21.12.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:04:52 -0700 (PDT)
Received: by mail-yb0-f179.google.com with SMTP id l16-v6so6375305ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:04:51 -0700 (PDT)
X-Received: by 2002:a25:1345:: with SMTP id 66-v6mr15741549ybt.171.1534878291456;
 Tue, 21 Aug 2018 12:04:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 12:04:50
 -0700 (PDT)
In-Reply-To: <CAK7LNAQeY1kHxPpGgLfP=GUZ7nB6DQy3mYsMzLduUagGAB=OXQ@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com> <CAK7LNAQeY1kHxPpGgLfP=GUZ7nB6DQy3mYsMzLduUagGAB=OXQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 21 Aug 2018 12:04:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+g97kaCimRd1euRdFNg1aNQFoaVV7V6PBPOA0P51=3xg@mail.gmail.com>
Message-ID: <CAGXu5j+g97kaCimRd1euRdFNg1aNQFoaVV7V6PBPOA0P51=3xg@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Joe Stringer <joe@ovn.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        George Burgess <gbiv@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 9:15 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>> Note that there are a few definitions of BUILD_BUG_ON that still use
>> this negative array size trick.  Should that pattern be removed from
>> them as well?  See:
>> * arch/x86/boot/boot.h#L33
>> * include/linux/build_bug.h#L66
>> * tools/include/linux/kernel.h#L38
>
> At this moment, -Wvla is the warning-3 level
> in scripts/Makefile.extrawarn.

We're down to a handful of VLA uses, but I don't think the negative
cases should matter since they're _intended_ to break a compile.

-Kees

-- 
Kees Cook
Pixel Security
