Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeBHTX5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:23:57 -0500
Received: from foss.arm.com ([217.140.101.70]:39522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbeBHTX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:23:56 -0500
Date: Thu, 8 Feb 2018 13:23:54 -0600
From: Kim Phillips <kim.phillips@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] coresight replicator: set default y after Kconfig
 rename
Message-Id: <20180208132354.5d66ab91234bd7c7d971c1b1@arm.com>
In-Reply-To: <4ed2bf14-206a-20c6-40a6-3ab9a2ec07b4@arm.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
        <4ed2bf14-206a-20c6-40a6-3ab9a2ec07b4@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 16:13:16 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 07/02/18 21:03, Kim Phillips wrote:
> > Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> > replicator naming") changed the Kconfig symbol name from
> > QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> > was being set in my juno build script, which left the new symbol unset,
> > causing the following unexpected grief:
> > 
> >   # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
> >   ..<snip>..
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> >   mmap size 528384B
> >   AUX area mmap length 4194304
> >   perf event ring buffer mmapped per cpu
> >   failed to mmap AUX area
> >   failed to mmap with 12 (Cannot allocate memory)
> > 
> > Make it default y to help not surprise unsuspecting users.
> 
> How many users are there relying on your Juno build script? :P

This shouldn't be that uncommon for coresight users:

make defconfig
scripts/config -e CONFIG_CORESIGHT
scripts/config -e CONFIG_CORESIGHT_LINK_AND_SINK_TMC
scripts/config -e CONFIG_CORESIGHT_SINK_TPIU
scripts/config -e CONFIG_CORESIGHT_SINK_ETBV10
scripts/config -e CONFIG_CORESIGHT_LINKS_AND_SINKS
scripts/config -e CONFIG_CORESIGHT_SOURCE_ETM3X
scripts/config -e CONFIG_CORESIGHT_SOURCE_ETM4X
#scripts/config -e CONFIG_CORESIGHT_QCOM_REPLICATOR
scripts/config -e CONFIG_CORESIGHT_DYNAMIC_REPLICATOR
scripts/config -e CONFIG_CORESIGHT_STM
scripts/config -e CONFIG_CORESIGHT_CPU_DEBUG

FWIW, Mathieu - who helped me track the cannot allocate memory problem
down to this config symbol - has also benn caught by this issue.

> > Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
> 
> Before that commit, CORESIGHT_QCOM_REPLICATOR was not "default y", nor 
> selected by any in-tree configs, so whatever the problem may be this is 
> clearly not the correct fix.

Well, there's only one defconfig for arm64.  I don't know why it
doesn't set CORESIGHT, but you're right, this is taking the build fix
one step further to facilitate user coresight configuration.  I can
change the patch to make the change to the arm64 defconfig, but I still
believe CORESIGHT_DYNAMIC_REPLICATOR should be default=y, and the
defconfig just set CORESIGHT.

> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > ---
> >   drivers/hwtracing/coresight/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> > index ef9cb3c164e1..b94bbd95efa6 100644
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
> >   config CORESIGHT_DYNAMIC_REPLICATOR
> >   	bool "CoreSight Programmable Replicator driver"
> >   	depends on CORESIGHT_LINKS_AND_SINKS
> > +	default y
> 
> CORESIGHT_LINKS_AND_SINKS is "default n" (as indeed is CORESIGHT), and 
> not selected by any defconfigs, so in general this doesn't really help 
> anyway.

Yeah, CORESIGHT_LINKS_AND_SINKS should probably be default y too.

Kim
