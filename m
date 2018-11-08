Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD13C20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD13C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeKHLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:41:03 -0500
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:58236 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728460AbeKHLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:41:03 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 08 Nov 2018 12:37:51 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gKZja-0000rf-Bk; Thu, 08 Nov 2018 13:07:50 +1100
Date:   Thu, 8 Nov 2018 13:07:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181108020750.GZ6311@dastard>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
 <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:03:06AM +0100, Miklos Szeredi wrote:
> On Wed, Nov 7, 2018 at 12:48 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Mon, 29 Oct 2018 23:04:45 +0000 Daniel Colascione <dancol@google.com> wrote:
> >
> >> On Mon, Oct 29, 2018 at 7:25 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> >> > This patch introduces a new /proc/stat2 file that is identical to the
> >> > regular 'stat' except that it zeroes all hard irq statistics. The new
> >> > file is a drop in replacement to stat for users that need performance.
> >>
> >> For a while now, I've been thinking over ways to improve the
> >> performance of collecting various bits of kernel information. I don't
> >> think that a proliferation of special-purpose named bag-of-fields file
> >> variants is the right answer, because even if you add a few info-file
> >> variants, you're still left with a situation where a given file
> >> provides a particular caller with too little or too much information.
> >> I'd much rather move to a model in which userspace *explicitly* tells
> >> the kernel which fields it wants, with the kernel replying with just
> >> those particular fields, maybe in their raw binary representations.
> >> The ASCII-text bag-of-everything files would remain available for
> >> ad-hoc and non-performance critical use, but programs that cared about
> >> performance would have an efficient bypass. One concrete approach is
> >> to let users open up today's proc files and, instead of read(2)ing a
> >> text blob, use an ioctl to retrieve specified and targeted information
> >> of the sort that would normally be encoded in the text blob. Because
> >> callers would open the same file when using either the text or binary
> >> interfaces, little would have to change, and it'd be easy to implement
> >> fallbacks when a particular system doesn't support a particular
> >> fast-path ioctl.
> 
> Please.   Sysfs, with the one value per file rule, was created exactly
> for the purpose of eliminating these sort of problems with procfs.  So
> instead of inventing special purpose interfaces for proc, just make
> the info available in sysfs, if not already available.

This doesn't solve the problem.

The problem is that this specific implementation of per-cpu
counters need to be summed on every read. Hence when you have a huge
number of CPUs each per-cpu iteration that takes a substantial
amount of time.

If only we had percpu counters that had a fixed, extremely low read
overhead that doesn't care about the number of CPUs in the
machine....

Oh, wait, we do: percpu_counters.[ch].

This all seems like a counter implementation deficiency to me, not
an interface problem...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
