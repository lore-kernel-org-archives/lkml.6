Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C620DC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A1C2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeLRBkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:40:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36488 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeLRBkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:40:37 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gZ4N7-0003yN-HI; Tue, 18 Dec 2018 01:40:33 +0000
Date:   Tue, 18 Dec 2018 01:40:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        James Morris James Morris <jmorris@namei.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: cleanup the match_token policy code
Message-ID: <20181218014033.GS2217@ZenIV.linux.org.uk>
References: <1545092089.4206.5.camel@linux.ibm.com>
 <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
 <20181218013348.GR2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218013348.GR2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:33:48AM +0000, Al Viro wrote:
> On Mon, Dec 17, 2018 at 04:36:54PM -0800, Linus Torvalds wrote:
> > On Mon, Dec 17, 2018 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > Start the policy_tokens and the associated enumeration from zero,
> > > simplifying the pt macro.
> > 
> > I applied this directly, since I decided to just commit my own "don't
> > use negative Opt_err" patch for the test_and_set_bit() cases, and they
> > kind of go together.
> > 
> > There's still a -1 in security/keys/encrypted-keys/encrypted.c, and
> > there are also three cases of "Opt_error = -1" in the security layer.
> > 
> > All of which look pointless and wrong, but not actively buggy, so I'll
> > leave them alone.
> 
> FWIW, that part of LSM shite is getting taken out and shot - LSM-related
> preps in the beginning of mount API series are, at the moment, at
>  fs/btrfs/ctree.h           |   4 -
>  fs/btrfs/super.c           |  82 ++-------
>  fs/namespace.c             |   9 +-
>  fs/nfs/internal.h          |   2 +-
>  fs/nfs/super.c             |  34 ++--
>  fs/super.c                 |  23 +--
>  include/linux/lsm_hooks.h  |  17 +-
>  include/linux/security.h   |  82 ++-------
>  security/security.c        |  39 +++--
>  security/selinux/hooks.c   | 798 ++++++++++++++++++++++++++++++++------------------------------------------------------
>  security/smack/smack_lsm.c | 359 +++++++++++++++------------------------
>  11 files changed, 523 insertions(+), 926 deletions(-)
> and unlike the original variant there's not much touched in security/*
> further in the series...
> 
> No match_token() uses left in there after this part.

In LSM, that is...
