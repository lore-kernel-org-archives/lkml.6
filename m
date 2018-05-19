Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeESDUk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 23:20:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37559 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeESDUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 23:20:37 -0400
X-Google-Smtp-Source: AB8JxZqO96vT3LsLXAvoyC0Oo/+PMwK8/3N+OtJizV52zP02cLY8dCy+xiIlyPSWdBdcdN7xOuJD+AmGF3z6f125/Go=
MIME-Version: 1.0
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
In-Reply-To: <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 20:20:26 -0700
Message-ID: <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
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

On Fri, May 18, 2018 at 8:15 PM Vasily Gorbik <gor@linux.ibm.com> wrote:

> Commit be83bbf80682 ("mmap: introduce sane default mmap limits")
> introduced "pgoff" limits checks for mmap, considering fs max file size
> as upper limit, which made it impossible to mmap /proc/vmcore file
> contents above 2Gb (/proc/vmcore appears to be the only procfs file
> supporting mmap).

> Reuse MAX_LFS_FILESIZE as procfs s_maxbytes value.

Ugh. /proc is where a lot of problems *have* been.

Admittedly not as much as random drivers, but still. If proc doesn't set
s_maxbytes, then we should not raise it here magically, there might be
various /proc files that get offset accounting wrong.

I'd *much* rather just set FMODE_UNSIGNED_OFFSET for /proc/vmcore _only_,
rather than open up all proc files to issues with 4G+ offsets.

                Linus
