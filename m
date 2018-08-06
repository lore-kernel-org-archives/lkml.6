Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB5BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0126721A3B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0126721A3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeHFXOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:14:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49420 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:14:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fmmfA-0007ok-BQ; Mon, 06 Aug 2018 21:03:36 +0000
Date:   Mon, 6 Aug 2018 22:03:36 +0100
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
Message-ID: <20180806210336.GN15082@ZenIV.linux.org.uk>
References: <20171005183636.20732-1-sergey.m.klyaus@gmail.com>
 <20171005205724.GJ21978@ZenIV.linux.org.uk>
 <CA+55aFx7d2+GG=0LqMejiK=ZADxX347v_m0S4WzrnQ=1FoyP8A@mail.gmail.com>
 <20171005230633.GK21978@ZenIV.linux.org.uk>
 <CA+55aFzJYXCNPXT8D91FmjU2AWOfvWMnx2BZE+0CLgBcqX3u1g@mail.gmail.com>
 <20180806170634.GA2490@ZenIV.linux.org.uk>
 <CA+55aFy0E1nm=YH_TMH9wUGuBHRit=_d+WQ_H88b_8Cp0fR+Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy0E1nm=YH_TMH9wUGuBHRit=_d+WQ_H88b_8Cp0fR+Rg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 11:45:29AM -0700, Linus Torvalds wrote:
> On Mon, Aug 6, 2018 at 10:06 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That leaves us with f_bsize and f_frsize (the latter defaulting to the former).
> > Hugetlbfs can put greater than 4Gb values in there, for really huge pages.
> > And that's the only thing worth checking in there.
> >
> > So the whole put_compat_statfs64() thing should be
> 
> Ack, I'm ok with this simplification.
> 
> > I'm somewhat tempted to get rid of those 'long' in struct kstatfs,
> 
> I'm ok with this one too.
> 
> > with
> >
> > #define STATFS_COPYOUT(type)                                            \
> > static int put##type(struct kstatfs *st, struct type __user *p)         \
> 
> No. Don't do this.
> 
> I'm ok with the #define to avoid duplication, but don't bother with
> the FIT_IN() after you've above successfully argued that it's
> pointless for anything but f_bsize/frsize.
> 
> So if you do the macro to generate the different copyout versions,
> just use your simplified code for that macro instead. With FIT_IN()
> just for f_bsize/frsize.

For statfs64 (both native and compat) that would do nicely; for statfs,
however...  The following describes the field sizes in all that mess:

        kstatfs	statfs          statfs64        compat_statfs compat_statfs64
       		!s390   s390   !s390   s390
type:   W	W       32      W       32              32      32
namelen:W	W       32      W       32              32      32
flags:  W	W       32      W       32              32      32
bsize:  W	W       32      W       32              32      32
frsize: W	W       32      W       32              32      32
blocks: 64	W       64      64      64              32      64
bfree:  64	W       64      64      64              32      64
bavail: 64	W       64      64      64              32      64
files:  64	W       64      64      64              32      64
ffree:  64	W       64      64      64              32      64
fsid:   __kernel_fsid_t on all

First of all, nobody gives a fuck about type, namelen and flags
overflows - can't happen.

blocks/bfree/bavail/files/ffree: can overflow in plain statfs on 32bit
and in compat statfs.  For files/ffree we also have "-1 means (s32)-1,
not an overflow" there.

bsize/frsize: can oveflow in anything on s390 or mips64 and any compat on anything

Oh, and then there's signedness - in compat_statfs64 everything's unsigned,
but for compat_statfs a bunch of those 32bit ones are signed.  Native on
32bit tend to be unsigned; native on 64bit and compat are often signed.
IMO that's a bug - compat ones should all be same as native 32bit.
As it is,
	arm, parisc, ppc, sparc, x86: on 32bit - unsigned, compat on 64bit - signed
	mips: both signed
	s390: both unsigned
I think we want to switch compat_statfs fields on the first group to u32.  These
declarations are not exposed to userland anyway.  mips is interesting - I've no
idea how does mips32 userland react to e.g. statfs() on 3G block filesystem...
