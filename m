Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC31ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE3A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE3A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGROYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:24:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58616 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbeGROYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:24:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ffmmp-0003VY-09; Wed, 18 Jul 2018 13:46:35 +0000
Date:   Wed, 18 Jul 2018 14:46:34 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: vfs / overlayfs conflict resolution for linux-next
Message-ID: <20180718134634.GT30522@ZenIV.linux.org.uk>
References: <20180711152555.GR30522@ZenIV.linux.org.uk>
 <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk>
 <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk>
 <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718124340.GS30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:43:40PM +0100, Al Viro wrote:

> It *is* broken.  For now leave override_creds() as in your variant, but
> we really want to deal with that crap eventually.
> 
> > Okay, so ->open() is a file op, and file ops should use file->f_cred,
> > but how are we going to enforce this?
> 
> I'd say we cut down on the use of current_cred() when deep in call chain...

Actually, how about this:

#define call_with_creds(__cred, expr) ({		\
	__typeof__(expr) ____res;			\
	const struct cred *____old = current->cred;	\
	const struct cred *____new = (__cred);		\
	rcu_assign_pointer(current->cred, ____new);	\
	____res = expr;					\
	BUG_ON(current->cred != ____new);		\
	rcu_assign_pointer(current->cred, ____old);	\
	____res;					\
})

and replacing
                error = open(inode, f);
with
		error = call_with_cred(f->f_cred, open(inode, f));

possibly with similar at other methods callsites?  Unlike override_creds()
and revert_creds() it's cheap - no validation of creds, no cacheline
ping-pong...

Folks?
