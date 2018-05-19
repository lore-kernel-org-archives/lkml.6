Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeESDnn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 23:43:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59846 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeESDnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 23:43:42 -0400
Date: Sat, 19 May 2018 04:43:38 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gor@linux.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] procfs: fix mmap() for /proc/vmcore
Message-ID: <20180519034338.GV30522@ZenIV.linux.org.uk>
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
 <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
 <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:33:37PM -0700, Linus Torvalds wrote:
> On Fri, May 18, 2018 at 8:20 PM Linus Torvalds <
> torvalds@linux-foundation.org> wrote:
> 
> > I'd *much* rather just set FMODE_UNSIGNED_OFFSET for /proc/vmcore _only_,
> > rather than open up all proc files to issues with 4G+ offsets.
> 
> Hmm. I was going to point to the s_maxbytes check in rw_verify_area() and
> ask you how that ever worked for that file, but it's not there, the
> s_maxbyte checks are only in lseek and in do_splice().
> 
> So apparently we protect against llseek + read/write, but we don't protect
> against pread64/pwrite64 having offset overflows..
> 
> That's crazy. That makes all the s_maxbytes protection much less effective
> than it should be. Filesystems that don't get the 64-bit case right will
> screw up pread64 and friends.
> 
> Al, I'm missing something. Did we always have this gaping hole where we
> didn't actually check s_maxbytes against read/write, only
> generic_file_llseek? Apparently.

Not quite.  The things like
        if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
                return 0;
        iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
protect most of the regular files (see mm/filemap.c).  And for devices (which is
where the majority of crap ->read()/->write() is) it's obviously not applicable -
->s_maxbytes of *what*?
