Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F322C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1F42147D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bls8IzGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1F42147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeI0AO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:14:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33097 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeI0AO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:14:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so13840751pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uXIwahuaS+t2PQbti3lmHWJPn0xFUyZCUXsmrWQpQL4=;
        b=bls8IzGM9J8y0J2ofAzIk4TQT+VpiYHiNgWBuhhZwVqiO6mFPe8zEq5Sk36j+Tsvo0
         gCV8oox0Ea2SXLM2/sq1OM3T/zI8lXILhEcFblSHexqT5UaiOBOHWHd2DyQsRKOrStt7
         2Ng+aIZPjDDbg33f5922IG5tpEVFoWf8TNm9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXIwahuaS+t2PQbti3lmHWJPn0xFUyZCUXsmrWQpQL4=;
        b=ZxCJtwMNP5nv9hBtTwz6RDcQEd6TdJxYxCJ5ObC+adDrbGH5tc07W/GFGzhE2dDop4
         UuehCcGqsX2MoXQaGqdYxJjJ5RkDOF4hjBW7Rrz95qFRND5NLqmjgGClVSkKfNB+LnoK
         0ODkxlYCvTUcfcO1n3xgtKWOwTrPTEwpQIpJG5PcSCYzFlSzrB9e3XMM6waHyrpt9SUb
         F0GVPjL9R9ICz/0BBSaRmoY+9kLCkGfw6BRQ5eGaczPteGSImjPiTXEBvTjnjcmbyPI5
         cVo0QHgEz2ScvCfN6XgSTV5MIxCTPBoIO/FZZ0f+7DNDQQQcre5eUId/9fGNV5Ajj/8t
         Iepg==
X-Gm-Message-State: ABuFfoiKbTzSl6ZcnHCwtFbww/7jSuj0Ijr6FJLzIDASx2OOUwQkwJoH
        ieVfv9L4e0O9muwDAw6jDjde/g==
X-Google-Smtp-Source: ACcGV63nfdMhzeowuIATub8X4L2uV19LEKKm9uJ8GTPiQqj9TBBH6wtpOmiATY+XLV11rJFITJ8Vgw==
X-Received: by 2002:a62:d286:: with SMTP id c128-v6mr6096876pfg.14.1537984820679;
        Wed, 26 Sep 2018 11:00:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a15-v6sm9516778pfe.32.2018.09.26.11.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:00:19 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:00:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        daniel.santos@pobox.com, Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Message-ID: <20180926180019.GD22824@google.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
 <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 09:46:02AM -0700, Nick Desaulniers wrote:
> On Tue, Aug 28, 2018 at 4:00 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
> > >
> > > Hello Nick,
> > >
> > > On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> > > >>> Let's give up __compiletime_assert_fallback().  This commit does not
> > > >>> change the current behavior since it just rips off the useless code.
> > > >> Clang is not the only target audience of
> > > >> __compiletime_assert_fallback().  Instead of ripping out something that
> > > >> may benefit builds with gcc 4.2 and earlier, why not override its
> > > > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> > > > version to 4.6") that gcc < 4.6 is irrelevant.
> > >
> > > Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
> > > I guess I would be OK with its removal, but I still think it would be
> > > better if a similar mechanism to break the Clang build could be found.
> >
> > I'm consulting with our best language lawyers to see what combinations
> > of _Static_assert and __builtin_constant_p would do the trick.
> 
> Linus,
> Can this patch be merged in the meantime?

friendly ping :)

With c5c2b11894f4 ("drm/i915: Warn against variable length arrays")
clang raises plenty of vla warnings about
__compiletime_error_fallback() in the i915 driver. Would be great to
get rid of those without having to revert that commit.
