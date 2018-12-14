Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524EBC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228E7208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228E7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeLNMdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbeLNMdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:33:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6126300156E;
        Fri, 14 Dec 2018 12:33:21 +0000 (UTC)
Received: from redhat.com (ovpn-121-101.rdu2.redhat.com [10.10.121.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3468E600C0;
        Fri, 14 Dec 2018 12:33:21 +0000 (UTC)
Date:   Fri, 14 Dec 2018 07:33:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
Message-ID: <20181214072334-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213102315-mutt-send-email-mst@kernel.org>
 <9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Dec 2018 12:33:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:42:18AM +0800, Jason Wang wrote:
> 
> On 2018/12/13 下午11:27, Michael S. Tsirkin wrote:
> > On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
> > > Hi:
> > > 
> > > This series tries to access virtqueue metadata through kernel virtual
> > > address instead of copy_user() friends since they had too much
> > > overheads like checks, spec barriers or even hardware feature
> > > toggling.
> > Userspace accesses through remapping tricks and next time there's a need
> > for a new barrier we are left to figure it out by ourselves.
> 
> 
> I don't get here, do you mean spec barriers?

I mean the next barrier people decide to put into userspace
memory accesses.

> It's completely unnecessary for
> vhost which is kernel thread.

It's defence in depth. Take a look at the commit that added them.
And yes quite possibly in most cases we actually have a spec
barrier in the validation phase. If we do let's use the
unsafe variants so they can be found.

> And even if you're right, vhost is not the
> only place, there's lots of vmap() based accessing in kernel.

For sure. But if one can get by without get user pages, one
really should. Witness recently uncovered mess with file
backed storage.

> Think in
> another direction, this means we won't suffer form unnecessary barriers for
> kthread like vhost in the future, we will manually pick the one we really
> need

I personally think we should err on the side of caution not on the side of
performance.

> (but it should have little possibility).

History seems to teach otherwise.

> Please notice we only access metdata through remapping not the data itself.
> This idea has been used for high speed userspace backend for years, e.g
> packet socket or recent AF_XDP.

I think their justification for the higher risk is that they are mostly
designed for priveledged userspace.

> The only difference is the page was remap to
> from kernel to userspace.

At least that avoids the g.u.p mess.

> 
> >    I don't
> > like the idea I have to say.  As a first step, why don't we switch to
> > unsafe_put_user/unsafe_get_user etc?
> 
> 
> Several reasons:
> 
> - They only have x86 variant, it won't have any difference for the rest of
> architecture.

Is there an issue on other architectures? If yes they can be extended
there.

> - unsafe_put_user/unsafe_get_user is not sufficient for accessing structures
> (e.g accessing descriptor) or arrays (batching).

So you want unsafe_copy_xxx_user? I can do this. Hang on will post.

> - Unless we can batch at least the accessing of two places in three of
> avail, used and descriptor in one run. There will be no difference. E.g we
> can batch updating used ring, but it won't make any difference in this case.
> 

So let's batch them all?


> > That would be more of an apples to apples comparison, would it not?
> 
> 
> Apples to apples comparison only help if we are the No.1. But the fact is we
> are not. If we want to compete with e.g dpdk or AF_XDP, vmap() is the
> fastest method AFAIK.
> 
> 
> Thanks

We need to speed up the packet access itself too though.
You can't vmap all of guest memory.


> 
> > 
> > 
> > > Test shows about 24% improvement on TX PPS. It should benefit other
> > > cases as well.
> > > 
> > > Please review
> > > 
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
