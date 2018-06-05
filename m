Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFEVUk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:20:40 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39974 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeFEVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:20:39 -0400
X-Google-Smtp-Source: ADUXVKJZgB1S7loJ23Ar8V0+9NTgL1FHOw3ocB2Jbvw6q+TQEmmWTkGypESUVoLpLRHf4vzU3Om8ZBbZGVaXBftoWTQ=
MIME-Version: 1.0
In-Reply-To: <20180605205841.15878-2-ross.zwisler@linux.intel.com>
References: <20180605205841.15878-1-ross.zwisler@linux.intel.com> <20180605205841.15878-2-ross.zwisler@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Jun 2018 14:20:38 -0700
Message-ID: <CAPcyv4ipWTDP0dNeyUd2vba1GcYb61BQ-w2yWms8o8SeMtBiRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm: don't flush power-fail protected CPU caches
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 1:58 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> This commit:
>
> 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
>
> intended to make sure that deep flush was always available even on
> platforms which support a power-fail protected CPU cache.  An unintended
> side effect of this change was that we also lost the ability to skip
> flushing CPU caches on those power-fail protected CPU cache.
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
> ---
>  drivers/dax/super.c   | 20 +++++++++++++++++++-
>  drivers/nvdimm/pmem.c |  2 ++
>  include/linux/dax.h   |  9 +++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c2c46f96b18c..457e0bb6c936 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -152,6 +152,8 @@ enum dax_device_flags {
>         DAXDEV_ALIVE,
>         /* gate whether dax_flush() calls the low level flush routine */
>         DAXDEV_WRITE_CACHE,
> +       /* only flush the CPU caches if they are not power fail protected */
> +       DAXDEV_FLUSH_ON_SYNC,
>  };
>
>  /**
> @@ -283,7 +285,8 @@ EXPORT_SYMBOL_GPL(dax_copy_from_iter);
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
>  {
> -       if (unlikely(!dax_write_cache_enabled(dax_dev)))
> +       if (unlikely(!dax_write_cache_enabled(dax_dev)) ||
> +                       !dax_flush_on_sync_enabled(dax_dev))

This seems backwards. I think we should teach the pmem driver to still
issue deep flush even when dax_write_cache_enabled() is false.
