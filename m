Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD9C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E99F219C6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JRfTZtg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E99F219C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeHKDL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:11:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36340 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeHKDL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:11:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7B0d0Yd178763;
        Sat, 11 Aug 2018 00:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kGriiRvaEJZkhi+Lyu+MC6HbJz34ewVUpzQb2zRP+9I=;
 b=JRfTZtg2ad5i4KaKfQ7EyJB9L+VM8BHmmfvxLpU3mOcDIrIrzEk2mhP4Bc9CLF1efLiw
 5YwHJ8+yceqUOfdkSk5pKE5zBk4Ulfimn3QDWXK1Xrvn1wcrRpyCaJ+0/qjHj1j9zzk3
 XCYugwZh2MQwhX9PnrsjDNrYk//qdylb3+r4wpGvwKmJR0H3km+3vEf/iABd8KJd4MsL
 KT9DJLTtPUf3JCrxC1IU/VotdUvHvWeEMeAUmQkrSHiwy/QreIvsCWhNWDCHS7R5Ckay
 BlKV48G3trFXmcFhA6IIbSRo5dtfDmMRINu/4xiw8ZSxe5HbL5pPMpODYXD3P+2uCY1p 4g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kn43p9b5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Aug 2018 00:39:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7B0d0Q3007194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Aug 2018 00:39:00 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7B0ctwS002509;
        Sat, 11 Aug 2018 00:38:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Aug 2018 17:38:55 -0700
Date:   Fri, 10 Aug 2018 17:38:52 -0700
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
Message-ID: <20180811003852.GA10463@magnolia>
References: <20180810153902.GH21087@thunk.org>
 <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180810204639.GI627@thunk.org>
 <20180810221234.GC4211@magnolia>
 <20180810235447.GK627@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810235447.GK627@thunk.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8981 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808110005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 07:54:47PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Aug 10, 2018 at 03:12:34PM -0700, Darrick J. Wong wrote:
> > Hey now, there was a little more nuance to it than that[1][2].  The
> > complaint in the first instance had much more to do with breaking
> > existing V4 filesystems by adding format requirements that mkfs didn't
> > know about when the filesystem was created.  Yes, you can create V4
> > filesystems that will hang the system if the log was totally unformatted
> > and metadata updates are made, but OTOH it's fairly obvious when that
> > happens, you have to be root to mount a disk filesystem, and we try to
> > avoid breaking existing users.
> 
> I wasn't thinking about syzbot reports; I've largely written them off
> as far as file system testing is concerned, but rather Wen Xu at
> Georgia Tech, who is much more reasonable than Dmitry, and has helpeyd
> me out a lot; and has complained that the XFS folks haven't been
> engaging with him.

Ahh, ok.  Yes, Wen has been easier to work with, and gives out
filesystem images.  Hm, I'll go comb the bugzilla again...

> In either case, both security researchers are fuzzing file system
> images, and then fixing the checksums, and discovering that this can
> lead to kernel crashes, and in a few cases, buffer overruns that can
> lead to potential privilege escalations.  Wen can generate reports
> faster than syzbot, but at least he gives me file system images (as
> opposed to having to dig them out of syzbot repro C files) and he
> actually does some analysis and explains what he thinks is going on.

(FWIW I tried to figure out how to add fs image dumping to syzbot and
whoah that was horrifying.

> I don't think anyone was claiming that format requirements should be
> added to ext4 or xfs file systems.  But rather, that kernel code
> should be made more robust against maliciously corrupted file system
> images that have valid checksums.  I've been more willing to work with
> Wen; Dave has expressed the opinion that these are not realistic bug
> reports, and since only root can mount file systems, it's not high
> priority.

I don't think they're high priority either, but they're at least worth
/some/ attention.

> The reason why I bring this up here is that in container land, there
> are those who believe that "container root" should be able to mount
> file systems, and if the "container root" isn't trusted, the fact that
> the "container root" can crash the host kernel, or worse, corrupt the
> host kernel and break out of the container as a result, that would be
> sad.
> 
> I was pretty sure most file system developers are on the same page
> that allowing untrusted "container roots" the ability to mount
> arbitrary block device file systems is insanity.

Agreed.

> Whether or not we try to fix these sorts of bugs submitted by security
> researchers.  :-)

and agreed. :)

--D

> 	  	       	    	       		  - Ted
