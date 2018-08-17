Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B883C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E89F208FA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w1sBMN0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E89F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHQVdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeHQVdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:33:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446EA208FA;
        Fri, 17 Aug 2018 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534530532;
        bh=hPVW0l+TlRTb28axWJBeUN+w3rCJtUiX3cR75urmw0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1sBMN0oFdp1xXgIGE4RzboyTrCy6etgAgJLItZvyd0Wc2JZLCDQamROe5UkTuAWN
         CY64HqdiE9zSYCmpyKG6BzHuhHpEqx+CuODl1GYUfuQ+1DRTyhzXAgLB8A8ySc9ZRH
         ZSjHjC8t/jBqxag97l3ImlYA1uzJkFk7weUML8jc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id DE581141C3A; Fri, 17 Aug 2018 15:28:49 -0300 (-03)
Date:   Fri, 17 Aug 2018 15:28:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 06/13] perf tools: Add compression id into struct
 kmod_path
Message-ID: <20180817182849.GE22443@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
 <20180817094813.15086-7-jolsa@kernel.org>
 <20180817182315.GD22443@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817182315.GD22443@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 17, 2018 at 03:23:15PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 17, 2018 at 11:48:06AM +0200, Jiri Olsa escreveu:
> >  static const struct {
> >  	const char *fmt;
> >  	int (*decompress)(const char *input, int output);
> >  } compressions[] = {
> > +	[COMP_ID__NONE] = { 0 },
> 
> 
> This broke the build in many places, problems of this kind:
> 
>   CC       /tmp/build/perf/util/dso.o
>   LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/libperf-in.o
>   LD       /tmp/build/perf/scripts/libperf-in.o
>   CC       /tmp/build/perf/trace/beauty/clone.o
>   CC       /tmp/build/perf/util/symbol.o
> util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
>         [COMP_ID__NONE] = { 0 },
>                               ^
> 1 error generated.
>   CC       /tmp/build/perf/trace/beauty/fcntl.o
> mv: cannot stat '/tmp/build/perf/util/.dso.o.tmp': No such file or directory
> /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/dso.o' failed
> 
> If we look just at those that failed, its several gcc versions:
> 
>   11     9.91 centos:5                      : FAIL gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   12    14.34 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   16    47.50 debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
>   28    53.92 fedora:25                     : FAIL gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
>   29    60.75 fedora:26                     : FAIL gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
>   30    90.76 fedora:27                     : FAIL gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
>   41    12.78 oraclelinux:6                 : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
>   43    12.85 ubuntu:12.04.5                : FAIL gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
>   46    45.56 ubuntu:16.04                  : FAIL gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
>   54    49.60 ubuntu:17.10                  : FAIL gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0

Sorry, gcc eats this with gusto, its just clang that is not taking it,
for instance, this is the one in fedora:27:

clang version 5.0.2 (tags/RELEASE_502/final)

- Arnaldo
