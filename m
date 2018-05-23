Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZqWifNzlxGsrXv0aUn7elBIBdUYQqAI3YKtTA1ZlurDHEtl7E7Fky3taTIIMzpG4KKlo1sv
ARC-Seal: i=1; a=rsa-sha256; t=1527099855; cv=none;
        d=google.com; s=arc-20160816;
        b=ZMkiBl2xnFoh+Sgp9h/I/15nMgvUSa09nrGsoam8z0gxm2jgyV70xVqkJfGnYcxsEI
         d0TICyhjx6WXaXRS3RWYioNXchGW3BhGFmh5I9mWFzReGuj0XJzz5aGpAkkY4SaDvwy1
         S3Kh4f8mIZxl1nLa/I1/X+ecT+N2v/Wwok9DM0bpuGevYYabshMBlBGe1cCIVJc/S1qh
         AVrCpviWcUqAyyuyCNohXvXTYhxSWybYfvuyWdO9LdgxpkToLs9cm4pp/vnyTEh9GQ86
         BYOz0hBFGa7EIA5E6wXAyKhU9hN4tTp+jY1V+aF4QBQw5Ny7K82aVmjqyQreCDePoRPG
         2Qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=/Meb5K96Zic6wwR3HckbCK43zrZSCWqw4glWBgy7fC8=;
        b=Wo+lFPcgGQnDyFbWM2C4WE7hiUg0MMe3AW1GBIflJCEi/K+QcpvPZrHShsB6arW4w6
         zVgCOvL5PxPha1dCWXcEv5CHRD96huIRtQbv7rZE+aIvxn13XpRaEuTIf02g40KHNjZq
         CcwnrZP4lx1KCDM8303j2YyyOiDTBS4PSO97zBPT4yyMDEfSPE4uSIfvwwWtE/8t+WF9
         iNnSKcHL4uKt+XRMmPmCc5yr7xnQ/fQVbHlxxzQC7CXTQjWSJg+IiWYCNkN/WPQ/p7Zf
         k4dol/bmQjb86eY5yCymaBrP0tIfO4vWbMV0jKlIu7BmxvD+MRG37a//jtDT0scLZFKw
         diRA==
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Len Brown <lenb@kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFCv2 0/4] virtio-mem: paravirtualized memory
Date: Wed, 23 May 2018 20:24:00 +0200
Message-Id: <20180523182404.11433-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601280257893566577?=
X-GMAIL-MSGID: =?utf-8?q?1601280257893566577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the Linux driver side of virtio-mem. Compared to the QEMU side,
it is in a pretty complete and clean state.

virtio-mem is a paravirtualized mechanism of adding/removing memory to/from
a VM. We can do this on a 4MB granularity right now. In Linux, all
memory is added to the ZONE_NORMAL, so unplugging cannot be guaranteed -
but will be more likely to succeed compared to unplugging 128MB+ chunks.
We might implement some optimizations in that area in the future that will
make memory unplug more reliable.

For now, this is an easy way to give a VM access to more memory and
eventually to remove some memory again. I am testing it on x86 and
s390x (under QEMU TCG so far only).

This is the follow up on [1], but the concept, user interface and
virtio protocol has been heavily changed. I am only including the important
parts in this cover letter (because otherwise nobody will read it).  Please
feel free to ask in case there are any questions.

This series is based on [4] and shows how it is being used. It contains
further information. Also have a look at the description of patch nr 4 in
this series.

This work is the result of the initital idea of Andrea Arcangeli to host
enforce guest access to memory inflated in virtio-balloon using
userfaultfd, which turned out to be problematic to implement. That's how
I came up with virtio-mem.

--------------------------------------------------------------------------
1. High level concept
--------------------------------------------------------------------------

Each virtio-mem device owns a memory region in the physical address space.
The guest is allowed to plug and online up to 'requested_size' of memory.
It will not be allowed to plug more than that size. Unplugged memory will
be protected by configurable mechanisms (e.g. random discard, userfaultfd
protection, etc.). virtio-mem is designed in a way that a guest may never
assume to be able to even read unplugged memory. This is a big difference
to classical balloon drivers.

The usable memory region might grow over time, so not all parts of the
device memory region might be usable from the start. This is an
optimization to allow a smarter implementation in the hypervisor (reduce
size of dirty bitmaps, size of memory regions ...).

When the device driver starts up, it will query 'requested_size' and start
to add memory to the system. This memory is not indicated e.g. via ACPI,
so unmodified systems will not silently try to use unplugged memory that
they are not supposed to touch.

Updates on the 'requested_size' indicate hypervisor requests to plug or
unplug memory.

As each virtio-mem device can belong to a NUMA node, we can easily
plug/unplug memory on a NUMA basis. And of course, we can have several
independent virtio-mem devices for a VM.

The idea is *not* to add new virtio-mem devices when hotplugging memory,
the idea is to resize (grow/shrink) virtio-mem devices.

--------------------------------------------------------------------------
2. Benefits
--------------------------------------------------------------------------

