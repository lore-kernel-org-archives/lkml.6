Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeB1TR6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:17:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:45377 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932780AbeB1TR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:17:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="21035451"
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
 <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
 <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de>
 <69ed85f2-b9c5-30d1-8437-45f20be3e95e@intel.com>
 <alpine.DEB.2.21.1802281924390.1392@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <7695220e-2503-d598-d9bd-cd0256028fce@intel.com>
Date: Wed, 28 Feb 2018 11:17:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802281924390.1392@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/28/2018 10:39 AM, Thomas Gleixner wrote:
> On Tue, 27 Feb 2018, Reinette Chatre wrote:
>> On 2/27/2018 2:36 AM, Thomas Gleixner wrote:
>>> On Mon, 26 Feb 2018, Reinette Chatre wrote:
>>>> Moving to "exclusive" mode it appears that, when enabled for a resource
>>>> group, all domains of all resources are forced to have an "exclusive"
>>>> region associated with this resource group (closid). This is because the
>>>> schemata reflects the hardware settings of all resources and their
>>>> domains and the hardware does not accept a "zero" bitmask. A user thus
>>>> cannot just specify a single region of a particular cache instance as
>>>> "exclusive". Does this match your intention wrt "exclusive"?
>>>
>>> Interesting question. I really did not think about that yet.
> 
> Second thoughts on that: I think for a start we can go the simple route and
> just say: exclusive covers all cache levels.

Will do ... (will refer back to this later)

> 
>>> You could make it:
>>>
>>> echo locksetup > mode
>>> echo $CONF > schemata
>>> echo locked > mode
>>>
>>> Or something like that.
>>
>> Indeed ... the final command may perhaps not be needed? Since the user
>> expressed intent to create pseudo-locked region by writing "locksetup"
>> the pseudo-locking can be done when the schemata is written. I think it
>> would be simpler to act when the schemata is written since we know
>> exactly at that point which regions should be pseudo-locked. After the
>> schemata is stored the user's choice is just merged with the larger
>> schemata representing all resources/domains. We could set mode to
>> "locked" on success, it can remain as "locksetup" on failure of creating
>> the pseudo-locked region. We could perhaps also consider a name change
>> "locksetup" -> "lockrsv" since after the first pseudo-locked region is
>> created on a domain then all the other domains associated with this
>> class of service need to have some special state since no task will ever
>> run on them with that class of service so we would not want their bits
>> (which will not be zero) to be taken into account when checking for
>> "shareable" or "exclusive".
> 
> Works for me.

A big change in the above is that now that the closid will be released
there is no need for the "lockrsv" anymore since the closid used for the
pseudo-locking can surely be re-used. It would thus change to:

# echo locksetup > mode
# echo $CONF > schemata
# echo $?
0
# cat mode
locked

Similar as before the writing of the schemata would trigger the
pseudo-locking and there is no lockarea/restrict file.

> I think dropping the closid makes sense. Once the thing is locked it's done
> and nothing can be changed anymore, except removal of course. That also
> gives you a 1:1 mapping between resource group and lockdevice.

Thanks. One pseudo-locked region per resource group does make things
simpler and removes the need for some strange removal tricks,
pseudo-locked region removal can be done with a directory removal.
Naming of the pseudo-locked region's character device will be same as
the resource group.

> 
>> This is a real issue. The pros and cons of using a global CLOSID across
>> all resources are documented in the comments preceding:
>> arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:closid_init()
>>
>> The issue I mention was foreseen, to quote from there "Our choices on
>> how to configure each resource become progressively more limited as the
>> number of resources grows".
>>
>>> Let's assume its real,
>>> so you could do the following:
>>>
>>> mkdir group		<- acquires closid
>>> echo locksetup > mode	<- Creates 'lockarea' file
>>> echo L2:0 > lockarea
>>> echo 'L2:0=0xf' > schemata
>>> echo locked > mode	<- locks down all files, does the lock setup
>>>      	      		   and drops closid
>>>
>>> That would solve quite some of the other issues as well. Hmm?
>>
>> At this time the resource group, represented by a resctrl directory, is
>> tightly associated with the closid. I'll take a closer look at what it
>> will take to separate them.
> 
> Shouldn't be that hard.
> 
>> Could you please elaborate on the purpose of the "lockarea" file? It
>> does seem to duplicate the information in the schemata written in the
>> subsequent line.
> 
> No. The lockarea or restrict file (as I named it later, but feel free to
> come up with something more intuitive) is there to tell which part of the
> resource zoo should be made exclusive/locked. That makes the whole write to
> schemata file and validate whether this is really exclusive way simpler.

This file (lockarea/restrict) would surely support a flexible exclusive
mode, but if we start with the simple case as you note above then it
does not seem to be needed for exclusive mode since the exclusive mode
would cover all domains of all resources.

# mkdir group
# echo exclusive > group/mode # will attempt to mark all bits in current
schemata as exclusive, will fail if any are in use by another closid
# echo $newschemata > group/schemata # will require that all bits are
not in use by any other closid

This file (lockarea/restrict) also does not seem to be needed for the
locked mode since only one pseudo-locked region is supported per
resource group and that is communicated at the time the schemata is
written. The locking flow above did not use this file.

>> If we do go this route then it seems that there would be one
>> pseudo-locked region per resource group, not multiple ones as I had in
>> my examples above.
> 
> Correct.
> 
>> An alternative to the hardware programming on creation of resource group
>> could also be to reset the bitmasks of the closid to be shareable/unused
>> bits at the time the closid is released.
> 
> That does not help because the default/shareable/unused bits can change
> between release of a CLOSID and reallocation.

Good point, thanks.

>>> Actually we could solve that problem similar to the locked one and share
>>> most of the functionality:
>>>
>>> mkdir group
>>> echo exclusive > mode
>>> echo L3:0 > restrict
>>>
>>> and for locked:
>>>
>>> mkdir group
>>> echo locksetup > mode
>>> echo L2:0 > restrict
>>> echo 'L2:0=0xf' > schemata
>>> echo locked > mode
>>>
>>> The 'restrict' file (feel free to come up with a better name) is only
>>> available/writeable in exclusive and locksetup mode. In case of exclusive
>>> mode it can contain several domains/resources, but in locked mode its only
>>> allowed to contain a single domain/resource.
>>>
>>> A write to schemata for exclusive or locksetup mode will apply the
>>> exclusiveness restrictions only to the resources/domains selected in the
>>> 'restrict' file. 
>>
>> I think I understand for the exclusive case. Here the introduction of
>> the restrict file helps. I will run through a few examples to ensure I
>> understand it. For the pseudo-locking cases I do have the questions and
>> comments above. Here I likely may be missing something but I'll keep
>> dissecting how this would work to clear up my understanding.
> 
> I came up with this under the assumptions:
> 
>   1) One locked region per resource group
>   2) Drop closid after locking

I am also now working under these assumptions ...

> Then the restrict file makes a lot of sense because it would give a clear
> selection of the possible resource to lock.

... but I am still stuck on why this restrict file is needed at this
time. Surely it would be needed if later we add the more flexible
exclusive mode, but I do not understand how it helps the locked mode.

Reinette
