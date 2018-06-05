Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeFEWMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:12:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39095 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeFEWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:12:22 -0400
X-Google-Smtp-Source: ADUXVKIqDQ4IcgwP7GrPBeTLxG/MnDAHeuZlaIcCCezx7hZy+rrCiRaAwl4iZkjxAJnvD6iKKgZfWOu0vstyNcfWsc0=
MIME-Version: 1.0
In-Reply-To: <20180605215926.GA16066@linux.intel.com>
References: <20180605205841.15878-1-ross.zwisler@linux.intel.com>
 <20180605205841.15878-2-ross.zwisler@linux.intel.com> <CAPcyv4ipWTDP0dNeyUd2vba1GcYb61BQ-w2yWms8o8SeMtBiRA@mail.gmail.com>
 <20180605215926.GA16066@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Jun 2018 15:12:20 -0700
Message-ID: <CAPcyv4h4U_nocetqT-ejjc5O7gzmAh6oShvb7CQ+3eVM1qw6tA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm: don't flush power-fail protected CPU caches
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 2:59 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Tue, Jun 05, 2018 at 02:20:38PM -0700, Dan Williams wrote:
>> On Tue, Jun 5, 2018 at 1:58 PM, Ross Zwisler
>> <ross.zwisler@linux.intel.com> wrote:
>> > This commit:
>> >
>> > 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
>> >
>> > intended to make sure that deep flush was always available even on
>> > platforms which support a power-fail protected CPU cache.  An unintended
>> > side effect of this change was that we also lost the ability to skip
>> > flushing CPU caches on those power-fail protected CPU cache.
>> >
>> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> > Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
>> > ---
>> >  drivers/dax/super.c   | 20 +++++++++++++++++++-
>> >  drivers/nvdimm/pmem.c |  2 ++
>> >  include/linux/dax.h   |  9 +++++++++
>> >  3 files changed, 30 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> > index c2c46f96b18c..457e0bb6c936 100644
>> > --- a/drivers/dax/super.c
>> > +++ b/drivers/dax/super.c
>> > @@ -152,6 +152,8 @@ enum dax_device_flags {
>> >         DAXDEV_ALIVE,
>> >         /* gate whether dax_flush() calls the low level flush routine */
>> >         DAXDEV_WRITE_CACHE,
>> > +       /* only flush the CPU caches if they are not power fail protected */
>> > +       DAXDEV_FLUSH_ON_SYNC,
>> >  };
>> >
>> >  /**
>> > @@ -283,7 +285,8 @@ EXPORT_SYMBOL_GPL(dax_copy_from_iter);
>> >  void arch_wb_cache_pmem(void *addr, size_t size);
>> >  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
>> >  {
>> > -       if (unlikely(!dax_write_cache_enabled(dax_dev)))
>> > +       if (unlikely(!dax_write_cache_enabled(dax_dev)) ||
>> > +                       !dax_flush_on_sync_enabled(dax_dev))
>>
>> This seems backwards. I think we should teach the pmem driver to still
>> issue deep flush even when dax_write_cache_enabled() is false.
>
> That does still happen.  Deep flush is essentially controlled by the 'wbc'
> variable in pmem_attach_disk(), which we use to set blk_queue_write_cache().

Right, what I'm trying to kill is the need to add
dax_flush_on_sync_enabled() I think we can handle this local to the
pmem driver and not extend the 'dax' api.

> My understanding is that this causes the block layer to send down
> REQ_FUA/REQ_PREFLUSH BIOs, and it's in response to these that we do a deep
> flush via nvdimm_flush().  Whether this happens is totally up to the device's
> write cache setting, and doesn't look at whether the platform has
> flush-on-fail CPU caches.
>
> This does bring up another wrinkle, though: we export a write_cache sysfs
> entry that you can use to change the write cache setting of a namespace:
>
> i.e.:
>         /sys/bus/nd/devices/pfn0.1/block/pmem0/dax/write_cache
>
> This changes whether or not the DAXDEV_WRITE_CACHE flag is set, but does *not*
> change whether the block queue says it supports a write cache
> (blk_queue_write_cache()).  So, the sysfs entry ends up controlling whether or
> not we do CPU cache flushing via DAX, but does not do anything with the deep
> flush code.
>
> I'm guessing this should be fixed?  I'll go take a look...

I think we need to disconnect DAXDEV_WRITE_CACHE from the indication
of the filesystem triggerring nvdimm_flush() via REQ_{FUA,FLUSH}.
