Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A9CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33009218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfAYSDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:03:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38979 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:03:31 -0500
Received: from [79.234.67.100] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gn5p8-0002ob-MF; Fri, 25 Jan 2019 19:03:26 +0100
Date:   Fri, 25 Jan 2019 19:03:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, srinivas.eeda@oracle.com,
        bp@suse.de, tim.c.chen@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com
Subject: Re: [PATCH] x86/speculation: Update TIF_SPEC_IB before ibpb
 barrier
In-Reply-To: <alpine.DEB.2.21.1901251637480.1622@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901251858280.1622@nanos.tec.linutronix.de>
References: <48a105d3-fa32-40e4-9775-37d49f42eac0@default> <alpine.DEB.2.21.1901231335570.1628@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901251637480.1622@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Thomas Gleixner wrote:
> On Wed, 23 Jan 2019, Thomas Gleixner wrote:
> 
> > On Fri, 18 Jan 2019, Zhenzhong Duan wrote:
> > 
> > > When a task is set for updating TIF_SPEC_IB throuth SECCOMP by others
> > > and it's scheduled in the first time, a stale TIF_SPEC_IB value is
> > > picked in cond_ibpb(). This is due to TIF_SPEC_IB is updated later at
> > > __switch_to_xtra().
> > > 
> > > Add an extra call to speculation_ctrl_update_tif() to update it before
> > > IBPB barrier.
> > 
> > Errm. No. It adds that call to speculation_ctrl_update_tif() for every
> > mm switch, most of the time for nothing.
> > 
> > If at all, and we discussed that before and decided not to worry about it
> > (because it gets fixed up on the next context switch), then you want to
> > handle ibpb() from there:
> 
> Actually we need to do that. It's not only the scheduled in first
> problem. That whole thing might become completely stale in either
> direction. Care to whip up a patch?

Bah, nonsense. Brain was clearly still out for lunch and I confused IBPB
and STIBP for a moment. cond_ibpb() is the thing issues in switch_mm() and
that is not leaving a stale MSR around because we only write to it when we
need the barrier. The bit is not stale because the barrier is only issued
with the write. The bit has not to be cleared.

So the only 'issue' what happens is that switch_to() either issues a
barrier too much or misses one. That's really not a problem.

Thanks,

	tglx


