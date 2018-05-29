Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966369AbeE2TU2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:20:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45880 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966323AbeE2TUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:20:23 -0400
Date: Tue, 29 May 2018 21:20:21 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] procfs: use inline functions instead of macros for
 proc_create_single_data stub
Message-ID: <20180529212021.62d06424@bbrezillon>
In-Reply-To: <20180525214548.2122779-1-arnd@arndb.de>
References: <20180525214548.2122779-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 23:45:00 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> The procfs interface changes caused one warning in afs for
> a now unused function:
> 
> fs/afs/proc.c:818:12: error: 'afs_proc_stats_show' defined but not used [-Werror=unused-function]
>  static int afs_proc_stats_show(struct seq_file *m, void *v)
> 
> This can be avoided by using an inline function instead of a macro
> to reference it, so now the compiler can silently drop the function
> after seeing that there is a reference but that it is never called.
> 
> Unfortunately, this change triggers another warning where a function
> is hidden and now unexpectedly referenced:
> 
> drivers/mtd/mtdcore.c: In function 'init_mtd':
> drivers/mtd/mtdcore.c:1878:48: error: 'mtd_proc_show' undeclared (first use in this function); did you mean 'mtd_name_show'?
> 
> It seems nicer to keep using the inline function and removing the #ifdef
> here than to add an #ifdef around every single function we pass into
> proc_create_single_data(), so I'm removing the #ifdef here.
> 
> After a few hundred randconfig builds, this was the only instance
> I found that caused a problem.
> 
> Fixes: 353861cf0594 ("afs: simplify procfs code")
> Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/mtdcore.c   |  3 ---
>  include/linux/proc_fs.h | 10 ++++++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 42395df06be9..08d1e89faf9c 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1814,8 +1814,6 @@ void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size)
>  }
>  EXPORT_SYMBOL_GPL(mtd_kmalloc_up_to);
>  
> -#ifdef CONFIG_PROC_FS
> -
>  /*====================================================================*/
>  /* Support for /proc/mtd */
>  
> @@ -1833,7 +1831,6 @@ static int mtd_proc_show(struct seq_file *m, void *v)
>  	mutex_unlock(&mtd_table_mutex);
>  	return 0;
>  }
> -#endif /* CONFIG_PROC_FS */
>  
>  /*====================================================================*/
>  /* Init code */
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index e518352137e7..3b44c357a6e7 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -84,8 +84,14 @@ static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
>  #define proc_create_seq_private(name, mode, parent, ops, size, data) ({NULL;})
>  #define proc_create_seq_data(name, mode, parent, ops, data) ({NULL;})
>  #define proc_create_seq(name, mode, parent, ops) ({NULL;})
> -#define proc_create_single(name, mode, parent, show) ({NULL;})
> -#define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
> +static inline struct proc_dir_entry *proc_create_single_data(const char *name,
> +		umode_t mode, struct proc_dir_entry *parent,
> +		int (*show)(struct seq_file *, void *), void *data)
> +{
> +	return NULL;
> +}
> +#define proc_create_single(name, mode, parent, show) \
> +	proc_create_single_data(name, mode, parent, show, NULL)
>  #define proc_create(name, mode, parent, proc_fops) ({NULL;})
>  #define proc_create_data(name, mode, parent, proc_fops, data) ({NULL;})
>  
