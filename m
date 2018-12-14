Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F42C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2993C208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2993C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeLNMwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbeLNMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:52:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 361AD308A973;
        Fri, 14 Dec 2018 12:52:32 +0000 (UTC)
Received: from redhat.com (ovpn-121-101.rdu2.redhat.com [10.10.121.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660E65C257;
        Fri, 14 Dec 2018 12:52:31 +0000 (UTC)
Date:   Fri, 14 Dec 2018 07:52:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
Message-ID: <20181214073709-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213144116-mutt-send-email-mst@kernel.org>
 <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 14 Dec 2018 12:52:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:29:54PM +0800, Jason Wang wrote:
> 
> On 2018/12/14 上午4:12, Michael S. Tsirkin wrote:
> > On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
> > > Hi:
> > > 
> > > This series tries to access virtqueue metadata through kernel virtual
> > > address instead of copy_user() friends since they had too much
> > > overheads like checks, spec barriers or even hardware feature
> > > toggling.
> > > 
> > > Test shows about 24% improvement on TX PPS. It should benefit other
> > > cases as well.
> > > 
> > > Please review
> > I think the idea of speeding up userspace access is a good one.
> > However I think that moving all checks to start is way too aggressive.
> 
> 
> So did packet and AF_XDP. Anyway, sharing address space and access them
> directly is the fastest way. Performance is the major consideration for
> people to choose backend. Compare to userspace implementation, vhost does
> not have security advantages at any level. If vhost is still slow, people
> will start to develop backends based on e.g AF_XDP.
> 

Let them what's wrong with that?

> > Instead, let's batch things up but let's not keep them
> > around forever.
> > Here are some ideas:
> > 
> > 
> > 1. Disable preemption, process a small number of small packets
> >     directly in an atomic context. This should cut latency
> >     down significantly, the tricky part is to only do it
> >     on a light load and disable this
> >     for the streaming case otherwise it's unfair.
> >     This might fail, if it does just bounce things out to
> >     a thread.
> 
> 
> I'm not sure what context you meant here. Is this for TX path of TUN? But a
> fundamental difference is my series is targeted for extreme heavy load not
> light one, 100% cpu for vhost is expected.

Interesting. You only shared a TCP RR result though.
What's the performance gain in a heavy load case?

> 
> > 
> > 2. Switch to unsafe_put_user/unsafe_get_user,
> >     and batch up multiple accesses.
> 
> 
> As I said, unless we can batch accessing of two difference places of three
> of avail, descriptor and used. It won't help for batching the accessing of a
> single place like used. I'm even not sure this can be done consider the case
> of packed virtqueue, we have a single descriptor ring.

So that's one of the reasons packed should be faster. Single access
and you get the descriptor no messy redirects. Somehow your
benchmarking so far didn't show a gain with vhost and
packed though - do you know what's wrong?

> Batching through
> unsafe helpers may not help in this case since it's equivalent to safe ones
> . And This requires non trivial refactoring of vhost. And such refactoring
> itself make give us noticeable impact (e.g it may lead regression).
> 
> 
> > 
> > 3. Allow adding a fixup point manually,
> >     such that multiple independent get_user accesses
> >     can get a single fixup (will allow better compiler
> >     optimizations).
> > 
> 
> So for metadata access, I don't see how you suggest here can help in the
> case of heavy workload.
> 
> For data access, this may help but I've played to batch the data copy to
> reduce SMAP/spec barriers in vhost-net but I don't see performance
> improvement.
> 
> Thanks

So how about we try to figure what's going on actually?
Can you drop the barriers and show the same gain?
E.g. vmap does not use a huge page IIRC so in fact it
can be slower than direct access. It's not a magic
faster way.



> 
> > 
> > 
> > 
> > > Jason Wang (3):
> > >    vhost: generalize adding used elem
> > >    vhost: fine grain userspace memory accessors
> > >    vhost: access vq metadata through kernel virtual address
> > > 
> > >   drivers/vhost/vhost.c | 281 ++++++++++++++++++++++++++++++++++++++----
> > >   drivers/vhost/vhost.h |  11 ++
> > >   2 files changed, 266 insertions(+), 26 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
