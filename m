Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeCSXBA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:01:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39164 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932418AbeCSXA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:00:56 -0400
X-Google-Smtp-Source: AG47ELsREjOoE4448eMk0aTbQtKyzUkSe4LRBi0+152cEReodNVc4rZD4CainddB+qJLS2d4VBTrhEO0bnPb+DhnXVs=
MIME-Version: 1.0
In-Reply-To: <3ca76af0-a8aa-6dec-242f-b031e6eb4710@infradead.org>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-2-git-send-email-jix024@eng.ucsd.edu> <3ca76af0-a8aa-6dec-242f-b031e6eb4710@infradead.org>
From: Andiry Xu <jix024@eng.ucsd.edu>
Date: Mon, 19 Mar 2018 16:00:54 -0700
Message-ID: <CAD4SzjtF70tL1Zi9gJxMjCafYgnKQ1wLEXtBCFUUzb9v_D4f_w@mail.gmail.com>
Subject: Re: [RFC v2 01/83] Introduction and documentation of NOVA filesystem.
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        swhiteho@redhat.com, miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2JN18E1013223

Thanks for all the comments.

On Mon, Mar 19, 2018 at 1:43 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 03/10/2018 10:17 AM, Andiry Xu wrote:
>> From: Andiry Xu <jix024@cs.ucsd.edu>
>>
>> NOVA is a log-structured file system tailored for byte-addressable non-volatile memories.
>> It was designed and developed at the Non-Volatile Systems Laboratory in the Computer
>> Science and Engineering Department at the University of California, San Diego.
>> Its primary authors are Andiry Xu <jix024@eng.ucsd.edu>, Lu Zhang
>> <luzh@eng.ucsd.edu>, and Steven Swanson <swanson@eng.ucsd.edu>.
>>
>> These two papers provide a detailed, high-level description of NOVA's design goals and approach:
>>
>>    NOVA: A Log-structured File system for Hybrid Volatile/Non-volatile Main Memories
>>    In The 14th USENIX Conference on File and Storage Technologies (FAST '16)
>>    (http://cseweb.ucsd.edu/~swanson/papers/FAST2016NOVA.pdf)
>>
>>    NOVA-Fortis: A Fault-Tolerant Non-Volatile Main Memory File System
>>    In The 26th ACM Symposium on Operating Systems Principles (SOSP '17)
>>    (http://cseweb.ucsd.edu/~swanson/papers/SOSP2017-NOVAFortis.pdf)
>>
>> This patchset contains features from the FAST paper. We leave NOVA-Fortis features,
>> such as snapshot, metadata and data replication and RAID parity for
>> future submission.
>>
>> Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
>> ---
>>  Documentation/filesystems/00-INDEX |   2 +
>>  Documentation/filesystems/nova.txt | 498 +++++++++++++++++++++++++++++++++++++
>>  MAINTAINERS                        |   8 +
>>  3 files changed, 508 insertions(+)
>>  create mode 100644 Documentation/filesystems/nova.txt
>
>> diff --git a/Documentation/filesystems/nova.txt b/Documentation/filesystems/nova.txt
>> new file mode 100644
>> index 0000000..4728f50
>> --- /dev/null
>> +++ b/Documentation/filesystems/nova.txt
>> @@ -0,0 +1,498 @@
>> +The NOVA Filesystem
>> +===================
>> +
>> +NOn-Volatile memory Accelerated file system (NOVA) is a DAX file system
>> +designed to provide a high performance and production-ready file system
>> +tailored for byte-addressable non-volatile memories (e.g., NVDIMMs
>> +and Intel's soon-to-be-released 3DXPoint DIMMs).
>> +NOVA combines design elements from many other file systems
>> +and adapts conventional log-structured file system techniques to
>> +exploit the fast random access that NVMs provide. In particular, NOVA maintains
>> +separate logs for each inode to improve concurrency, and stores file data
>> +outside the log to minimize log size and reduce garbage collection costs. NOVA's
>> +logs provide metadata and data atomicity and focus on simplicity and
>> +reliability, keeping complex metadata structures in DRAM to accelerate lookup
>> +operations.
>> +
>> +NOVA was developed by the Non-Volatile Systems Laboratory (NVSL) in
>> +the Computer Science and Engineering Department at the University of
>> +California, San Diego.
>> +
>> +A more thorough discussion of NOVA's design is avaialable in these two papers:
>
>                                                   available
>
>> +
>> +NOVA: A Log-structured File System for Hybrid Volatile/Non-volatile Main Memories
>> +Jian Xu and Steven Swanson
>> +In The 14th USENIX Conference on File and Storage Technologies (FAST '16)
>> +
>> +NOVA-Fortis: A Fault-Tolerant Non-Volatile Main Memory File System
>> +Jian Xu, Lu Zhang, Amirsaman Memaripour, Akshatha Gangadharaiah, Amit Borase,
>> +Tamires Brito Da Silva, Andy Rudoff and Steven Swanson
>> +In The 26th ACM Symposium on Operating Systems Principles (SOSP '17)
>> +
>> +This version of NOVA contains features from the FAST paper.
>> +NOVA-Fortis features, such as snapshot, metadata and data protection and replication
>> +are left for future submission.
>> +
>> +The main NOVA features include:
>> +
>> +  * POSIX semantics
>> +  * Directly access (DAX) byte-addressable NVMM without page caching
>> +  * Per-CPU NVMM pool to maximize concurrency
>> +  * Strong consistency guarantees with 8-byte atomic stores
>> +
>> +
>> +Filesystem Design
>> +=================
>> +
>> +NOVA divides NVMM into several regions. NOVA's 512B superblock contains global
>
>                                         (prefer:) 512-byte
>
>> +file system information and the recovery inode. The recovery inode represents a
>> +special file that stores recovery information (e.g., the list of unallocated
>> +NVMM pages). NOVA divides its inode tables into per-CPU stripes. It also
>> +provides per-CPU journals for complex file operations that involve multiple
>> +inodes. The rest of the available NVMM stores logs and file data.
>> +
>> +NOVA is log-structured and stores a separate log for each inode to maximize
>> +concurrency and provide atomicity for operations that affect a single file. The
>> +logs only store metadata and comprise a linked list of 4 KB pages. Log entries
>> +are small – between 32 and 64 bytes. Logs are generally non-contiguous, and log
>> +pages may reside anywhere in NVMM.
>> +
>> +NOVA keeps copies of most file metadata in DRAM during normal
>> +operations, eliminating the need to access metadata in NVMM during reads.
>> +
>> +NOVA supports both copy-on-write and in-place file data updates and appends
>> +metadata about the write to the log. For operations that affect multiple inodes
>
>                                                                             inodes,
>
>> +NOVA uses lightweight, fixed-length journals –one per core.
>
>                                                 -- one per core.
>
>> +
>> +NOVA divides the allocatable NVMM into multiple regions, one region per CPU
>> +core. A per-core allocator manages each of the regions, minimizing contention
>> +during memory allocation.
>> +
>> +After a system crash, NOVA must scan all the logs to rebuild the memory
>> +allocator state. Since, there are many logs, NOVA aggressively parallelizes the
>
>                     Since there are
>
>> +scan.
>> +
>> +
>> +Building and using NOVA
>> +=======================
>> +
>> +To build NOVA, build the kernel with PMEM (`CONFIG_BLK_DEV_PMEM`),
>> +DAX (`CONFIG_FS_DAX`) and NOVA (`CONFIG_NOVA_FS`) support.  Install as usual.
>> +
>> +NOVA runs on a pmem non-volatile memory region.  You can create one of these
>> +regions with the `memmap` kernel command line option.  For instance, adding
>> +`memmap=16G!8G` to the kernel boot parameters will reserve 16GB memory starting
>> +from address 8GB, and the kernel will create a `pmem0` block device under the
>> +`/dev` directory.
>> +
>> +After the OS has booted, you can initialize a NOVA instance with the following commands:
>> +
>> +
>> +# modprobe nova
>> +# mount -t NOVA -o init /dev/pmem0 /mnt/nova
>
> Hmph, unique in upper-case-ness (at least for in-tree fs-es).
> Would you consider "nova" instead?
>

I will try that.

>> +
>> +
>> +The above commands create a NOVA instance on `/dev/pmem0` and mounts it on
>> +`/mnt/nova`.
>> +
>> +NOVA support several module command line options:
>
>         supports
>
>> +
>> + * measure_timing: Measure the timing of file system operations for profiling (default: 0)
>> +
>> + * inplace_data_updates:  Update data in place rather than with COW (default: 0)
>> +
>> +To recover an existing NOVA instance, mount NOVA without the init option, for example:
>> +
>> +# mount -t NOVA /dev/pmem0 /mnt/nova
>> +
>> +
>> +Sysfs support
>> +-------------
>> +
>> +NOVA provides sysfs support to enable user to get/set information of
>
>                                   enable a user
>                         or        enable users
>
> And the line above ends with a trailing space.  Please check/remove all of those.
>
>> +a running NOVA instance.
>> +After mount, NOVA creates four entries under proc directory /proc/fs/nova/pmem#/:
>
> Above uses lower-case "nova" in /proc/fs/nova/... but the examples below use NOVA.
> nova is preferred (IMO).
>
>> +
>> +timing_stats IO_stats        allocator       gc
>> +
>> +Show NOVA file operation timing statistics:
>> +# cat /proc/fs/NOVA/pmem#/timing_stats
>> +
>> +Clear timing statistics:
>> +# echo 1 > /proc/fs/NOVA/pmem#/timing_stats
>> +
>> +Show NOVA I/O statistics:
>> +# cat /proc/fs/NOVA/pmem#/IO_stats
>> +
>> +Clear I/O statistics:
>> +# echo 1 > /proc/fs/NOVA/pmem#/IO_stats
>> +
>> +Show NOVA allocator information:
>> +# cat /proc/fs/NOVA/pmem#/allocator
>> +
>> +Manual garbage collection:
>> +# echo #inode_number > /proc/fs/NOVA/pmem#/gc
>> +
>> +
>> +Source File Structure
>> +=====================
>> +
>> +  * nova_def.h/nova.h
>> +   Defines NOVA macros and key inline functions.
>> +
>> +  * balloc.{h,c}
>> +    NOVA's pmem allocator implementation.
>> +
>> +  * bbuild.c
>> +    Implements recovery routines to restore the in-use inode list and the NVMM
>> +    allocator information.
>> +
>> +  * dax.c
>> +    Implements DAX read/write and mmap functions to access file data. NOVA uses
>> +    copy-on-write to modify file pages by default, unless inplace data update is
>> +    enabled at mount-time.
>> +
>> +  * dir.c
>> +    Contains functions to create, update, and remove NOVA dentries.
>> +
>> +  * file.c
>> +    Implements file-related operations such as open, fallocate, llseek, fsync,
>> +    and flush.
>> +
>> +  * gc.c
>> +    NOVA's garbage collection functions.
>> +
>> +  * inode.{h,c}
>> +    Creates, reads, and frees NOVA inode tables and inodes.
>> +
>> +  * ioctl.c
>> +    Implements some ioctl commands to call NOVA's internal functions.
>> +
>> +  * journal.{h,c}
>> +    For operations that affect multiple inodes NOVA uses lightweight,
>> +    fixed-length journals – one per core. This file contains functions to
>> +    create and manage the lite journals.
>> +
>> +  * log.{h,c}
>> +    Functions to manipulate NOVA inode logs, including log page allocation, log
>> +    entry creation, commit, modification, and deletion.
>> +
>> +  * namei.c
>> +    Functions to create/remove files, directories, and links. It also looks for
>> +    the NOVA inode number for a given path name.
>> +
>> +  * rebuild.c
>> +    When mounting NOVA, rebuild NOVA inodes from its logs.
>> +
>> +  * stats.{h,c}
>> +    Provide routines to gather and print NOVA usage statistics.
>> +
>> +  * super.{h,c}
>> +    Super block structures and NOVA FS layout and entry points for NOVA
>> +    mounting and unmounting, initializing or recovering the NOVA super block
>> +    and other global file system information.
>> +
>> +  * symlink.c
>> +    Implements functions to create and read symbolic links in the filesystem.
>> +
>> +  * sysfs.c
>> +    Implements sysfs entries to take user inputs for printing NOVA statistics.
>
> s/sysfs/procfs/
>
>> +
>> +
>> +Filesystem Layout
>> +=================
>> +
>> +A NOVA file systems resides in single PMEM device. *****
>> +NOVA divides the device into 4KB blocks.
>
>                                 4 KB  {or use 4KB way up above here}
>
>> +
>> + block
>> ++---------------------------------------------------------+
>> +|    0    | primary super block (struct nova_super_block) |
>> ++---------------------------------------------------------+
>> +|    1    | Reserved inodes                               |
>> ++---------------------------------------------------------+
>> +|  2 - 15 | reserved                                      |
>> ++---------------------------------------------------------+
>> +| 16 - 31 | Inode table pointers                          |
>> ++---------------------------------------------------------+
>> +| 32 - 47 | Journal pointers                              |
>> ++---------------------------------------------------------+
>> +| 48 - 63 | reserved                                      |
>> ++---------------------------------------------------------+
>> +|   ...   | log and data pages                            |
>> ++---------------------------------------------------------+
>> +|   n-2   | replica reserved Inodes                       |
>> ++---------------------------------------------------------+
>> +|   n-1   | replica super block                           |
>> ++---------------------------------------------------------+
>> +
>> +
>> +
>> +Superblock and Associated Structures
>> +====================================
>> +
>> +The beginning of the PMEM device hold the super block and its associated
>
>                                     holds
>
>> +tables.  These include reserved inodes, a table of pointers to the journals
>> +NOVA uses for complex operations, and pointers to inodes tables.  NOVA
>> +maintains replicas of the super block and reserved inodes in the last two
>> +blocks of the PMEM area.
>> +
>> +
>> +Block Allocator/Free Lists
>> +==========================
>> +
>> +NOVA uses per-CPU allocators to manage free PMEM blocks.  On initialization,> +NOVA divides the range of blocks in the PMEM device among the CPUs, and those
>> +blocks are managed solely by that CPU.  We call these ranges of "allocation regions".
>> +Each allocator maintains a red-black tree of unallocated ranges (struct
>> +nova_range_node).
>> +
>> +Allocation Functions
>> +--------------------
>> +
>> +NOVA allocate PMEM blocks using two mechanisms:
>
>         allocates
>
>> +
>> +1.  Static allocation as defined in super.h
>> +
>> +2.  Allocation for log and data pages via nova_new_log_blocks() and
>> +nova_new_data_blocks().
>> +
>> +
>> +PMEM Address Translation
>> +------------------------
>> +
>> +In NOVA's persistent data structures, memory locations are given as offsets
>> +from the beginning of the PMEM region.  nova_get_block() translates offsets to
>> +PMEM addresses.  nova_get_addr_off() performs the reverse translation.
>> +
>> +
>> +Inodes
>> +======
>> +
>> +NOVA maintains per-CPU inode tables, and inode numbers are striped across the
>> +tables (i.e., inos 0, n, 2n,... on cpu 0; inos 1, n + 1, 2n + 1, ... on cpu 1).
>> +
>> +The inodes themselves live in a set of linked lists (one per CPU) of 2MB
>> +blocks.  The last 8 bytes of each block points to the next block.  Pointers to
>> +heads of these list live in PMEM block INODE_TABLE_START.
>
>                   lists
>
>> +Additional space for inodes is allocated on demand.
>> +
>> +To allocate inodes, NOVA maintains a per-cpu "inuse_list" in DRAM holds a RB
>
> s/cpu/CPU/g
> s/a RB/an RB/
>
> but that isn't quite a sentence. Please fix it.
>
>> +tree that holds ranges of allocated inode numbers.
>> +
>> +
>> +Logs
>> +====
>> +
>> +NOVA maintains a log for each inode that records updates to the inode's
>> +metadata and holds pointers to the file data.  NOVA makes updates to file data
>> +and metadata atomic by atomically appending log entries to the log.
>> +
>> +Each inode contains pointers to head and tail of the inode's log.  When the log
>> +grows past the end of the last page, nova allocates additional space.  For
>> +short logs (less than 1MB) , it doubles the length.  For longer logs, it adds a
>> +fixed amount of additional space (1MB).
>> +
>> +Log space is reclaimed during garbage collection.
>> +
>> +Log Entries
>> +-----------
>> +
>> +There are four kinds of log entry, documented in log.h.  The log entries have
>> +several entries in common:
>> +
>> +   1.  'epoch_id' gives the epoch during which the log entry was created.
>> +   Creating a snapshot increments the epoch_id for the file systems.
>
>                                                           file system.  (?)
> or do multiple epochs (snapshots) => multiple fs-es?
>
>> +   Currently disabled (always zero).
>> +
>> +   2.  'trans_id' is per-inode, monotone increasing, number assigned each
>> +   log entry.  It provides an ordering over FS operations on a single inode.
>> +
>> +   3.  'invalid' is true if the effects of this entry are dead and the log
>> +   entry can be garbage collected.
>> +
>> +   4.  'csum' is a CRC32 checksum for the entry. Currently it is disabled.
>> +
>> +Log structure
>> +-------------
>> +
>> +The logs comprise a linked list of PMEM blocks.  The tail of each block
>> +contains some metadata about the block and pointers to the next block and
>> +block's replica (struct nova_inode_page_tail).
>> +
>> ++----------------+
>> +| log entry      |
>> ++----------------+
>> +| log entry      |
>> ++----------------+
>> +| ...            |
>> ++----------------+
>> +| tail           |
>> +|  metadata      |
>> +|  -> next block |
>> ++----------------+
>> +
>> +
>> +Journals
>> +========
>> +
>> +NOVA uses a lightweight journaling mechanisms to provide atomicity for
>
>                                       mechanism
>
>> +operations that modify more than one on inode.  The journals providing logging
>
> end of that "sentence" (above) is confusing or missing something.
>
>> +for two operations:
>> +
>> +1.  Single word updates (JOURNAL_ENTRY)
>> +2.  Copying inodes (JOURNAL_INODE)
>> +
>> +The journals are undo logs: NOVA creates the journal entries for an operation,
>> +and if the operation does not complete due to a system failure, the recovery
>> +process rolls back the changes using the journal entries.
>> +
>> +To commit, NOVA drops the log.
>> +
>> +NOVA maintains one journal per CPU.  The head and tail pointers for each
>> +journal live in a reserved page near the beginning of the file system.
>> +
>> +During recovery, NOVA scans the journals and undoes the operations described by
>> +each entry.
>> +
>> +
>> +File and Directory Access
>> +=========================
>> +
>> +To access file data via read(), NOVA maintains a radix tree in DRAM for each
>> +inode (nova_inode_info_header.tree) that maps file offsets to write log
>> +entries.  For directories, the same tree maps a hash of filenames to their
>> +corresponding dentry.
>> +
>> +In both cases, the nova populates the tree when the file or directory is opened
>
>                   the nova fs (?)
>
>> +by scanning its log.
>> +
>> +
>> +MMap and DAX
>> +============
>> +
>> +NOVA leverages the kernel's DAX mechanisms for mmap and file data access.
>> +NOVA supports DAX-style mmap, i.e. mapping NVM pages directly to the
>> +application's address space.
>> +
>> +
>> +Garbage Collection
>> +==================
>> +
>> +NOVA recovers log space with a two-phase garbage collection system.  When a log
>> +reaches the end of its allocated pages, NOVA allocates more space.  Then, the
>> +fast GC algorithm scans the log to remove pages that have no valid entries.
>> +Then, it estimates how many pages the logs valid entries would fill.  If this
>> +is less than half the number of pages in the log, the second GC phase copies
>> +the valid entries to new pages.
>> +
>> +For example (V=valid; I=invalid):
>> +
>> ++---+         +---+          +---+
>> +| I |               | I |            | V |
>> ++---+               +---+  Thorough  +---+
>> +| V |               | V |     GC     | V |
>> ++---+               +---+   =====>   +---+
>> +| I |               | I |            | V |
>> ++---+               +---+            +---+
>> +| V |               | V |            | V |
>> ++---+               +---+            +---+
>> +  |           |
>> +  V           V
>> ++---+               +---+
>> +| I |               | V |
>> ++---+               +---+
>> +| I | fast GC  | I |
>> ++---+  ====>   +---+
>> +| I |               | I |
>> ++---+               +---+
>> +| I |               | V |
>> ++---+               +---+
>> +  |
>> +  V
>> ++---+
>> +| V |
>> ++---+
>> +| I |
>> ++---+
>> +| I |
>> ++---+
>> +| V |
>> ++---+
>> +
>> +
>> +Umount and Recovery
>> +===================
>> +
>> +Clean umount/mount
>> +------------------
>> +
>> +On a clean unmount, NOVA saves the contents of many of its DRAM data structures
>> +to PMEM to accelerate the next mount:
>> +
>> +1. NOVA stores the allocator state for each of the per-cpu allocators to the
>> +   log of a reserved inode (NOVA_BLOCK_NODE_INO).
>> +
>> +2. NOVA stores the per-CPU lists of alive inodes (the inuse_list) to the
>> +   NOVA_BLOCK_INODELIST_INO reserved inode.
>> +
>> +After a clean unmount, the following mount restores these data and then
>> +invalidates them.
>> +
>> +Recovery after failures
>> +-----------------------
>> +
>> +In case of a unclean dismount (e.g., system crash), NOVA must rebuild these
>
>            of an unclean
>
>> +DRAM structures by scanning the inode logs.  NOVA log scanning is fast because
>> +per-CPU inode tables and per-inode logs allow for parallel recovery.
>> +
>> +The number of live log entries in an inode log is roughly the number of extents
>> +in the file.  As a result, NOVA only needs to scan a small fraction of the NVMM
>> +during recovery.
>> +
>> +The NOVA failure recovery consists of two steps:
>> +
>> +First, NOVA checks its lite weight journals and rolls back any uncommitted
>
>           should be one word: lightweight (or liteweight)
>
>> +transactions to restore the file system to a consistent state.
>> +
>> +Second, NOVA starts a recovery thread on each CPU and scans the inode tables in
>> +parallel, performing log scanning for every valid inode in the inode table.
>> +NOVA use different recovery mechanisms for directory inodes and file inodes:
>
>                                                                and file inodes.
>
>> +For a directory inode, NOVA scans the log's linked list to enumerate the pages
>> +it occupies, but it does not inspect the log's contents.  For a file inode,
>> +NOVA reads the write entries in the log to enumerate the data pages.
>> +
>> +During the recovery scan NOVA builds a bitmap of occupied pages, and rebuilds
>> +the allocator based on the result. After this process completes, the file
>> +system is ready to accept new requests.
>> +
>> +During the same scan, it rebuilds the list of available inodes.
>> +
>> +
>> +Gaps, Missing Features, and Development Status
>> +==============================================
>> +
>> +Although NOVA is a fully-functional file system, there is still much work left
>> +to be done.  In particular, (at least) the following items are currently missing:
>> +
>> +1.  Snapshot, metadata and data replication and protection are left for future submission.
>> +2.  There is no mkfs or fsck utility (`mount` takes `-o init` to create a NOVA file system).
>> +3.  NOVA only works on x86-64 kernels.
>> +4.  NOVA does not currently support extended attributes or ACL.
>> +5.  NOVA doesn't provide quota support.
>> +6.  Moving NOVA file systems between machines with different numbers of CPUs does not work.
>
> You could artificially limit the number of "known" CPUs so that a NOVA fs could be
> moved from a 16-CPU system to an 8-CPU system by telling NOVA to use only 8 CPUs
> (as an example).  Just a thought.
>

I think storing the number of CPUs in the superblock, and perform
checking during mount phase can fix the issue.

Moving from 8-CPU to 16-CPU should be simple, just allocate more inode
tables and journal pages. Moving from 16-CPU to 8-CPU is a little more
difficult, mainly in inode table linking. CPU hotplug is still a
challenge.

I will try to fix it in the next version if I have time.

Thanks,
Andiry

>> +
>> +None of these are fundamental limitations of NOVA's design.
>> +
>> +NOVA is complete and robust enough to run a range of complex applications, but
>> +it is not yet ready for production use.  Our current focus is on adding a few
>> +missing features from the list above and finding/fixing bugs.
>> +
>> +
>> +Hacking and Contributing
>> +========================
>> +
>> +If you find bugs, please report them at https://github.com/NVSL/linux-nova/issues.
>> +
>> +If you have other questions or suggestions you can contact the NOVA developers
>> +at cse-nova-hackers@eng.ucsd.edu.
>
>
> --
> ~Randy
