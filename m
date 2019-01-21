Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0945C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DB120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfAUWOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:14:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfAUWOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:14:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18411AC95;
        Mon, 21 Jan 2019 22:14:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F545DA85F; Mon, 21 Jan 2019 23:14:17 +0100 (CET)
Date:   Mon, 21 Jan 2019 23:14:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Message-ID: <20190121221417.GK2900@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jann Horn <jannh@google.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
References: <20190118161440.220134-1-jannh@google.com>
 <20190121215454.GA12996@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121215454.GA12996@mit.edu>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
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
> error code number for EFSCORRUPTED.  The downside of doing this is
> that for a while, older versions glibc won't have strerror/perror
> translation for the new error code.  On the other hand, I'm not sure
> it will be that much more confusing to the average user than
> "Structure needs cleaning".  :-)
>
> The upside of assigning a new error code is that in a year or two,
> we'll actually have an intelligible error message showing up in log
> files and in user's terminals.

I vote for a new code with a better message than EUCLEAN provides.
