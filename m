Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80194C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5F21A8E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB5F21A8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeHKXxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:53:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46458 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeHKXxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:53:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1foX6q-0007DN-3j; Sat, 11 Aug 2018 16:51:24 +0000
Date:   Sat, 11 Aug 2018 17:51:24 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Message-ID: <20180811165123.GH6515@ZenIV.linux.org.uk>
References: <87pnyphf8i.fsf@xmission.com>
 <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <30365.1533972586@warthog.procyon.org.uk>
 <9B6E2781-484B-4C42-95F5-F900EA36CEA5@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9B6E2781-484B-4C42-95F5-F900EA36CEA5@amacapital.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 09:31:29AM -0700, Andy Lutomirski wrote:

> I don’t see why we need all this fancy “do the options match” stuff.  For the handful of filesystems (like NFS) that do something intelligent when multiple non-bind mount requests against the same underlying storage happen,  we can keep that behavior in the new API. For other filesystems that don’t have this feature, we should simply fail the request.

> IOW I see so compelling reason to call sget() at all from the new API.  The only sort-of-legit use case I can think of is mounting more than one btrfs subvolume. But even that should probably not be done by asking the kernel to separately instantiate the filesystem.


May I politely suggest the esteemed participants of that conversation
to RTFS?  Yes, I know that it's less fun that talking about your
rather vague ideas of how the things (surely) work, but it just might
avoid the feats of idiocy like the above.

Andy, I don't know how to put it more plainly: read the fucking source.
Even grep would do.  The same NFS you've granted (among the "handful"
of filesystems) an exception, *DOES* *CALL* *THE* *FUCKING* sget().

Yes, really.  And in some obscure[1] cases (including the one mentioned
upthread) it does reuse a pre-existing superblock.  For a very good
reason.

[1] such as, oh, mounting two filesystems from the same server with
default options - who would've ever thought of doing something so
perverted?
