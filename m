Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB1C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB50A21EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="O55kWoXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB50A21EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeHJSJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:09:51 -0400
Received: from imap.thunk.org ([74.207.234.97]:59400 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbeHJSJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Pz/6tKnuLzpE5nK588kIUmaUNkjM5HG+kYWHqQtNSA8=; b=O55kWoXWdCcAX/OpdGAlTtiD7c
        /GcPiJEjqpP9L8X82wEPwnRkO20gVIriOjilKves1QUYT0OFG9fJ3H/dFWC53DUi5T1pqMrzVODrh
        DTBmR5OWJpp43gd+i8WYjxd+PXqd1qHYS1h885+3AEfesj8zyaYbIvT8Cbt44ETbF9UU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fo9VH-0001fW-OJ; Fri, 10 Aug 2018 15:39:03 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 080757A570B; Fri, 10 Aug 2018 11:39:02 -0400 (EDT)
Date:   Fri, 10 Aug 2018 11:39:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: BUG: Mount ignores mount options
Message-ID: <20180810153902.GH21087@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>, Li Zefan <lizefan@huawei.com>,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22361.1533913891@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:11:31PM +0100, David Howells wrote:
> 
> Yes.  Since you *absolutely* *insist* on this being fixed *right* *now* *or*
> *else*, I'm working up a set of additional patches to give userspace the
> option of whether they want no sharing; sharing, but only with exactly the
> same parameters; or to ignore the parameter differences and just accept
> sharing of what's already already mounted (ie. the current behaviour).

But there's no way to support "no sharing", at least not in the
general case.  A file system can only be mounted once, and without
file system support, there's no way for a file system to be mounted
with the bsddf or minixdf mount simultaneously.

Even *with* file system support, there's no way today for the VFS to
keep track of whether a pathname resolution came through one
mountpoint or another, so I can't do something like this:

	mount /dev/sdXX -o casefold /android-data
	mount /dev/sdXX -o nocasefold /android-data-2

Which is a pity, since if we could we could much more easily get rid
of the horror which is Android's wrapfs...

So if the file system has been mounted with one set of mount options,
and you want to try to mount it with a conflicting set of mount
options and you don't want it to silently ignore the mount options,
the *only* thing we can today is to refuse the mount and return an
error.  

I'm not sure Eric would really consider that an improvement for the
container use case....

						- Ted

P.S.  And as Al has pointed out, this would require special, per-file
system support to determine whether the mount options are conflicting
or not....
