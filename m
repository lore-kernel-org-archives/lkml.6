Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BBAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B72086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL8Am1wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9B72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeK2ALX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbeK2ALW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:11:22 -0500
Received: from quaco.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63ED720832;
        Wed, 28 Nov 2018 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543410585;
        bh=7YU7ZQXq/P3DtNilzh8wU9XZYduEwvEdBmJ4aX7+4YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL8Am1wTbjDucXgXlTHCKbwfoCZ+OO1n1QKf0EeDXkkoRbhXJqA6BC5zBsLL89Hr4
         CpevFa36loYc055cZCvgb8b2wTp1m9LGQFpz/CMNLxjiZ+j8b8CyFm8etAnw09e54u
         Gjyizj5A5FD7mL5vRV+x5q+NFUQ0vyq1XJyYiZzs=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id CD10340341; Wed, 28 Nov 2018 10:09:42 -0300 (-03)
Date:   Wed, 28 Nov 2018 10:09:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix error with config term pt=0
Message-ID: <20181128130942.GC31608@kernel.org>
References: <20181127084336.12142-1-adrian.hunter@intel.com>
 <20181127123928.GB15747@kernel.org>
 <b7c5b4e5-9497-10e5-fd43-5f3e4a0fe51d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c5b4e5-9497-10e5-fd43-5f3e4a0fe51d@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 28, 2018 at 02:38:13PM +0200, Adrian Hunter escreveu:
> On 27/11/18 2:39 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 27, 2018 at 10:43:36AM +0200, Adrian Hunter escreveu:
> >> Users should never use 'pt=0', but if they do it may give a meaningless
> >> error:
> >>
> >> 	$ perf record -e intel_pt/pt=0/u uname
> >> 	Error:
> >> 	The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
> >> 	event (intel_pt/pt=0/u).
> >>
> >> Fix that by forcing 'pt=1'.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/arch/x86/util/intel-pt.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> >> index db0ba8caf5a2..af25a7824ee0 100644
> >> --- a/tools/perf/arch/x86/util/intel-pt.c
> >> +++ b/tools/perf/arch/x86/util/intel-pt.c
> >> @@ -524,10 +524,18 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
> >>  				    struct perf_evsel *evsel)
> >>  {
> >>  	int err;
> >> +	char c;
> >>  
> >>  	if (!evsel)
> >>  		return 0;
> >>  
> >> +	/*
> >> +	 * If supported, force pass-through config term (pt=1) even if user
> >> +	 * sets pt=0, which avoids senseless kernel errors.
> >> +	 */
> >> +	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1)
> >> +		evsel->attr.config |= 1;
> > 
> > shouldn't we have a warning like:
> > 
> >    pr_warning("pt=0 doesn't make sense, forcing pt=1")
> > 
> > 
> > Instead of silently doing something the user, mistakenly, did
> > explicitely?
> 
> Sure, here it is:

Thanks, sticked this to the cset:

------------------------

Committer testing:

  # perf record -e intel_pt/pt=0/u uname
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (intel_pt/pt=0/u).
  /bin/dmesg | grep -i perf may provide additional information.

  # perf record -e intel_pt/pt=0/u uname
  pt=0 doesn't make sense, forcing pt=1
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.020 MB perf.data ]
  #
------------------------

Thanks, applied.

- Arnaldo
