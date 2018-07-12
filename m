Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E51C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CD120BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CD120BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeGLL7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:59:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeGLL7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:59:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90D59AEDD;
        Thu, 12 Jul 2018 11:49:48 +0000 (UTC)
Date:   Thu, 12 Jul 2018 13:49:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Message-ID: <20180712114946.GI32648@dhcp22.suse.cz>
References: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz>
 <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
 <5B46BB46.2080802@intel.com>
 <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
 <5B46C258.40601@intel.com>
 <20180712081317.GD32648@dhcp22.suse.cz>
 <5B473CB8.1050306@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B473CB8.1050306@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-07-18 19:34:16, Wei Wang wrote:
> On 07/12/2018 04:13 PM, Michal Hocko wrote:
> > On Thu 12-07-18 10:52:08, Wei Wang wrote:
> > > On 07/12/2018 10:30 AM, Linus Torvalds wrote:
> > > > On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
> > > > > Would it be better to remove __GFP_THISNODE? We actually want to get all
> > > > > the guest free pages (from all the nodes).
> > > > Maybe. Or maybe it would be better to have the memory balloon logic be
> > > > per-node? Maybe you don't want to remove too much memory from one
> > > > node? I think it's one of those "play with it" things.
> > > > 
> > > > I don't think that's the big issue, actually. I think the real issue
> > > > is how to react quickly and gracefully to "oops, I'm trying to give
> > > > memory away, but now the guest wants it back" while you're in the
> > > > middle of trying to create that 2TB list of pages.
> > > OK. virtio-balloon has already registered an oom notifier
> > > (virtballoon_oom_notify). I plan to add some control there. If oom happens,
> > > - stop the page allocation;
> > > - immediately give back the allocated pages to mm.
> > Please don't. Oom notifier is an absolutely hideous interface which
> > should go away sooner or later (I would much rather like the former) so
> > do not build a new logic on top of it. I would appreciate if you
> > actually remove the notifier much more.
> > 
> > You can give memory back from the standard shrinker interface. If we are
> > reaching low reclaim priorities then we are struggling to reclaim memory
> > and then you can start returning pages back.
> 
> OK. Just curious why oom notifier is thought to be hideous, and has it been
> a consensus?

Because it is a completely non-transparent callout from the OOM context
which is really subtle on its own. It is just too easy to end up in
weird corner cases. We really have to be careful and be as swift as
possible. Any potential sleep would make the OOM situation much worse
because nobody would be able to make a forward progress or (in)direct
dependency on MM subsystem can easily deadlock. Those are really hard
to track down and defining the notifier as blockable by design which
just asks for bad implementations because most people simply do not
realize how subtle the oom context is.

Another thing is that it happens way too late when we have basically
reclaimed the world and didn't get out of the memory pressure so you can
expect any workload is suffering already. Anybody sitting on a large
amount of reclaimable memory should have released that memory by that
time. Proportionally to the reclaim pressure ideally.

The notifier API is completely unaware of oom constrains. Just imagine
you are OOM in a subset of numa nodes. Callback doesn't have any idea
about that.

Moreover we do have proper reclaim mechanism that has a feedback
loop and that should be always preferable to an abrupt reclaim.
-- 
Michal Hocko
SUSE Labs
