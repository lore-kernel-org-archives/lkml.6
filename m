Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A9AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D59217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfBEPnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbfBEPnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15EACC058CB7;
        Tue,  5 Feb 2019 15:43:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 57602B28E1;
        Tue,  5 Feb 2019 15:43:12 +0000 (UTC)
Date:   Tue, 5 Feb 2019 16:43:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf: python3 + tests attr.py failing
Message-ID: <20190205154311.GK4794@krava>
References: <20190204151042.GH5593@kernel.org>
 <20190204203738.GE4794@krava>
 <20190205134935.GB10613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205134935.GB10613@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 05 Feb 2019 15:43:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:49:35AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 04, 2019 at 09:37:38PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 04, 2019 at 12:10:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Noticed this now when building with PYTHON=python3, can you take a look?
> > > For now I'm reinstalling python2-devel and building with it, i.e.
> > > removing that PYTHON=python3 make command line variable.
> > > 
> > > [root@quaco ~]# perf test -v perf_event_attr
> > > 16: Setup struct perf_event_attr                          :
> > > --- start ---
> > > test child forked, pid 23937
> > >   File "/home/acme/libexec/perf-core/tests/attr.py", line 325
> > >     except Unsup, obj:
> > >                 ^
> > > SyntaxError: invalid syntax
> > > test child finished with -1
> > > ---- end ----
> > > Setup struct perf_event_attr: FAILED!
> > 
> > hum, I built the same way like you 'make PYTHON=python3'
> > [root@krava perf]# ldd ./perf | grep python
> >         libpython3.6m.so.1.0 => /lib64/libpython3.6m.so.1.0 (0x00007f4ca7cc4000)
> > 
> > and get 'Ok result'
> > 
> > [root@krava perf]# ./perf test attr
> > 16: Setup struct perf_event_attr                          : Ok
> > 48: Synthesize attr update                                : Ok
> > 
> > 
> > [root@krava perf]# python3 --version
> > Python 3.6.8
> > [root@krava perf]# rpm -qa | grep python3-devel
> > python3-devel-3.6.8-1.fc28.x86_64
> > 
> > which Fedora are you on 29? I'm on 28
> 
> I think you tested perf/core, that has Tony's fix to make 'perf test perf_event_attr'
> work with both python2 and python3, right?
> 
> While I was having that failure with perf/urgent.
> 
> I just cherry-picked:
> 
> commit 35ea7e4bbb89ecd32057f5f6a2a8feb0d7224e51
> Author: Tony Jones <tonyj@suse.de>
> Date:   Wed Jan 23 16:52:29 2019 -0800
> 
>     perf script python: Add Python3 support to tests/attr.py

right, i was over latest perf/core

jirka

> 
> 
> ----------------------
> 
> And now my perf/urgent branch passes that 'perf test' entry with both
> python2 and 3.
> 
> - Arnaldo
