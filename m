Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F70ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231A42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231A42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeGRSwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:52:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37382 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeGRSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:52:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ffqwW-0001Q5-Gg; Wed, 18 Jul 2018 18:12:52 +0000
Date:   Wed, 18 Jul 2018 19:12:52 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] call_with_creds()
Message-ID: <20180718181252.GU30522@ZenIV.linux.org.uk>
References: <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk>
 <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk>
 <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk>
 <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:46:09PM +0200, Miklos Szeredi wrote:

> I like the call_with_creds() idea.  I didn't realize that
> override_creds()/revert_creds() can be quite heavyweight due to doing
> (unnecessary in this case) refcounting.   Could use call_with_creds()
> in overlayfs too, since we hold ref on ofs->creator_cred for the
> lifetime of the filesystem.

OK...

/* expr is non-void here */
#define __call_with_creds(__cred, expr) ({			\
	const struct cred *____old = current->cred;		\
	const struct cred *____new = __cred;			\
	__typeof__(expr) __res;					\
	rcu_assign_pointer(current->cred, ____new);		\
	__res = (expr);						\
	BUG_ON(current->cred != ____new);			\
	rcu_assign_pointer(current->cred, ____old);		\
	__res; })

/* expr for non-void, expr,0 for void */
#define __wrap_void(expr) __builtin_choose_expr(		\
	__builtin_types_compatible_p(__typeof__(expr), void),	\
		((expr),0), (expr))

/*
 * Evaluate an expression with current->cred temporary set to __cred.
 * NOTE: expr must not result in changed ->cred - any changes during
 * its evaluation must be undone.
 */
#define call_with_creds(__cred, expr)	\
	((__typeof__(expr))__call_with_creds(__cred, __wrap_void(expr)))

Linus, David - do you have any objections to the above?  I would like
to do some of the file method calls via that - e.g. have callers of
->write() (both __vfs_write() and do_loop_readv_writev()) use
	nr = call_with_creds(file->f_cred,
			file->f_op->write(file, iovec.iov_base,
					  iovec.iov_len, ppos));
instead of
	nr = file->f_op->write(file, iovec.iov_base,
				  iovec.iov_len, ppos));
Ditto for call of open() in do_dentry_open(), etc.
