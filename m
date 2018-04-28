Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeD1A6e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:58:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45615 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeD1A6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:58:32 -0400
X-Google-Smtp-Source: AB8JxZr1r9RUH+6izPjx8vLLXxh4N3xOzzPMQs5bepBSE7UZubjYPu62SCKsv7H6DtsBp7qgoFuu+A==
Subject: Re: BUG: /proc/kcore does not export direct-mapped memory on arm64
 (and presumably some other architectures)
To: Kees Cook <keescook@chromium.org>, Dave Anderson <anderson@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <andi@firstfloor.org>
References: <981100282.24860394.1524770798522.JavaMail.zimbra@redhat.com>
 <823082096.24861749.1524771086176.JavaMail.zimbra@redhat.com>
 <CAGXu5j+3LpvTk49p8o4oBiS3e=3UBAqL5oHzBZB1i9AegvMmDg@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <7ab806fe-ee36-59ad-483b-d6734fcd3451@redhat.com>
Date: Fri, 27 Apr 2018 17:58:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+3LpvTk49p8o4oBiS3e=3UBAqL5oHzBZB1i9AegvMmDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 02:16 PM, Kees Cook wrote:
> On Thu, Apr 26, 2018 at 12:31 PM, Dave Anderson <anderson@redhat.com> wrote:
>>
>> While testing /proc/kcore as the live memory source for the crash utility,
>> it fails on arm64.  The failure on arm64 occurs because only the
>> vmalloc/module space segments are exported in PT_LOAD segments,
>> and it's missing all of the PT_LOAD segments for the generic
>> unity-mapped regions of physical memory, as well as their associated
>> vmemmap sections.
>>
>> The mapping of unity-mapped RAM segments in fs/proc/kcore.c is
>> architecture-neutral, and after debugging it, I found this as the
>> problem.  For each chunk of physical memory, kcore_update_ram()
>> calls walk_system_ram_range(), passing kclist_add_private() as a
>> callback function to add the chunk to the kclist, and eventually
>> leading to the creation of a PT_LOAD segment.
>>
>> kclist_add_private() does some verification of the memory region,
>> but this one below is bogus for arm64:
>>
>>      static int
>>      kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
>>      {
>>      ... [ cut ] ...
>>              ent->addr = (unsigned long)__va((pfn << PAGE_SHIFT));
>>      ... [ cut ] ...
>>
>>              /* Sanity check: Can happen in 32bit arch...maybe */
>>              if (ent->addr < (unsigned long) __va(0))
>>                      goto free_out;
>>
>> And that's because __va(0) is a bogus check for arm64.  It is checking
>> whether the ent->addr value is less than the lowest possible unity-mapped
>> address.  But "0" should not be used as a physical address on arm64; the
>> lowest legitimate physical address for this __va() check would be the arm64
>> PHYS_OFFSET, or memstart_addr:
>>
>> Here's the arm64 __va() and PHYS_OFFSET:
>>
>>    #define __va(x) ((void *)__phys_to_virt((phys_addr_t)(x)))
>>    #define __phys_to_virt(x)       ((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
>>
>>    extern s64                      memstart_addr;
>>    /* PHYS_OFFSET - the physical address of the start of memory. */
>>    #define PHYS_OFFSET             ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
>>
>> If PHYS_OFFSET/memstart_addr is anything other than 0 (it is 0x4000000000 on my
>> test system), the __va(0) calculation goes negative and creates a bogus, very
>> large, virtual address.  And since the ent->addr virtual address is less than
>> bogus __va(0) address, the test fails, and the memory chunk is rejected.
>>
>> Looking at the kernel sources, it seems that this would affect other
>> architectures as well, i.e., the ones whose __va() is not a simple
>> addition of the physical address with PAGE_OFFSET.
>>
>> Anyway, I don't know what the best approach for an architecture-neutral
>> fix would be in this case.  So I figured I'd throw it out to you guys for
>> some ideas.
> 
> I'm not as familiar with this code, but I've added Ard and Laura to CC
> here, as this feels like something they'd be able to comment on. :)
> 
> -Kees
> 

It seems backwards that we're converting a physical address to
a virtual address and then validating that. I think checking against
pfn_valid (to ensure there is a valid memmap entry)
and then checking page_to_virt against virt_addr_valid to catch
other cases (e.g. highmem or holes in the space) seems cleaner.
Maybe something like:

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d1e82761de81..e64ecb9f2720 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -209,25 +209,34 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
  {
  	struct list_head *head = (struct list_head *)arg;
  	struct kcore_list *ent;
+	struct page *p;
+
+	if (!pfn_valid(pfn))
+		return 1;
+
+	p = pfn_to_page(pfn);
+	if (!memmap_valid_within(pfn, p, page_zone(p)))
+		return 1;
  
  	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
  	if (!ent)
  		return -ENOMEM;
-	ent->addr = (unsigned long)__va((pfn << PAGE_SHIFT));
+	ent->addr = (unsigned long)page_to_virt(p);
  	ent->size = nr_pages << PAGE_SHIFT;
  
-	/* Sanity check: Can happen in 32bit arch...maybe */
-	if (ent->addr < (unsigned long) __va(0))
+	if (!virt_addr_valid(ent->addr))
  		goto free_out;
  
  	/* cut not-mapped area. ....from ppc-32 code. */
  	if (ULONG_MAX - ent->addr < ent->size)
  		ent->size = ULONG_MAX - ent->addr;
  
-	/* cut when vmalloc() area is higher than direct-map area */
-	if (VMALLOC_START > (unsigned long)__va(0)) {
-		if (ent->addr > VMALLOC_START)
-			goto free_out;
+	/*
+	 * We've already checked virt_addr_valid so we know this address
+	 * is a valid pointer, therefore we can check against it to determine
+	 * if we need to trim
+	 */
+	if (VMALLOC_START > ent->addr) {
  		if (VMALLOC_START - ent->addr < ent->size)
  			ent->size = VMALLOC_START - ent->addr;
  	}
