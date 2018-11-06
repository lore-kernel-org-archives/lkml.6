Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F120B20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F120B20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbeKGJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:16:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47846 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeKGJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:16:27 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D5B48F5;
        Tue,  6 Nov 2018 23:48:42 +0000 (UTC)
Date:   Tue, 6 Nov 2018 15:48:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-Id: <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
In-Reply-To: <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
References: <20181029192521.23059-1-dave@stgolabs.net>
        <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 23:04:45 +0000 Daniel Colascione <dancol@google.com> wrote:

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

Yup.  There are better ways of getting information out of the kernel,
to say the least.

It would be interesting to know precisely which stat fields the
database-which-shall-not-be-named is looking for.  Then we could cook
up a very whizzy way of getting at the info.

A downside of the stat2 approach is that applications will need to be
rebuilt.  And hopefully when people do this, they'll open
"/etc/my-app-name/symlink-to-proc-stat" (or use per-application config)
so they won't need a rebuild when we add /proc/stat3!

A /proc/change-how-stat-works tunable would avoid the need to rebuild
applications.  But if a system still has some applications which want
the irq info then that doesn't work.

It's all very sad, really.

btw,

> +The stat2 file acts as a performance alternative to /proc/stat for workloads
> +and systems that care and are under heavy irq load. In order to to be completely
> +compatible, /proc/stat and /proc/stat2 are identical with the exception that the
> +later will show 0 for any (hard)irq-related fields. This refers particularly

"latter"

> +to the "intr" line and 'irq' column for that aggregate in the cpu line.

btw2, please quantify "poor performance".  That helps us determine how
much we care about all of this!
