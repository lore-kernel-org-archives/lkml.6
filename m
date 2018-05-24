Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966924AbeEXXaa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:30:30 -0400
Received: from foss.arm.com ([217.140.101.70]:52068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965649AbeEXXa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:30:29 -0400
Date: Thu, 24 May 2018 18:30:27 -0500
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS
 dependencies and selections
Message-Id: <20180524183027.dc498058344604e2d6027eff@arm.com>
In-Reply-To: <CANLsYkw-KcEM43pqWgGU1XYOfSTD4cmspNcPM-u+n9x6Xtazbg@mail.gmail.com>
References: <20180517070643.GC13919@kroah.com>
        <20180518012024.22645-1-kim.phillips@arm.com>
        <20180522173140.GA25658@xps15>
        <20180523145155.5929dd09c78a056ef19329be@arm.com>
        <CANLsYkw-KcEM43pqWgGU1XYOfSTD4cmspNcPM-u+n9x6Xtazbg@mail.gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 09:32:48 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On 23 May 2018 at 13:51, Kim Phillips <kim.phillips@arm.com> wrote:
> > On Tue, 22 May 2018 11:31:40 -0600
> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> >> On Thu, May 17, 2018 at 08:20:19PM -0500, Kim Phillips wrote:
> >> > A coresight topology doesn't need to include links, i.e., a source can
> >> > be directly connected to a sink.  As such, selecting and/or depending on
> >> > LINKS_AND_SINKS is no longer needed.
> >>
> >> I'm good with this patch but now the help text for CORESIGHT_LINKS_AND_SINKS no
> >> longer match what the config does.  I see two ways to fix this:
> >
> > This patch doesn't change what the config does, it just changes what
> > other config options depend on it.
> >
> >> 1) Rework the help text.
> >
> > I don't see how, given the above.  Here's the text:
> >
> > config CORESIGHT_LINKS_AND_SINKS
> >         bool "CoreSight Link and Sink drivers"
> >         help
> >           This enables support for CoreSight link and sink drivers that are
> >           responsible for transporting and collecting the trace data
> >           respectively.  Link and sinks are dynamically aggregated with a trace
> >           entity at run time to form a complete trace path.
> >
> > What part of that becomes invalid with this patch?
> 
> Looking at the new Kconfig, what sink component depend on
> CORESIGHT_LINKS_AND_SINKS?

How does that affect the description text?  The description text
doesn't insinuate any implicit dependencies or non-.

> config CORESIGHT_LINKS

Please, not another gratuitous config name change, I've already
experienced usage regressions from the CORESIGHT_QCOM_REPLICATOR =>
CORESIGHT_DYNAMIC_REPLICATOR change:

https://patchwork.kernel.org/patch/10206023/

>          bool "CoreSight Link drivers"
>          help
>            This enables support for CoreSight link drivers that are responsible
>            for transporting trace data from source to sink.  Links are
> dynamically
>            aggregated with other traces entities at run time to form a
> complete trace
>            path.

Oh, I see, so your point is that LINKS_AND_SINKS doesn't technically
build any sink drivers?  That's completely orthogonal to removing a
dependency chain:  that just tells me the name was a poor choice in the
first place maybe?  I don't see where the Makefile may have built a
sink, but it may be before the move to drivers/hwtracing/coresight, or
some other reorganization.

> >> 2) Rework CORESIGHT_LINKS_AND_SINKS to be CORESIGHT_FUNNEL and move
> >> coresight-replicator.o under CORESIGHT_DYNAMIC_REPLICATOR in the Makefile. I
> >> really liked your idea of making the replicator driver intelligent enough to
> >> deal with both DT and platform declaration, which merges two driver into one.
> >>
> >> I'm obviously favouring the second option but recognise it doesn't have to be
> >> part of this patchet.  So for this set please rework the help text for
> >> CORESIGHT_LINKS_AND_SINKS.  Once we've dealt with this topic we can refactor the
> >> replicator driver.
> >
> > I'd really like to just focus on getting CoreSight to load as modules,
> > something for which this patch isn't technically required...
> 
> The only thing I'm asking is that the config description and help text
> reflect what the Makefile does.

argh, wellll, it's a completely different change, and we're now
completely off the modularization topic, and I'm uncomfortable doing
reorgs on things I don't understand, renaming CONFIG_s, esp. when
others such as the REPLICATOR, since as far as I know, that's also a
link??

Kim