Guest side:
- Increase memory usable by Linux in 4MB steps (vs. section size like 128MB
  on x86 or 2GB on e.g. some arm if I'm not mistaking)
- Remove struct pages once all 4MB chunks of a section are offline (in
  contrast to all balloon drivers where this never happens)
- Don't fragment memory, while still being able to unplug smaller chunks
  than ordinary DIMM sizes.
- Memory hotplug support for architectures that have no proper interface
  (e.g. s390x misses the external notification part) or e.g. QEMU/Linux
  support is complicated to implement.
- Automatic management of onlining/offlining in the device driver -
  no manual interaction from an admin/tool necessary.

QEMU side:
- Resizing (plug/unplug) has a single interface - in contrast to a mixture
  of ACPI and virtio-balloon. See the example below.
- Migration works out of the box - no need to specify new DIMMs or new
  sizes on the migration target. It simply works.
- We can resize in arbitrary steps and sizes (in contrast to e.g. ACPI,
  where we have to know upfront in which granularity we later on want to
  remove memory or even how much memory we eventually want to add to our
  guest)
- One interface to rule them (architectures) all :)

--------------------------------------------------------------------------
3. Reboot handling
--------------------------------------------------------------------------

After a reboot, all memory is unplugged. This allows the hypervisor
to see if support for virtio-mem is available in the freshly booted system.
This way we could charge only for the actually "plugged" memory size. And
it avoids to sense for plugged memory in the guest.

E.g. on every size change of a virtio-mem device, we can notify management
layers. So we can track how much memory a VM has plugged.

--------------------------------------------------------------------------
4. Example
--------------------------------------------------------------------------

(not including resizable memory regions on the QEMU side yet, so don't
 focus on that part - it will consume a lot of memory right now for e.g.
 dirty bitmaps and memory slot tracking data)

Start QEMU with two virtio-mem devices that provide little memory inititally.
	$ qemu-system-x86_64 -m 4G,maxmem=504G \
		-smp sockets=2,cores=2 \
		[...]
		-object memory-backend-ram,id=mem0,size=256G \
		-device virtio-mem-pci,id=vm0,memdev=mem0,node=0,size=4160M \
		-object memory-backend-ram,id=mem1,size=256G \
		-device virtio-mem-pci,id=vm1,memdev=mem1,node=1,size=3G

Query the configuration ('size' tells us the guest driver is active):
	(qemu) info memory-devices
	info memory-devices
	Memory device [virtio-mem]: "vm0"
	  phys-addr: 0x140000000
	  node: 0
	  requested-size: 4362076160
	  size: 4362076160
	  max-size: 274877906944
	  block-size: 4194304
	  memdev: /objects/mem0
	Memory device [virtio-mem]: "vm1"
	  phys-addr: 0x4140000000
	  node: 1
	  requested-size: 3221225472
	  size: 3221225472
	  max-size: 274877906944
	  block-size: 4194304
	  memdev: /objects/mem1

Change the size of a virtio-mem device:
	(qemu) memory-device-resize vm0 40960
	memory-device-resize vm0 40960
	...
	(qemu) info memory-devices
	info memory-devices
	Memory device [virtio-mem]: "vm0"
	  phys-addr: 0x140000000
	  node: 0
	  requested-size: 42949672960
	  size: 42949672960
	  max-size: 274877906944
	  block-size: 4194304
	  memdev: /objects/mem0
	...

Try to unplug memory (KASAN active in the guest - a lot of memory wasted):
	(qemu) memory-device-resize vm0 1024
	memory-device-resize vm0 1024
	...
	(qemu) info memory-devices
	info memory-devices
	Memory device [virtio-mem]: "vm0"
	  phys-addr: 0x140000000
	  node: 0
	  requested-size: 1073741824
	  size: 6169821184
	  max-size: 274877906944
	  block-size: 4194304
	  memdev: /objects/mem0
	...

I am sharing for now only the linux driver side. The current code can be
found at [2]. The QEMU side is still heavily WIP, the current QEMU
prototype can be found at [3].


[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03870.html
[2] https://github.com/davidhildenbrand/linux/tree/virtio-mem
[3] https://github.com/davidhildenbrand/qemu/tree/virtio-mem
[4] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1698014.html

David Hildenbrand (4):
  ACPI: NUMA: export pxm_to_node
  s390: mm: support removal of memory
  s390: numa: implement memory_add_physaddr_to_nid()
  virtio-mem: paravirtualized memory

 arch/s390/mm/init.c             |   18 +-
 arch/s390/numa/numa.c           |   12 +
 drivers/acpi/numa.c             |    1 +
 drivers/virtio/Kconfig          |   15 +
 drivers/virtio/Makefile         |    1 +
 drivers/virtio/virtio_mem.c     | 1040 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h |    1 +
 include/uapi/linux/virtio_mem.h |  134 ++++
 8 files changed, 1216 insertions(+), 6 deletions(-)
 create mode 100644 drivers/virtio/virtio_mem.c
 create mode 100644 include/uapi/linux/virtio_mem.h

-- 
2.17.0
