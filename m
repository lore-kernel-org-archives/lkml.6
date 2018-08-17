Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850122152E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850122152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeHRCRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:17:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58686 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeHRCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:17:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fqntz-0003A0-DY; Fri, 17 Aug 2018 23:11:31 +0000
Date:   Sat, 18 Aug 2018 00:11:31 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Howells <dhowells@redhat.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        sfrench@samba.org, steved@redhat.com,
        torvalds@linux-foundation.org,
        "Eric W. Biederman" <ebiederm@redhat.com>,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: Should we split the network filesystem setup into two phases?
Message-ID: <20180817231131.GI6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <17763.1534350685@warthog.procyon.org.uk>
 <87pnyiew8x.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnyiew8x.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:06:06AM -0500, Eric W. Biederman wrote:

> So I don't think we can completely abandon the option for filesystems
> to always create a new filesystem instance when mount(8) is called.

Huh?  If filesystem wants to create a new instance on each ->mount(),
it can bloody well do so.  Quite a few do - if that fs can handle
that, more power to it.

The problem is what to do with filesystems that *can't* do that.
You really, really can't have two ext4 (or xfs, etc.) instances over
the same device at the same time.  Cache coherency, locking, etc.
will kill you.

And that's not to mention the joy of defining the semantics of
having the same ext4 mounted with two logs at the same time ;-)

I've seen "reject unless the options are compatible/identical/whatever",
but that ignores the real problem with existing policy.  It's *NOT*
"I've mounted this and got an existing instance with non-matching
options".  That's a minor annoyance (and back when that decision
had been made, mount(2) was very definitly root-only).  The real
problem is different and much worse - it's remount.

I have asked to mount something and it had already been mounted,
with identical options.  OK, so what happens if I do mount -o remount
on my instance?  *IF* we are operating in the "only sysadmin can
mount new filesystems", it's not a big deal - there are already
lots of ways you can shoot yourself in the foot and mount(2) is
certainly a powerful one.  But if we get to "Joe R. Luser can do
it in his container", we have a big problem.

Decision back then had been mostly for usability reasons - it was
back in 2001 (well before the containermania, userns or anything
of that sort) and it was more about "how many hoops does one have
to jump through to get something mounted, assuming the sanity of
sysadmin doing that?".  If *anything* like userns had been a concern
back then, it probably would've been different.  However, it's
17 years too late and if anyone has a functional TARDIS, I can
easily think of better uses for it...
