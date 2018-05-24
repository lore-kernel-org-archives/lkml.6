Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969575AbeEXXtL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:49:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964788AbeEXXtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:49:10 -0400
Date: Thu, 24 May 2018 18:49:08 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] coresight: allow to build as modules
Message-Id: <20180524184908.3648cf67456510261a1afe16@arm.com>
In-Reply-To: <20180522213906.GC25658@xps15>
References: <20180517070643.GC13919@kroah.com>
        <20180518012024.22645-1-kim.phillips@arm.com>
        <20180518012024.22645-6-kim.phillips@arm.com>
        <20180522213906.GC25658@xps15>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 15:39:06 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On Thu, May 17, 2018 at 08:20:24PM -0500, Kim Phillips wrote:
> > Allow to build coresight as modules.  This greatly enhances developer
> > efficiency by allowing the development to take place exclusively on the
> > target, and without needing to reboot in between changes.
> > 
> > - Kconfig bools become tristates, to allow =m
> > 
> > - use -objs to denote merge object directives in Makefile, adds a
> >   coresight-core nomenclature for the base module.
> > 
> > - Export core functions so as to be able to be used by
> >   non-core modules.
> > 
> > - add a coresight_exit() that unregisters the coresight bus, add
> >   remove fns for most others.
> > 
> > - fix up modules with ID tables for autoloading on boot
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > ---
> >  drivers/hwtracing/coresight/Kconfig           | 48 +++++++++++++++----
> >  drivers/hwtracing/coresight/Makefile          | 28 +++++++----
> >  .../hwtracing/coresight/coresight-cpu-debug.c |  2 +
> >  .../coresight/coresight-dynamic-replicator.c  | 26 ++++++++--
> >  drivers/hwtracing/coresight/coresight-etb10.c | 27 +++++++++--
> >  .../hwtracing/coresight/coresight-etm-perf.c  |  9 +++-
> >  .../coresight/coresight-etm3x-sysfs.c         |  1 +
> >  drivers/hwtracing/coresight/coresight-etm3x.c | 32 +++++++++++--
> >  .../coresight/coresight-etm4x-sysfs.c         |  1 +
> >  drivers/hwtracing/coresight/coresight-etm4x.c | 33 +++++++++++--
> >  .../hwtracing/coresight/coresight-funnel.c    | 26 ++++++++--
> >  drivers/hwtracing/coresight/coresight-priv.h  |  1 -
> >  .../coresight/coresight-replicator.c          | 28 +++++++++--
> >  drivers/hwtracing/coresight/coresight-stm.c   | 23 ++++++++-
> >  drivers/hwtracing/coresight/coresight-tmc.c   | 18 ++++++-
> >  drivers/hwtracing/coresight/coresight-tpiu.c  | 26 ++++++++--
> >  drivers/hwtracing/coresight/coresight.c       | 14 ++++++
> >  17 files changed, 299 insertions(+), 44 deletions(-)
> 
> For the next revision please split the work based on files.

If I read that literally, one file-by-one would break build
bisectability.  Do you mean split by source files depending on the
logical modules they belong to, e.g., etm3x, etm4x, etb10, etc.?  If
so, I think it would look like the coresight-core would be first,
followed by the rest, but I also think there are cross-dependencies.
Hmm, OK, I'll have a look, but there's also one more thing:  I think
the Makefile  obj '-core' nomenclature was to change the name of the
module to not be the same as the core source file, so what do you think
about renaming the core source file instead of the module name?  e.g.:

Instead of this:

obj-$(CONFIG_CORESIGHT) += coresight-core.o
coresight-core-objs := coresight.o \
                       of_coresight.o

we have this:

obj-$(CONFIG_CORESIGHT) += coresight.o
coresight-objs := coresight-core.o \
                  of_coresight.o

and e.g., instead of this:

obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x-core.o
coresight-etm3x-core-objs := coresight-etm3x.o \
                             coresight-etm-cp14.o \
                             coresight-etm3x-sysfs.o

we have this:

obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
coresight-etm3x-objs := coresight-etm3x-core.o \
                        coresight-etm-cp14.o \
                        coresight-etm3x-sysfs.o

?

> > +static int __exit tmc_remove(struct amba_device *adev)
> > +{
> > +	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > +
> > +	/* free ETB/ETF or ETR memory */
> > +	tmc_read_unprepare(drvdata);
> > +
> > +	misc_deregister(&drvdata->miscdev);
> > +	coresight_unregister(drvdata->csdev);
> > +
> > +	return 0;
> > +}
> > +
> 
> Right now I can remove the module for a TMC link or sink when part of an active
> session, something I pointed out during an earlier revision.

Right, I missed that :(

So would the first thing tmc_remove does is this:

if (drvdata->reading)
	return -EBUSY;

work, or would we need to introduce a new sentinel?

> I also think we need to deal with driver removal cases when the TMC buffer
> (ETR or ETF) is being read from sysFS.

OK, I thought the:

struct file_operations tmc_fops = {
	.owner = THIS_MODULE,

would prevent module unload whilst sysfs access was being performed,
but I'll double check.

Thanks,

Kim
