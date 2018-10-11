Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4489C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E89920658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E89920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeJLBkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeJLBkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:40:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6116380F7C;
        Thu, 11 Oct 2018 18:11:44 +0000 (UTC)
Received: from redhat.com (ovpn-122-251.rdu2.redhat.com [10.10.122.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F517764F2;
        Thu, 11 Oct 2018 18:11:43 +0000 (UTC)
Date:   Thu, 11 Oct 2018 14:11:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Message-ID: <20181011140837-mutt-send-email-mst@kernel.org>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
 <56957D54.5000602@zytor.com>
 <20160126101921-mutt-send-email-mst@redhat.com>
 <20181011173707.26pekp65tlipvhdx@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011173707.26pekp65tlipvhdx@alap3.anarazel.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 11 Oct 2018 18:11:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:37:07AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2016-01-26 10:20:14 +0200, Michael S. Tsirkin wrote:
> > On Tue, Jan 12, 2016 at 02:25:24PM -0800, H. Peter Anvin wrote:
> > > On 01/12/16 14:10, Michael S. Tsirkin wrote:
> > > > mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
> > > > 2 to 3 times slower than lock; addl $0,(%%e/rsp) that we use on older CPUs.
> > > > 
> > > > So let's use the locked variant everywhere - helps keep the code simple as
> > > > well.
> > > > 
> > > > While I was at it, I found some inconsistencies in comments in
> > > > arch/x86/include/asm/barrier.h
> > > > 
> > > > I hope I'm not splitting this up too much - the reason is I wanted to isolate
> > > > the code changes (that people might want to test for performance) from comment
> > > > changes approved by Linus, from (so far unreviewed) comment change I came up
> > > > with myself.
> > > > 
> > > > Lightly tested on my system.
> > > > 
> > > > Michael S. Tsirkin (3):
> > > >   x86: drop mfence in favor of lock+addl
> > > >   x86: drop a comment left over from X86_OOSTORE
> > > >   x86: tweak the comment about use of wmb for IO
> > > > 
> > > 
> > > I would like to get feedback from the hardware team about the
> > > implications of this change, first.
> 
> > Any luck getting some feedback on this one?
> 
> Ping?  I just saw a bunch of kernel fences in a benchmark, making me
> wonder why linux uses mfence rather than lock addl. Leading me to this
> thread.
> 
> Greetings,
> 
> Andres Freund

It doesn't do it for smp_mb any longer:

commit 450cbdd0125cfa5d7bbf9e2a6b6961cc48d29730
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Fri Oct 27 19:14:31 2017 +0300

    locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE


I didn't bother with mb() since I didn't think it's performance
critical, and one needs to worry about drivers possibly doing
non-temporals etc which do need mfence.

Do you see mb() in a benchmark then?

-- 
MST
