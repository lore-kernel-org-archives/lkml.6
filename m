Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A08C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6552175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfBENvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:51:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfBENvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:51:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBF6DE6A71;
        Tue,  5 Feb 2019 13:51:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9A9FA6B460;
        Tue,  5 Feb 2019 13:51:38 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:51:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 14/14] perf record: Add --dir option to store data in
 directory
Message-ID: <20190205135137.GI4794@krava>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <20190203153018.9650-15-jolsa@kernel.org>
 <41a1874b-3cd5-91d2-bc02-40fc8e93a9c4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a1874b-3cd5-91d2-bc02-40fc8e93a9c4@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 05 Feb 2019 13:51:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 03:36:24PM +0300, Alexey Budankov wrote:
> 
> On 03.02.2019 18:30, Jiri Olsa wrote:
> > Adding --dir option to store data in directory. It's next
> > step for multiple threads in record. It's not possible
> > to make directory data via --dir option, like:
> > 
> >   $ perf record --dir perf bench sched messaging
> >   $ ls -l perf.data
> >   total 344
> >   -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
> >   -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
> >   -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
> >   -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
> >   -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
> >   -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
> >   -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
> >   -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
> >   -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header
> > 
> > There's a data file created for every cpu and it's storing
> > data for those cpu maps.
> > 
> > It's possible to transform directory data into standard
> > perf.data file via following inject command:
> > 
> >   $ perf inject -o perf.data.file -i perf.data
> > 
> > Link: http://lkml.kernel.org/n/tip-0kjm8wpglzu2tm18tpagfm4d@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-record.txt |  3 ++
> >  tools/perf/builtin-record.c              | 59 ++++++++++++++++++++++--
> >  tools/perf/util/mmap.h                   | 23 ++++-----
> >  3 files changed, 70 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index d232b13ea713..8dcdc8cabcad 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -505,6 +505,9 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
> >  
> >  Implies --tail-synthesize.
> >  
> > +--dir::
> > +Store data into directory with one data file for cpu.
> > +
> 
> Makes sense to mention compatibility with -o option and per-thread buffer mapping.

right, will do

> 
> >  SEE ALSO
> >  --------
> >  linkperf:perf-stat[1], linkperf:perf-list[1]
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index cd02ab3ec4ff..87e39b9cc7bd 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -111,17 +111,21 @@ static bool switch_output_time(struct record *rec)
> >  	       trigger_is_ready(&switch_output_trigger);
> >  }
> >  
> > -static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
> > +static int record__write(struct record *rec, struct perf_mmap *map,
> >  			 void *bf, size_t size)
> >  {
> > -	struct perf_data_file *file = &rec->session->data->file;
> > +	struct perf_data_file *file = &rec->data.file;
> > +
> > +	if (map && map->file)
> > +		file = map->file;
> 
> For AIO mode per-cpu streaming could be done in parallel because Posix 
> AIO API uses a separate thread for every open data.# or header fd.

yes, I was thinking of that and I plan to try that to see
if there's some benefit

> 
> >  
> >  	if (perf_data_file__write(file, bf, size) < 0) {
> >  		pr_err("failed to write perf data, error: %m\n");
> >  		return -1;
> >  	}
> >  
> > -	rec->bytes_written += size;
> > +	if (file == &rec->data.file)
> > +		rec->bytes_written += size;
> 
> switch-output logic now tracks header file size only? 
> If so, it probably needs to be corrected or simply disabled 
> for --output_dir mode.

the rec->bytes_written value is used to track header file size,
which is used to fill in the header data section in here
record__finish_output, we can't mix other file sizes into it

the switch-output option still needs some changes to work
over the directory data

jirka
