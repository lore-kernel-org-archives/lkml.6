Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeEAWlO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:41:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51600 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEAWlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:41:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
References: <cover.1525197407.git.rahul.lakkireddy@chelsio.com>
        <cover.1525197407.git.rahul.lakkireddy@chelsio.com>
        <b6065b53c5446d98ee55e09119f6821f979418d4.1525197408.git.rahul.lakkireddy@chelsio.com>
Date: Tue, 01 May 2018 17:41:00 -0500
In-Reply-To: <b6065b53c5446d98ee55e09119f6821f979418d4.1525197408.git.rahul.lakkireddy@chelsio.com>
        (Rahul Lakkireddy's message of "Tue, 1 May 2018 23:57:45 +0530")
Message-ID: <87o9hzyp6r.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDdxJ-0006uf-E0;;;mid=<87o9hzyp6r.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18wKAcA1M06ONhFG3FvOCqww2SKPY3odmY=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 781 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.3%), b_tie_ro: 1.87 (0.2%), parse: 1.22 (0.2%),
        extract_message_metadata: 21 (2.7%), get_uri_detail_list: 7 (0.9%),
        tests_pri_-1000: 8 (1.0%), tests_pri_-950: 1.22 (0.2%), tests_pri_-900: 1.02
        (0.1%), tests_pri_-400: 64 (8.2%), check_bayes: 63 (8.0%), b_tokenize: 31
        (3.9%), b_tok_get_all: 17 (2.1%), b_comp_prob: 5 (0.7%), b_tok_touch_all: 7
        (0.9%), b_finish: 0.86 (0.1%), tests_pri_0: 671 (86.0%),
        check_dkim_signature: 1.05 (0.1%), check_dkim_adsp: 3.0 (0.4%),
        tests_pri_500: 7 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v7 1/3] vmcore: add API to collect hardware dump in second kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> The sequence of actions done by device drivers to append their device
> specific hardware/firmware logs to /proc/vmcore are as follows:

