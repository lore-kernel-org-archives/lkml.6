Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FABE20850
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYwsLxUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FABE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeGOJtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeGOJtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:49:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2175D20850;
        Sun, 15 Jul 2018 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531646848;
        bh=eY6RCS7I30DhoUHp7yldf682bWL1C1NChS0BxfDdWMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FYwsLxUy9GfaAmccc8lZuljuQz5gDihBY4VmJeYMgBpARJ6NxgO9WHL/ed7RBbmpo
         Dg4r5INbLRpr5P1YifjgpaqdoYy6HgTB38p5cnjzLgGhgeCccerktlsfI/jl6Qoe+x
         7fNqgkVkI1RNrv1Lwq8Gdzb2CAYf2BOs7gjh8AXM=
Date:   Sun, 15 Jul 2018 10:27:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Randy Dunlap <rdunlap@infradead.org>, david@fromorbit.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, willy@infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
Message-ID: <20180715102722.71fe618e@archlinux>
In-Reply-To: <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
References: <20180710144737.1136856-1-arnd@arndb.de>
        <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 09:24:52 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Jul 10, 2018 at 4:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > As Dave Chinner points out, we don't have a proper documentation for the
> > ktime_get() family of interfaces, making it rather unclear which of the
> > over 30 (!) interfaces one should actually use in a driver or elsewhere
> > in the kernel.
> >
> > I wrote up an explanation from how I personally see the interfaces,
> > documenting what each of the functions do and hopefully making it a bit
> > clearer which should be used where.
> >
> > This is the first time I tried writing .rst format documentation, so
> > in addition to any mistakes in the content, I probably also introduce
> > nonstandard formatting ;-)
> >
> > I first tried to add an extra section to
> > Documentation/timers/timekeeping.txt, but this is currently not included
> > in the generated API, and it seems useful to have the API docs as part
> > of what gets generated in
> > https://www.kernel.org/doc/html/latest/core-api/index.html#core-utilities
> > instead, so I started a new file there.
> >
> > I also considered adding the documentation inline in the
> > include/linux/timekeeping.h header, but couldn't figure out how to do
> > that in a way that would result both in helpful inline comments as
> > well as readable html output, so I settled for the latter, with
> > a small note pointing to it from the header.
> >
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: minor changes suggested by Randy  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This brings into question commit bc2b7dab629a5
> "iio:core: timestamping clock selection support"
> that has bothered me for some time. Now that is ABI, but
> we might be able to do some recommendations based on the
> time base and have a sensible default moving forward.
> 
> As I want to make that clock base parsing similar for GPIO
> I first thought it was a good idea to support the same clocks,
> but now it seems like a bad idea.
> 
> IIRC you told me to simply hammer down the clock that
> makes the most sense.
> 
> At the same time userspace libraries (such as GNU radio) will
> be confused if they can't match the timestamping clocks,
> as correlating GPIO and IIO events is something they will
> want to do. And I guess these clocks are there for a reason.
> 
> So asking Lars-Peter and Gregor: from a userspace point
> of view, what makes most sense for the usecases you
> have seen? Having one consistent time base or all of these
> as we currently have? Different clocks under different
> circumstances?

Yeah, this mess in IIO was all a silly mistake I made years
ago, though we may have messed up how to 'fix' it.

Basically I should probably have gone with a monotonic clock
but I didn't.  This leads to some really odd algorithm issues
when the non monotonic clocks are updated.

Still when we originally looked at it, the answer is that there
are different 'right' choices depending largely on what timescales
you are working at.

There are systems where you want to sample fairly infrequently enough
that you are not going to see the non monotonic jumps, and where your
biggest requirement is absolute precision on the time stamp.  In these
you would be frequently updating your clock.

Others are running at high speed and you need a best estimate smoothed
result that doesn't ever go backwards.

The right answer was probably to limit it to a couple of 'almost'
right choices - but that's hind sight.  Certainly don't copy this
without a lot of thought!

Now I wonder which of those clocks choices we can remove without anyone
ever noticing?

Jonathan

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

