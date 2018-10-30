Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEDC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC912080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC912080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeJ3JuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:50:00 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:59378 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeJ3JuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:50:00 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 9B5CC1A402D8; Mon, 29 Oct 2018 17:58:45 -0700 (PDT)
Date:   Mon, 29 Oct 2018 17:58:45 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181030005845.c3x2z72ns4qhbida@shells.gnugeneration.com>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:04:45PM +0000, Daniel Colascione wrote:
> On Mon, Oct 29, 2018 at 7:25 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> > This patch introduces a new /proc/stat2 file that is identical to the
> > regular 'stat' except that it zeroes all hard irq statistics. The new
> > file is a drop in replacement to stat for users that need performance.
> 
> For a while now, I've been thinking over ways to improve the
> performance of collecting various bits of kernel information. I don't
> think that a proliferation of special-purpose named bag-of-fields file
> variants is the right answer, because even if you add a few info-file
> variants, you're still left with a situation where a given file
> provides a particular caller with too little or too much information.
> I'd much rather move to a model in which userspace *explicitly* tells
> the kernel which fields it wants, with the kernel replying with just
> those particular fields, maybe in their raw binary representations.
> The ASCII-text bag-of-everything files would remain available for
> ad-hoc and non-performance critical use, but programs that cared about
> performance would have an efficient bypass. One concrete approach is
> to let users open up today's proc files and, instead of read(2)ing a
> text blob, use an ioctl to retrieve specified and targeted information
> of the sort that would normally be encoded in the text blob. Because
> callers would open the same file when using either the text or binary
> interfaces, little would have to change, and it'd be easy to implement
> fallbacks when a particular system doesn't support a particular
> fast-path ioctl.


We have two extremes of granularity in the /proc and /sys virtual
filesystems today:

On procfs there's these legacy files which aggregate loosely-related
system information, and in cases where you actually want most of what's
provided, it's a nice optimization because you can sample it all in a
single pread() call.

On sysfs the granularity is much finer with it being fairly common to
find a file-per-datum.  This has other advantages, like not needing to
parse snowflake formats which sometimes varied across kernel versions
like in procfs, or needing to burden the kernel to produce more
information than necessary.

But anyone who has written tools trying to sample large subsets of the
granular information in sysfs at a high rate will know how quickly it
becomes rather costly in terms of system calls.

The last time I went down this path, I wished there were a system call
like readv() which accepted a vector a new iovec type specifying an fd.

Then the sysfs model could be made a more efficient by coalescing all
the required read syscalls into a single megaread bundling all the
relevant fds that are simply kept open and reused.

If we had such a readv() variant, the sysfs granular model could be used
to granularly expose all the information we currently expose in /proc,
while still being relatively efficient in terms of system calls per
sample.  Sure you still have to lookup and open all the files of
interest, but that only needs to occur once at initialization.

Regards,
Vito Caputo
