Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A9C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00979219C8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00979219C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeHKEtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:49:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60288 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeHKEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:49:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1foJSi-0008Sq-Dq; Sat, 11 Aug 2018 02:17:04 +0000
Date:   Sat, 11 Aug 2018 03:17:04 +0100
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
Message-ID: <20180811021704.GE6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com>
 <20180810151606.GA6515@ZenIV.linux.org.uk>
 <87pnypiufr.fsf@xmission.com>
 <20180811015815.GD6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811015815.GD6515@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 02:58:15AM +0100, Al Viro wrote:
> On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
> 
> > All I proposed was that we distinguish between a first mount and an
> > additional mount so that userspace knows the options will be ignored.
> 
> For pity sake, just what does it take to explain to you that your
> notions of "first mount" and "additional mount" ARE HEAVILY FS-DEPENDENT
> and may depend upon the pieces of state userland (especially in container)
> simply does not have?
> 
> One more time, slowly:
> 
> mount -t nfs4 wank.example.org:/foo/bar /mnt/a
> mount -t nfs4 wank.example.org:/baz/barf /mnt/b
> 
> yield the same superblock.  Is anyone who mounts something over NFS
> required to know if anybody else has mounted something from the same
> server, and if so how the hell are they supposed to find that out,
> so that they could decide whether they are creating the "first" or
> "additional" mount, whatever that might mean in this situation?
> 
> And how, kernel-side, is that supposed to be handled by generic code
> of any description?  
> 
> While we are at it,
> mount -t nfs4 wank.example.org:/foo/bar -o wsize=16384 /mnt/c
> is *NOT* the same superblock as the previous two.

s/as the previous two/as in the previous two cases/, that is - the first two
examples yield one superblock, this one - another.
