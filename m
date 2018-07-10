Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D433C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C042089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C042089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeGJC1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbeGJC12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:27:28 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54362089D;
        Tue, 10 Jul 2018 02:27:27 +0000 (UTC)
Date:   Mon, 9 Jul 2018 22:27:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180709222725.66a763e9@vmware.local.home>
In-Reply-To: <20180709234203.GG4447@eros>
References: <20180706134724.563799-1-arnd@arndb.de>
        <20180706144213.GA411@tigerII.localdomain>
        <20180706114951.6e739180@gandalf.local.home>
        <20180709234203.GG4447@eros>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 09:42:03 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Steve if you do not rebase your next branch and the branch ends up
> containing fixes to patches like the above doesn't this mean that when
> you do a pull request to Linus the branch you are asking to be pulled
> will be too 'dirty' i.e. I thought that the pull request should be like
> a patch set and only contain the 'final product' not every change that
> was made during development?

Nope, once I push to next, my branch is ready to be worked against.
Sha1 and all. Rebasing will break that. I also have a full test suite
that all my code runs through and it must pass before sending to Linus
or linux-next.

> 
> I was under the impression that each maintainer constantly rebased their
> next branches and that was why one has to checkout the tagged linux-next

Some maintainers (Ingo being one) is very against any unnecessary
rebasing. This is because it can hide the history and development of
code. Linus doesn't like to see rebasing of public trees. Once you
rebase, you lose all the prior testing done on the previous code. It
also makes it difficult for anyone that is basing code off of it.

> each day instead of just pulling.  From information on the net somewhere
> I have been checking out linux-next using this shell function
> 
> checkout-next () {
> 	local branch='linux-next' 
> 
> 	git checkout master
> 	git remote update linux-next
> 	git branch -D $branch
> 	git checkout -b $branch $(git tag -l "next-*" | tail -1)
> }

I believe linux-next itself creates its master branch each time it
pulls in everyone's branches. It throws away the old one, and pulls in
all the new ones. This makes sense because otherwise the history will be
loaded with pulls from various branches. And yes, some branches will
rebase. If just one branch rebases, then it would need to do this.

> 
> Also, when my leaks tree got included in linux-next I was told that it
> was ok to rebase and have since been rebasing mercilessly.

It's really a choice for the maintainer. I consider a branch that goes
into next as "tested". I wont rebase unless there is a nasty bug that I
don't want to go upstream. Or a compiler failure. Warnings don't bother
me. I've sometimes rebased to add Acked-by/Reviewed-by tags. But that's
because the code is identical to what was there before (I do git diffs
to confirm that).

Linus has yelled at people that have rebased just before sending a
pull request to him.

-- Steve
