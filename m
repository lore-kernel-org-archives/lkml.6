Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD542199E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD542199E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeHQXGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:06:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeHQXGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 548BA406C790;
        Fri, 17 Aug 2018 20:01:25 +0000 (UTC)
Received: from krava (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id CF2447C4F;
        Fri, 17 Aug 2018 20:01:22 +0000 (UTC)
Date:   Fri, 17 Aug 2018 22:01:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 06/13] perf tools: Add compression id into struct
 kmod_path
Message-ID: <20180817200121.GE24121@krava>
References: <20180817094813.15086-1-jolsa@kernel.org>
 <20180817094813.15086-7-jolsa@kernel.org>
 <20180817182315.GD22443@kernel.org>
 <20180817182849.GE22443@kernel.org>
 <20180817185641.GF22443@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817185641.GF22443@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 17 Aug 2018 20:01:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 17 Aug 2018 20:01:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 03:56:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 17, 2018 at 03:28:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Aug 17, 2018 at 03:23:15PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Aug 17, 2018 at 11:48:06AM +0200, Jiri Olsa escreveu:
> > > >  static const struct {
> > > >  	const char *fmt;
> > > >  	int (*decompress)(const char *input, int output);
> > > >  } compressions[] = {
> > > > +	[COMP_ID__NONE] = { 0 },
> > > 
> > > 
> > > This broke the build in many places, problems of this kind:
> > > 
> > >   CC       /tmp/build/perf/util/dso.o
> > >   LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/libperf-in.o
> > >   LD       /tmp/build/perf/scripts/libperf-in.o
> > >   CC       /tmp/build/perf/trace/beauty/clone.o
> > >   CC       /tmp/build/perf/util/symbol.o
> > > util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
> > >         [COMP_ID__NONE] = { 0 },
> > >                               ^
> > > 1 error generated.
> > >   CC       /tmp/build/perf/trace/beauty/fcntl.o
> > > mv: cannot stat '/tmp/build/perf/util/.dso.o.tmp': No such file or directory
> > > /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/dso.o' failed
> > > 
> > > If we look just at those that failed, its several gcc versions:
> > > 
> > >   11     9.91 centos:5                      : FAIL gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
> > >   12    14.34 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
> > >   16    47.50 debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
> > >   28    53.92 fedora:25                     : FAIL gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
> > >   29    60.75 fedora:26                     : FAIL gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
> > >   30    90.76 fedora:27                     : FAIL gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
> > >   41    12.78 oraclelinux:6                 : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
> > >   43    12.85 ubuntu:12.04.5                : FAIL gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
> > >   46    45.56 ubuntu:16.04                  : FAIL gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
> > >   54    49.60 ubuntu:17.10                  : FAIL gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
> > 
> > Sorry, gcc eats this with gusto, its just clang that is not taking it,
> > for instance, this is the one in fedora:27:
> > 
> > clang version 5.0.2 (tags/RELEASE_502/final)
> 
> Nah, this cures it, and its not just clang, as we don't have it in the older
> images like centos:5.

ugh.. for some reason I thought this one is failing '= { }' , so I used this one '= { 0 }',
so it's this one then ' = { .xxx = 0 }' :-\ nice

thanks,
jirka

> 
> Patch below seems to cure in all cases, I'll do what is usual, use
> designated initializers everywhere...
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 8ce3de665993..bbed90e5d9bb 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -198,7 +198,7 @@ static const struct {
>  	int (*decompress)(const char *input, int output);
>  	bool (*is_compressed)(const char *input);
>  } compressions[] = {
> -	[COMP_ID__NONE] = { 0 },
> +	[COMP_ID__NONE] = { .fmt = NULL, },
>  #ifdef HAVE_ZLIB_SUPPORT
>  	{ "gz", gzip_decompress_to_file, gzip_is_compressed },
>  #endif
