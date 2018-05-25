Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936309AbeEYRMj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:12:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936185AbeEYRMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:12:38 -0400
Subject: Re: [PATCH 6/6] coresight: allow to build as modules
To: Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
 <20180518012024.22645-6-kim.phillips@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <4986a636-d5a5-387c-abf1-d68afe063f06@arm.com>
Date: Fri, 25 May 2018 18:12:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518012024.22645-6-kim.phillips@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 02:20, Kim Phillips wrote:
> Allow to build coresight as modules.  This greatly enhances developer
> efficiency by allowing the development to take place exclusively on the
> target, and without needing to reboot in between changes.
> 
> - Kconfig bools become tristates, to allow =m
> 
> - use -objs to denote merge object directives in Makefile, adds a
>    coresight-core nomenclature for the base module.
> 
> - Export core functions so as to be able to be used by
>    non-core modules.
> 
> - add a coresight_exit() that unregisters the coresight bus, add
>    remove fns for most others.
> 
> - fix up modules with ID tables for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>

Kim,

I see that you have addressed my comments on a previous version
of this series posted in April. But I don't see the version number
increased for this new version. Please add versioning to make it
easier to make it more obvious.

Also, generally it is a good idea to keep the people who reviewed
and commented on your previous versions in the newer versions.

Some comments below :

> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> index fc742215ab05..bc42b8022556 100644
> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> @@ -37,7 +37,12 @@ struct replicator_state {
>   static int replicator_enable(struct coresight_device *csdev, int inport,
>   			      int outport)
>   {
> -	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct replicator_state *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>   
>   	CS_UNLOCK(drvdata->base);

What is the guarantee that the "csdev" is still available when we reach
here ?

A module could be unloaded "after the component was added to the path"
(via coresight_build_path) and before we invoke the "enable" on each
component in the path ?

Also, it  is tedious to do module_get in "enable" and module_put in the
disable call backs for each component.

Instead, if we do a module_get() in build_path and module_put() in
release path, we could solve all these problems and keep it the module
refcount in a central place.

> +MODULE_DEVICE_TABLE(amba, replicator_ids);
> +
>   static struct amba_driver replicator_driver = {
>   	.drv = {
>   		.name	= "coresight-dynamic-replicator",
> @@ -207,9 +226,10 @@ static struct amba_driver replicator_driver = {
>   		.suppress_bind_attrs = true,
>   	},
>   	.probe		= replicator_probe,
> +	.remove		= replicator_remove,
>   	.id_table	= replicator_ids,
>   };

Do we have the owner field set here for this driver ? I see that you
added it for some components and not others. e.g, you have added it for
etm4x, while not for replicator and others.


> +MODULE_DEVICE_TABLE(amba, etm4_ids);
> +
>   static struct amba_driver etm4x_driver = {
>   	.drv = {
>   		.name   = "coresight-etm4x",
> +		.owner  = THIS_MODULE,
>   		.suppress_bind_attrs = true,
>   	},
>   	.probe		= etm4_probe,
> +	.remove		= etm4_remove,
>   	.id_table	= etm4_ids,
>   };
> -builtin_amba_driver(etm4x_driver);
> +module_amba_driver(etm4x_driver);


Suzuki
