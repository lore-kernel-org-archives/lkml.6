Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeBUF6y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:58:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:49914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbeBUF6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:58:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="19910867"
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
 <6c960fc0-820e-757c-2770-d770647e63d6@intel.com>
 <alpine.DEB.2.21.1802202355240.24268@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <9bb96e22-fe30-67dd-4d1d-fb850e321a2f@intel.com>
Date: Tue, 20 Feb 2018 21:58:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802202355240.24268@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/20/2018 3:21 PM, Thomas Gleixner wrote:
> On Tue, 20 Feb 2018, Reinette Chatre wrote:
>> On 2/20/2018 9:15 AM, Thomas Gleixner wrote:
>>> On Tue, 13 Feb 2018, Reinette Chatre wrote:
>>>
>>> Are you really sure that the life time rules of plr are correct vs. an
>>> application which still has the locked memory mapped? i.e. the following
>>> operation:
>>
>> You are correct. I am not preventing an administrator from removing the
>> pseudo-locked region if it is in use. I will fix that.
> 
> The removal is fine and you cannot prevent it w/o introducing a mess, but
> you have to make sure that the PLR and the mapped memory are not
> vanishing. The refcount rules I outlined are exactly doing that.

Thank you for catching my misunderstanding. Will do.

>> Thank you so much for taking the time to do this thorough review and to
>> make these suggestions. While I am still digesting the details I do
>> intend to follow all (as well as the ones earlier I did not explicitly
>> respond to).
> 
> Make your mind up and tell me where I'm wrong before you implement the crap
> I suggested blindly, as that will just cause the next reviewer (me or
> someone else) to tell _you_ that it is crap :)

Will do. I need more time to digest your suggestions because your
thorough review provided me plenty to consider.

>> Keeping the CLOSID associated with the pseudo-locked region will surely
>> make the above simpler since CLOSID's are association with resource
>> groups (represented by the directories). I would like to highlight that
>> on some platforms there are only a few (for example, 4) CLOSIDs
>> available. Not releasing a CLOSID would thus reduce available CLOSIDs
>> that are already limited. These platforms do have smaller possible
>> bitmasks though (for example, 8 possible bits), which may make light of
>> this concern. I thus just add it as informational to the consequence of
>> this simplification.
> 
> Yes. If you have 4 CLOSIDs and only 8 CBM bits it really does not matter
> much.
> 
>>> Now the remaining thing is the memory allocation and the mmap itself. I
>>> really dislike the preallocation of memory right at setup time. Ideally
>>> that should be an allocation of the application itself, but the horrid
>>> wbinvd stuff kinda prevents that. With that restriction we are more or less
>>> bound to immediate allocation and population.
>>
>> Acknowledged. I am not sure if the current permissions would support
>> such a dynamic setup though. At this time the system administrator is
>> the one that sets up the pseudo-locked region and can through
>> permissions of the character device provide access to these regions to
>> user space applications.
> 
> You still would need some interface, e.g. character device which allows you
> to hand in the pointer to the user allocated memory and do the cache
> priming. So you could use the same permission setup for that character
> device.
> 
> The other problem is that we'd need to have MAP_CONTIG first so you
> actually can allocate physically contigous memory from user space. Mike is
> working on that, but it's not available today. The only way to do so today
> (with lots of waste) would be MAP_HUGETLB, which might be an acceptable
> constraint up to the point where MAP_CONTIG is available.

I recorded this in a pseudo-locking task list as something to consider
if the wbinvd requirement goes away at some point.

> Though this all depends on the ability to remove the wbinvd
> requirement. But even if we can remove that we'd still need to be aware
> that the cache priming loop which needs to run with interrupts disabled is
> expensive as well and can introduce undesired latencies. Needs all some
> thought...

Reinette
