Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeCIGBO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:01:14 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39283 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCIGBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:01:11 -0500
X-Google-Smtp-Source: AG47ELuQ/+FbItSDoDTZ6sl/nMW1O/yn+QMGU+u+WAh0Qc1GyTYQYFMeGXHZbZaWIrMg52ikZJdj3w==
Date: Fri, 9 Mar 2018 14:01:01 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf machine: Fix load kernel symbol with '-k' option
Message-ID: <20180309060101.GA20696@leoy-ThinkPad-T440>
References: <1519715872-31050-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkxyBvhWBSR4A2meQVeefssrcfTVfBw6vG-ZKGNXwPDP9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxyBvhWBSR4A2meQVeefssrcfTVfBw6vG-ZKGNXwPDP9g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Mar 07, 2018 at 02:09:24PM -0700, Mathieu Poirier wrote:
> Hi Leo,
> 
> On 27 February 2018 at 00:17, Leo Yan <leo.yan@linaro.org> wrote:
> > On Hikey arm64 octa A53 platform, when use command './perf report -v
> > -k vmlinux --stdio' it outputs below error info, and it skips to load
> > kernel symbol and doesn't print symbol for event:
> > Failed to open [kernel.kallsyms]_text, continuing without symbols.
> >
> > The regression is introduced by commit ("8c7f1bb37b29 perf machine: Move
> > kernel mmap name into struct machine"), which changes the logic for
> > machine mmap_name by removing function machine__mmap_name() and always
> > use 'machine->mmap_name'.  Comparing difference between
> > machine__mmap_name() and 'machine->mmap_name', the later one includes
> > the string for specified kernel vmlinux string with option '-k' in
> > command, but the old function machine__mmap_name() ignores vmlinux
> > path string.  As result, event's mmap file name doesn't match with
> > machine mmap file name anymore and it skips to load kernel symbol from
> > vmlinux file.
> >
> > To resolve this issue, this patch adds extra checking for
> > 'machine->mmap_name', when its start char is not '[' then we can know
> > it includes vmlinux path string specified for option '-k'. For this
> > case it sets 'is_kernel_mmap = true' and run into flow to load kernel
> > symbol from vmlinux.
> >
> > This patch has been verified with two commands: './perf report -v
> > -k vmlinux --stdio' and './perf script -v -F cpu,event,ip,sym,symoff
> > -k vmlinux'.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/machine.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 12b7427..ffd709d 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
> >         else
> >                 kernel_type = DSO_TYPE_GUEST_KERNEL;
> >
> > -       is_kernel_mmap = memcmp(event->mmap.filename,
> > -                               machine->mmap_name,
> > -                               strlen(machine->mmap_name) - 1) == 0;
> > +       /*
> > +        * If machine mmap_name doesn't start with char '[', it includes
> > +        * the specified kernel vmlinux name with option '-k'.  So set
> > +        * is_kernel_mmap as true to create machine symbol map.
> > +        */
> > +       if (machine->mmap_name[0] != '[')
> 
> I have tested your patch and it indeed solves the problem but I
> suggest to replace the above with:
> 
>     if (symbol_conf.vmlinux_name)
> 
> That is consistent with the test in function machine__set_mmap_name()
> and doesn't rely on a user specified input to operate properly.

Thanks a lot for suggestion and testing.

Your suggestion does make sense after I go back to read a bit for the
code.  Will spin new patch and send out soon for reviewing.

Thanks,
Leo Yan

> > +               is_kernel_mmap = true;
> > +       else
> > +               is_kernel_mmap = memcmp(event->mmap.filename,
> > +                                       machine->mmap_name,
> > +                                       strlen(machine->mmap_name) - 1) == 0;
> > +
> >         if (event->mmap.filename[0] == '/' ||
> >             (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
> >                 map = machine__findnew_module_map(machine, event->mmap.start,
> > --
> > 2.7.4
> >
