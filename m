Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ACBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AE6208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AE6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeJFGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:48:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58486 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeJFGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8ZoI-0006VV-Hr; Fri, 05 Oct 2018 23:47:06 +0000
Date:   Sat, 6 Oct 2018 00:47:06 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Message-ID: <20181005234706.GX32577@ZenIV.linux.org.uk>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
 <20181005044659.GU32577@ZenIV.linux.org.uk>
 <20181005220518.747ri4q34obrnaoc@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVURVaqJChL=RwZPe74+JfX-6Zzp9kLR9-mLiownSOexQ@mail.gmail.com>
 <20181005222752.l5da54rpww6tlyfy@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005222752.l5da54rpww6tlyfy@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 03:27:54PM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 05, 2018 at 03:09:20PM -0700, Andy Lutomirski wrote:
> > On Fri, Oct 5, 2018 at 3:05 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Oct 05, 2018 at 05:46:59AM +0100, Al Viro wrote:
> > >
> > > > Another problem is your direct poking in ->i_ino.  It's not
> > > > something directly exposed to userland at the moment and it should
> > > > not become such.
> > >
> > > The patch is not making i_ino directly exposed.
> > > Only 'struct bpf_file_info' is exposed to user space / bpf programs.
> > 
> > I think Al is saying that the valie of i_ino is not something that
> > user code is permitted to know regardless of how you format it because
> > it may or may not actually match the value returned by stat().
> > Another way of saying that is that your patch is digging into an
> > internal data structure and is doing it wrong.
> 
> several fs implementation I've looked at just do generic_fillattr()
> for these fields. Are you saying some FS don't use inode->i_ino at all?
> And it's bogus, hence shouldn't be read?

Bloody wonderful...  "Several instances use a library function and do not
override that part of its results; ergo, let's assume that all of them
do the same".

generic_fillattr() is a library function.  In a lot of cases this is all
->getattr() instance needs to do.  And yes, use of ->i_dev and ->i_ino
to intialize ->st_dev and ->st_ino happens to be the default.  However,
this is entirely up to the filesystem in question.  These fields are
fs-private; whether to use them for stat(2) (or anything userland-visible,
really) or to calculate some other value is up to individual filesystem.

FWIW, finding which instances do that is as simple as
grep -n '[-]>[[:space:]]*ino[[:space:]]*=' `git grep -l -w generic_fillattr`
on the plausible theory that ->getattr() instances will be using that helper
at least for some of the fields.  Discarding fs/stat.c, where generic_fillattr()
itself lives, we are left with
fs/ceph/inode.c:558:            if (realm->ino == ci->i_vino.ino)
fs/ceph/inode.c:2268:           stat->ino = ceph_translate_ino(inode->i_sb, inode->i_ino);
fs/cifs/inode.c:2067:   stat->ino = CIFS_I(inode)->uniqueid;
fs/fat/file.c:410:              stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
fs/fuse/dir.c:866:      stat->ino = attr->ino;
fs/fuse/dir.c:954:              stat->ino = fi->orig_ino;
fs/nfs/inode.c:841:     stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
Trivial examination shows that all matches except the first one *are* in ->getattr()
instances of the filesystems in question or are called from such.

And no, it's not that each of those filesystems does not use inode->i_ino at all.
There's a bunch of library helpers in fs/*.c that happen to use the value filesystem
has seen fit to store there.  Whether to use those helpers or not, what to store in
that field, etc. is, again, entirely up to the filesystem in question.
generic_fillattr() is one of those, that's all there is to it.

That's precisely why I really do not like the idea of hooks poking in the internals
of kernel data structures.  Especially since not even "it's not visible outside of
a subsystem-internal header" appears to slow you down.

The same goes for tracepoints, etc. - turning random details of implementation into
a carved in stone ABI is actively harmful.

NAK.

PS: If anything, visibility to hooks should be opt-in.  Sure, we can start actively hiding
the things, but that's a winless arms race  - even if we bloody went and encrypted the
private stuff, you'd still be able to pull decryption key from where it would be accessed
by legitimate users, etc.  Нахуй нам это надо?
