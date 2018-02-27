Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeB0Kgu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:36:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45950 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeB0Kgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:36:48 -0500
Date: Tue, 27 Feb 2018 11:36:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
Message-ID: <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

On Mon, 26 Feb 2018, Reinette Chatre wrote:
> I started looking at how this implementation may look and would like to
> confirm with you that your intentions behind the new "exclusive" and
> "locked" modes can be maintained. I also have a few questions.

Phew :)

> Focusing on CAT a resource group represents a closid across all domains
> (cache instances) of all resources (cache layers) on the system. A full
> schemata reflecting the active bitmask associated with this closid for
> each domain of each resource is maintained. The current implementation
> supports partial writes to the schemata, with the assumption that only
> the changed values need to be updated, the others remain as is. For the
> current implementation this works well since what is shown by schemata
> reflects current hardware settings and what is written to schemata will
> change current hardware settings. This is done irrespective of any
> overlap between bitmasks of different closids (the "shareable" mode).

Right.

> A change to start us off with could be to initialize the schemata with
> all the shareable and unused bits set for all domains when a new
> resource group is created.

The new resource group initialization is the least of my worries. The
current mode is to use the default group setting, right?

> Moving to "exclusive" mode it appears that, when enabled for a resource
> group, all domains of all resources are forced to have an "exclusive"
> region associated with this resource group (closid). This is because the
> schemata reflects the hardware settings of all resources and their
> domains and the hardware does not accept a "zero" bitmask. A user thus
> cannot just specify a single region of a particular cache instance as
> "exclusive". Does this match your intention wrt "exclusive"?

Interesting question. I really did not think about that yet. 

> Moving on to the "locked" mode. We cannot support different
> pseudo-locked regions across multiple resources (eg. L2 and L3). In
> fact, if we would at some point in the future then a pseudo-locked
> region on one resource could implicitly span a second resource.
> Additionally, we would like to enable a user to enable a single
> pseudo-locked region on a single cache instance.
> 
> From the above it follows that "locked" mode cannot just simply build on
> top of "exclusive" mode rules (as I expressed them above) since it
> cannot enforce a locked region on each domain of each resource.
> 
> We would like to support something like (as you also have in your example):
> 
> mkdir group
> echo "L2:1=0x3" > schemata
> echo locked > mode
> 
> The above should only pseudo-lock the indicated region and not touch any
> other domain. The problem is that the schemata always contain non-zero
> bitmasks for all domains so at the time "locked" is written it is not
> known which cache region needs to be locked. I am currently unable to
> see a simple way to build on top of the current schemata design to
> support the "locked" mode as you intended. It does seem as though the
> user's intention to create a pseudo-locked region needs to be
> communicated before the schemata is written, but from what I understand
> this does not seem to be supported by the mode/schemata combination.
> Please do correct me where I am wrong.

You could make it:

echo locksetup > mode
echo $CONF > schemata
echo locked > mode

Or something like that.

> To continue, when we overcome the above obstacle:
> A scenario could be where a single resource group will contain all the
> pseudo-locked regions (to avoid wasting closids). It is not clear to me
> how to easily support such a usage though since the way writes to the
> schemata is done is "changes only". If for example, two pseudo-locked
> regions exists:
> 
> # mkdir group
> # echo "L2:1=0x3" > schemata
> # echo locked > mode
> # cat schemata
> L2:1=0x3
> # echo "L2:0=0xf" > schemata
> # cat schemata
> L2:0=0xf;1=0x3
> 
> How can the user remove one of the pseudo-locked regions without
> affecting the other? Could we perhaps allow zero bitmask writes when a
> region is locked?

That might work. Though it looks hacky.

> Another point I would like to highlight is that when we talked about
> keeping the closid associated with the pseudo-locked region I mentioned
> that some resources may have few closids (for example, 4). As discussed
> this seems ok when there are only 8 bits in the bitmask. What I did not
> highlight at that time is that the closids are limited to the smallest
> number supported by all resources. So, if this same platform has a
> second resource (with more bits in a bitmask) with more closids, they
> would also be limited to 4. In this case it does seem removing a closid
> from service would have bigger impact.

Is that a real issue or just an academic exercise? Let's assume its real,
so you could do the following:

mkdir group		<- acquires closid
echo locksetup > mode	<- Creates 'lockarea' file
echo L2:0 > lockarea
echo 'L2:0=0xf' > schemata
echo locked > mode	<- locks down all files, does the lock setup
     	      		   and drops closid

That would solve quite some of the other issues as well. Hmm?

Thanks,

	tglx
