Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A81C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248722420
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C248722420
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHJRqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:46:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48048 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:46:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fo994-0005ai-Q0; Fri, 10 Aug 2018 15:16:06 +0000
Date:   Fri, 10 Aug 2018 16:16:06 +0100
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
Message-ID: <20180810151606.GA6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0uqpba5.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:05:22AM -0500, Eric W. Biederman wrote:
> 
> There is a serious problem with mount options today that fsopen does not
> address.  The problem is that mount options are ignored for block based
> filesystems, and any other type of filesystem that follows the same
> pattern.
> 
> The script below demonstrates this bug.  Showing this bug can cause the
> ext4 "acl" "quota" and "user_xattr" options to be silently ignored.
> 
> fsopen has my nack until it addresses this issue.
> 
> I don't know if we can fix this in the context of sys_mount.  But we if
> we are redoing the option parsing of how we mount filesystems this needs
> to be fixed before we start worrying about bug compatibility.
> 
> Hopefully this report is simple and clear enough that we can at least
> agree on the problem.

Sure, it is simple.  So's the solution: MNT_USERNS_SPECIAL_SEMANTICS that
would get passed to filesystems, so that Eric would be able to implement
his mount(2)-incompatible behaviour at leisure, without worrying about
compatibility issues.

Does that address your complaint?  Because one thing we are not going
to do is changing mount(2) behaviour.  Reason: userland-visible
behaviour of hell knows how many local scripts.  Another thing that
is flat-out not feasible is some kind of blanket "compare options"
stuff; it *can* be done as helpers to be used by filesystem when
it sees that new flag, but it's simply not going to work at the
fs-independent level.  Trivial example with the same ext4:
mount /dev/sda1 /mnt/a -o bsddf vs. mount /dev/sda1 /mnt/b
ext4 can tell that these are the same.  syscall itself has no
clue.  What's more, it's not just explicitly spelled default
options - it's the stuff that has more than one form.  And while
we are at it, the things like two NFS mounts of different trees
from the same server; they might or might not get the same superblock.
Depending upon the options.

Convenience helper that would allow ext4 to compare options and reject
the incompatible mount?  Not sure how much ext4-specific knowledge
would have to go in it, but if you can come up with one - more power
to you.  But the decision to use it *must* be ext4-specific.  Because
for e.g. NFS such thing as -o fsid=..., while certainly a part of
options, has a very different meaning - it's "use a separate fs instance"
(and let the server deal with coherency issues on its end).

Decision to use sget() (and the way it's used) is up to filesystem.
We *can't* lift that into syscall.  Not without breaking the fuck out
of existing behaviour.

Having something like a second callback for mount_bdev() that would
be called when we'd found an existing instance for the same block
device?  Sure, no problem.  Having a helper for doing such comparison
that would work in enough cases to bother, so that different fs
could avoid boilerplate in that callback?  Again, more power to you.

But I don't see what the hell does that have to the syscall interface.
