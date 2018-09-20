Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1355AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBE521523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBE521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeITNEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:04:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeITNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:04:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37083D6E;
        Thu, 20 Sep 2018 07:22:08 +0000 (UTC)
Date:   Thu, 20 Sep 2018 09:22:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Message-ID: <20180920072205.GC11963@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
 <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920001024.GD20280@nautica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 02:10:24AM +0200, Dominique Martinet wrote:
> Miguel Ojeda wrote on Thu, Sep 20, 2018:
> > > I've not followed so closely, in particular I'm not sure if it's the
> > > only problem with arm32 right now, but that is a regression - the
> > > general serie is meant as an improvement, but these two patches fix
> > > 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
> > > exclusive") which was taken in 4.19-rc1
> > >
> > > (Miguel, perhaps a Fixes: tag might help remember that?)
> > 
> > The commit is mentioned in the commit message, although not with the
> > Fixes: syntax -- is something now automatically parsing that? I guess
> > it is also easier for humans to parse :)
> 
> As far as I'm aware, the backport to stable stuff parse these to know up
> till how far back they should backport, but it still requires explicit
> Cc to the stable@vger list... (not needed here as the "bad" commit never
> made it to stable)
> I'm not aware of anything else, but as you said, while I now see you
> naming the commit now, I managed to miss it earlier and I was somewhat
> following this so it's probably also easier on humans :)

"Fixes:" is not just for stable, we use it wherever we have a patch that
we know fixes a problem introduced in another patch.

For this instance, I think we should just revert the offending patch,
which should resolve the issue for everyone and then you can try to redo
your series to get it right the next time.

Sound good?

> > > (If no-one in Cc has anything included in -next I could take them in my
> > > 9p branch, but that is quite a bit out of scope from what I advertised
> > > this branch as so I think it would be confusing ; I think it might
> > > almost be best if Miguel will keep maintaining these in the future to do
> > > his own request to inclusion in -next?)
> > 
> > I can ask for my auxdisplay tree (or better, a new one) to be in -next
> > and use that (are non-kernel.org trees allowed to be in -next, by the
> > way?).
> 
> I think a new one would be great, yes.
> (my branch is on github, so Stephen does not appear to mind
> non-kernel.org trees)

Why not just route these through Andrew?  He takes lots of stuff like
this for this very reason.

thanks,

greg k-h
