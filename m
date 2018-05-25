Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967664AbeEYRWS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:22:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36553 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967306AbeEYRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:22:01 -0400
X-Google-Smtp-Source: AB8JxZprr5fhaFXblRrbYNdfOV51OKOCVc0iUFsrzvnNbPQPCF/cC9Zz3+WWGZBxoO4VO6Y205DpMQ28qPkzM2lqXVc=
MIME-Version: 1.0
In-Reply-To: <20180524184908.3648cf67456510261a1afe16@arm.com>
References: <20180517070643.GC13919@kroah.com> <20180518012024.22645-1-kim.phillips@arm.com>
 <20180518012024.22645-6-kim.phillips@arm.com> <20180522213906.GC25658@xps15> <20180524184908.3648cf67456510261a1afe16@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 25 May 2018 11:21:59 -0600
Message-ID: <CANLsYkw7rpSz-mJoUa6n-98ko+5X4xc6zF6TpkJ1pjV9cnMEwg@mail.gmail.com>
Subject: Re: [PATCH 6/6] coresight: allow to build as modules
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2018 at 17:49, Kim Phillips <kim.phillips@arm.com> wrote:
> On Tue, 22 May 2018 15:39:06 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
>> On Thu, May 17, 2018 at 08:20:24PM -0500, Kim Phillips wrote:
>> > Allow to build coresight as modules.  This greatly enhances developer
>> > efficiency by allowing the development to take place exclusively on the
>> > target, and without needing to reboot in between changes.
>> >
>> > - Kconfig bools become tristates, to allow =m
>> >
>> > - use -objs to denote merge object directives in Makefile, adds a
>> >   coresight-core nomenclature for the base module.
>> >
>> > - Export core functions so as to be able to be used by
>> >   non-core modules.
>> >
>> > - add a coresight_exit() that unregisters the coresight bus, add
>> >   remove fns for most others.
>> >
>> > - fix up modules with ID tables for autoloading on boot
>> >
>> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> > Cc: Randy Dunlap <rdunlap@infradead.org>
>> > Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>> > ---
>> >  drivers/hwtracing/coresight/Kconfig           | 48 +++++++++++++++----
>> >  drivers/hwtracing/coresight/Makefile          | 28 +++++++----
>> >  .../hwtracing/coresight/coresight-cpu-debug.c |  2 +
>> >  .../coresight/coresight-dynamic-replicator.c  | 26 ++++++++--
>> >  drivers/hwtracing/coresight/coresight-etb10.c | 27 +++++++++--
>> >  .../hwtracing/coresight/coresight-etm-perf.c  |  9 +++-
>> >  .../coresight/coresight-etm3x-sysfs.c         |  1 +
>> >  drivers/hwtracing/coresight/coresight-etm3x.c | 32 +++++++++++--
>> >  .../coresight/coresight-etm4x-sysfs.c         |  1 +
>> >  drivers/hwtracing/coresight/coresight-etm4x.c | 33 +++++++++++--
>> >  .../hwtracing/coresight/coresight-funnel.c    | 26 ++++++++--
>> >  drivers/hwtracing/coresight/coresight-priv.h  |  1 -
>> >  .../coresight/coresight-replicator.c          | 28 +++++++++--
>> >  drivers/hwtracing/coresight/coresight-stm.c   | 23 ++++++++-
>> >  drivers/hwtracing/coresight/coresight-tmc.c   | 18 ++++++-
>> >  drivers/hwtracing/coresight/coresight-tpiu.c  | 26 ++++++++--
>> >  drivers/hwtracing/coresight/coresight.c       | 14 ++++++
>> >  17 files changed, 299 insertions(+), 44 deletions(-)
>>
>> For the next revision please split the work based on files.
>
> If I read that literally, one file-by-one would break build
> bisectability.  Do you mean split by source files depending on the
> logical modules they belong to, e.g., etm3x, etm4x, etb10, etc.?  If

I meant to introduce all the needed changes - including the module
author, description and licences - per module.  That will break up
this patch considerably and allow us to concentrate on individual
component.  As a final step do the changes to Kconfig and the
Makefile.


> so, I think it would look like the coresight-core would be first,
> followed by the rest, but I also think there are cross-dependencies.
> Hmm, OK, I'll have a look, but there's also one more thing:  I think
> the Makefile  obj '-core' nomenclature was to change the name of the
> module to not be the same as the core source file, so what do you think
> about renaming the core source file instead of the module name?  e.g.:
>
> Instead of this:
>
> obj-$(CONFIG_CORESIGHT) += coresight-core.o
> coresight-core-objs := coresight.o \
>                        of_coresight.o
>
> we have this:
>
> obj-$(CONFIG_CORESIGHT) += coresight.o
> coresight-objs := coresight-core.o \
>                   of_coresight.o
>
> and e.g., instead of this:
>
> obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x-core.o
> coresight-etm3x-core-objs := coresight-etm3x.o \
>                              coresight-etm-cp14.o \
>                              coresight-etm3x-sysfs.o
>
> we have this:
>
> obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
> coresight-etm3x-objs := coresight-etm3x-core.o \
>                         coresight-etm-cp14.o \
>                         coresight-etm3x-sysfs.o
>
> ?

I think that is much better and avoid carrying the heave "-core"
appendage.  Renaming needs to be a patch on its own (but still part of
this set).

>
>> > +static int __exit tmc_remove(struct amba_device *adev)
>> > +{
>> > +   struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> > +
>> > +   /* free ETB/ETF or ETR memory */
>> > +   tmc_read_unprepare(drvdata);
>> > +
>> > +   misc_deregister(&drvdata->miscdev);
>> > +   coresight_unregister(drvdata->csdev);
>> > +
>> > +   return 0;
>> > +}
>> > +
>>
>> Right now I can remove the module for a TMC link or sink when part of an active
>> session, something I pointed out during an earlier revision.
>
> Right, I missed that :(
>
> So would the first thing tmc_remove does is this:
>
> if (drvdata->reading)
>         return -EBUSY;
>
> work, or would we need to introduce a new sentinel?

The ->reading flag is to prevent concurrent access to the buffer from
sysFS and to avoid clobbering said buffer with new trace data.  The
TMC driver shouldn't be different from the other ones with regards to
the usage of the try_module_get()/module_put() functions.

>
>> I also think we need to deal with driver removal cases when the TMC buffer
>> (ETR or ETF) is being read from sysFS.
>
> OK, I thought the:
>
> struct file_operations tmc_fops = {
>         .owner = THIS_MODULE,
>
> would prevent module unload whilst sysfs access was being performed,
> but I'll double check.

Right, just check that it works as advertised.

>
> Thanks,
>
> Kim
