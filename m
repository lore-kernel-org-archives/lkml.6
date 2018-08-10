Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1484C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6713222432
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="KAdgtBrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6713222432
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeHJSox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:44:53 -0400
Received: from imap.thunk.org ([74.207.234.97]:59672 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeHJSox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SML2hrdrnTP2GFsjV13UJ8h9GTZNMMCvlSxSz8mpmH8=; b=KAdgtBrTVdOTfYDs4aRsMefQVx
        vl6HiRbe/6yXPaJz1X13ExHgAY1gdOO3Sd0OgekX1yGQgDPPRCb9/IxZS2qrd8dfWPJ4rxFX6r0kn
        IEgaWjJ/7zmc/ldAGGqMxPFLkjs3btvKC3Ool3nUBWyuWXSk0neTZrdsbbxZmp6IcrR4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1foA37-00025N-8W; Fri, 10 Aug 2018 16:14:01 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 881997A570B; Fri, 10 Aug 2018 12:14:00 -0400 (EDT)
Date:   Fri, 10 Aug 2018 12:14:00 -0400
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
Message-ID: <20180810161400.GA627@thunk.org>
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
References: <20180810153902.GH21087@thunk.org>
 <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28045.1533916438@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:53:58PM +0100, David Howells wrote:
> Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> > Even *with* file system support, there's no way today for the VFS to
> > keep track of whether a pathname resolution came through one
> > mountpoint or another, so I can't do something like this:
> 
> Ummm...  Isn't that encoded in the vfsmount pointer in struct path?

Well, yes, and we do use this as a hack to make read-only bind mounts
work.  But that's done as a special case, and it's for permissions
checking only.

The big problem is that there is single dentry cache object regardless
of which mount point was used to access it.  So that makes it
impossible to support case folding as a mount-pointism.

> 
> However, the case folding stuff - is that a superblockism of a mountpointism?

It's a superblock-ism.  As far as I know the *only* thing that we can
support as a mount-pointism is the ro flag, and that's handled as a
special case, and only if the original superblock was mounted
read/write.  ey That was my point; aside from the ro flag, we can't
support any other mount options as a per-mount point thing, so the
only thing we can do is to fail the mount if there are conflicting
mount options.  And I'm not really sure it helps the container use
case, since the whole point is they want their "guest" to be able to
blithely run "mount /dev/sda1 -o noxattr /mnt" and not worry about the
fact that in some other container, someone had run "mount /dev/sda1 -o
xattr /mnt".  But having the second mount fail because of conflicting
mount option breaks the illusion that containers are functionally as
rich as VM's.

So before you put in lots of work to support rejecting the attmpted
mount if the mount options conflict, are we sure people will actually
find this to be useful?  Because it's not only fsopen() work for you,
but each file system is going to have to implement new functions to
answer the question "are these mount options conflicting or not?".
Are we sure it's worth the effort?

					- Ted
