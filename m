Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B49C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FC920665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfAHW1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:27:24 -0500
Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:46766
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729042AbfAHW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:27:24 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl6.internode.on.net with ESMTP; 09 Jan 2019 08:57:05 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1ggzpw-0000BO-PR; Wed, 09 Jan 2019 09:27:04 +1100
Date:   Wed, 9 Jan 2019 09:27:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190108222704.GD27534@dastard>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
 <20190107223214.GZ6311@dastard>
 <9b4208b7-f97b-047c-4dab-15bd3791e7de@redhat.com>
 <20190108020422.GA27534@dastard>
 <56954b42-4258-7268-53b5-ddca28758193@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56954b42-4258-7268-53b5-ddca28758193@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:58:26AM -0500, Waiman Long wrote:
> On 01/07/2019 09:04 PM, Dave Chinner wrote:
> > On Mon, Jan 07, 2019 at 05:41:39PM -0500, Waiman Long wrote:
> >> On 01/07/2019 05:32 PM, Dave Chinner wrote:
> >>> On Mon, Jan 07, 2019 at 10:12:56AM -0500, Waiman Long wrote:
> > What I was suggesting is that you change the per-cpu counter
> > implementation to the /generic infrastructure/ that solves this
> > problem, and then determine if the extra update overhead is at all
> > measurable. If you can't measure any difference in update overhead,
> > then slapping complexity on the existing counter to attempt to
> > mitigate the summing overhead is the wrong solution.
> >
> > Indeed, it may be that you need o use a custom batch scaling curve
> > for the generic per-cpu coutner infrastructure to mitigate the
> > update overhead, but the fact is we already have generic
> > infrastructure that solves your problem and so the solution should
> > be "use the generic infrastructure" until it can be proven not to
> > work.
> >
> > i.e. prove the generic infrastructure is not fit for purpose and
> > cannot be improved sufficiently to work for this use case before
> > implementing a complex, one-off snowflake counter implementation...
> 
> I see your point. I like the deferred summation approach that I am
> currently using. If I have to modify the current per-cpu counter
> implementation to support that

No! Stop that already. The "deferred counter summation" is exactly
the problem the current algorithm has and exactly the problem the
generic counters /don't have/. Changing the generic percpu counter
algorithm to match this specific hand rolled implementation is not
desirable as it will break implementations that rely on the
bound maximum summation deviation of the existing algorithm (e.g.
the ext4 and XFS ENOSPC accounting algorithms).

> and I probably need to add counter
> grouping support to amortize the overhead, that can be a major

The per-cpu counters already have configurable update batching
to amortise the summation update cost across multiple individual
per-cpu updates. You don't need to change the implementation at all,
just tweak the amortisation curve appropriately for the desired
requirements for update scalability (high) vs read accuracy (low).

Let's face it, on large systems where counters are frequently
updated, the resultant sum can be highly inaccurate by the time a
thousand CPU counters have been summed. The generic counters have a
predictable and bound "fast sum" maximum deviation (batch size *
nr_cpus), so over large machines are likely to be much more accurate
than "unlocked summing on demand" algorithms.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
