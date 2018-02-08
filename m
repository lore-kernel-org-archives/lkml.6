Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeBHRWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:22:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeBHRWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:22:16 -0500
Date: Thu, 8 Feb 2018 11:22:13 -0600
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] coresight replicator: set default y after Kconfig
 rename
Message-Id: <20180208112213.2f466a1c09f942e8e158a168@arm.com>
In-Reply-To: <CANLsYkwMUG9pwcMH9UdLWVqS9pzJCOFJa5Y0Y1NX0SqznUdx+w@mail.gmail.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
        <CANLsYkwMUG9pwcMH9UdLWVqS9pzJCOFJa5Y0Y1NX0SqznUdx+w@mail.gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 08:59:30 -0700
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On 7 February 2018 at 14:03, Kim Phillips <kim.phillips@arm.com> wrote:
> > Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> > replicator naming") changed the Kconfig symbol name from
> > QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> > was being set in my juno build script, which left the new symbol unset,
> > causing the following unexpected grief:
> >
> >  # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
> >  ..<snip>..
> >  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> >  mmap size 528384B
> >  AUX area mmap length 4194304
> >  perf event ring buffer mmapped per cpu
> >  failed to mmap AUX area
> >  failed to mmap with 12 (Cannot allocate memory)
> >
> > Make it default y to help not surprise unsuspecting users.
> >
> > Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > ---
> >  drivers/hwtracing/coresight/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> > index ef9cb3c164e1..b94bbd95efa6 100644
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
> >  config CORESIGHT_DYNAMIC_REPLICATOR
> >         bool "CoreSight Programmable Replicator driver"
> >         depends on CORESIGHT_LINKS_AND_SINKS
> > +       default y
> >         help
> >           This enables support for dynamic CoreSight replicator link driver.
> >           The programmable ATB replicator allows independent filtering of the
> 
> As I said before don't see why it needs to be treated differently than other CS
> blocks

I don't think it does either, but this one is special since it recently
underwent a rename, which breaks its users that were setting the old
name in their config builds.  The default y keeps it set in those
cases, thereby discontinuing any such regression.

> - intelligent replicators show up on the AMBA bus and need to
> be declared in the DT.  As such people are expected to enable the proper
> option.

The driver should only run given a replicator in the device tree; if
that's not the case, then that's another problem, and orthogonal to
this one.

Kim
