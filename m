Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeESDdv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 23:33:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37274 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeESDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 23:33:49 -0400
X-Google-Smtp-Source: AB8JxZr6vQRT6zUnAUl76DQvK3024y9vJ4l+QReexqk/9Q9dD4lDBA8ckmkpeRXnRl9XwzSFAqxZhQ6pWTPeqY7A+EE=
MIME-Version: 1.0
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
 <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
In-Reply-To: <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 20:33:37 -0700
Message-ID: <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix mmap() for /proc/vmcore
To: gor@linux.ibm.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 8:20 PM Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> I'd *much* rather just set FMODE_UNSIGNED_OFFSET for /proc/vmcore _only_,
> rather than open up all proc files to issues with 4G+ offsets.

Hmm. I was going to point to the s_maxbytes check in rw_verify_area() and
ask you how that ever worked for that file, but it's not there, the
s_maxbyte checks are only in lseek and in do_splice().

So apparently we protect against llseek + read/write, but we don't protect
against pread64/pwrite64 having offset overflows..

That's crazy. That makes all the s_maxbytes protection much less effective
than it should be. Filesystems that don't get the 64-bit case right will
screw up pread64 and friends.

Al, I'm missing something. Did we always have this gaping hole where we
didn't actually check s_maxbytes against read/write, only
generic_file_llseek? Apparently.

               Linus
