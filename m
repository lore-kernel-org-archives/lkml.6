Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeEDS5z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbeEDS5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:57:54 -0400
Date: Fri, 4 May 2018 15:21:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
Subject: Re: [V5 PATCH] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180504182116.GA32709@kernel.org>
References: <1525185096-13477-1-git-send-email-kan.liang@linux.intel.com>
 <20180501163340.GB11539@krava>
 <1c2fc5c1-2ad1-8caf-eac6-f08b5f42d7fc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2fc5c1-2ad1-8caf-eac6-f08b5f42d7fc@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 04, 2018 at 01:57:33PM -0400, Liang, Kan escreveu:
> 
> 
> On 5/1/2018 12:33 PM, Jiri Olsa wrote:
> > On Tue, May 01, 2018 at 07:31:36AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Perf stat doesn't count the uncore event aliases from the same uncore
> > > block in a group, for example:
> > > 
> > >    perf stat -e '{unc_m_cas_count.all,unc_m_clockticks}' -a -I 1000
> > >    #           time             counts unit events
> > >         1.000447342      <not counted>      unc_m_cas_count.all
> > >         1.000447342      <not counted>      unc_m_clockticks
> > >         2.000740654      <not counted>      unc_m_cas_count.all
> > >         2.000740654      <not counted>      unc_m_clockticks
> > > 
> > > The output is very misleading. It gives a wrong impression that the
> > > uncore event doesn't work.
> > > 
> > > An uncore block could be composed by several PMUs. An uncore event alias
> > > is a joint name which means the same event runs on all PMUs of a block.
> > > Perf doesn't support mixed events from different PMUs in the same group.
> > > It is wrong to put uncore event aliases in a big group.
> > > 
> > > The right way is to split the big group into multiple small groups which
> > > only include the events from the same PMU.
> > > Only uncore event aliases from the same uncore block should be specially
> > > handled here. It doesn't make sense to mix the uncore events with other
> > > uncore events from different blocks or even core events in a group.
> > > 
> > > With the patch:
> > >    #           time             counts unit events
> > >       1.001557653            140,833      unc_m_cas_count.all
> > >       1.001557653      1,330,231,332      unc_m_clockticks
> > >       2.002709483             85,007      unc_m_cas_count.all
> > >       2.002709483      1,429,494,563      unc_m_clockticks
> > > 
> > > Reported-by: Andi Kleen <ak@linux.intel.com>
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > > 
> > > Changes since V4:
> > > - Add WARN_ON when failing to alloc an array for leaders
> > > - Add comments to explain why it has to go through the whole group
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> 
> Thanks Jirka.
> 
> Hi Arnaldo,
> 
> Are you OK with the patch?
> It looks like Jirka has another patch which will touch the same code.
> If it's OK for you, could you please merge the patch? So he can do the
> changes on top of this patch.

Yeah, I'm applying to my perf/core branch and pushing it out now.

- Arnaldo
