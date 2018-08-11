Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0004CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2CD2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2CD2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHKEbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:31:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60002 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeHKEbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:31:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1foJAV-0008D5-9n; Sat, 11 Aug 2018 01:58:15 +0000
Date:   Sat, 11 Aug 2018 02:58:15 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Howells <dhowells@redhat.com>,
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
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: BUG: Mount ignores mount options
Message-ID: <20180811015815.GD6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com>
 <20180810151606.GA6515@ZenIV.linux.org.uk>
 <87pnypiufr.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnypiufr.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:

> All I proposed was that we distinguish between a first mount and an
> additional mount so that userspace knows the options will be ignored.

For pity sake, just what does it take to explain to you that your
notions of "first mount" and "additional mount" ARE HEAVILY FS-DEPENDENT
and may depend upon the pieces of state userland (especially in container)
simply does not have?

One more time, slowly:

mount -t nfs4 wank.example.org:/foo/bar /mnt/a
mount -t nfs4 wank.example.org:/baz/barf /mnt/b

yield the same superblock.  Is anyone who mounts something over NFS
required to know if anybody else has mounted something from the same
server, and if so how the hell are they supposed to find that out,
so that they could decide whether they are creating the "first" or
"additional" mount, whatever that might mean in this situation?

And how, kernel-side, is that supposed to be handled by generic code
of any description?  

While we are at it,
mount -t nfs4 wank.example.org:/foo/bar -o wsize=16384 /mnt/c
is *NOT* the same superblock as the previous two.

> I don't know how the above wound up being construed as asking that the
> code call sget directly but that is what has happened.

Not by me.  What I'm saying is that the entire superblock-creating
machinery - all of it - is nothing but library helpers.  With the
decision of when/how/if they are to be used being down to filesystem
driver.  Your "first mount"/"additional mount" simply do not map
to anything universally applicable.

> > Having something like a second callback for mount_bdev() that would
> > be called when we'd found an existing instance for the same block
> > device?  Sure, no problem.  Having a helper for doing such comparison
> > that would work in enough cases to bother, so that different fs
> > could avoid boilerplate in that callback?  Again, more power to you.
> 
> Normal forms etc.  If we want to do that it just requires a wee bit of
> discipline.  And if all of the option parsing is being rewritten and
> retested anyway I don't see why we can't do something like that as well.
> So it does not sound unreasonable to me.

See above.
