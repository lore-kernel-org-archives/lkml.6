Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D096C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D859B20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAUWOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:14:04 -0500
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:42368 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfAUWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:14:03 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 22 Jan 2019 08:43:58 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1glhpN-0001lg-S6; Tue, 22 Jan 2019 09:13:57 +1100
Date:   Tue, 22 Jan 2019 09:13:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Message-ID: <20190121221357.GC4205@dastard>
References: <20190118161440.220134-1-jannh@google.com>
 <20190121215454.GA12996@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121215454.GA12996@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:54:54PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Jan 18, 2019 at 05:14:38PM +0100, Jann Horn wrote:
> > Multiple filesystems can already return EFSCORRUPTED errors to userspace;
> > however, so far, definitions of EFSCORRUPTED were in filesystem-private
> > headers.
> > 
> > I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
> > Dave Chinner says that I should instead hoist the definitions of
> > EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.
> > 
> > This patch is marked for stable backport because it is a prerequisite for
> > the following patch.
> > 
> > Cc: stable@vger.kernel.org
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
> 
> Before we enshrine the overloading of EUCLEAN and EFSCORRUPTED, I
> wonder if we should at least consider the option of assigning a new
> error code number for EFSCORRUPTED. 

No.

We've exposed filesystem corruption errors to userspace as errno 117
for many years now, so people are already familiar with this error
as indicating a filesystem problem.

> The downside of doing this is
> that for a while, older versions glibc won't have strerror/perror
> translation for the new error code.

And everyone will end up asking "WTF is this undefined error the
application just received?" until glibc, man pages and enough
occurrences of the question have been asked that the search engines
develop enough of a history record that they return useful results.
Not only won't users have a clue, but the app developers the users
first ask "what's this error mean" won't have a clue, either.

> On the other hand, I'm not sure
> it will be that much more confusing to the average user than
> "Structure needs cleaning".  :-)

Go search for "XFS structure needs cleaning" on your preferred
search engine and will you get lots and lots of hits indicating what
you should do when you get that error. It's taken years to build up
that history such that it's extremely useful to the average user....

> The upside of assigning a new error code is that in a year or two,
> we'll actually have an intelligible error message showing up in log
> files and in user's terminals.

The downside is that it will take several years before people will
become familiar with the new error, and we'll have to deal with the
fallout repeatedly from it. Hence, IMO, there's no upside to
changing the errno of EFSCORRUPTED now that it is largely ubiquitous
in userspace.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