Except for the missing include that the kbuild test robot caught
I am not seeing a problems.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> 1. During probe (before hardware is initialized), device drivers
> register to the vmcore module (via vmcore_add_device_dump()), with
> callback function, along with buffer size and log name needed for
> firmware/hardware log collection.
>
> 2. vmcore module allocates the buffer with requested size. It adds
> an Elf note and invokes the device driver's registered callback
> function.
>
> 3. Device driver collects all hardware/firmware logs into the buffer
> and returns control back to vmcore module.
>
> Ensure that the device dump buffer size is always aligned to page size
> so that it can be mmaped.
>
> Also, rename alloc_elfnotes_buf() to vmcore_alloc_buf() to make it more
> generic and reserve NT_VMCOREDD note type to indicate vmcore device
> dump.
>
> Suggested-by: Eric Biederman <ebiederm@xmission.com>.
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
> ---
> v7:
> - Removed "CHELSIO" vendor identifier in Elf Note name. Instead,
>   writing "LINUX".
> - Moved vmcoredd_header to new file include/uapi/linux/vmcore.h
> - Reworked vmcoredd_header to include Elf Note as part of the header
>   itself.
> - Removed vmcoredd_get_note_size().
> - Renamed vmcoredd_write_note() to vmcoredd_write_header().
> - Replaced all "unsigned long" with "unsigned int" for device dump
>   size since max size of Elf Word is u32.
>
> v6:
> - Reworked device dump elf note name to contain vendor identifier.
> - Added vmcoredd_header that precedes actual dump in the Elf Note.
> - Device dump's name is moved inside vmcoredd_header.
>
> v5:
> - Removed enabling CONFIG_PROC_VMCORE_DEVICE_DUMP by default and
>   updated help message to indicate that the driver must be present
>   in second kernel's initramfs to collect the underlying device
>   snapshot.
>
> v4:
> - Made __vmcore_add_device_dump() static.
> - Moved compile check to define vmcore_add_device_dump() to
>   crash_dump.h to fix compilation when vmcore.c is not compiled in.
> - Convert ---help--- to help in Kconfig as indicated by checkpatch.
> - Rebased to tip.
>
> v3:
> - Dropped sysfs crashdd module.
> - Added CONFIG_PROC_VMCORE_DEVICE_DUMP to allow configuring device
>   dump support.
> - Moved logic related to adding dumps from crashdd to vmcore module.
> - Rename all crashdd* to vmcoredd*.
>
> v2:
> - Added ABI Documentation for crashdd.
> - Directly use octal permission instead of macro.
>
> Changes since rfc v2:
> - Moved exporting crashdd from procfs to sysfs.  Suggested by
>   Stephen Hemminger <stephen@networkplumber.org>
> - Moved code from fs/proc/crashdd.c to fs/crashdd/ directory.
> - Replaced all proc API with sysfs API and updated comments.
> - Calling driver callback before creating the binary file under
>   crashdd sysfs.
> - Changed binary dump file permission from S_IRUSR to S_IRUGO.
> - Changed module name from CRASH_DRIVER_DUMP to CRASH_DEVICE_DUMP.
>
> rfc v2:
> - Collecting logs in 2nd kernel instead of during kernel panic.
>   Suggested by Eric Biederman <ebiederm@xmission.com>.
> - Patch added in this series.
>
>  fs/proc/Kconfig             |  15 +++++
>  fs/proc/vmcore.c            | 140 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/crash_dump.h  |  18 ++++++
>  include/linux/kcore.h       |   6 ++
>  include/uapi/linux/elf.h    |   1 +
>  include/uapi/linux/vmcore.h |  16 +++++
>  6 files changed, 187 insertions(+), 9 deletions(-)
>  create mode 100644 include/uapi/linux/vmcore.h
>
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 1ade1206bb89..0eaeb41453f5 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -43,6 +43,21 @@ config PROC_VMCORE
>          help
>          Exports the dump image of crashed kernel in ELF format.
>  
> +config PROC_VMCORE_DEVICE_DUMP
> +	bool "Device Hardware/Firmware Log Collection"
> +	depends on PROC_VMCORE
> +	default n
> +	help
> +	  After kernel panic, device drivers can collect the device
> +	  specific snapshot of their hardware or firmware before the
> +	  underlying devices are initialized in crash recovery kernel.
> +	  Note that the device driver must be present in the crash
> +	  recovery kernel's initramfs to collect its underlying device
> +	  snapshot.
> +
> +	  If you say Y here, the collected device dumps will be added
> +	  as ELF notes to /proc/vmcore.
> +
>  config PROC_SYSCTL
>  	bool "Sysctl support (/proc/sys)" if EXPERT
>  	depends on PROC_FS
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a45f0af22a60..60fce8dfe4e3 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/crash_dump.h>
>  #include <linux/list.h>
> +#include <linux/mutex.h>
>  #include <linux/vmalloc.h>
>  #include <linux/pagemap.h>
>  #include <linux/uaccess.h>
> @@ -44,6 +45,12 @@ static u64 vmcore_size;
>  
>  static struct proc_dir_entry *proc_vmcore;
>  
> +#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> +/* Device Dump list and mutex to synchronize access to list */
> +static LIST_HEAD(vmcoredd_list);
> +static DEFINE_MUTEX(vmcoredd_mutex);
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> +
>  /*
>   * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
>   * The called function has to take care of module refcounting.
> @@ -302,10 +309,8 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
>  };
>  
>  /**
> - * alloc_elfnotes_buf - allocate buffer for ELF note segment in
> - *                      vmalloc memory
> - *
> - * @notes_sz: size of buffer
> + * vmcore_alloc_buf - allocate buffer in vmalloc memory
> + * @sizez: size of buffer
>   *
>   * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
>   * the buffer to user-space by means of remap_vmalloc_range().
> @@ -313,12 +318,12 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
>   * If CONFIG_MMU is not defined, use vzalloc() since mmap_vmcore() is
>   * disabled and there's no need to allow users to mmap the buffer.
>   */
> -static inline char *alloc_elfnotes_buf(size_t notes_sz)
> +static inline char *vmcore_alloc_buf(size_t size)
>  {
>  #ifdef CONFIG_MMU
> -	return vmalloc_user(notes_sz);
> +	return vmalloc_user(size);
>  #else
> -	return vzalloc(notes_sz);
> +	return vzalloc(size);
>  #endif
>  }
>  
> @@ -665,7 +670,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  		return rc;
>  
>  	*notes_sz = roundup(phdr_sz, PAGE_SIZE);
> -	*notes_buf = alloc_elfnotes_buf(*notes_sz);
> +	*notes_buf = vmcore_alloc_buf(*notes_sz);
>  	if (!*notes_buf)
>  		return -ENOMEM;
>  
> @@ -851,7 +856,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  		return rc;
>  
>  	*notes_sz = roundup(phdr_sz, PAGE_SIZE);
> -	*notes_buf = alloc_elfnotes_buf(*notes_sz);
> +	*notes_buf = vmcore_alloc_buf(*notes_sz);
>  	if (!*notes_buf)
>  		return -ENOMEM;
>  
> @@ -1145,6 +1150,120 @@ static int __init parse_crash_elf_headers(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> +/**
> + * vmcoredd_write_header - Write vmcore device dump header at the
> + * beginning of the dump's buffer.
> + * @buf: Output buffer where the note is written
> + * @data: Dump info
> + * @size: Size of the dump
> + *
> + * Fills beginning of the dump's buffer with vmcore device dump header.
> + */
> +static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
> +				  u32 size)
> +{
> +	struct vmcoredd_header *vdd_hdr = (struct vmcoredd_header *)buf;
> +
> +	vdd_hdr->n_namesz = sizeof(vdd_hdr->name);
> +	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
> +	vdd_hdr->n_type = NT_VMCOREDD;
> +
> +	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> +		sizeof(vdd_hdr->name));
> +	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +}
> +
> +/**
> + * vmcore_add_device_dump - Add a buffer containing device dump to vmcore
> + * @data: dump info.
> + *
> + * Allocate a buffer and invoke the calling driver's dump collect routine.
> + * Write Elf note at the beginning of the buffer to indicate vmcore device
> + * dump and add the dump to global list.
> + */
> +static int __vmcore_add_device_dump(struct vmcoredd_data *data)
> +{
> +	struct vmcoredd_node *dump;
> +	void *buf = NULL;
> +	size_t data_size;
> +	int ret;
> +
> +	if (!data || !strlen(data->dump_name) ||
> +	    !data->vmcoredd_callback || !data->size)
> +		return -EINVAL;
> +
> +	dump = vzalloc(sizeof(*dump));
> +	if (!dump) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	/* Keep size of the buffer page aligned so that it can be mmaped */
> +	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> +			    PAGE_SIZE);
> +
> +	/* Allocate buffer for driver's to write their dumps */
> +	buf = vmcore_alloc_buf(data_size);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	vmcoredd_write_header(buf, data, data_size -
> +			      sizeof(struct vmcoredd_header));
> +
> +	/* Invoke the driver's dump collection routing */
> +	ret = data->vmcoredd_callback(data, buf +
> +				      sizeof(struct vmcoredd_header));
> +	if (ret)
> +		goto out_err;
> +
> +	dump->buf = buf;
> +	dump->size = data_size;
> +
> +	/* Add the dump to driver sysfs list */
> +	mutex_lock(&vmcoredd_mutex);
> +	list_add_tail(&dump->list, &vmcoredd_list);
> +	mutex_unlock(&vmcoredd_mutex);
> +
> +	return 0;
> +
> +out_err:
> +	if (buf)
> +		vfree(buf);
> +
> +	if (dump)
> +		vfree(dump);
> +
> +	return ret;
> +}
> +
> +int vmcore_add_device_dump(struct vmcoredd_data *data)
> +{
> +	return __vmcore_add_device_dump(data);
> +}
> +EXPORT_SYMBOL(vmcore_add_device_dump);
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> +
> +/* Free all dumps in vmcore device dump list */
> +static void vmcore_free_device_dumps(void)
> +{
> +#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> +	mutex_lock(&vmcoredd_mutex);
> +	while (!list_empty(&vmcoredd_list)) {
> +		struct vmcoredd_node *dump;
> +
> +		dump = list_first_entry(&vmcoredd_list, struct vmcoredd_node,
> +					list);
> +		list_del(&dump->list);
> +		vfree(dump->buf);
> +		vfree(dump);
> +	}
> +	mutex_unlock(&vmcoredd_mutex);
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> +}
> +
>  /* Init function for vmcore module. */
>  static int __init vmcore_init(void)
>  {
> @@ -1192,4 +1311,7 @@ void vmcore_cleanup(void)
>  		kfree(m);
>  	}
>  	free_elfcorebuf();
> +
> +	/* clear vmcore device dump list */
> +	vmcore_free_device_dumps();
>  }
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index f7ac2aa93269..3e4ba9d753c8 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -5,6 +5,7 @@
>  #include <linux/kexec.h>
>  #include <linux/proc_fs.h>
>  #include <linux/elf.h>
> +#include <uapi/linux/vmcore.h>
>  
>  #include <asm/pgtable.h> /* for pgprot_t */
>  
> @@ -93,4 +94,21 @@ static inline bool is_kdump_kernel(void) { return 0; }
>  #endif /* CONFIG_CRASH_DUMP */
>  
>  extern unsigned long saved_max_pfn;
> +
> +/* Device Dump information to be filled by drivers */
> +struct vmcoredd_data {
> +	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> +	unsigned int size;                       /* Size of the dump */
> +	/* Driver's registered callback to be invoked to collect dump */
> +	int (*vmcoredd_callback)(struct vmcoredd_data *data, void *buf);
> +};
> +
> +#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> +int vmcore_add_device_dump(struct vmcoredd_data *data);
> +#else
> +static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  #endif /* LINUX_CRASHDUMP_H */
> diff --git a/include/linux/kcore.h b/include/linux/kcore.h
> index 80db19d3a505..8de55e4b5ee9 100644
> --- a/include/linux/kcore.h
> +++ b/include/linux/kcore.h
> @@ -28,6 +28,12 @@ struct vmcore {
>  	loff_t offset;
>  };
>  
> +struct vmcoredd_node {
> +	struct list_head list;	/* List of dumps */
> +	void *buf;		/* Buffer containing device's dump */
> +	unsigned int size;	/* Size of the buffer */
> +};
> +
>  #ifdef CONFIG_PROC_KCORE
>  extern void kclist_add(struct kcore_list *, void *, size_t, int type);
>  #else
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index e2535d6dcec7..4e12c423b9fe 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -421,6 +421,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
>  #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
>  #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
> +#define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
>  
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
> diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
> new file mode 100644
> index 000000000000..f9eab9a37370
> --- /dev/null
> +++ b/include/uapi/linux/vmcore.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _UAPI_VMCORE_H
> +#define _UAPI_VMCORE_H
> +
> +#define VMCOREDD_NOTE_NAME "LINUX"
> +#define VMCOREDD_MAX_NAME_BYTES 44
> +
> +struct vmcoredd_header {
> +	__u32 n_namesz; /* Name size */
> +	__u32 n_descsz; /* Content size */
> +	__u32 n_type;   /* NT_VMCOREDD */
> +	__u8 name[8];   /* LINUX\0\0\0 */
> +	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> +};
> +
> +#endif /* _UAPI_VMCORE_H */
