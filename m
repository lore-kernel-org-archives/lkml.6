Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62DBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6365F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6365F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeGRNVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:21:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:21:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fflnw-0002BN-Sg; Wed, 18 Jul 2018 12:43:40 +0000
Date:   Wed, 18 Jul 2018 13:43:40 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: vfs / overlayfs conflict resolution for linux-next
Message-ID: <20180718124340.GS30522@ZenIV.linux.org.uk>
References: <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk>
 <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk>
 <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk>
 <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:10:32PM +0200, Miklos Szeredi wrote:
> On Wed, Jul 18, 2018 at 9:25 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> > On Wed, Jul 18, 2018 at 5:29 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> Hi Al,
> >>
> >> On Wed, 18 Jul 2018 03:56:37 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
> >>>
> >>> ... and now it even builds.  Said that, I would really like to hear something
> >>> from you - I can duplicate the entire overlayfs-next and merge it into
> >>> my #for-next and ask Steven to use that instead of your tree, but I very
> >>> much dislike going over your head like that.
> >>>
> >>> I realize that you'd been away for a while and probably are digging yourself
> >>> from under the piles of mail, but it's getting late in the cycle and I want
> >>> to get #for-next into reasonably sane shape.  Please, look through that
> >>> thing and respond.
> 
> In "ovl: stack file ops" this:
> 
>     AV: make it use open_with_fake_path(), don't mess with override_creds
> 
> Maybe it's the way to go, but looks broken as is; e.g. NFS does call
> current_creds() from its open method to get the credentials to work
> with.

It *is* broken.  For now leave override_creds() as in your variant, but
we really want to deal with that crap eventually.

> Okay, so ->open() is a file op, and file ops should use file->f_cred,
> but how are we going to enforce this?

I'd say we cut down on the use of current_cred() when deep in call chain...
