Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE8C20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYanPH/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE8C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJIVJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIVJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:09:32 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B0A2086D;
        Tue,  9 Oct 2018 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539093148;
        bh=fTfoaQdlrjV35jsWphIHm/NVHGXj6Zae+ggQ8ny1plg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYanPH/bvF76bhjb+e4LBwDbsKXYZF4k26JhEXlh/h+3gKYGBe3wi9GBdRRT2f4un
         QWzqS4swQCImKivn5F5lYQr4szgKP4NKOLu7eDSDvQDd85/8kEDfdQLfKtwV/O8ik0
         nkyneaK5EsnET+DLAH3d5AFWzAddBoqb+RkJ6YBo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 2FEDD142C5E; Tue,  9 Oct 2018 10:52:26 -0300 (-03)
Date:   Tue, 9 Oct 2018 10:52:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] Revert "perf tools: Fix PMU term format max value
 calculation"
Message-ID: <20181009135226.GC10775@kernel.org>
References: <20181003072046.29276-1-jolsa@kernel.org>
 <20181009095917.GE6499@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009095917.GE6499@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 09, 2018 at 11:59:17AM +0200, Jiri Olsa escreveu:
> ping

oops, applied to perf/urgent, added a Fixes: line so that stable@ pick
this up.

- Arnaldo
 
> thanks,
> jirka
> 
> On Wed, Oct 03, 2018 at 09:20:46AM +0200, Jiri Olsa wrote:
> > This reverts commit ac0e2cd555373ae6f8f3a3ad3fbbf5b6d1e7aaaa.
> > 
> > Michael reported an issue with oversized terms values assignment
> > and I noticed there was actually a misunderstanding of the max
> > value check in the past.
> > 
> > The above commit's changelog says:
> > 
> >   If bit 21 is set, there is parsing issues as below.
> > 
> >     $ perf stat -a -e uncore_qpi_0/event=0x200002,umask=0x8/
> >     event syntax error: '..pi_0/event=0x200002,umask=0x8/'
> >                                       \___ value too big for format, maximum is 511
> > 
> > But there's no issue there, because the event value is distributed
> > along the value defined by the format. Even if the format defines
> > separated bit, the value is treated as a continual number, which
> > should follow the format definition.
> > 
> > In above case it's 9-bit value with last bit separated:
> >   $ cat uncore_qpi_0/format/event
> >   config:0-7,21
> > 
> > Hence the value 0x200002 is correctly reported as format violation,
> > because it exceeds 9 bits. It should have been 0x102 instead, which
> > sets the 9th bit - the bit 21 of the format.
> > 
> >   $ perf stat -vv -a -e uncore_qpi_0/event=0x102,umask=0x8/
> >   Using CPUID GenuineIntel-6-2D
> >   ...
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             10
> >     size                             112
> >     config                           0x200802
> >     sample_type                      IDENTIFIER
> >   ...
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Kan Liang <kan.liang@intel.com>
> > Reported-by: Michael Petlan <mpetlan@redhat.com>
> > Link: http://lkml.kernel.org/n/tip-icxq7a1r66lusm3ahaimekis@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/pmu.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index afd68524ffa9..7799788f662f 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -930,13 +930,14 @@ static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
> >  
> >  static __u64 pmu_format_max_value(const unsigned long *format)
> >  {
> > -	__u64 w = 0;
> > -	int fbit;
> > -
> > -	for_each_set_bit(fbit, format, PERF_PMU_FORMAT_BITS)
> > -		w |= (1ULL << fbit);
> > +	int w;
> >  
> > -	return w;
> > +	w = bitmap_weight(format, PERF_PMU_FORMAT_BITS);
> > +	if (!w)
> > +		return 0;
> > +	if (w < 64)
> > +		return (1ULL << w) - 1;
> > +	return -1;
> >  }
> >  
> >  /*
> > -- 
> > 2.17.1
> > 
