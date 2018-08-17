Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C1DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7D62188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7D62188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeHQLaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:30:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbeHQLaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:30:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2532F40201C4;
        Fri, 17 Aug 2018 08:27:55 +0000 (UTC)
Received: from [10.36.117.9] (ovpn-117-9.ams2.redhat.com [10.36.117.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12F4E10DCF5B;
        Fri, 17 Aug 2018 08:27:50 +0000 (UTC)
Subject: Re: [PATCH RFC 2/2] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@linuxdriverproject.org, linux-s390@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, osalvador@suse.de,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-3-david@redhat.com>
 <CAJZ5v0jpx_XOmkSkMiSxcECxNHGXPGZHtgqRy_Q7iKnf-C55pg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ce6e0944-11bb-a36b-eac1-aaf123b8be8a@redhat.com>
Date:   Fri, 17 Aug 2018 10:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jpx_XOmkSkMiSxcECxNHGXPGZHtgqRy_Q7iKnf-C55pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 08:27:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 08:27:55 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2018 10:20, Rafael J. Wysocki wrote:
> On Fri, Aug 17, 2018 at 9:59 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> There seem to be some problems as result of 30467e0b3be ("mm, hotplug:
>> fix concurrent memory hot-add deadlock"), which tried to fix a possible
>> lock inversion reported and discussed in [1] due to the two locks
>>         a) device_lock()
>>         b) mem_hotplug_lock
>>
>> While add_memory() first takes b), followed by a) during
>> bus_probe_device(), onlining of memory from user space first took b),
>> followed by a), exposing a possible deadlock.
>>
>> In [1], and it was decided to not make use of device_hotplug_lock, but
>> rather to enforce a locking order. Looking at 1., this order is not always
>> satisfied when calling device_online() - essentially we simply don't take
>> one of both locks anymore - and fixing this would require us to
>> take the mem_hotplug_lock in core driver code (online_store()), which
>> sounds wrong.
>>
>> The problems I spotted related to this:
>>
>> 1. Memory block device attributes: While .state first calls
>>    mem_hotplug_begin() and the calls device_online() - which takes
>>    device_lock() - .online does no longer call mem_hotplug_begin(), so
>>    effectively calls online_pages() without mem_hotplug_lock. onlining/
>>    offlining of pages is no longer serialised across different devices.
>>
>> 2. device_online() should be called under device_hotplug_lock, however
>>    onlining memory during add_memory() does not take care of that. (I
>>    didn't follow how strictly this is needed, but there seems to be a
>>    reason because it is documented at device_online() and
>>    device_offline()).
>>
>> In addition, I think there is also something wrong about the locking in
>>
>> 3. arch/powerpc/platforms/powernv/memtrace.c calls offline_pages()
>>    (and device_online()) without locks. This was introduced after
>>    30467e0b3be. And skimming over the code, I assume it could need some
>>    more care in regards to locking.
>>
>> ACPI code already holds the device_hotplug_lock, and as we are
>> effectively hotplugging memory block devices, requiring to hold that
>> lock does not sound too wrong, although not chosen in [1], as
>>         "I don't think resolving a locking dependency is appropriate by
>>          just serializing them with another lock."
>> I think this is the cleanest solution.
>>
>> Requiring add_memory()/add_memory_resource() to be called under
>> device_hotplug_lock fixes 2., taking the mem_hotplug_lock in
>> online_pages/offline_pages() fixes 1. and 3.
>>
>> Fixup all callers of add_memory/add_memory_resource to hold the lock if
>> not already done.
>>
>> So this is essentially a revert of 30467e0b3be, implementation of what
>> was suggested in [1] by Vitaly, applied to the current tree.
>>
>> [1] http://driverdev.linuxdriverproject.org/pipermail/ driverdev-devel/
>>     2015-February/065324.html
>>
>> This patch is partly based on a patch by Vitaly Kuznetsov.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/powerpc/platforms/powernv/memtrace.c |  3 ++
>>  drivers/acpi/acpi_memhotplug.c            |  1 +
>>  drivers/base/memory.c                     | 18 +++++-----
>>  drivers/hv/hv_balloon.c                   |  4 +++
>>  drivers/s390/char/sclp_cmd.c              |  3 ++
>>  drivers/xen/balloon.c                     |  3 ++
>>  mm/memory_hotplug.c                       | 42 ++++++++++++++++++-----
>>  7 files changed, 55 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
>> index 51dc398ae3f7..4c2737a33020 100644
>> --- a/arch/powerpc/platforms/powernv/memtrace.c
>> +++ b/arch/powerpc/platforms/powernv/memtrace.c
>> @@ -206,6 +206,8 @@ static int memtrace_online(void)
>>         int i, ret = 0;
>>         struct memtrace_entry *ent;
>>
>> +       /* add_memory() requires device_hotplug_lock */
>> +       lock_device_hotplug();
>>         for (i = memtrace_array_nr - 1; i >= 0; i--) {
>>                 ent = &memtrace_array[i];
>>
>> @@ -244,6 +246,7 @@ static int memtrace_online(void)
>>                 pr_info("Added trace memory back to node %d\n", ent->nid);
>>                 ent->size = ent->start = ent->nid = -1;
>>         }
>> +       unlock_device_hotplug();
>>         if (ret)
>>                 return ret;
>>
>> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
>> index 6b0d3ef7309c..e7a4c7900967 100644
>> --- a/drivers/acpi/acpi_memhotplug.c
>> +++ b/drivers/acpi/acpi_memhotplug.c
>> @@ -228,6 +228,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>>                 if (node < 0)
>>                         node = memory_add_physaddr_to_nid(info->start_addr);
>>
>> +               /* we already hold the device_hotplug lock at this point */
>>                 result = add_memory(node, info->start_addr, info->length);
>>
>>                 /*
> 
> A very minor nit here: I would say "device_hotplug_lock is already
> held at this point" in the comment (I sort of don't like to say "we"
> in code comments as it is not particularly clear what group of people
> is represented by that and the lock is actually called
> device_hotplug_lock).

Easy to fix, thanks!

> 
> Otherwise the approach is fine by me.
> 
> BTW, the reason why device_hotplug_lock is acquired by the ACPI memory
> hotplug is because it generally needs to be synchronized with respect
> CPU hot-remove and similar.  I believe that this may be the case in
> non-ACPI setups as well.

Yes, and that lock is the reason why we didn't have real problems with
ACPI memory hotplug in this respect so far. (as user triggered
online/offline also takes that lock already)

> 
> Thanks,
> Rafael
> 


-- 

Thanks,

David / dhildenb
