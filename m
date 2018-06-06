Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeFFCAQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 22:00:16 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44335 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbeFFCAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 22:00:15 -0400
X-Google-Smtp-Source: ADUXVKJmezhN+6/n1GokKpugw6WkU6G3bI1bnIXHSiI4x1B/kpmnWhdLHcQM5xAABNMJXpwXhl44maacp4JmhTP473w=
MIME-Version: 1.0
In-Reply-To: <20180605235802.14531-3-ross.zwisler@linux.intel.com>
References: <20180605235802.14531-1-ross.zwisler@linux.intel.com> <20180605235802.14531-3-ross.zwisler@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Jun 2018 19:00:14 -0700
Message-ID: <CAPcyv4gs-EMxQhX6dNYnygav1RfaLOuuA0XwYVHv-eSirjw6jA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libnvdimm: don't flush power-fail protected CPU caches
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 4:58 PM, Ross Zwisler
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
>  drivers/dax/super.c   | 14 +++++++++++++-
>  drivers/nvdimm/pmem.c |  2 ++
>  include/linux/dax.h   |  4 ++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c2c46f96b18c..80253c531a9b 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -152,6 +152,8 @@ enum dax_device_flags {
>         DAXDEV_ALIVE,
>         /* gate whether dax_flush() calls the low level flush routine */
>         DAXDEV_WRITE_CACHE,
> +       /* only flush the CPU caches if they are not power fail protected */
> +       DAXDEV_FLUSH_ON_SYNC,

I'm not grokking why we need DAXDEV_FLUSH_ON_SYNC. The power fail
protected status of the cache only determines the default for
DAXDEV_WRITE_CACHE.
