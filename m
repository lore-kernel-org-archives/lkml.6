Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AC3C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2FA2189B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2FA2189B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHKDAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:00:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43344 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbeHKDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:00:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foHlR-0005cO-Au; Fri, 10 Aug 2018 18:28:17 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foHlQ-0001fM-Dt; Fri, 10 Aug 2018 18:28:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
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
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
        <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <22361.1533913891@warthog.procyon.org.uk>
        <28045.1533916438@warthog.procyon.org.uk>
        <20180810161400.GA627@thunk.org>
Date:   Fri, 10 Aug 2018 19:28:00 -0500
In-Reply-To: <20180810161400.GA627@thunk.org> (Theodore Y. Ts'o's message of
        "Fri, 10 Aug 2018 12:14:00 -0400")
Message-ID: <87bma9oigf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1foHlQ-0001fM-Dt;;;mid=<87bma9oigf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Yp1iyvwgqhEviaB7XCawr7/9SZazFcvo=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: BUG: Mount ignores mount options
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Fri, Aug 10, 2018 at 04:53:58PM +0100, David Howells wrote:
>> Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> 
>> > Even *with* file system support, there's no way today for the VFS to
>> > keep track of whether a pathname resolution came through one
>> > mountpoint or another, so I can't do something like this:
>> 

>> However, the case folding stuff - is that a superblockism of a mountpointism?
>
> It's a superblock-ism.  As far as I know the *only* thing that we can
> support as a mount-pointism is the ro flag, and that's handled as a
> special case, and only if the original superblock was mounted
> read/write.  ey That was my point; aside from the ro flag, we can't
> support any other mount options as a per-mount point thing, so the
> only thing we can do is to fail the mount if there are conflicting
> mount options.  And I'm not really sure it helps the container use
> case, since the whole point is they want their "guest" to be able to
> blithely run "mount /dev/sda1 -o noxattr /mnt" and not worry about the
> fact that in some other container, someone had run "mount /dev/sda1 -o
> xattr /mnt".  But having the second mount fail because of conflicting
> mount option breaks the illusion that containers are functionally as
> rich as VM's.

Ted this isn't about some container case.

It about the fact that practically every filesystem in the kernel has
the behavior I have described and it means that if root is not super
careful root will shoot himself in the foot with the shotgun we have
pointed there.

It really is about loosing acls or some other filesystem option.


Eric
