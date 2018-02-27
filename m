Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeB0Aeo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:34:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:23099 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeB0Aen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:34:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="20417500"
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
Date: Mon, 26 Feb 2018 16:34:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/20/2018 9:15 AM, Thomas Gleixner wrote:
> Let's look at the existing crtl/mon groups which are each represented by a
> directory already.
> 
>  - Adding a 'size' file to the ctrl groups would be a natural extension
>    which makes sense for regular cache allocations as well.
> 
>  - Adding a 'exclusive' flag would be an interesting feature even for the
>    normal use case. Marking a group as exclusive prevents other groups to
>    request CBM bits which are held by a exclusive allocation.
> 
>    I'd suggest to have a file 'mode' for controlling this. The valid values
>    would be something like 'shareable' and 'exclusive'.
> 
>    When trying to set a group to exclusive mode then the schemata has to be
>    checked for overlaps with the other schematas and in case of conflict
>    the write fails. Once enabled subsequent writes to the schemata file
>    need to be checked for conflicts as well.
> 
>    If the exclusive setting is enabled then the CBM bits of that group
>    are excluded from being used in other control groups.
> 
> Aside of that a file in the info directory which shows the (un)used CBM
> bits of all groups is really helpful for controlling all of that (even w/o
> pseudo locking). You have this in the 'avail' file, but there is no reason
> why this should only be available for pseudo locking enabled systems.
> 
> Now for the pseudo locking part.
> 
> What you need on top of the above is a new 'mode': 'locked'. That mode
> utilizes the 'exclusive' mode rules vs. conflict checking and the
> protection against allocating the associated CBM bits in other control
> groups.
> 
> The setup would be like this:
> 
>     mkdir group
>     echo '$CONFIG' >group/schemata
>     echo 'locked' >group/mode
> 
> Setting mode to locked locks down the schemata file along with the
> task/cpus/cpus_list files. The task/cpu files need to be empty when
> entering locked mode, otherwise the operation fails. I'd even would not
> bother handing back the CLOSID. For simplicity the CLOSID should just stay
> associated with the control group until it is destroyed as any other
> control group.

I started looking at how this implementation may look and would like to
confirm with you that your intentions behind the new "exclusive" and
"locked" modes can be maintained. I also have a few questions.

Focusing on CAT a resource group represents a closid across all domains
(cache instances) of all resources (cache layers) on the system. A full
schemata reflecting the active bitmask associated with this closid for
each domain of each resource is maintained. The current implementation
supports partial writes to the schemata, with the assumption that only
the changed values need to be updated, the others remain as is. For the
current implementation this works well since what is shown by schemata
reflects current hardware settings and what is written to schemata will
change current hardware settings. This is done irrespective of any
overlap between bitmasks of different closids (the "shareable" mode).

A change to start us off with could be to initialize the schemata with
all the shareable and unused bits set for all domains when a new
resource group is created.

Moving to "exclusive" mode it appears that, when enabled for a resource
group, all domains of all resources are forced to have an "exclusive"
region associated with this resource group (closid). This is because the
schemata reflects the hardware settings of all resources and their
domains and the hardware does not accept a "zero" bitmask. A user thus
cannot just specify a single region of a particular cache instance as
"exclusive". Does this match your intention wrt "exclusive"?

Moving on to the "locked" mode. We cannot support different
pseudo-locked regions across multiple resources (eg. L2 and L3). In
fact, if we would at some point in the future then a pseudo-locked
region on one resource could implicitly span a second resource.
Additionally, we would like to enable a user to enable a single
pseudo-locked region on a single cache instance.

>From the above it follows that "locked" mode cannot just simply build on
top of "exclusive" mode rules (as I expressed them above) since it
cannot enforce a locked region on each domain of each resource.

We would like to support something like (as you also have in your example):

mkdir group
echo "L2:1=0x3" > schemata
echo locked > mode

The above should only pseudo-lock the indicated region and not touch any
other domain. The problem is that the schemata always contain non-zero
bitmasks for all domains so at the time "locked" is written it is not
known which cache region needs to be locked. I am currently unable to
see a simple way to build on top of the current schemata design to
support the "locked" mode as you intended. It does seem as though the
user's intention to create a pseudo-locked region needs to be
communicated before the schemata is written, but from what I understand
this does not seem to be supported by the mode/schemata combination.
Please do correct me where I am wrong.

To continue, when we overcome the above obstacle:
A scenario could be where a single resource group will contain all the
pseudo-locked regions (to avoid wasting closids). It is not clear to me
how to easily support such a usage though since the way writes to the
schemata is done is "changes only". If for example, two pseudo-locked
regions exists:

# mkdir group
# echo "L2:1=0x3" > schemata
# echo locked > mode
# cat schemata
L2:1=0x3
# echo "L2:0=0xf" > schemata
# cat schemata
L2:0=0xf;1=0x3

How can the user remove one of the pseudo-locked regions without
affecting the other? Could we perhaps allow zero bitmask writes when a
region is locked?

Another point I would like to highlight is that when we talked about
keeping the closid associated with the pseudo-locked region I mentioned
that some resources may have few closids (for example, 4). As discussed
this seems ok when there are only 8 bits in the bitmask. What I did not
highlight at that time is that the closids are limited to the smallest
number supported by all resources. So, if this same platform has a
second resource (with more bits in a bitmask) with more closids, they
would also be limited to 4. In this case it does seem removing a closid
from service would have bigger impact.

Reinette
