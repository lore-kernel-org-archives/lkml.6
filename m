Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbeBSWVr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:21:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:26633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932116AbeBSWVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:21:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="19311075"
Subject: Re: [RFC PATCH V2 01/22] x86/intel_rdt: Documentation for Cache
 Pseudo-Locking
To: Randy Dunlap <rdunlap@infradead.org>, tglx@linutronix.de,
        fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <9416db57e47e2040a7108ba269f5432d0c91f1f7.1518443616.git.reinette.chatre@intel.com>
 <ae8252f6-83b4-d8d6-8eaf-ecbae78339aa@infradead.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a5ebbd0b-3e7c-44a7-391e-4856ae3257cd@intel.com>
Date: Mon, 19 Feb 2018 14:21:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ae8252f6-83b4-d8d6-8eaf-ecbae78339aa@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 2/19/2018 1:27 PM, Randy Dunlap wrote:
> On 02/13/18 07:46, Reinette Chatre wrote:
>> Add description of Cache Pseudo-Locking feature, its interface,
>> as well as an example of its usage.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  Documentation/x86/intel_rdt_ui.txt | 229 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 228 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
>> index 756fd76b78a6..bb3d6fe0a3e4 100644
>> --- a/Documentation/x86/intel_rdt_ui.txt
>> +++ b/Documentation/x86/intel_rdt_ui.txt
> 
>> @@ -329,6 +332,149 @@ L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>>  L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
>>  L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>>  
>> +Cache Pseudo-Locking
>> +--------------------
>> +CAT enables a user to specify the amount of cache space into which an
> 
>                                                      space that an

Will fix.

> 
>> +application can fill. Cache pseudo-locking builds on the fact that a
>> +CPU can still read and write data pre-allocated outside its current
>> +allocated area on a cache hit. With cache pseudo-locking, data can be
>> +preloaded into a reserved portion of cache that no application can
>> +fill, and from that point on will only serve cache hits. The cache
>> +pseudo-locked memory is made accessible to user space where an
>> +application can map it into its virtual address space and thus have
>> +a region of memory with reduced average read latency.
>> +
>> +Cache pseudo-locking increases the probability that data will remain
>> +in the cache via carefully configuring the CAT feature and controlling
>> +application behavior. There is no guarantee that data is placed in
>> +cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
>> +“locked” data from cache. Power management C-states may shrink or
>> +power off cache. It is thus recommended to limit the processor maximum
>> +C-state, for example, by setting the processor.max_cstate kernel parameter.
>> +
>> +It is required that an application using a pseudo-locked region runs
>> +with affinity to the cores (or a subset of the cores) associated
>> +with the cache on which the pseudo-locked region resides. This is
>> +enforced by the implementation.
>> +
>> +Pseudo-locking is accomplished in two stages:
>> +1) During the first stage the system administrator allocates a portion
>> +   of cache that should be dedicated to pseudo-locking. At this time an
>> +   equivalent portion of memory is allocated, loaded into allocated
>> +   cache portion, and exposed as a character device.
>> +2) During the second stage a user-space application maps (mmap()) the
>> +   pseudo-locked memory into its address space.
>> +
>> +Cache Pseudo-Locking Interface
>> +------------------------------
>> +Platforms supporting cache pseudo-locking will expose a new
>> +"/sys/fs/restrl/pseudo_lock" directory after successful mount of the
>> +resctrl filesystem. Initially this directory will contain a single file,
>> +"avail" that contains the schemata, one line per resource, of cache region
>> +available for pseudo-locking.
> 
> uh, sysfs is supposed to be one value per file.

This builds on how the schemata file currently works.

>> +A pseudo-locked region is created by creating a new directory within
>> +/sys/fs/resctrl/pseudo_lock. On success two new files will appear in
>> +the directory:
>> +
>> +"schemata":
>> +	Shows the schemata representing the pseudo-locked cache region.
>> +	User writes schemata of requested locked area to file.
> 
> 	use complete sentences, please. E.g.:
> 
> 	The user writes the schemata of the requested locked area to the file.
> 
>> +	Only one id of single resource accepted - can only lock from
> 
> 	            of a single resource is accepted -
> 

Will fix both.

>> +	single cache instance. Writing of schemata to this file will
>> +	return success on successful pseudo-locked region setup.
>> +"size":
>> +	After successful pseudo-locked region setup this read-only file
>> +	will contain the size in bytes of pseudo-locked region.
> 
> 

Thank you very much for taking a look!

Reinette
