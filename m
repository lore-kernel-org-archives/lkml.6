Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5653C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981DC20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981DC20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbeGKQUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:20:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38518 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:20:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdHmG-0004uZ-DQ; Wed, 11 Jul 2018 16:15:40 +0000
Date:   Wed, 11 Jul 2018 17:15:40 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [RFC][PATCH 01/42] drm_mode_create_lease_ioctl(): fix open-coded
 filp_clone_open()
Message-ID: <20180711161540.GS30522@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711152555.GR30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:25:55PM +0100, Al Viro wrote:

> FWIW, looking at the ->f_flags handling, I'm seriously tempted to do
> alloc_file_pseudo(inode, mnt, name, f_flags, ops).
> 
> Reason: right now all but two callers of alloc_file_pseudo() are followed
> by setting ->f_flags and for all those callers the mode argument passed
> to alloc_file_pseudo() is equal to OPEN_FMODE(->f_flags value to be).
> 
> The exceptions are __shmem_file_setup() and hugetlb_file_setup().  Both
> end up with FMODE_READ | FMODE_WRITE combined with 0 (i.e. O_RDONLY) in
> f_flags.  Which smells like a bug in making, at the very least.
> 
> Unless somebody has a good reason why those shouldn't have O_RDWR,
> I want to add (and fold back into individual "convert to alloc_file_pseudo"
> commits) the following:

[snip]

> Objections?  Another odd beastie is do_shmat() - there we end up with
> f_mode not matching f_flags, same way as in shmem and hugetlb.  If we
> could rectify that one as well, we'd be able to switch alloc_file_clone()
> to flags as well.  I would obviously prefer that kind of change to happen
> before these helpers go into mainline...

Actually, looking at the entire thing, I'm rather tempted to go for
	alloc_empty_file(f_flags, cred)
setting both f_flags and f_flags-derived part of f_mode, making
	alloc_file_pseudo(inode, mnt, name, f_flags, ops)
	alloc_file_clone(base, f_flags, ops)
do the same automatically as they call alloc_empty_file().

do_dentry_open() would, instead of
        f->f_mode |= OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
                                FMODE_PREAD | FMODE_PWRITE;
do just
        f->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
just before calling ->open(), with comment along the lines of
"usually we want those set; let ->open() remove the wrong ones
if it wants to".
