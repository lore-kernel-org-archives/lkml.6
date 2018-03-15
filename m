Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeCOGLv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:11:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46808 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeCOGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:11:49 -0400
X-Google-Smtp-Source: AG47ELv6zoi1b2DgbC6P0O/oAuSkA/M2WM11JfdsrvkLds0vSUFIQagnnaLGRMQ8RBdjD7kYxny4uvD1Sz1DT5pzd/0=
MIME-Version: 1.0
In-Reply-To: <20180315045401.GB4860@magnolia>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-4-git-send-email-jix024@eng.ucsd.edu> <20180315045401.GB4860@magnolia>
From: Andiry Xu <jix024@eng.ucsd.edu>
Date: Wed, 14 Mar 2018 23:11:48 -0700
Message-ID: <CAD4SzjtHmBTisX6vQYuEnJf0fKsF==w5GHqsdks6xGv1go7Lzw@mail.gmail.com>
Subject: Re: [RFC v2 03/83] Add super.h.
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com, swhiteho@redhat.com,
        miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:54 PM, Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Sat, Mar 10, 2018 at 10:17:44AM -0800, Andiry Xu wrote:
>> From: Andiry Xu <jix024@cs.ucsd.edu>
>>
>> This header file defines NOVA persistent and volatile superblock
>> data structures.
>>
>> It also defines NOVA block layout:
>>
>> Page 0: Superblock
>> Page 1: Reserved inodes
>> Page 2 - 15: Reserved
>> Page 16 - 31: Inode table pointers
>> Page 32 - 47: Journal address pointers
>> Page 48 - 63: Reserved
>> Pages n-2: Replicate reserved inodes
>> Pages n-1: Replicate superblock
>>
>> Other pages are for normal inodes, logs and data.
>>
>> Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
>> ---
>>  fs/nova/super.h | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 149 insertions(+)
>>  create mode 100644 fs/nova/super.h
>>
>> diff --git a/fs/nova/super.h b/fs/nova/super.h
>> new file mode 100644
>> index 0000000..cb53908
>> --- /dev/null
>> +++ b/fs/nova/super.h
>> @@ -0,0 +1,149 @@
>> +#ifndef __SUPER_H
>> +#define __SUPER_H
>> +/*
>> + * Structure of the NOVA super block in PMEM
>> + *
>> + * The fields are partitioned into static and dynamic fields. The static fields
>> + * never change after file system creation. This was primarily done because
>> + * nova_get_block() returns NULL if the block offset is 0 (helps in catching
>> + * bugs). So if we modify any field using journaling (for consistency), we
>> + * will have to modify s_sum which is at offset 0. So journaling code fails.
>> + * This (static+dynamic fields) is a temporary solution and can be avoided
>> + * once the file system becomes stable and nova_get_block() returns correct
>> + * pointers even for offset 0.
>> + */
>> +struct nova_super_block {
>> +     /* static fields. they never change after file system creation.
>> +      * checksum only validates up to s_start_dynamic field below
>> +      */
>> +     __le32          s_sum;                  /* checksum of this sb */
>> +     __le32          s_magic;                /* magic signature */
>> +     __le32          s_padding32;
>> +     __le32          s_blocksize;            /* blocksize in bytes */
>> +     __le64          s_size;                 /* total size of fs in bytes */
>> +     char            s_volume_name[16];      /* volume name */
>> +
>> +     /* all the dynamic fields should go here */
>> +     __le64          s_epoch_id;             /* Epoch ID */
>> +
>> +     /* s_mtime and s_wtime should be together and their order should not be
>> +      * changed. we use an 8 byte write to update both of them atomically
>> +      */
>> +     __le32          s_mtime;                /* mount time */
>> +     __le32          s_wtime;                /* write time */
>
> Hmmm, 32-bit timestamps?  2038 isn't that far away...
>

I will try fixing this in the next version.

>> +} __attribute((__packed__));
>> +
>> +#define NOVA_SB_SIZE 512       /* must be power of two */
>> +
>> +/* ======================= Reserved blocks ========================= */
>> +
>> +/*
>> + * Page 0 contains super blocks;
>> + * Page 1 contains reserved inodes;
>> + * Page 2 - 15 are reserved.
>> + * Page 16 - 31 contain pointers to inode tables.
>> + * Page 32 - 47 contain pointers to journal pages.
>> + */
>> +#define      HEAD_RESERVED_BLOCKS    64
>> +#define      NUM_JOURNAL_PAGES       16
>> +
>> +#define      SUPER_BLOCK_START       0 // Superblock
>> +#define      RESERVE_INODE_START     1 // Reserved inodes
>> +#define      INODE_TABLE_START       16 // inode table pointers
>> +#define      JOURNAL_START           32 // journal pointer table
>> +
>> +/* For replica super block and replica reserved inodes */
>> +#define      TAIL_RESERVED_BLOCKS    2
>> +
>> +/* ======================= Reserved inodes ========================= */
>> +
>> +/* We have space for 31 reserved inodes */
>> +#define NOVA_ROOT_INO                (1)
>> +#define NOVA_INODETABLE_INO  (2)     /* Fake inode associated with inode
>> +                                      * stroage.  We need this because our
>> +                                      * allocator requires inode to be
>> +                                      * associated with each allocation.
>> +                                      * The data actually lives in linked
>> +                                      * lists in INODE_TABLE_START. */
>> +#define NOVA_BLOCKNODE_INO   (3)     /* Storage for allocator state */
>> +#define NOVA_LITEJOURNAL_INO (4)     /* Storage for lightweight journals */
>> +#define NOVA_INODELIST_INO   (5)     /* Storage for Inode free list */
>> +
>> +
>> +/* Normal inode starts at 32 */
>> +#define NOVA_NORMAL_INODE_START      (32)
>
> I've been wondering this whole time, why not make the inode number the
> byte offset into the pmem?  Then you don't have to lose the last 8 bytes
> of each inode block to point to the next one.
>

