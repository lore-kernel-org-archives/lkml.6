Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34490C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F22921901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfBROUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:20:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390457AbfBROUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:20:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64CA699DD6;
        Mon, 18 Feb 2019 14:20:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9748A60A9F;
        Mon, 18 Feb 2019 14:20:42 +0000 (UTC)
Date:   Mon, 18 Feb 2019 15:20:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/3] perf tools: Add numa_topology object
Message-ID: <20190218142042.GA13284@krava>
References: <20190218113927.30841-1-jolsa@kernel.org>
 <20190218113927.30841-4-jolsa@kernel.org>
 <CAM9d7cjEaUmYhduf2ddgxOAZw9=1NfsNTScwZZENPzXvUyMBaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjEaUmYhduf2ddgxOAZw9=1NfsNTScwZZENPzXvUyMBaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 18 Feb 2019 14:20:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:08:55PM +0900, Namhyung Kim wrote:
> Hi Jirka,
> 
> On Mon, Feb 18, 2019 at 8:39 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding numa_topology object to return the list of numa
> > nodes together with their cpus. It will replace the numa
> > code in header.c and will be used from perf record code
> > in following patches.
> >
> > Adding following interface functions to load numa details:
> >
> >   struct numa_topology *numa_topology__new(void);
> >   void numa_topology__delete(struct numa_topology *tp);
> >
> > And replacing current (copied) local interface, with no
> > functional changes.
> >
> > Link: http://lkml.kernel.org/n/tip-rn15st6hjj7txg2i88v7yff4@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/cputopo.c | 120 ++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/cputopo.h |  16 +++++
> >  tools/perf/util/header.c  | 119 +++++++++----------------------------
> >  3 files changed, 162 insertions(+), 93 deletions(-)
> >
> > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > index 84470ed4e707..daac3cf90b12 100644
> > --- a/tools/perf/util/cputopo.c
> > +++ b/tools/perf/util/cputopo.c
> > @@ -1,9 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <sys/param.h>
> > +#include <inttypes.h>
> >
> >  #include "cputopo.h"
> >  #include "cpumap.h"
> >  #include "util.h"
> > +#include "env.h"
> >
> >
> >  #define CORE_SIB_FMT \
> > @@ -142,3 +144,121 @@ struct cpu_topology *cpu_topology__new(void)
> >         }
> >         return tp;
> >  }
> > +
> > +static int load_numa_node(struct numa_topology_node *node, int nr)
> > +{
> > +       char str[MAXPATHLEN];
> > +       char field[32];
> > +       char *buf = NULL, *p;
> > +       size_t len = 0;
> > +       int ret = -1;
> > +       FILE *fp;
> > +       u64 mem;
> > +
> > +       node->node = (u32) nr;
> > +
> > +       sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
> 
> Why not using similar macro like NODE_MEMINFO_FMT?
> Also it'd be better using snprintf() or scnprintf() instead.

right, that code needs to be changed to take /sys from sysfs__mountpoint

but I wanted just to move the code now, with only necessary changes,
like the issues you found below ;-)

> 
> 
> > +       fp = fopen(str, "r");
> > +       if (!fp)
> > +               return -1;
> > +
> > +       while (getline(&buf, &len, fp) > 0) {
> > +               /* skip over invalid lines */
> > +               if (!strchr(buf, ':'))
> > +                       continue;
> > +               if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
> > +                       goto err;
> > +               if (!strcmp(field, "MemTotal:"))
> > +                       node->mem_total = mem;
> > +               if (!strcmp(field, "MemFree:"))
> > +                       node->mem_free = mem;
> > +               if (node->mem_total && node->mem_free)
> > +                       break;
> > +       }
> > +
> > +       fclose(fp);
> > +       fp  = NULL;
> > +       buf = NULL;
> 
> No need to make them NULL.  Also it'd leak buf..

oops, I'll put free in here

> 
> 
> > +
> > +       ret = -1;
> 
> It's not changed yet.

right, will change

thanks,
jirka
