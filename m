Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbeDZTb2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeDZTb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:31:27 -0400
Date: Thu, 26 Apr 2018 15:31:26 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mingo@kernel.org, andi@firstfloor.org, keescook@chromium.org
Message-ID: <823082096.24861749.1524771086176.JavaMail.zimbra@redhat.com>
In-Reply-To: <981100282.24860394.1524770798522.JavaMail.zimbra@redhat.com>
Subject: BUG: /proc/kcore does not export direct-mapped memory on arm64 (and
 presumably some other architectures)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.17.201, 10.4.195.19]
Thread-Topic: /proc/kcore does not export direct-mapped memory on arm64 (and presumably some other architectures)
Thread-Index: PMGTpZ8S7xqiuulvvGn4JbhIGYCG5Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While testing /proc/kcore as the live memory source for the crash utility,
it fails on arm64.  The failure on arm64 occurs because only the 
vmalloc/module space segments are exported in PT_LOAD segments, 
and it's missing all of the PT_LOAD segments for the generic 
unity-mapped regions of physical memory, as well as their associated
vmemmap sections.
  
The mapping of unity-mapped RAM segments in fs/proc/kcore.c is 
architecture-neutral, and after debugging it, I found this as the
problem.  For each chunk of physical memory, kcore_update_ram()
calls walk_system_ram_range(), passing kclist_add_private() as a 
callback function to add the chunk to the kclist, and eventually 
leading to the creation of a PT_LOAD segment.
  
kclist_add_private() does some verification of the memory region,
but this one below is bogus for arm64:
  
    static int
    kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
    {
    ... [ cut ] ...
            ent->addr = (unsigned long)__va((pfn << PAGE_SHIFT));
    ... [ cut ] ...
  
            /* Sanity check: Can happen in 32bit arch...maybe */
            if (ent->addr < (unsigned long) __va(0))
                    goto free_out;
  
And that's because __va(0) is a bogus check for arm64.  It is checking
whether the ent->addr value is less than the lowest possible unity-mapped
address.  But "0" should not be used as a physical address on arm64; the 
lowest legitimate physical address for this __va() check would be the arm64 
PHYS_OFFSET, or memstart_addr:
  
Here's the arm64 __va() and PHYS_OFFSET:
  
  #define __va(x) ((void *)__phys_to_virt((phys_addr_t)(x)))
  #define __phys_to_virt(x)       ((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
  
  extern s64                      memstart_addr;
  /* PHYS_OFFSET - the physical address of the start of memory. */
  #define PHYS_OFFSET             ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
  
If PHYS_OFFSET/memstart_addr is anything other than 0 (it is 0x4000000000 on my 
test system), the __va(0) calculation goes negative and creates a bogus, very 
large, virtual address.  And since the ent->addr virtual address is less than 
bogus __va(0) address, the test fails, and the memory chunk is rejected. 
  
Looking at the kernel sources, it seems that this would affect other
architectures as well, i.e., the ones whose __va() is not a simple
addition of the physical address with PAGE_OFFSET.
  
Anyway, I don't know what the best approach for an architecture-neutral
fix would be in this case.  So I figured I'd throw it out to you guys for
some ideas.

Dave Anderson
