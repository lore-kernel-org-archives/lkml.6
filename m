Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10F214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD10F214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeHURRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:17:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHURRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:17:54 -0400
Received: from localhost (ip-213-127-46-227.ip.prioritytelecom.net [213.127.46.227])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 50539E3D;
        Tue, 21 Aug 2018 13:57:38 +0000 (UTC)
Date:   Tue, 21 Aug 2018 15:57:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180821135734.GA19916@kroah.com>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
 <20180821095055.GA400@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821095055.GA400@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 06:50:55PM +0900, Sergey Senozhatsky wrote:
> Hi Rasmus,
> 
> On (08/21/18 09:59), Rasmus Villemoes wrote:
> > > +char *sysfs_strncpy(char *dest, const char *src, size_t count)
> > > +{
> > > +	char *c;
> > > +
> > > +	strncpy(dest, skip_spaces(src), count);
> > 
> > I'd like to see where and how you'd use this, but I'm very skeptical of
> > count being used both for the size of the dest buffer as well as an
> > essentially random argument to strncpy - if count is also the maximum
> > number of bytes to read from the src, you'd need to take the
> > skip_spaces() into account, because there are not count bytes left after
> > that...
> > And if src is not necessarily nul-terminated, skip_spaces() by
> > itself is wrong.
> 
> I think that sysfs input is always properly NULL-terminated. It may or
> may not contain \n, but \0 is expected to be there. Am I wrong?

sysfs data is always null terminated.

What exactly are you trying to do here?  If a user sends you crappy data
in a sysfs file (like leading or trailing whitespace), well, you can
always just error out, no problem.  You can be very strict in the
SINGLE_VALUE that you accept in your sysfs file.  And yes, sysfs files
are single values, if you want to do more than that, you need to use
something else, so I really do not understand what problem you are
trying to solve here.

Please always post a user of your new api when you make stuff like this
otherwise we do not know how it is used, or even why you are adding it.

thanks,

greg k-h
