Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754933AbeEaMho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:37:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754197AbeEaMhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:37:41 -0400
Date: Thu, 31 May 2018 08:37:39 -0400
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
Message-ID: <20180531123738.GA10552@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31 2018 at  4:37am -0400,
Sagi Grimberg <sagi@grimberg.me> wrote:

> 
> >Wouldn't expect you guys to nurture this 'mpath_personality' knob.  SO
> >when features like "dispersed namespaces" land a negative check would
> >need to be added in the code to prevent switching from "native".
> >
> >And once something like "dispersed namespaces" lands we'd then have to
> >see about a more sophisticated switch that operates at a different
> >granularity.  Could also be that switching one subsystem that is part of
> >"dispersed namespaces" would then cascade to all other associated
> >subsystems?  Not that dissimilar from the 3rd patch in this series that
> >allows a 'device' switch to be done in terms of the subsystem.
> 
> Which I think is broken by allowing to change this personality on the
> fly.

I saw your reply to the 1/3 patch.. I do agree it is broken for not
checking if any handles are active.  But that is easily fixed no?

Or are you suggesting some other aspect of "broken"?

> >Anyway, I don't know the end from the beginning on something you just
> >told me about ;)  But we're all in this together.  And can take it as it
> >comes.
> 
> I agree but this will be exposed to user-space and we will need to live
> with it for a long long time...

OK, well dm-multipath has been around for a long long time.  We cannot
simply wish it away.  Regardless of whatever architectural grievances
are levied against it.

There are far more customer and vendor products that have been developed
to understand and consume dm-multipath and multipath-tools interfaces
than native NVMe multipath.

> >>Don't get me wrong, I do support your cause, and I think nvme should try
> >>to help, I just think that subsystem granularity is not the correct
> >>approach going forward.
> >
> >I understand there will be limits to this 'mpath_personality' knob's
> >utility and it'll need to evolve over time.  But the burden of making
> >more advanced NVMe multipath features accessible outside of native NVMe
> >isn't intended to be on any of the NVMe maintainers (other than maybe
> >remembering to disallow the switch where it makes sense in the future).
> 
> I would expect that any "advanced multipath features" would be properly
> brought up with the NVMe TWG as a ratified standard and find its way
> to nvme. So I don't think this particularly is a valid argument.

You're misreading me again.  I'm also saying stop worrying.  I'm saying
any future native NVMe multipath features that come about don't necessarily
get immediate dm-multipath parity.  The native NVMe multipath would need
appropriate negative checks.
 
> >>As I said, I've been off the grid, can you remind me why global knob is
> >>not sufficient?
> >
> >Because once nvme_core.multipath=N is set: native NVMe multipath is then
> >not accessible from the same host.  The goal of this patchset is to give
> >users choice.  But not limit them to _only_ using dm-multipath if they
> >just have some legacy needs.
> >
> >Tough to be convincing with hypotheticals but I could imagine a very
> >obvious usecase for native NVMe multipathing be PCI-based embedded NVMe
> >"fabrics" (especially if/when the numa-based path selector lands).  But
> >the same host with PCI NVMe could be connected to a FC network that has
> >historically always been managed via dm-multipath.. but say that
> >FC-based infrastructure gets updated to use NVMe (to leverage a wider
> >NVMe investment, whatever?) -- but maybe admins would still prefer to
> >use dm-multipath for the NVMe over FC.
> 
> You are referring to an array exposing media via nvmf and scsi
> simultaneously? I'm not sure that there is a clean definition of
> how that is supposed to work (ANA/ALUA, reservations, etc..)

No I'm referring to completely disjoint arrays that are homed to the
same host.

> >>This might sound stupid to you, but can't users that desperately must
> >>keep using dm-multipath (for its mature toolset or what-not) just
> >>stack it on multipath nvme device? (I might be completely off on
> >>this so feel free to correct my ignorance).
> >
> >We could certainly pursue adding multipath-tools support for native NVMe
> >multipathing.  Not opposed to it (even if just reporting topology and
> >state).  But given the extensive lengths NVMe multipath goes to hide
> >devices we'd need some way to piercing through the opaque nvme device
> >that native NVMe multipath exposes.  But that really is a tangent
> >relative to this patchset.  Since that kind of visibility would also
> >benefit the nvme cli... otherwise how are users to even be able to trust
> >but verify native NVMe multipathing did what it expected it to?
> 
> Can you explain what is missing for multipath-tools to resolve topology?

I've not poured over these nvme interfaces (below I just learned
nvme-cli has since grown the capability).   SO I'm not informed enough
to know if nvme cli has grown other new capabilities.

In any case, training multipath-tools to understand native NVMe
multipath topology doesn't replace actual dm-multipath interface and
associated information.

Per-device statistics is something that users want to be able to see.
Per-device up/down state, etc.

> nvme list-subsys is doing just that, doesn't it? It lists subsys-ctrl
> topology but that is sort of the important information as controllers
> are the real paths.

I had nvme cli version 1.4; which doesn't have nvme list-subsys.
Which means I need to uninstall the distro provided
nvme-cli-1.4-3.el7.x86_64 and find the relevant upstream and build from
src.... 

Yes, this looks like the basic topology info I was hoping for:

# nvme list-subsys
nvme-subsys0 - NQN=nqn.2014.08.org.nvmexpress:80868086PHMB7361004R280CGN  INTEL SSDPED1D280GA
\
 +- nvme0 pcie 0000:5e:00.0
nvme-subsys1 - NQN=mptestnqn
\
 +- nvme1 fc traddr=nn-0x200140111111dbcc:pn-0x100140111111dbcc host_traddr=nn-0x200140111111dac8:pn-0x100140111111dac8
 +- nvme2 fc traddr=nn-0x200140111111dbcd:pn-0x100140111111dbcd host_traddr=nn-0x200140111111dac9:pn-0x100140111111dac9
 +- nvme3 fc traddr=nn-0x200140111111dbce:pn-0x100140111111dbce host_traddr=nn-0x200140111111daca:pn-0x100140111111daca
 +- nvme4 fc traddr=nn-0x200140111111dbcf:pn-0x100140111111dbcf host_traddr=nn-0x200140111111dacb:pn-0x100140111111dacb
