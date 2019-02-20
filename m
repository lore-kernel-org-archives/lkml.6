Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C676C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16302146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzfFlIir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfBTDjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:39:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46280 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfBTDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:39:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so16335075otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 19:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8vhQ3tmgzBOdGYD4wICZoCDzu7fbBenNd993tJCq28=;
        b=nzfFlIirguGhBPx/5W3M/bUq7OLn4F7BPMf3izt5IwZIb8WdeaUlMr9mMcM5bn9uwn
         DwrAo/qVqQED75HENHT/fAxZFMfR7rJFn8pbv899AkEv3E5a4EDJVJ5IB0Bq5u8wdVP9
         KXOkMtfeANKDhE/XX4Jv6h5nLEi1KFA/rcDszChNkF3bsxNg8d/u/xmpXFWW9bWUXEe4
         ZTWPBWlyn5pVjVkUDiWOFQlNsL5x+GrhsT5Nzp15/br/xXnTOYRX/DqbCojao7l0x58n
         1ahUDlvfpr1577Dj31Jmhe7OutOIxAGh83aGppTy641NALWfdzr2wmsnC/3td/GpcrjV
         9pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8vhQ3tmgzBOdGYD4wICZoCDzu7fbBenNd993tJCq28=;
        b=RHnKBy1OOOfRS9e9y4l192OMxMYHxtZmf8c5p4hYb/9YpOpkfDXFT6F7Stj22SbomF
         9WXgtqyRCyCKO5tQuFKPi9AHNu6cyDzK5pdNINTQ5HhcPzC7uwDejUD+BjNFF7fhhP4I
         NQIWJJM2/0oNFQosIcUEgnCg7MPUBeVLMPKzoCn99ZpaNgwmJJ9/I4zvxpE6HDNqtHgZ
         AsdUBkOK0/sBiQQO2yjzPTnc5rqwGjaj+ewPoTlcvtOJ7FYxekje/Rd47UJyNCeQNXq6
         4g8jgpsgkY/FBaHdmM3UCHPPTybZ4VtDHRepy0TuAPa65iSzu0AUMK8DANNTQh49no5O
         ezOQ==
X-Gm-Message-State: AHQUAuaTd7Xj+dY6oQ2ElKWQjp1bAa1Mu5KFR3wNZWig1BeTi5YiHEb8
        PC94XFzh/ZhxKYUuod1vDXuWeUSxjUR+S4OCVYFlCA==
X-Google-Smtp-Source: AHgI3IbgVa4T8R0rpHkw/jyV3QJngj6njTl/fZ17hmHgz4dIFE6NaAf5gkm3S/LNJB6dGzUmCgC0uH95U1VGjFwe2sQ=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr20546463otp.364.1550633970534;
 Tue, 19 Feb 2019 19:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
In-Reply-To: <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Feb 2019 19:39:19 -0800
Message-ID: <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> > Add support for aborting/bailing out of test cases. Needed for
> > implementing assertions.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> > Changes Since Last Version
> >  - This patch is new introducing a new cross-architecture way to abort
> >    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
> >    details).
> >  - On a side note, this is not a complete replacement for the UML abort
> >    mechanism, but covers the majority of necessary functionality. UML
> >    architecture specific featurs have been dropped from the initial
> >    patchset.
> > ---
> >  include/kunit/test.h |  24 +++++
> >  kunit/Makefile       |   3 +-
> >  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
> >  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
> >  4 files changed, 353 insertions(+), 9 deletions(-)
> >  create mode 100644 kunit/test-test.c
>
> < snip >
>
> > diff --git a/kunit/test.c b/kunit/test.c
> > index d18c50d5ed671..6e5244642ab07 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -6,9 +6,9 @@
> >   * Author: Brendan Higgins <brendanhiggins@google.com>
> >   */
> >
> > -#include <linux/sched.h>
> >  #include <linux/sched/debug.h>
> > -#include <os.h>
> > +#include <linux/completion.h>
> > +#include <linux/kthread.h>
> >  #include <kunit/test.h>
> >
> >  static bool kunit_get_success(struct kunit *test)
> > @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
> >       spin_unlock_irqrestore(&test->lock, flags);
> >  }
> >
> > +static bool kunit_get_death_test(struct kunit *test)
> > +{
> > +     unsigned long flags;
> > +     bool death_test;
> > +
> > +     spin_lock_irqsave(&test->lock, flags);
> > +     death_test = test->death_test;
> > +     spin_unlock_irqrestore(&test->lock, flags);
> > +
> > +     return death_test;
> > +}
> > +
> > +static void kunit_set_death_test(struct kunit *test, bool death_test)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&test->lock, flags);
> > +     test->death_test = death_test;
> > +     spin_unlock_irqrestore(&test->lock, flags);
> > +}
> > +
> >  static int kunit_vprintk_emit(const struct kunit *test,
> >                             int level,
> >                             const char *fmt,
> > @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
> >       stream->commit(stream);
> >  }
> >
> > +static void __noreturn kunit_abort(struct kunit *test)
> > +{
> > +     kunit_set_death_test(test, true);
> > +
> > +     test->try_catch.throw(&test->try_catch);
> > +
> > +     /*
> > +      * Throw could not abort from test.
> > +      */
> > +     kunit_err(test, "Throw could not abort from test!");
> > +     show_stack(NULL, NULL);
> > +     BUG();
>
> kunit_abort() is what will be call as the result of an assert failure.

Yep. Does that need clarified somewhere?

>
> BUG(), which is a panic, which is crashing the system is not acceptable
> in the Linux kernel.  You will just annoy Linus if you submit this.

Sorry, I thought this was an acceptable use case since, a) this should
never be compiled in a production kernel, b) we are in a pretty bad,
unpredictable state if we get here and keep going. I think you might
have said elsewhere that you think "a" is not valid? In any case, I
can replace this with a WARN, would that be acceptable?
