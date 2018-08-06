Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2474021A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2474021A5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbeHFTQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:16:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43916 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:16:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fmixm-0002Gl-RN; Mon, 06 Aug 2018 17:06:34 +0000
Date:   Mon, 6 Aug 2018 18:06:34 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Klyaus <sergey.m.klyaus@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Wang <liwang@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Andi Kleen <andi.kleen@intel.com>
Subject: Re: [PATCH] vfs: fix statfs64() returning impossible EOVERFLOW for
 64-bit f_files
Message-ID: <20180806170634.GA2490@ZenIV.linux.org.uk>
References: <20171005183636.20732-1-sergey.m.klyaus@gmail.com>
 <20171005205724.GJ21978@ZenIV.linux.org.uk>
 <CA+55aFx7d2+GG=0LqMejiK=ZADxX347v_m0S4WzrnQ=1FoyP8A@mail.gmail.com>
 <20171005230633.GK21978@ZenIV.linux.org.uk>
 <CA+55aFzJYXCNPXT8D91FmjU2AWOfvWMnx2BZE+0CLgBcqX3u1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzJYXCNPXT8D91FmjU2AWOfvWMnx2BZE+0CLgBcqX3u1g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2017 at 06:31:29PM -0700, Linus Torvalds wrote:
> On Thu, Oct 5, 2017 at 4:06 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Just to make sure we are on the same page: out of kstatfs fields
> > we have 5 u64 ones (see above; all of them are u64 is struct statfs64
> > on all architectures), an opaque 64bit f_fsid and 5 fields that
> > are long: f_type (magic numbers, all 32bit), f_namelen (max filename
> > length), f_frsize (0 on most of filesystems, always fits into 32 bits),
> > f_flags (guaranteed to be 32bit) and f_bsize.
> 
> Please just use that FITS_IN() kind of macro regardless.
> 
> If the sizes match, the compiler will optimize the test away.
> 
> If the sizes don't match, that FITS_IN() will do the right thing.
> 
> Do *not* manually go and say "these fields are ok, because..". The
> whole bug was because people were confused about the field widths.

To bring that thread back, with apologies for having it fall through
the cracks back last autumn:

compat_statfs64 "overflow checks" are completely bogus.  Some relevant
information:
	* all struct compat_statfs64 instances (all 3 of them) have
identical field sizes.  So any ifdefs on sizeof of anything in them
are nonsense to start with.
	* most of the fields have the same size as their struct kstatfs
counterparts, with the following exceptions - f_type, f_bsize, f_frsize,
f_namelen and f_flags are u32 in compat_statfs64 and long in kstatfs.
Anything other than those fields should not be getting any overflow
checks for obvious reasons - in particular this
                /* f_files and f_ffree may be -1; it's okay
                 * to stuff that into 32 bits */
                if (kbuf->f_files != 0xffffffffffffffffULL
                 && (kbuf->f_files & 0xffffffff00000000ULL))
                        return -EOVERFLOW;
                if (kbuf->f_ffree != 0xffffffffffffffffULL
                 && (kbuf->f_ffree & 0xffffffff00000000ULL))
                        return -EOVERFLOW;
is garbage, blindly copied from handling of compat_statfs where f_files is
32bit.
	* anyone who seriously suggests that some fs might want to report
f_namelen greater than 4Gb is welcome to bludgeon themselves with GNU Hurd
manuals, repeating the mantras about avoiding arbitrary limits until they
get enlightened, go join Hurd development or succeed in bashing out
whatever they had between their ears.  Either way, they won't be pestering
us again.
	* f_type is an opaque magic value; if it doesn't fit into 32 bits,
such filesystem can't be used on 32bit host.  Bug.
	* f_flags is generated right there in fs/statfs.c and the value is
currently limited to 13 bits.

That leaves us with f_bsize and f_frsize (the latter defaulting to the former).
Hugetlbfs can put greater than 4Gb values in there, for really huge pages.
And that's the only thing worth checking in there.

