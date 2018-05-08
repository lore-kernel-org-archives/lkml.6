Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbeEHDxA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:53:00 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:44286 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbeEHDw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:52:59 -0400
X-Google-Smtp-Source: AB8JxZrOPsQ75IqTEY99ca28yFrDvMQfb9AtT3dB3Al9JgIhVpkHXe19pKS/KLpzhq+bIEgdg6V0cGrfBdNHc4JEUpw=
MIME-Version: 1.0
In-Reply-To: <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org> <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com> <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 May 2018 20:52:57 -0700
Message-ID: <CAPcyv4imJSVaSBTcjLSi6RMpN7PBhe5DMZUf93rbwMcgvcYVDQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem) zone
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        NingTing Cheng <chengnt@lenovo.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        Linux MM <linux-mm@kvack.org>, "colyli@suse.de" <colyli@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w483r7iT014155

On Mon, May 7, 2018 at 7:59 PM, Huaisheng HS1 Ye <yehs1@lenovo.com> wrote:
>>
>>Dan Williams <dan.j.williams@intel.com> writes:
>>
>>> On Mon, May 7, 2018 at 11:46 AM, Matthew Wilcox <willy@infradead.org>
>>wrote:
>>>> On Mon, May 07, 2018 at 10:50:21PM +0800, Huaisheng Ye wrote:
>>>>> Traditionally, NVDIMMs are treated by mm(memory management)
>>subsystem as
>>>>> DEVICE zone, which is a virtual zone and both its start and end of pfn
>>>>> are equal to 0, mm wouldn’t manage NVDIMM directly as DRAM, kernel
>>uses
>>>>> corresponding drivers, which locate at \drivers\nvdimm\ and
>>>>> \drivers\acpi\nfit and fs, to realize NVDIMM memory alloc and free with
>>>>> memory hot plug implementation.
>>>>
>>>> You probably want to let linux-nvdimm know about this patch set.
>>>> Adding to the cc.
>>>
>>> Yes, thanks for that!
>>>
>>>> Also, I only received patch 0 and 4.  What happened
>>>> to 1-3,5 and 6?
>>>>
>>>>> With current kernel, many mm’s classical features like the buddy
>>>>> system, swap mechanism and page cache couldn’t be supported to
>>NVDIMM.
>>>>> What we are doing is to expand kernel mm’s capacity to make it to
>>handle
>>>>> NVDIMM like DRAM. Furthermore we make mm could treat DRAM and
>>NVDIMM
>>>>> separately, that means mm can only put the critical pages to NVDIMM
>>
>>Please define "critical pages."
>>
>>>>> zone, here we created a new zone type as NVM zone. That is to say for
>>>>> traditional(or normal) pages which would be stored at DRAM scope like
>>>>> Normal, DMA32 and DMA zones. But for the critical pages, which we hope
>>>>> them could be recovered from power fail or system crash, we make them
>>>>> to be persistent by storing them to NVM zone.
>>
>>[...]
>>
>>> I think adding yet one more mm-zone is the wrong direction. Instead,
>>> what we have been considering is a mechanism to allow a device-dax
>>> instance to be given back to the kernel as a distinct numa node
>>> managed by the VM. It seems it times to dust off those patches.
>>
>>What's the use case?  The above patch description seems to indicate an
>>intent to recover contents after a power loss.  Without seeing the whole
>>series, I'm not sure how that's accomplished in a safe or meaningful
>>way.
>>
>>Huaisheng, could you provide a bit more background?
>>
>
> Currently in our mind, an ideal use scenario is that, we put all page caches to
> zone_nvm, without any doubt, page cache is an efficient and common cache
> implement, but it has a disadvantage that all dirty data within it would has risk
> to be missed by power failure or system crash. If we put all page caches to NVDIMMs,
> all dirty data will be safe.
>
> And the most important is that, Page cache is different from dm-cache or B-cache.
> Page cache exists at mm. So, it has much more performance than other Write
> caches, which locate at storage level.

Can you be more specific? I think the only fundamental performance
difference between page cache and a block caching driver is that page
cache pages can be DMA'ed directly to lower level storage. However, I
believe that problem is solvable, i.e. we can teach dm-cache to
perform the equivalent of in-kernel direct-I/O when transferring data
between the cache and the backing storage when the cache is comprised
of persistent memory.

>
> At present we have realized NVM zone to be supported by two sockets(NUMA)
> product based on Lenovo Purley platform, and we can expand NVM flag into
> Page Cache allocation interface, so all Page Caches of system had been stored
> to NVDIMM safely.
>
> Now we are focusing how to recover data from Page cache after power on. That is,
> The dirty pages could be safe and the time cost of cache training would be saved a lot.
> Because many pages have already stored to ZONE_NVM before power failture.

I don't see how ZONE_NVM fits into a persistent page cache solution.
All of the mm structures to maintain the page cache are built to be
volatile. Once you build the infrastructure to persist and restore the
state of the page cache it is no longer the traditional page cache.
I.e. it will become something much closer to dm-cache or a filesystem.

One nascent idea from Dave Chinner is to teach xfs how to be a block
server for an upper level filesystem. His aim is sub-volume and
snapshot support, but I wonder if caching could be adapted into that
model?

In any event I think persisting and restoring cache state needs to be
designed before deciding if changes to the mm are needed.
