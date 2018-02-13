Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933514AbeBMHQ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:16:58 -0500
Received: from h2.hallyn.com ([78.46.35.8]:34332 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933428AbeBMHQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:16:56 -0500
Date: Tue, 13 Feb 2018 01:16:55 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
Message-ID: <20180213071655.GA11240@mail.hallyn.com>
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
 <20180211215028.16210-1-metux@gmx.de>
 <20180211215028.16210-2-metux@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211215028.16210-2-metux@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 09:50:28PM +0000, Enrico Weigelt, metux IT consult wrote:
> From: "Enrico Weigelt, metux IT consult" <info@metux.net>
> 
> This driver implements the Plan9 capability devices, used for
> switching user id via capability tokens.
> 
> https://9p.io/sys/doc/auth.html
> ---
>  drivers/staging/Kconfig         |   2 +
>  drivers/staging/Makefile        |   1 +
>  drivers/staging/p9caps/Kconfig  |  11 ++
>  drivers/staging/p9caps/Makefile |   1 +
>  drivers/staging/p9caps/p9caps.c | 369 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 384 insertions(+)
>  create mode 100644 drivers/staging/p9caps/Kconfig
>  create mode 100644 drivers/staging/p9caps/Makefile
>  create mode 100644 drivers/staging/p9caps/p9caps.c
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 554683912cff..23f325339fe8 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -118,4 +118,6 @@ source "drivers/staging/vboxvideo/Kconfig"
>  
>  source "drivers/staging/pi433/Kconfig"
>  
> +source "drivers/staging/p9caps/Kconfig"
> +
>  endif # STAGING
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 6e536020029a..eccdf4643453 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -3,6 +3,7 @@
>  
>  obj-y				+= media/
>  obj-y				+= typec/
> +obj-$(CONFIG_PLAN9CAPS)		+= p9caps/
>  obj-$(CONFIG_IRDA)		+= irda/net/
>  obj-$(CONFIG_IRDA)		+= irda/drivers/
>  obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
> diff --git a/drivers/staging/p9caps/Kconfig b/drivers/staging/p9caps/Kconfig
> new file mode 100644
> index 000000000000..b909daaa79ce
> --- /dev/null
> +++ b/drivers/staging/p9caps/Kconfig
> @@ -0,0 +1,11 @@
> +config PLAN9CAPS
> +	tristate "Plan 9 capability device"
> +	default n
> +	select CRYPTO_HMAC
> +	select CRYPTO_SHA1
> +	help
> +	  This module implements the Plan 9 capability devices
> +	  /dev/caphash and /dev/capuse
> +
> +	  To compile this driver as a module, choose
> +	  M here: the module will be called p9caps.
> diff --git a/drivers/staging/p9caps/Makefile b/drivers/staging/p9caps/Makefile
> new file mode 100644
> index 000000000000..67d38099a249
> --- /dev/null
> +++ b/drivers/staging/p9caps/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_PLAN9CAPS)	+= p9caps.o
> diff --git a/drivers/staging/p9caps/p9caps.c b/drivers/staging/p9caps/p9caps.c
> new file mode 100644
> index 000000000000..e46b09821c18
> --- /dev/null
> +++ b/drivers/staging/p9caps/p9caps.c
> @@ -0,0 +1,369 @@
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/errno.h>
> +#include <linux/fcntl.h>
> +#include <linux/cdev.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/scatterlist.h>
> +#include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/user_namespace.h>
> +#include <linux/mutex.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
> +
> +/*
> + * Plan9 /dev/caphash and /dev/capuse device
> + *
> + * 2DO: - caphash should only allow one process (per userns)
> + *      - support textual user names
> + *      - invalidate old caps
> + */
> +
> +#define DEVICE_CAPUSE	"/dev/capuse"
> +#define DEVICE_CAPHASH	"/dev/caphash"
> +
> +struct caphash_entry {
> +	struct list_head list;
> +	struct user_namespace *user_ns;
> +	char data[SHA1_DIGEST_SIZE];
> +};
> +
> +struct caphash_writer {
> +	struct list_head list;
> +	struct user_namespace *user_ns;
> +};
> +
> +static dev_t caphash_devid = 0;
> +static dev_t capuse_devid = 0;
> +
> +static LIST_HEAD(caphash_entries);
> +static LIST_HEAD(caphash_writers);
> +
> +static DEFINE_MUTEX(lock);
> +
> +struct crypto_ahash *hmac_tfm = NULL;
> +
> +static int caphash_open(struct inode *inode, struct file *filp)
> +{
> +	struct caphash_writer *tmp = NULL;
> +	struct user_namespace *user_ns = current_user_ns();
> +	int retval = 0;
> +	struct list_head *pos, *q;
> +
> +	/* make sure only one instance per namespace can be opened */

... at a time

might be better to keep this state in the user_ns itself, would
avoid kzalloc below.

Would it be worth doing any privilege checking here?

(incidentally, for historical reference, https://lkml.org/lkml/2010/4/20/404 :)

> +	mutex_lock(&lock);
> +
> +	list_for_each_safe(pos, q, &(caphash_writers)) {
> +		tmp = list_entry(pos, struct caphash_writer, list);
> +		if (tmp->user_ns == user_ns) {
> +			pr_err("already locked in this namespace\n");
> +			retval = -EBUSY;
> +			goto out;
> +		}
> +	}
> +
> +	if (!(tmp = kzalloc(sizeof(struct caphash_writer), GFP_KERNEL))) {
> +		retval = -ENOMEM;
> +		goto out;
> +	}
> +
> +	tmp->user_ns = get_user_ns(user_ns);
> +	list_add(&(tmp->list), &caphash_writers);
> +
> +out:
> +	mutex_unlock(&lock);
> +	return retval;
> +}
