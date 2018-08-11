Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69575C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB07322430
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB07322430
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHKDiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:38:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45125 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKDiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:38:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foILy-0008TJ-Na; Fri, 10 Aug 2018 19:06:02 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foILx-0008A5-5K; Fri, 10 Aug 2018 19:06:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@ZenIV.linux.org.uk>
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
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <87d0uqpba5.fsf@xmission.com>
        <20180810151606.GA6515@ZenIV.linux.org.uk>
Date:   Fri, 10 Aug 2018 20:05:44 -0500
In-Reply-To: <20180810151606.GA6515@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 10 Aug 2018 16:16:06 +0100")
Message-ID: <87pnypiufr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1foILx-0008A5-5K;;;mid=<87pnypiufr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/g8WFZY503vYlM0/I07vqphH4G39CE9hU=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: BUG: Mount ignores mount options
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Fri, Aug 10, 2018 at 09:05:22AM -0500, Eric W. Biederman wrote:
>> 
>> There is a serious problem with mount options today that fsopen does not
>> address.  The problem is that mount options are ignored for block based
>> filesystems, and any other type of filesystem that follows the same
>> pattern.
>> 
>> The script below demonstrates this bug.  Showing this bug can cause the
>> ext4 "acl" "quota" and "user_xattr" options to be silently ignored.
>> 
>> fsopen has my nack until it addresses this issue.
>> 
>> I don't know if we can fix this in the context of sys_mount.  But we if
>> we are redoing the option parsing of how we mount filesystems this needs
>> to be fixed before we start worrying about bug compatibility.
>> 
>> Hopefully this report is simple and clear enough that we can at least
>> agree on the problem.
>
> Sure, it is simple.  So's the solution: MNT_USERNS_SPECIAL_SEMANTICS that
> would get passed to filesystems, so that Eric would be able to implement
> his mount(2)-incompatible behaviour at leisure, without worrying about
> compatibility issues.
>
> Does that address your complaint?

Absolutely not.

My complaint is that the current implemented behavior of practically
every filesystem in the kernel, is that it will ignore mount options
when mounted a second time.  

It is not some weird special case.

It is not some container thing.

It is that the behavior of mount(2) with practically every filesystem
type when that filesystem is already mounted somewhere else behaves
in ways no one would expect.

With the new fsopen api the easy thing to do is simply have CMD_CREATE
CMD_BIND_INTERNAL and be done with it.  CMD_CREATE guarantee that a new
superblock is created.  CMD_BIND_INTERNAL would only work with an
existing superblock.  Then root would at least know that he is
connecting to an already mounted filesystem and could look at the
options etc and fail if he didn't like what he saw.  No surprises, no
muss, no fuss simple.


But I have been told the simple solution above is somehow unacceptable.
And an option to compare the mount options and see if they are the same
was offered.  That would will work to.

I just care that we define the semantics in such a way that it is not
easy for root to get confused and do something stupid that will bite
later, and that we build the infrastructure so that all filesystems
can implement it easily.

So yes this is 100% a question about how filesystems should behave with
respect to their option when mounted for a second time.  That is what
Dave Howells patchset is addressing.

> Because one thing we are not going to do is changing mount(2)
> behaviour.

I have not asked for that.  I have asked that we get it right for
fsopen.

> Reason: userland-visible behaviour of hell knows how many local scripts.



> Another thing that
> is flat-out not feasible is some kind of blanket "compare options"
> stuff; it *can* be done as helpers to be used by filesystem when
> it sees that new flag, but it's simply not going to work at the
> fs-independent level.
>
> Trivial example with the same ext4:
> mount /dev/sda1 /mnt/a -o bsddf vs. mount /dev/sda1 /mnt/b
> ext4 can tell that these are the same.  syscall itself has no
> clue.  What's more, it's not just explicitly spelled default
> options - it's the stuff that has more than one form.  And while
> we are at it, the things like two NFS mounts of different trees
> from the same server; they might or might not get the same superblock.
> Depending upon the options.
>
> Convenience helper that would allow ext4 to compare options and reject
> the incompatible mount?  Not sure how much ext4-specific knowledge
> would have to go in it, but if you can come up with one - more power
> to you.  But the decision to use it *must* be ext4-specific.  Because
> for e.g. NFS such thing as -o fsid=..., while certainly a part of
> options, has a very different meaning - it's "use a separate fs instance"
> (and let the server deal with coherency issues on its end).
>
> Decision to use sget() (and the way it's used) is up to filesystem.
> We *can't* lift that into syscall.  Not without breaking the fuck out
> of existing behaviour.

I have never proposed that.  See above.  I may have talked in terms
of what sget does and muddied the waters.  If so I apologize.

All I proposed was that we distinguish between a first mount and an
additional mount so that userspace knows the options will be ignored.

Then the code to replicate the current behavior can look like:

	fd = fsopen(...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	
	if (fsconfig(fd, CMD_CREATE) == -EBUSY) {
        	fsconfig(fd, CMD_BIND_INTERNAL);
        }

But userspace would then be free to issue a warning or do something
else if CMD_CREATE returns -EBUSY.

I don't know how the above wound up being construed as asking that the
code call sget directly but that is what has happened.

> Having something like a second callback for mount_bdev() that would
> be called when we'd found an existing instance for the same block
> device?  Sure, no problem.  Having a helper for doing such comparison
> that would work in enough cases to bother, so that different fs
> could avoid boilerplate in that callback?  Again, more power to you.

Normal forms etc.  If we want to do that it just requires a wee bit of
discipline.  And if all of the option parsing is being rewritten and
retested anyway I don't see why we can't do something like that as well.
So it does not sound unreasonable to me.

It does sound like more work than what I was proposing.

Eric
