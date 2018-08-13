Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB67C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062552175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062552175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeHMUPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:15:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54024 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:15:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fpGf5-0005Fn-U5; Mon, 13 Aug 2018 17:29:47 +0000
Date:   Mon, 13 Aug 2018 18:29:47 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, SELinux-NSA <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>,
        Linux API <linux-api@vger.kernel.org>,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: BUG: Mount ignores mount options
Message-ID: <20180813172947.GS6515@ZenIV.linux.org.uk>
References: <20180810153902.GH21087@thunk.org>
 <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180813173502.1a7a1d9c@alans-desktop>
 <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 09:48:53AM -0700, Andy Lutomirski wrote:

> I would consider the GFS2 case to be essentially equivalent to the NFS
> case.  I think we can probably divide all the filesystems into three
> or four types:
> 
> pseudo file systems: Multiple instantiations of the same fs driver
> pointing at the same backing store give separate filesystems.  (Same
> backing store includes the case where there isn't any backing store.)
> tmpfs is an example.  This isn't particularly interesting.
> 
> network-like file systems: Multiple instantiations of the same fs
> driver pointing at the same backing store are expected.  This includes
> NFS, GFS2, AFS, CIFS, etc.  This is only really interesting to the
> extent that, if the fs driver internally wants to share state between
> multiple instantiations, it should be smart enough to make sure the
> options are compatible or that it can otherwise handle mismatched
> options correctly.  NFS does this right.
> 
> non-network-like filesystems: There are complicated ones like btrfs
> and ZFS and simple ones like ext4.  In either case, multiple totally
> separate instantiations of the driver sharing the backing store will
> lead to corruption.  In cases like ext4, we seem to support it for
> legacy reasons, because we're afraid that there are scripts that try
> to mount the same block device more than once, and I think the new API
> has no need to support this.  In cases like btrfs, we also seem to
> support multiple user requests for "mounts" with the same underlying
> block devices because we need it for full functionality.  But I think
> this is because our API is wrong.
> 
> Are there cases I'm missing?  It sounds like the API could be improved
> to fully model the last case, and everything will work nicely.

	You know, that's starting to remind of this little gem of Borges:
http://www.alamut.com/subj/artiface/language/johnWilkins.html
Especially the delightful (fake) quote contained in there:
[...] it is written that the animals are divided into:
	(a) belonging to the emperor,
	(b) embalmed,
	(c) tame,
	(d) sucking pigs,
	(e) sirens,
	(f) fabulous,
	(g) stray dogs,
	(h) included in the present classification,
	(i) frenzied,
	(j) innumerable,
	(k) drawn with a very fine camelhair brush,
	(l) et cetera,
	(m) having just broken the water pitcher,
	(n) that from a long way off look like flies.
