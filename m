Date: Mon, 9 Apr 2018 10:03:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 4/4] zram: introduce zram memory tracking
Message-ID: <20180409080345.GC18095@kroah.com>
References: <20180409055435.135695-1-minchan@kernel.org>
 <20180409055435.135695-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409055435.135695-5-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 02:54:35PM +0900, Minchan Kim wrote:
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
>       300    75.033841 .wh
>       301    63.806904 s..
>       302    63.806919 ..h
> 
> First column is zram's block index and 3rh one represents symbol
> (s: same page w: written page to backing store h: huge page) of the
> block state. Second column represents usec time unit of the block
> was last accessed. So above example means the 300th block is accessed
> at 75.033851 second and it was huge so it was written to the backing
> store.
> 
> Admin can leverage this information to catch cold|incompressible pages
> of process with *pagemap* once part of heaps are swapped out.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  Documentation/blockdev/zram.txt |  24 ++++++
>  drivers/block/zram/Kconfig      |   9 +++
>  drivers/block/zram/zram_drv.c   | 139 +++++++++++++++++++++++++++++---
>  drivers/block/zram/zram_drv.h   |   5 ++
>  4 files changed, 166 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
> index 78db38d02bc9..45509c7d5716 100644
> --- a/Documentation/blockdev/zram.txt
> +++ b/Documentation/blockdev/zram.txt
> @@ -243,5 +243,29 @@ to backing storage rather than keeping it in memory.
>  User should set up backing device via /sys/block/zramX/backing_dev
>  before disksize setting.
>  
> += memory tracking
> +
> +With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
> +zram block. It could be useful to catch cold or incompressible
> +pages of the proess with*pagemap.
> +If you enable the feature, you could see block state via
> +/sys/kernel/debug/zram/zram0/block_state". The output is as follows,
> +
> +	  300    75.033841 .wh
> +	  301    63.806904 s..
> +	  302    63.806919 ..h
> +
> +First column is zram's block index.
> +Second column is access time.
> +Third column is state of the block.
> +(s: same page
> +w: written page to backing store
> +h: huge page)
> +
> +First line of above example says 300th block is accessed at 75.033841sec
> +and the block's state is huge so it is written back to the backing
> +storage. It's a debugging feature so anyone shouldn't rely on it to work
> +properly.
> +
>  Nitin Gupta
>  ngupta@vflare.org
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index ac3a31d433b2..efe60c82d8ec 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -26,3 +26,12 @@ config ZRAM_WRITEBACK
>  	 /sys/block/zramX/backing_dev.
>  
>  	 See zram.txt for more infomration.
> +
> +config ZRAM_MEMORY_TRACKING
> +	bool "Tracking zram block status"
> +	depends on ZRAM
> +	select DEBUG_FS

Select?  Shouldn't you depend on this instead?  Selecting is a pain to
try to track down what is keeping an option enabled.

> +	help
> +	  With this feature, admin can track the state of allocated block
> +	  of zRAM. Admin could see the information via
> +	  /sys/kernel/debug/zram/zramX/block_state.

A short note here as to where to find the documentation for what that
info is (i.e. in the file you wrote above?)

> +#else
> +static void zram_debugfs_create(void) {};
> +static void zram_debugfs_destroy(void) {};
> +static void zram_accessed(struct zram *zram, u32 index) {};
> +static void zram_reset_access(struct zram *zram, u32 index) {};
> +static void zram_debugfs_register(struct zram *zram) {};
> +static void zram_debugfs_unregister(struct zram *zram) {};
> +#endif

Much nicer, thanks!

The above was only very minor nits, no need to change anything if you
don't want to.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
