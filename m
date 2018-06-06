Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HsZ8Kgk5GFuIaQAAmS7hNA
	; Wed, 06 Jun 2018 20:55:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 36BDB607F7; Wed,  6 Jun 2018 20:55:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D844A605BD;
	Wed,  6 Jun 2018 20:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D844A605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeFFUzE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:55:04 -0400
Received: from foss.arm.com ([217.140.101.70]:45086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752074AbeFFUzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:55:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA25680D;
        Wed,  6 Jun 2018 13:55:02 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF7BA3F59D;
        Wed,  6 Jun 2018 13:55:01 -0700 (PDT)
Date: Wed, 6 Jun 2018 15:55:01 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
Message-Id: <20180606155501.704583e1412996a1a2c6fa61@arm.com>
In-Reply-To: <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
        <20180605210710.22227-6-kim.phillips@arm.com>
        <20180606082422.GB19727@kroah.com>
        <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 10:46:36 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
> > On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
> >> Increment the refcnt for driver modules in current use by calling
> >> module_get in coresight_build_path and module_put in release_path.
> >>
> >> This prevents driver modules from being unloaded when they are in use,
> >> either in sysfs or perf mode.
> > 
> > Why does it matter?  Shouldn't you be allowed to remove any module at
> > any point in time, much like a networking driver?
> > 
> > 
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Leo Yan <leo.yan@linaro.org>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> >> index 338f1719641c..1c941351f1d1 100644
> >> --- a/drivers/hwtracing/coresight/coresight.c
> >> +++ b/drivers/hwtracing/coresight/coresight.c
> >> @@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
> >>   
> >>   	node->csdev = csdev;
> >>   	list_add(&node->link, path);
> >> +
> >> +	if (!try_module_get(csdev->dev.parent->driver->owner)) {
> > 
> > What is to keep parent->driver from going away right here?  What keeps
> > parent around?  This feels very fragile to me, I don't see any locking
> > anywhere around this code path to try to keep things in place.
> 
> You're right. We do have coresight_mutex, which is held across the build 
> path and the csdev is removed when a device is unregistered. However, I
> see that we don't hold the mutex while removing the connections from
> coresight_unregister(). Holding the mutex should protect us from the
> csdev being removed, while we build the path.

OK, I'll add this for the next version:

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f96258de1e9b..da702507a55c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1040,8 +1040,12 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
+       mutex_lock(&coresight_mutex);
+
        /* Remove references of that device in the topology */
        coresight_remove_conns(csdev);
        device_unregister(&csdev->dev);
+
+       mutex_unlock(&coresight_mutex);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);

> And while we are at this, I also realised that we hold references to the
> parent devices for each connection (via bus_find_device() from 
> of_coresight_get_endpoint_device()), while parsing the platform data, 
> which is never released.

Would this fix that?:

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index a33a92ebe74b..a43ab078c85e 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -181,6 +181,8 @@ of_get_coresight_platform_data(struct device *dev,
                        pdata->child_names[i] = dev_name(rdev);
                        pdata->child_ports[i] = rendpoint.id;
 
+                       put_device(rdev);
+
                        i++;
                } while (ep);
        }

Thanks,

Kim
