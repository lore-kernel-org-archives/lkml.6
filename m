Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B10C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDA720841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDA720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJHT5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJHT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2A1638AC0;
        Mon,  8 Oct 2018 12:45:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id C0B5667E74;
        Mon,  8 Oct 2018 12:45:38 +0000 (UTC)
Date:   Mon, 8 Oct 2018 14:45:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181008124538.GE18757@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <3c3d65dc-b2f6-b102-1805-a05ee6755653@linux.intel.com>
 <20181008105509.GH17270@krava>
 <4016811d-74ac-fffc-7dc9-1c7acaf228be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4016811d-74ac-fffc-7dc9-1c7acaf228be@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Oct 2018 12:45:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:47:13PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 08.10.2018 13:55, Jiri Olsa wrote:
> > On Mon, Oct 08, 2018 at 09:19:17AM +0300, Alexey Budankov wrote:
> <SNIP>
> >> +#ifdef HAVE_AIO_SUPPORT
> >> +	if (!strcmp(var, "record.aio-cblocks"))
> >> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
> >> +#endif
> >>  
> >>  	return 0;
> >>  }
> >> @@ -1837,6 +1864,10 @@ static struct option __record_options[] = {
> >>  			  "signal"),
> >>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
> >>  		    "Parse options then exit"),
> >> +#ifdef HAVE_AIO_SUPPORT
> >> +	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
> >> +		    "Max number of simultaneous per-mmap trace writes (default: 0 - serial, max: 4)"),
> >> +#endif
> > 
> > could you please move the option to enable that to the previou patch?
> > so we could test the simple variant as well
> 
> Ok.
> 
> > 
> > also I think it'd be better if we have simple '--aio' option that would
> > enable this with some default values..  and add --aio-cblocks to configure
> > that further
> 
> Well, absence of --aio option, on the command line or in .perfconfig, or --aio=0 
> means serial writing.
> 
> From this perspective perf record --aio --aio-cblocks=N looks like a complication.

'perf record --aio-cblocks=N' could imply '--aio',

I'd like to have simple/intuitive way to enable that,
without studing the meaning of the cblocks argument

  # perf record --aio ...

means that I'm storing data via async writes,
and using some reasonable default for cblocks

and later on we'd add 'perf record --threads'
allowing threads based writers ;-)

jirka
