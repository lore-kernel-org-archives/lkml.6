Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557FCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319D52177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBHTb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:31:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:37986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727209AbfBHTb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:31:59 -0500
Received: (qmail 15374 invoked by uid 109); 8 Feb 2019 19:31:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 19:31:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26801 invoked by uid 111); 8 Feb 2019 19:32:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 14:32:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 14:31:57 -0500
Date:   Fri, 8 Feb 2019 14:31:57 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190208193157.GA30952@sigill.intra.peff.net>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
 <20190208165052.GC23461@sigill.intra.peff.net>
 <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
 <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:26:17PM -0500, Randall S. Becker wrote:

> > > For this, we could use truncate -s count file instead of dd to get a
> > > fixed size file of nulls. This would remove the need for /dev/zero in
> > > t5318 (the patch below probably will wrap badly in my mailer so I can
> > > submit a real patch separately.
> > 
> > I don't think "truncate" is portable, though.
> 
> It is available AFAIK on Linux, POSIX, and Windows under Cygwin.
> That's more than /dev/zero has anyway. I have the patch ready if you
> want it.

Is it POSIX? Certainly truncate() is, but I didn't think the
command-line tool was. If it really is available everywhere, then yeah,
I'd be fine with it.

> > > > Other cases don't seem to actually care that they're getting NULs,
> > > > and are just redirecting stdin from /dev/zero to get an infinite
> > > > amount of input. They could probably use "yes" for that.
> > >
> > > What about reading from /dev/null?
> > 
> > That would yield zero bytes, not an infinite number of them.
> 
> So something like: yes | tr 'y' '\0' | stuff?

Exactly (if we even care about them being NULs; otherwise, we can omit
the "tr" invocation).

-Peff
