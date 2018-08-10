Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB37C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405232083B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xWdgubYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405232083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHKApR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:45:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeHKApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:45:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7AMA7aj088828;
        Fri, 10 Aug 2018 22:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=djArXZKJdMFL042r/VtUyGz0O3VM1QSbk/Y1/OYLPnA=;
 b=xWdgubYRhy50fL1QlEuxpHtHhv51V/mOWhuy8C765zWg3B/Ge4rhj+jMT2iG6+2Qllih
 RWv1aj9PEM38il69pWadcOElv+wE7HO87dG2PWyuzO7GjRK3ZyPdUGxkrfM8HDH9p5aI
 4tJzV+g7blw75Im+PcoAVb8bGYU5b0TQ7Z7WcYtUelwwOsWYldKgHHk3ZVatrvWws1Ys
 prJlcFAqRmWTGur6/LUsnPvnwqC38yGT9v8tlgmvas9Ba/C9XXtCgA06WMBPD836KI9v
 h1aAncpNJHxhqzcyA4FSGuIkYZ/s+4wu0txEmphxsZRkGsDQDfahfIVenKpGQnTqYazl Jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kn43p953s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 22:12:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7AMCe0i028909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 22:12:40 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7AMCakL028351;
        Fri, 10 Aug 2018 22:12:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Aug 2018 15:12:36 -0700
Date:   Fri, 10 Aug 2018 15:12:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20180810221234.GC4211@magnolia>
References: <20180810153902.GH21087@thunk.org>
 <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180810204639.GI627@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810204639.GI627@thunk.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8981 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808100232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:46:39PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Aug 10, 2018 at 01:06:54PM -0700, Andy Lutomirski wrote:
> > If the same block device is visible, with rw access, in two different
> > containers, I don't see any anything good can happen.
> 
> It's worse than that.  I've fixed a lot of bugs which cause the kernel
> to crash, and a few that might be levered into a privilege escalationh
> attack, when you mount a maliciously corrupted file system using ext4.
> I'm told told the security researcher filed similar reports with the
> XFS community, and he was told, "that's what metadata checksums are
> for; go away".

Hey now, there was a little more nuance to it than that[1][2].  The
complaint in the first instance had much more to do with breaking
existing V4 filesystems by adding format requirements that mkfs didn't
know about when the filesystem was created.  Yes, you can create V4
filesystems that will hang the system if the log was totally unformatted
and metadata updates are made, but OTOH it's fairly obvious when that
happens, you have to be root to mount a disk filesystem, and we try to
avoid breaking existing users.

XFS developers have been and will continue to examine security problems
when they are brought to our attention and strengthen validation as
needed to minimize the risk of incorrect behaviors, but filesystems are
complex machines, complex machinery is risky, and we arbitrate some of
that risk by requiring administrators to elect to mount an XFS.

> Given how much time it takes to work with these security researchers,
> I don't blame them.
> 
> But in light of that, I'd make a somewhat stronger statement.  If you
> let an untrusted container mount arbitrary block devices where they
> have rw acccess to the underlying block device, nothing good can
> happen.  Period.  :-)
> 
> Which is why I don't think the lack of being able to reject
> "conflicting mount options" is really all that important.  It
> certainly shouldn't block the fsopen patch series.  #1, it's a problem
> we have today, and #2, I'm really not all sure supporting bind mounts
> via specifying block device was ever a good idea to begin with.  And
> #3, while I've been fixing ext4 against security issues caused by
> maliciously corrupted file system images, I'm still sure that allowing
> untrusted containers access to mount *any* file system via a block
> device for which they have r/w access is a Really Bad Idea.
> 
> > It seems to me that the current approach mostly involves crossing our fingers.
> 
> Agreed!

Crossing our fingers and demanding administrator intentionality when
mounting filesystems off some piece of storage.

--D

[1] https://lkml.org/lkml/2018/5/21/649
[2] https://lkml.org/lkml/2018/4/2/572

