Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D0D2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D0D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeGKDB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:01:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeGKDB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:01:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd5Lc-0004Dl-KE; Wed, 11 Jul 2018 02:59:20 +0000
Date:   Wed, 11 Jul 2018 03:59:20 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [RFC][PATCH 16/42] now we can fold open_check_o_direct() into
 do_dentry_open()
Message-ID: <20180711025920.GQ30522@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-16-viro@ZenIV.linux.org.uk>
 <CA+55aFyoQkoRm5sGaXpxtrr8au1mgr1_+khY=St0o7NRd5qw8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyoQkoRm5sGaXpxtrr8au1mgr1_+khY=St0o7NRd5qw8w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 07:44:59PM -0700, Linus Torvalds wrote:
> I like the patch, I hate the commit message.
> 
> It makes sense right now in this sequence, but I'd really like the
> commit message to say _why_ this sequence led up to this point.
> 
> Right now I still remember you trying this, and having to revert it
> because it didn't work before all the fput/put_filp issues. But a year
> from now? Five years from now?
> 
> So at least a "now that fput() works regardless of how far the open
> got.." kind of explanation, ok?

Umm...  Something like

These checks are better off in do_dentry_open(); the reason we couldn't
put them there used to be that callers couldn't tell what kind of cleanup
would do_dentry_open() failure call for.  Now that we have FMODE_OPENED,
cleanup is the same in all cases - it's simply fput().  So let's fold
that into do_dentry_open(), as Christoph's patch tried to.

perhaps?
