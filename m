Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E42DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BD12098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="N8M3CJ6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BD12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeIYVyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:54:41 -0400
Received: from imap.thunk.org ([74.207.234.97]:45596 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbeIYVyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3zzIQZzaHxit4oMS1I7zcmcJoowx3ZYw6fkvw/KRdxM=; b=N8M3CJ6ESU8yx4PZswc4AfFgGE
        77Dtrq13IPukmbnZuLEqyE9oi3nQmdX8ga+uk0bJChnVwltO76yZ13o/ehpZc38YWQFBCLizXBskA
        9PaN//SNfxE04Fy3AsRhTGjZM0NEmO8mcGKq5gJIu0ONesCjt4NH8QsUarvRdBIgf1u4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g4pXg-0000l3-J8; Tue, 25 Sep 2018 15:46:28 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C859F7A510B; Tue, 25 Sep 2018 11:46:27 -0400 (EDT)
Date:   Tue, 25 Sep 2018 11:46:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925154627.GC2933@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:15:34AM -0400, Jeff Layton wrote:
> Linux has dozens of filesystems and they all behave differently in this
> regard. A catastrophic failure (paradoxically) makes things simpler for
> the fs developer, but even on local filesystems isolated errors can
> occur. It's also not just NFS -- what mostly started me down this road
> was working on ENOSPC handling for CephFS.
>
> I think it'd be good to at least establish a "gold standard" for what
> filesystems ought to do in this situation. We might not be able to
> achieve that in all cases, but we could then document the exceptions.

I'd argue the standard should be the precedent set by AFS and NFS.
AFS verifies space available on close(2) and returns ENOSPC from the
close(2) system call if space is not available.  At MIT Project
Athena, where we used AFS extensively in the late 80's and early 90's,
we made and contributed back changes to avoid data loss as a result of
quota errors.

The best practice that should be documented for userspace is when
writing precious files[1], programs should open for writing foo.new, write
out the data, call fsync() and check the error return, call close()
and check the error return, and then call rename(foo.new, foo) and
check the error return.  Writing a library function which does this,
and which also copies the ACL's and xattr's from foo to foo.new before
the rename() would probably help, but not as much as we might think.

[1] That is, editors writing source files, but not compilers and
similar programs writing object files and other generated files.

None of this is really all that new.  We had the same discussion back
during the O_PONIES controversy, and we came out in the same place.

						- Ted

P.S.  One thought: it might be cool if there was some way for
userspace applications to mark files with "nuke if not closed" flag,
such that if the system crashes, the file systems would automatically
unlink the file after a reboot or if the process was killed or exits
without an explicit close(2).  For networked/remote file systems that
supported this flag, after the client comes back up after a reboot, it
could notify the server that all files created previously from that
client should be unlinked.

Unlike O_TMPFILE, this would require file system changes to support,
so maybe it's not worth having something which automatically cleans up
files that were in the middle of being written at the time of a system
crash.  (Especially since you can get most of the functionality by
using some naming convention for files that in the process of being
written, and then teach some program that is regularly scanning the
entire file system, such as updatedb(2) to nuke the files from a cron
job.  It won't be as efficient, but it would be much easier to
implement.)