During failure recovery, NOVA scans the inode logs. To find all the
inodes, it follows the inode block list. Making inode number the byte
offset cannot locate all the inodes during recovery.

One option is to organize the inodes in a B+tree, which makes the code
more complex.

Thanks,
Andiry

> --D
>
>> +
>> +
>> +
>> +/*
>> + * NOVA super-block data in DRAM
>> + */
>> +struct nova_sb_info {
>> +     struct super_block *sb;                 /* VFS super block */
>> +     struct nova_super_block *nova_sb;       /* DRAM copy of SB */
>> +     struct block_device *s_bdev;
>> +     struct dax_device *s_dax_dev;
>> +
>> +     /*
>> +      * base physical and virtual address of NOVA (which is also
>> +      * the pointer to the super block)
>> +      */
>> +     phys_addr_t     phys_addr;
>> +     void            *virt_addr;
>> +     void            *replica_reserved_inodes_addr;
>> +     void            *replica_sb_addr;
>> +
>> +     unsigned long   num_blocks;
>> +
>> +     /* Mount options */
>> +     unsigned long   bpi;
>> +     unsigned long   blocksize;
>> +     unsigned long   initsize;
>> +     unsigned long   s_mount_opt;
>> +     kuid_t          uid;    /* Mount uid for root directory */
>> +     kgid_t          gid;    /* Mount gid for root directory */
>> +     umode_t         mode;   /* Mount mode for root directory */
>> +     atomic_t        next_generation;
>> +     /* inode tracking */
>> +     unsigned long   s_inodes_used_count;
>> +     unsigned long   head_reserved_blocks;
>> +     unsigned long   tail_reserved_blocks;
>> +
>> +     struct mutex    s_lock; /* protects the SB's buffer-head */
>> +
>> +     int cpus;
>> +
>> +     /* Current epoch. volatile guarantees visibility */
>> +     volatile u64 s_epoch_id;
>> +
>> +     /* ZEROED page for cache page initialized */
>> +     void *zeroed_page;
>> +};
>> +
>> +static inline struct nova_sb_info *NOVA_SB(struct super_block *sb)
>> +{
>> +     return sb->s_fs_info;
>> +}
>> +
>> +static inline struct nova_super_block
>> +*nova_get_redund_super(struct super_block *sb)
>> +{
>> +     struct nova_sb_info *sbi = NOVA_SB(sb);
>> +
>> +     return (struct nova_super_block *)(sbi->replica_sb_addr);
>> +}
>> +
>> +
>> +/* If this is part of a read-modify-write of the super block,
>> + * nova_memunlock_super() before calling!
>> + */
>> +static inline struct nova_super_block *nova_get_super(struct super_block *sb)
>> +{
>> +     struct nova_sb_info *sbi = NOVA_SB(sb);
>> +
>> +     return (struct nova_super_block *)sbi->virt_addr;
>> +}
>> +
>> +extern void nova_error_mng(struct super_block *sb, const char *fmt, ...);
>> +
>> +#endif
>> --
>> 2.7.4
>>
