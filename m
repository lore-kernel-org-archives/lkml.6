Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932588AbeE3WCL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:02:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932222AbeE3WCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:02:08 -0400
Date: Wed, 30 May 2018 18:02:06 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180530220206.GA7037@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2018 at  5:20pm -0400,
Sagi Grimberg <sagi@grimberg.me> wrote:

> Hi Folks,
> 
> I'm sorry to chime in super late on this, but a lot has been
> going on for me lately which got me off the grid.
> 
> So I'll try to provide my input hopefully without starting any more
> flames..
> 
> >>>This patch series aims to provide a more fine grained control over
> >>>nvme's native multipathing, by allowing it to be switched on and off
> >>>on a per-subsystem basis instead of a big global switch.
> >>
> >>No.  The only reason we even allowed to turn multipathing off is
> >>because you complained about installer issues.  The path forward
> >>clearly is native multipathing and there will be no additional support
> >>for the use cases of not using it.
> >
> >We all basically knew this would be your position.  But at this year's
> >LSF we pretty quickly reached consensus that we do in fact need this.
> >Except for yourself, Sagi and afaik Martin George: all on the cc were in
> >attendance and agreed.
> 
> Correction, I wasn't able to attend LSF this year (unfortunately).

Yes, I was trying to say you weren't at LSF (but are on the cc).

> >And since then we've exchanged mails to refine and test Johannes'
> >implementation.
> >
> >You've isolated yourself on this issue.  Please just accept that we all
> >have a pretty solid command of what is needed to properly provide
> >commercial support for NVMe multipath.
> >
> >The ability to switch between "native" and "other" multipath absolutely
> >does _not_ imply anything about the winning disposition of native vs
> >other.  It is purely about providing commercial flexibility to use
> >whatever solution makes sense for a given environment.  The default _is_
> >native NVMe multipath.  It is on userspace solutions for "other"
> >multipath (e.g. multipathd) to allow user's to whitelist an NVMe
> >subsystem to be switched to "other".
> >
> >Hopefully this clarifies things, thanks.
> 
> Mike, I understand what you're saying, but I also agree with hch on
> the simple fact that this is a burden on linux nvme (although less
> passionate about it than hch).
> 
> Beyond that, this is going to get much worse when we support "dispersed
> namespaces" which is a submitted TPAR in the NVMe TWG. "dispersed
> namespaces" makes NVMe namespaces share-able over different subsystems
> so changing the personality on a per-subsystem basis is just asking for
> trouble.
> 
> Moreover, I also wanted to point out that fabrics array vendors are
> building products that rely on standard nvme multipathing (and probably
> multipathing over dispersed namespaces as well), and keeping a knob that
> will keep nvme users with dm-multipath will probably not help them
> educate their customers as well... So there is another angle to this.

Wouldn't expect you guys to nurture this 'mpath_personality' knob.  SO
when features like "dispersed namespaces" land a negative check would
need to be added in the code to prevent switching from "native".

And once something like "dispersed namespaces" lands we'd then have to
see about a more sophisticated switch that operates at a different
granularity.  Could also be that switching one subsystem that is part of
"dispersed namespaces" would then cascade to all other associated
subsystems?  Not that dissimilar from the 3rd patch in this series that
allows a 'device' switch to be done in terms of the subsystem.

Anyway, I don't know the end from the beginning on something you just
told me about ;)  But we're all in this together.  And can take it as it
comes.  I'm merely trying to bridge the gap from old dm-multipath while
native NVMe multipath gets its legs.

In time I really do have aspirations to contribute more to NVMe
multipathing.  I think Christoph's NVMe multipath implementation of
bio-based device ontop on NVMe core's blk-mq device(s) is very clever
and effective (blk_steal_bios() hack and all).

> Don't get me wrong, I do support your cause, and I think nvme should try
> to help, I just think that subsystem granularity is not the correct
> approach going forward.

I understand there will be limits to this 'mpath_personality' knob's
utility and it'll need to evolve over time.  But the burden of making
more advanced NVMe multipath features accessible outside of native NVMe
isn't intended to be on any of the NVMe maintainers (other than maybe
remembering to disallow the switch where it makes sense in the future).
 
> As I said, I've been off the grid, can you remind me why global knob is
> not sufficient?

Because once nvme_core.multipath=N is set: native NVMe multipath is then
not accessible from the same host.  The goal of this patchset is to give
users choice.  But not limit them to _only_ using dm-multipath if they
just have some legacy needs.

Tough to be convincing with hypotheticals but I could imagine a very
obvious usecase for native NVMe multipathing be PCI-based embedded NVMe
"fabrics" (especially if/when the numa-based path selector lands).  But
the same host with PCI NVMe could be connected to a FC network that has
historically always been managed via dm-multipath.. but say that
FC-based infrastructure gets updated to use NVMe (to leverage a wider
NVMe investment, whatever?) -- but maybe admins would still prefer to
use dm-multipath for the NVMe over FC.
 
> This might sound stupid to you, but can't users that desperately must
> keep using dm-multipath (for its mature toolset or what-not) just
> stack it on multipath nvme device? (I might be completely off on
> this so feel free to correct my ignorance).

We could certainly pursue adding multipath-tools support for native NVMe
multipathing.  Not opposed to it (even if just reporting topology and
state).  But given the extensive lengths NVMe multipath goes to hide
devices we'd need some way to piercing through the opaque nvme device
that native NVMe multipath exposes.  But that really is a tangent
relative to this patchset.  Since that kind of visibility would also
benefit the nvme cli... otherwise how are users to even be able to trust
but verify native NVMe multipathing did what it expected it to?

Mike
