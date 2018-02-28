Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeB1SjP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:39:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeB1SjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:39:13 -0500
Date: Wed, 28 Feb 2018 19:39:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <69ed85f2-b9c5-30d1-8437-45f20be3e95e@intel.com>
Message-ID: <alpine.DEB.2.21.1802281924390.1392@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
 <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de> <69ed85f2-b9c5-30d1-8437-45f20be3e95e@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

On Tue, 27 Feb 2018, Reinette Chatre wrote:
> On 2/27/2018 2:36 AM, Thomas Gleixner wrote:
> > On Mon, 26 Feb 2018, Reinette Chatre wrote:
> >> A change to start us off with could be to initialize the schemata with
> >> all the shareable and unused bits set for all domains when a new
> >> resource group is created.
> > 
> > The new resource group initialization is the least of my worries. The
> > current mode is to use the default group setting, right?
> 
> No. When a new group is created a closid is assigned to it. The schemata
> it is initialized with is the schemata the previous group with the same
> closid had. At the beginning, yes, it is the default, but later you get
> something like this:
> 
> # mkdir asd
> # cat asd/schemata
> L2:0=ff;1=ff
> # echo 'L2:0=0xf;1=0xfc' > asd/schemata
> # cat asd/schemata
> L2:0=0f;1=fc
> # rmdir asd
> # mkdir qwe
> # cat qwe/schemata
> L2:0=0f;1=fc

Ah, was not aware and did not bother to look into the code.

> The reason why I suggested this initialization is to have the defaults
> work on resource group creation. I assume a new resource group would be
> created with "shareable" mode so its schemata should not overlap with
> any "exclusive" or "locked". Since the bitmasks used by the previous
> group with this closid may not be shareable I considered it safer to
> initialize with "shareable" mode with known shareable/unused bitmasks. A
> potential issue with this idea is that the creation of a group may now
> result in the programming of the hardware with settings these defaults.

Yes, setting it to 'default' group bits at creation (ID allocation) time
makes sense.

> >> Moving to "exclusive" mode it appears that, when enabled for a resource
> >> group, all domains of all resources are forced to have an "exclusive"
> >> region associated with this resource group (closid). This is because the
> >> schemata reflects the hardware settings of all resources and their
> >> domains and the hardware does not accept a "zero" bitmask. A user thus
> >> cannot just specify a single region of a particular cache instance as
> >> "exclusive". Does this match your intention wrt "exclusive"?
> > 
> > Interesting question. I really did not think about that yet.

Second thoughts on that: I think for a start we can go the simple route and
just say: exclusive covers all cache levels.

> > You could make it:
> > 
> > echo locksetup > mode
> > echo $CONF > schemata
> > echo locked > mode
> > 
> > Or something like that.
> 
> Indeed ... the final command may perhaps not be needed? Since the user
> expressed intent to create pseudo-locked region by writing "locksetup"
> the pseudo-locking can be done when the schemata is written. I think it
> would be simpler to act when the schemata is written since we know
> exactly at that point which regions should be pseudo-locked. After the
> schemata is stored the user's choice is just merged with the larger
> schemata representing all resources/domains. We could set mode to
> "locked" on success, it can remain as "locksetup" on failure of creating
> the pseudo-locked region. We could perhaps also consider a name change
> "locksetup" -> "lockrsv" since after the first pseudo-locked region is
> created on a domain then all the other domains associated with this
> class of service need to have some special state since no task will ever
> run on them with that class of service so we would not want their bits
> (which will not be zero) to be taken into account when checking for
> "shareable" or "exclusive".

Works for me.

> This could also support multiple pseudo-locked regions.
> For example:
> # #Create first pseudo-locked region
> # echo locksetup > mode
> # echo L2:0=0xf > schemata
> # echo $?
> 0
> # cat mode
> locked # will be locksetup on failure
> # cat schemata
> L2:0=0xf #only show pseudo-locked regions
> # #Create second pseudo-locked region
> # # Not necessary to write "locksetup" again
> # echo L2:1=0xf > schemata #will trigger the pseudo-locking of new region
> # echo $?
> 1 # just for example, this could succeed also
> # cat mode
> locked
> # cat schemata
> L2:0=0xf
> 
> Schemata shown to user would be only the pseudo-locked region(s), unless
> there is none, then nothing will be returned.
> 
> I'll think about this more, but if we do go the route of releasing
> closids as suggested below it may change a lot.

I think dropping the closid makes sense. Once the thing is locked it's done
and nothing can be changed anymore, except removal of course. That also
gives you a 1:1 mapping between resource group and lockdevice.

> This is a real issue. The pros and cons of using a global CLOSID across
> all resources are documented in the comments preceding:
> arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:closid_init()
> 
> The issue I mention was foreseen, to quote from there "Our choices on
> how to configure each resource become progressively more limited as the
> number of resources grows".
> 
> > Let's assume its real,
> > so you could do the following:
> > 
> > mkdir group		<- acquires closid
> > echo locksetup > mode	<- Creates 'lockarea' file
> > echo L2:0 > lockarea
> > echo 'L2:0=0xf' > schemata
> > echo locked > mode	<- locks down all files, does the lock setup
> >      	      		   and drops closid
> > 
> > That would solve quite some of the other issues as well. Hmm?
> 
> At this time the resource group, represented by a resctrl directory, is
> tightly associated with the closid. I'll take a closer look at what it
> will take to separate them.

Shouldn't be that hard.

> Could you please elaborate on the purpose of the "lockarea" file? It
> does seem to duplicate the information in the schemata written in the
> subsequent line.

No. The lockarea or restrict file (as I named it later, but feel free to
come up with something more intuitive) is there to tell which part of the
resource zoo should be made exclusive/locked. That makes the whole write to
schemata file and validate whether this is really exclusive way simpler.

> If we do go this route then it seems that there would be one
> pseudo-locked region per resource group, not multiple ones as I had in
> my examples above.

Correct.

> An alternative to the hardware programming on creation of resource group
> could also be to reset the bitmasks of the closid to be shareable/unused
> bits at the time the closid is released.

That does not help because the default/shareable/unused bits can change
between release of a CLOSID and reallocation.

> > Actually we could solve that problem similar to the locked one and share
> > most of the functionality:
> > 
> > mkdir group
> > echo exclusive > mode
> > echo L3:0 > restrict
> > 
> > and for locked:
> > 
> > mkdir group
> > echo locksetup > mode
> > echo L2:0 > restrict
> > echo 'L2:0=0xf' > schemata
> > echo locked > mode
> > 
> > The 'restrict' file (feel free to come up with a better name) is only
> > available/writeable in exclusive and locksetup mode. In case of exclusive
> > mode it can contain several domains/resources, but in locked mode its only
> > allowed to contain a single domain/resource.
> > 
> > A write to schemata for exclusive or locksetup mode will apply the
> > exclusiveness restrictions only to the resources/domains selected in the
> > 'restrict' file. 
> 
> I think I understand for the exclusive case. Here the introduction of
> the restrict file helps. I will run through a few examples to ensure I
> understand it. For the pseudo-locking cases I do have the questions and
> comments above. Here I likely may be missing something but I'll keep
> dissecting how this would work to clear up my understanding.

I came up with this under the assumptions:

  1) One locked region per resource group
  2) Drop closid after locking

Then the restrict file makes a lot of sense because it would give a clear
selection of the possible resource to lock.

Thanks,

	tglx
