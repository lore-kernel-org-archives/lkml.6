Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeBBKuv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:50:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeBBKum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:50:42 -0500
Subject: Re: [RFC PATCH v1 00/13] lru_lock scalability
To: Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <6bd1c8a5-c682-a3ce-1f9f-f1f53b4117a9@redhat.com>
 <e3e47085-1b5e-0d2e-f8cb-03defb9af0dd@oracle.com>
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <962e6540-08e5-aca2-2ff9-bcbd9650d962@redhat.com>
Date: Fri, 2 Feb 2018 10:50:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <e3e47085-1b5e-0d2e-f8cb-03defb9af0dd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 02/02/18 04:18, Daniel Jordan wrote:
>
>
> On 02/01/2018 10:54 AM, Steven Whitehouse wrote:
>> Hi,
>>
>>
>> On 31/01/18 23:04, daniel.m.jordan@oracle.com wrote:
>>> lru_lock, a per-node* spinlock that protects an LRU list, is one of the
>>> hottest locks in the kernel.  On some workloads on large machines, it
>>> shows up at the top of lock_stat.
>>>
>>> One way to improve lru_lock scalability is to introduce an array of 
>>> locks,
>>> with each lock protecting certain batches of LRU pages.
>>>
>>>          *ooooooooooo**ooooooooooo**ooooooooooo**oooo ...
>>>          |           ||           ||           ||
>>>           \ batch 1 /  \ batch 2 /  \ batch 3 /
>>>
>>> In this ASCII depiction of an LRU, a page is represented with either 
>>> '*'
>>> or 'o'.  An asterisk indicates a sentinel page, which is a page at the
>>> edge of a batch.  An 'o' indicates a non-sentinel page.
>>>
>>> To remove a non-sentinel LRU page, only one lock from the array is
>>> required.  This allows multiple threads to remove pages from different
>>> batches simultaneously.  A sentinel page requires lru_lock in 
>>> addition to
>>> a lock from the array.
>>>
>>> Full performance numbers appear in the last patch in this series, 
>>> but this
>>> prototype allows a microbenchmark to do up to 28% more page faults per
>>> second with 16 or more concurrent processes.
>>>
>>> This work was developed in collaboration with Steve Sistare.
>>>
>>> Note: This is an early prototype.  I'm submitting it now to support my
>>> request to attend LSF/MM, as well as get early feedback on the 
>>> idea.  Any
>>> comments appreciated.
>>>
>>>
>>> * lru_lock is actually per-memcg, but without memcg's in the picture it
>>>    becomes per-node.
>> GFS2 has an lru list for glocks, which can be contended under certain 
>> workloads. Work is still ongoing to figure out exactly why, but this 
>> looks like it might be a good approach to that issue too. The main 
>> purpose of GFS2's lru list is to allow shrinking of the glocks under 
>> memory pressure via the gfs2_scan_glock_lru() function, and it looks 
>> like this type of approach could be used there to improve the 
>> scalability,
>
> Glad to hear that this could help in gfs2 as well.
>
> Hopefully struct gfs2_glock is less space constrained than struct page 
> for storing the few bits of metadata that this approach requires.
>
> Daniel
>
We obviously want to keep gfs2_glock small, however within reason then 
yet we can add some additional fields as required. The use case is 
pretty much a standard LRU list, so items are added and removed, mostly 
at the active end of the list, and the inactive end of the list is 
scanned periodically by gfs2_scan_glock_lru()

Steve.
