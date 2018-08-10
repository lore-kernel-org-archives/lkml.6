Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF84C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2437922444
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2437922444
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeHJUbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:31:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59321 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeHJUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:31:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foBiJ-0004jR-Bd; Fri, 10 Aug 2018 12:00:39 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foBiI-0000br-Bu; Fri, 10 Aug 2018 12:00:39 -0600
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
References: <87d0uqpba5.fsf@xmission.com>
        <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <22361.1533913891@warthog.procyon.org.uk>
        <20180810153902.GH21087@thunk.org>
Date:   Fri, 10 Aug 2018 13:00:22 -0500
In-Reply-To: <20180810153902.GH21087@thunk.org> (Theodore Y. Ts'o's message of
        "Fri, 10 Aug 2018 11:39:02 -0400")
Message-ID: <87mutunlu1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1foBiI-0000br-Bu;;;mid=<87mutunlu1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kWSwTl4z3ylb6I+7AATnGbuIYWrjv/2c=
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

> On Fri, Aug 10, 2018 at 04:11:31PM +0100, David Howells wrote:
>> 
>> Yes.  Since you *absolutely* *insist* on this being fixed *right* *now* *or*
>> *else*, I'm working up a set of additional patches to give userspace the
>> option of whether they want no sharing; sharing, but only with exactly the
>> same parameters; or to ignore the parameter differences and just accept
>> sharing of what's already already mounted (ie. the current behaviour).
>
> But there's no way to support "no sharing", at least not in the
> general case.  A file system can only be mounted once, and without
> file system support, there's no way for a file system to be mounted
> with the bsddf or minixdf mount simultaneously.
>
> Even *with* file system support, there's no way today for the VFS to
> keep track of whether a pathname resolution came through one
> mountpoint or another, so I can't do something like this:
>
> 	mount /dev/sdXX -o casefold /android-data
> 	mount /dev/sdXX -o nocasefold /android-data-2
>
> Which is a pity, since if we could we could much more easily get rid
> of the horror which is Android's wrapfs...
>
> So if the file system has been mounted with one set of mount options,
> and you want to try to mount it with a conflicting set of mount
> options and you don't want it to silently ignore the mount options,
> the *only* thing we can today is to refuse the mount and return an
> error.  
>
> I'm not sure Eric would really consider that an improvement for the
> container use case....

I think I would consider it an improvement.  I keep running into cases
where the mount options differed and something was done silently and
that causes problems.

Eric
