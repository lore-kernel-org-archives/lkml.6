Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00912087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546963868;
	bh=eg72T+hSyR8rpbWCy8OaDldw2lOsIjv336rj3E0sTHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G7TOlwj4qOehsTIMTLOlMWWNtiCmJ4LISjzrPLQaPgZpaTAcPO/vJyElQ4/d2tCQz
	 WSycUQ2azMFU0vcaFr1MZ6az+Mk7IKckPTWsQPGAmVIuuC2TGDTQcoPAXBjvuabu9i
	 eWQav4nwlfwRCDHxIO/IZwPSFWLF3h4YhkKENXw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfAHQLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729077AbfAHQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:11:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 325D8B0A3;
        Tue,  8 Jan 2019 16:11:02 +0000 (UTC)
Date:   Tue, 8 Jan 2019 17:11:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/2] /proc/stat: Reduce irqs counting performance overhead
Message-ID: <20190108161100.GE31793@dhcp22.suse.cz>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
 <20190107223214.GZ6311@dastard>
 <9b4208b7-f97b-047c-4dab-15bd3791e7de@redhat.com>
 <20190108020422.GA27534@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108020422.GA27534@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 13:04:22, Dave Chinner wrote:
> On Mon, Jan 07, 2019 at 05:41:39PM -0500, Waiman Long wrote:
> > On 01/07/2019 05:32 PM, Dave Chinner wrote:
> > > On Mon, Jan 07, 2019 at 10:12:56AM -0500, Waiman Long wrote:
> > >> As newer systems have more and more IRQs and CPUs available in their
> > >> system, the performance of reading /proc/stat frequently is getting
> > >> worse and worse.
> > > Because the "roll-your-own" per-cpu counter implementaiton has been
> > > optimised for low possible addition overhead on the premise that
> > > summing the counters is rare and isn't a performance issue. This
> > > patchset is a direct indication that this "summing is rare and can
> > > be slow" premise is now invalid.
> > >
> > > We have percpu counter infrastructure that trades off a small amount
> > > of addition overhead for zero-cost reading of the counter value.
> > > i.e. why not just convert this whole mess to percpu_counters and
> > > then just use percpu_counter_read_positive()? Then we just don't
> > > care how often userspace reads the /proc file because there is no
> > > summing involved at all...
> > >
> > > Cheers,
> > >
> > > Dave.
> > 
> > Yes, percpu_counter_read_positive() is cheap. However, you still need to
> > pay the price somewhere. In the case of percpu_counter, the update is
> > more expensive.
> 
> Ummm, that's exactly what I just said. It's a percpu counter that
> solves the "sum is expensive and frequent" problem, just like you
> are encountering here. I do not need basic scalability algorithms
> explained to me.
> 
> > I would say the percentage of applications that will hit this problem is
> > small. But for them, this problem has some significant performance overhead.
> 
> Well, duh!
> 
> What I was suggesting is that you change the per-cpu counter
> implementation to the /generic infrastructure/ that solves this
> problem, and then determine if the extra update overhead is at all
> measurable. If you can't measure any difference in update overhead,
> then slapping complexity on the existing counter to attempt to
> mitigate the summing overhead is the wrong solution.
> 
> Indeed, it may be that you need o use a custom batch scaling curve
> for the generic per-cpu coutner infrastructure to mitigate the
> update overhead, but the fact is we already have generic
> infrastructure that solves your problem and so the solution should
> be "use the generic infrastructure" until it can be proven not to
> work.
> 
> i.e. prove the generic infrastructure is not fit for purpose and
> cannot be improved sufficiently to work for this use case before
> implementing a complex, one-off snowflake counter implementation...

Completely agreed! Apart from that I find that conversion to a generic
infrastructure worth even if that doesn't solve the problem at hands
completely. If for no other reasons then the sheer code removal as kstat
is not really used for anything apart from this accounting AFAIR. The
less ad-hoc code we have the better IMHO.

And to the underlying problem. Some proc files do not scale on large
machines. Maybe it is time to explain that to application writers that
if they are collecting data too agressively then it won't scale. We can
only do this much. Lying about numbers by hiding updates is, well,
lying and won't solve the underlying problem. 
-- 
Michal Hocko
SUSE Labs