So the whole put_compat_statfs64() thing should be
static int put_compat_statfs64(struct compat_statfs64 __user *ubuf, struct kstatfs *kbuf)
{
	struct compat_statfs64 buf;

	if ((kbuf->f_bsize | kbuf->f_frsize) & 0xffffffff00000000ULL)
		return -EOVERFLOW;

	memset(&buf, 0, sizeof(struct compat_statfs64));
	buf.f_type = kbuf->f_type;
	buf.f_bsize = kbuf->f_bsize;
	buf.f_blocks = kbuf->f_blocks;
	buf.f_bfree = kbuf->f_bfree;
	buf.f_bavail = kbuf->f_bavail;
	buf.f_files = kbuf->f_files;
	buf.f_ffree = kbuf->f_ffree;
	buf.f_namelen = kbuf->f_namelen;
	buf.f_fsid.val[0] = kbuf->f_fsid.val[0];
	buf.f_fsid.val[1] = kbuf->f_fsid.val[1];
	buf.f_frsize = kbuf->f_frsize;
	buf.f_flags = kbuf->f_flags;
	if (copy_to_user(ubuf, &buf, sizeof(struct compat_statfs64)))
		return -EFAULT;
	return 0;
}
and that's it for compat_statfs64 bug reported by Sergey.

I'm somewhat tempted to get rid of those 'long' in struct kstatfs,
turning f_bsize and f_frsize into u64, with f_type, f_namelen and f_flags
becoming u32 and f_spare going to hell (not a single filesystem stores
anything in f_spare and e.g. mips zeroes those on the way to userland in
*native* statfs(2) anyway).  We'd lose the "fast" case of do_statfs64()
and do_statfs_native(), but frankly, it's not a great loss.  Doing e.g.

struct kstatfs {
        u32 f_type;
	u32 f_namelen;	// moved up here
        u64 f_bsize;
        u64 f_blocks;
        u64 f_bfree;
        u64 f_bavail;
        u64 f_files;
        u64 f_ffree;
        __kernel_fsid_t f_fsid;
        u64 f_frsize;
        u32 f_flags;
};

with

#define STATFS_COPYOUT(type)						\
static int put##type(struct kstatfs *st, struct type __user *p)		\
{									\
	struct type buf;						\
									\
	memset(&buf, 0, sizeof(buf));					\
	buf.f_type = st->f_type;					\
	if (!FIT_IN(st->f_bsize, buf.f_bsize))				\
		return -EOVERFLOW;					\
	buf.f_bsize = st->f_bsize;					\
	if (!FIT_IN(st->f_blocks, buf.f_blocks))			\
		return -EOVERFLOW;					\
	buf.f_blocks = st->f_blocks;					\
	if (!FIT_IN(st->f_bfree, buf.f_bfree))				\
		return -EOVERFLOW;					\
	buf.f_bfree = st->f_bfree;					\
	if (!FIT_IN(st->f_bavail, buf.f_bavail))			\
		return -EOVERFLOW;					\
	buf.f_bavail = st->f_bavail;					\
	if (!FIT_IN(st->f_files, buf.f_files) && st->f_files != -1)	\
		return -EOVERFLOW;					\
	buf.f_files = st->f_files;					\
	if (!FIT_IN(st->f_ffree, buf.f_ffree) && st->f_ffree != -1)	\
		return -EOVERFLOW;					\
	buf.f_ffree = st->f_ffree;					\
	buf.f_fsid = st->f_fsid;					\
	buf.f_namelen = st->f_namelen;					\
	if (!FIT_IN(st->f_frsize, buf.f_frsize))			\
		return -EOVERFLOW;					\
	buf.f_frsize = st->f_frsize;					\
	buf.f_flags = st->f_flags;					\
	if (copy_to_user(p, &buf, sizeof(buf)))				\
		return -EFAULT;						\
	return 0;							\
}

STATFS_COPYOUT(statfs)
STATFS_COPYOUT(compat_statfs)
STATFS_COPYOUT(statfs64)
STATFS_COPYOUT(compat_statfs64)

providing all the copyout helpers should be reasonably sane, IMO.

As for the convoluted macros Sergey has proposed...  Not without a very
good evidence that they win enough performance to be worth the complexity.

Comments?  Again, my apologies for losing that thread back then - I've just
found it while doing (unrelated) grep through the old mailboxen...
