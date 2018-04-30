Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZqqeGk940QQTpu5nKDe0ImX6wf6JQTNYfcCvht2no/CZjif/FaoNsHV4H8goBCBLMJiNcCZ
ARC-Seal: i=1; a=rsa-sha256; t=1525081363; cv=none;
        d=google.com; s=arc-20160816;
        b=GB8VuHLeM/o6lFaq7iVmNLDUD7q9bsYdpKxNjRKhFPr9E3KpHJfuQxdGKPfL9vFaLg
         PU+5+5Dy33luk7xcN6ivww1fravnRB1+jfGv21soKKxkspdYZA76fFFZNqeApmZfLmap
         Hm/ns3shAdGT5+ApbLSwGSjKvLW5kakypNOyfaTqbTjz/KhM8f4wD9w0P/0r1bvc1kgt
         lkYQwK+fxp+pPvrAZZVKRP0IDWhHjmJoBxaIxcSZNZsAsUkGz4RybaxtI8qbfktOs7Up
         AALSyRJdkMP3V/AjABBEydM9DkselL0MQFKyVGMb0NbClSNnOlTR62DaRvDTLJ+lIGSI
         aK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=GtG8sdXhFwaRWCpNdVptgKt6NBp/dbqPCjvfz0/vCZ4=;
        b=gMSl7EKmRPDGhrJzWZR+CfgW/IM3OwB/vWGiU8SpnRFGxIpxnrj0DuloMrGkHnuo5t
         NFLIi1Q0kzrKF2ar6I85IzO0O6Pp1185UnXELhKmAosds7kAfPDTMxrAOgisjbccSEwi
         gCwti9Mc0b3CLvbyQJUpGiEhoQPWB1gP46oH7B9uT3tyxO949rjLU/czVX8p9MbhGAFv
         WinYY6wkTCb2hhTAq4DTqbj6j36j5h2e9pHKlklGujemdnDIobtKiviMdCZqz7CRZR4W
         xGmPORxFj2+hUy33U2l7+q60POj5MoNEoQAy0FDEeg3/Da4HNLqzPVIYvQgWm9gaL3tK
         NJwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Young <dyoung@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.vnet.ibm.com>,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Juergen Gross <jgross@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Paul Mackerras <paulus@samba.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Rashmica Gupta <rashmica.g@gmail.com>,
	Reza Arbab <arbab@linux.vnet.ibm.com>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RCFv2 0/7] mm: online/offline 4MB chunks controlled by device driver
Date: Mon, 30 Apr 2018 11:42:29 +0200
Message-Id: <20180430094236.29056-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599163715332859080?=
X-GMAIL-MSGID: =?utf-8?q?1599163715332859080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I am right now working on a paravirtualized memory device ("virtio-mem").
These devices control a memory region and the amount of memory available
via it. Memory will not be indicated/added/onlined via ACPI and friends,
the device driver is responsible for it.

When the device driver starts up, it will add and online the requested
amount of memory from its assigned physical memory region. On request, it can
add (online) either more memory or try to remove (offline) memory. As it
will be a virtio module, we also want to be able to have it as a loadable
kernel module.

Such a device can be thought of like a "resizable DIMM" or a "huge
number of 4MB DIMMS" that can be automatically managed.

As we want to be able to add/remove small chunks of memory to a VM without
fragmenting guest memory ("it's not what the guest pays for" and "what if
the hypervisor wants to sue huge pages"), it looks like we can do that
under Linux in a 4MB granularity by using online_pages()/offline_pages()

We add a segment and online only 4MB blocks of it on demand. So the other
memory might not be accessible. For kdump and offlining code, we have to
mark pages as offline before a new segment is visible to the system (e.g.
as these pages might not be backed by real memory in the hypervisor).

This is not a balloon driver. Main differences:
- We can add more memory to a VM without having to use mixture of
  technologies - e.g. ACPI for plugging, balloon for unplugging (in contrast
  to virtio-balloon).
- The device is responsible for its own memory only - will not inflate on
  any system memory. (in contrast to all balloons)
- Works on a coarser granularity (e.g. 4MB because that's what we can
  online/offline in Linux). We are not using the buddy allocator when unplugging
  but really search for chunks of memory we can offline. We actually
  can support arbitrary block sizes. (in contrast to all balloons)
- That's why we don't fragment guest memory.
- A device can belong to exactly one NUMA node. This way we can online/offline
  memory in a fine granularity NUMA aware. Even if the guest does not even
  know how to spell NUMA. (in contrast to all balloons)
- Architectures that don't have proper memory hotplug interfaces (e.g. s390x)
  get memory hotplug support. I have a prototype for s390x.
- Once all 4MB chunks of a memory block are offline, we can remove the
  memory block and therefore the struct pages. (in contrast to all balloons)

This essentially allows us to add/remove 4MB chunks to/from a VM. Especially
without caring about the future when adding memory ("If I add a 128GB DIMM
I can only unplug 128GB again") or running into limits ("If I want my VM to
grow to 4TB, I have to plug at least 16GB per DIMM").

Future work:
 - Performance improvements
 - Be smarter about which blocks to offline first (e.g. free ones)
 - Automatically manage assignemnt to NORMAL/MOVABLE zone to make
   unplug more likely to succeed.

I will post the next prototype of virtio-mem shortly.

RFC -> RFCv2:
 - "mm: introduce and use PageOffline()"
  -> Use a mapcount value instead of a page flag
  -> Rework to not require to revert a patch completely
 - "kdump: include PAGE_OFFLINE_MAPCOUNT_VALUE in ELF info$"
  -> Export the mapcount value instead
 - "mm/memory_hotplug: limit offline_pages() to sizes we can actually .."
  -> Make this look a bit nicer and drivers to also use the size
 - "mm/memory_hotplug: print only with DEBUG_VM in offline_pages()"
  -> offlining is right now fairly noisy when delaing with small chunks
 - "mm/memory_hotplug: teach offline_pages() to not try forever"
  -> We need offline_pages() to fail fast and not loop forever on persistent
     errors (e.g. -ENOMEM)
 - "mm/memory_hotplug: allow online/offline memory by a kernel module"
  -> Actually compiled it as a module and noticed that a lot was still missing

David Hildenbrand (7):
  mm: introduce and use PageOffline()
  kdump: include PAGE_OFFLINE_MAPCOUNT_VALUE in ELF info
  mm/memory_hotplug: limit offline_pages() to sizes we can actually
    handle
  mm/memory_hotplug: allow to control onlining/offlining of memory by a
    driver
  mm/memory_hotplug: print only with DEBUG_VM in offline_pages()
  mm/memory_hotplug: teach offline_pages() to not try forever
  mm/memory_hotplug: allow online/offline memory by a kernel module

 arch/powerpc/platforms/powernv/memtrace.c |   2 +-
 drivers/base/memory.c                     |  25 ++++--
 drivers/base/node.c                       |   1 -
 drivers/xen/balloon.c                     |   2 +-
 include/linux/memory.h                    |   2 +-
 include/linux/memory_hotplug.h            |  20 +++--
 include/linux/mm.h                        |   2 +
 include/linux/page-flags.h                |   9 ++
 kernel/crash_core.c                       |   1 +
 mm/memory_hotplug.c                       | 131 +++++++++++++++++++++++++-----
 mm/page_alloc.c                           |  22 +++--
 mm/sparse.c                               |  25 +++++-
 12 files changed, 195 insertions(+), 47 deletions(-)

-- 
2.14.3
