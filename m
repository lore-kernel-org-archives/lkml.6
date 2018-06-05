Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeFEVOw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:14:52 -0400
Received: from foss.arm.com ([217.140.101.70]:34034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbeFEVOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:14:50 -0400
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
To: Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f3650607-995c-1664-9f73-bfc5df9303e3@arm.com>
Date: Tue, 5 Jun 2018 22:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605210710.22227-6-kim.phillips@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 10:07 PM, Kim Phillips wrote:
> Increment the refcnt for driver modules in current use by calling
> module_get in coresight_build_path and module_put in release_path.
> 
> This prevents driver modules from being unloaded when they are in use,
> either in sysfs or perf mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 338f1719641c..1c941351f1d1 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   
>   	node->csdev = csdev;
>   	list_add(&node->link, path);
> +
> +	if (!try_module_get(csdev->dev.parent->driver->owner)) {
> +		dev_err(&csdev->dev, "could not get coresight driver module\n");
> +		return -ENODEV;
> +	}
> +

Kim,

It would be safer to do the check before we actually add the device to 
the path above. That way, we don't add an unavailable device to the 
path, which will be "released" in the release_path below.

Otherwise looks good to me.


>   	pm_runtime_get_sync(csdev->dev.parent);
>   
>   	return 0;
> @@ -510,6 +516,9 @@ void coresight_release_path(struct list_head *path)
>   		csdev = nd->csdev;
>   
>   		pm_runtime_put_sync(csdev->dev.parent);
> +
> +		module_put(csdev->dev.parent->driver->owner);
> +
>   		list_del(&nd->link);
>   		kfree(nd);
>   	}
> 

Suzuki
