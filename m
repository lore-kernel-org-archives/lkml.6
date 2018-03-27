Date: Tue, 27 Mar 2018 09:12:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] zram: introduce zram memory tracking
Message-ID: <20180327071238.GA5830@kroah.com>
References: <20180327065033.181819-1-minchan@kernel.org>
 <20180327065033.181819-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327065033.181819-5-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:50:33PM +0900, Minchan Kim wrote:
> zRam as swap is useful for small memory device. However, swap means
> those pages on zram are mostly cold pages due to VM's LRU algorithm.
> Especially, once init data for application are touched for launching,
> they tend to be not accessed any more and finally swapped out.
> zRAM can store such cold pages as compressed form but it's pointless
> to keep in memory. Better idea is app developers free them directly
> rather than remaining them on heap.
> 
> This patch tell us last access time of each block of zram via
> "cat /sys/kernel/debug/zram/zram0/block_state".
> 
> The output is as follows,
> 
>    25064    .wh       100
>    25065    s..       9
>    25067    ..h       15
> 
> First column is zram's block index and second one represents symbol
> (s: same page w: written page to backing store h: huge page) of the
> block state. Last one means number of seconds elapsed since the block
> was last accessed. So above example means the 25065th block is accessed
> 100 second ago and it was huge so it was written to the backing store.
> 
> Admin can leverage this information to catch cold|incompressible pages
> of process with *pagemap* once part of heaps are swapped out.

For debugging, yes, but remember that no system functionality should
ever depend on debugfs :)

> +config ZRAM_MEMORY_TRACKING
> +       bool "Tracking zram block status"
> +       depends on ZRAM
> +       select DEBUG_FS

depends on?

> +       default n

That's always the default, no need to list it.

> +       help
> +	 With this feature, admin can track the state of allocated block
> +	 of zRAM. Admin could see the information via
> +	 /sys/kernel/debug/zram/zramX/block_state.

Odd indentation, please use tabs everywhere here.

> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -31,10 +31,15 @@
>  #include <linux/err.h>
>  #include <linux/idr.h>
>  #include <linux/sysfs.h>
> +#include <linux/debugfs.h>
>  #include <linux/cpuhotplug.h>
>  
>  #include "zram_drv.h"
>  
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +static struct dentry *zram_debugfs_root;
> +#endif
> +
>  static DEFINE_IDR(zram_index_idr);
>  /* idr index must be protected */
>  static DEFINE_MUTEX(zram_index_mutex);
> @@ -67,6 +72,13 @@ static inline bool init_done(struct zram *zram)
>  	return zram->disksize;
>  }
>  
> +static inline bool zram_allocated(struct zram *zram, u32 index)
> +{
> +
> +	return (zram->table[index].value >> (ZRAM_FLAG_SHIFT + 1)) ||
> +					zram->table[index].handle;
> +}
> +
>  static inline struct zram *dev_to_zram(struct device *dev)
>  {
>  	return (struct zram *)dev_to_disk(dev)->private_data;
> @@ -83,7 +95,7 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
>  }
>  
>  /* flag operations require table entry bit_spin_lock() being held */
> -static int zram_test_flag(struct zram *zram, u32 index,
> +static bool zram_test_flag(struct zram *zram, u32 index,
>  			enum zram_pageflags flag)
>  {
>  	return zram->table[index].value & BIT(flag);
> @@ -107,16 +119,6 @@ static inline void zram_set_element(struct zram *zram, u32 index,
>  	zram->table[index].element = element;
>  }
>  
> -static void zram_accessed(struct zram *zram, u32 index)
> -{
> -	zram->table[index].ac_time = get_seconds();
> -}
> -
> -static void zram_reset_access(struct zram *zram, u32 index)
> -{
> -	zram->table[index].ac_time = 0;
> -}
> -
>  static unsigned long zram_get_element(struct zram *zram, u32 index)
>  {
>  	return zram->table[index].element;
> @@ -620,6 +622,98 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
>  static void zram_wb_clear(struct zram *zram, u32 index) {}
>  #endif
>  
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +static void zram_accessed(struct zram *zram, u32 index)
> +{
> +	zram->table[index].ac_time = get_seconds();
> +}
> +
> +static void zram_reset_access(struct zram *zram, u32 index)
> +{
> +	zram->table[index].ac_time = 0;
> +}
> +
> +static ssize_t read_block_state(struct file *file, char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	char *kbuf;
> +	ssize_t index, written = 0;
> +	struct zram *zram = file->private_data;
> +	unsigned long last_access, nr_pages = zram->disksize >> PAGE_SHIFT;
> +	char flags[__NR_ZRAM_PAGEFLAGS - ZRAM_FLAG_SHIFT];
> +
> +	kbuf = kvmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	down_read(&zram->init_lock);
> +	if (!init_done(zram)) {
> +		up_read(&zram->init_lock);
> +		kvfree(kbuf);
> +		return -EINVAL;
> +	}
> +
> +	for (index = *ppos; index < nr_pages; index++) {
> +		int copied;
> +
> +		zram_slot_lock(zram, index);
> +		if (!zram_allocated(zram, index))
> +			goto next;
> +
> +		snprintf(flags, sizeof(flags), "%c%c%c",
> +			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
> +			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
> +			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.');
> +
> +		last_access = get_seconds() - zram->table[index].ac_time;
> +		copied = snprintf(kbuf + written, count, "%12lu %6s %12lu\n",
> +						index, flags, last_access);
> +		if (count < copied) {
> +			zram_slot_unlock(zram, index);
> +			break;
> +		}
> +		written += copied;
> +		count -= copied;
> +next:
> +		zram_slot_unlock(zram, index);
> +		*ppos += 1;
> +	}
> +
> +	up_read(&zram->init_lock);
> +	copy_to_user(buf, kbuf, written);
> +	kvfree(kbuf);
> +
> +	return written;
> +}
> +
> +static const struct file_operations proc_zram_block_state_op = {
> +	.open = simple_open,
> +	.read = read_block_state,
> +	.llseek = default_llseek,
> +};
> +
> +static void zram_debugfs_register(struct zram *zram)
> +{
> +	if (!zram_debugfs_root)
> +		return;
> +
> +	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
> +						zram_debugfs_root);
> +	debugfs_create_file("block_state", 0400, zram->debugfs_dir,
> +				zram, &proc_zram_block_state_op);
> +}

Much nicer code, thanks for the changes.

>  static void destroy_devices(void)
>  {
>  	class_unregister(&zram_control_class);
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +	debugfs_remove_recursive(zram_debugfs_root);
> +#endif

No need for #ifdefs in .c code if your .h files are correct.

>  	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
>  	idr_destroy(&zram_index_idr);
>  	unregister_blkdev(zram_major, "zram");
> @@ -1760,6 +1859,9 @@ static int __init zram_init(void)
>  		return ret;
>  	}
>  
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +	zram_debugfs_root = debugfs_create_dir("zram", NULL);
> +#endif

Same here. Put this in a wrapper function somewhere.

thanks,

greg k-h
