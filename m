Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D66C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8D220851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMYBcOIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8D220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeKUCZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKUCZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:25:56 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BA4206BA;
        Tue, 20 Nov 2018 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542729367;
        bh=Bx04NZOZppvUQmBe3fnrPqMxOLYp+fONoquzplNVj4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMYBcOIoP09BIIjpCf3miT/Ew2w2/rk6cPJ0SR///6rGpW0CEpVBYG/Pf2DXRjhZR
         vZw04qg4bRvco8Jz6Tzd+7/6nXacjWkVCVvhJsaE9GYeHMY2cyZrYbPY9GnkLeRiZl
         zYNc7sO6P6UoXd5NcM2gFfAOYP6+nk5MueO/T7yU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8381B1443D6; Tue, 20 Nov 2018 12:56:04 -0300 (-03)
Date:   Tue, 20 Nov 2018 12:56:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Restore proper cwd on return from mnt ns
Message-ID: <20181120155604.GA6248@kernel.org>
References: <20181101170001.30019-1-jolsa@kernel.org>
 <20181119161006.GA13850@kernel.org>
 <20181120105618.GD8967@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120105618.GD8967@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 20, 2018 at 11:56:18AM +0100, Jiri Olsa escreveu:
> On Mon, Nov 19, 2018 at 08:10:06AM -0800, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Nov 01, 2018 at 06:00:01PM +0100, Jiri Olsa escreveu:
> > > Adding the current working directory to be part of the cookie
> > > and restoring it in the nsinfo__mountns_exit call.
> >  
> > > diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> > > index cf8bd123cf73..fb0458b7e6aa 100644
> > > --- a/tools/perf/util/namespaces.c
> > > +++ b/tools/perf/util/namespaces.c
> > 
> > > @@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > >  	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
> > >  		return;
> >   
> > > +	oldcwd = get_current_dir_name();
> > 
> > Breaks the build with bionic (Android), where get_current_dir_name() is
> > not available:
> > 
> > /tmp/build/perf/libperf.a(libperf-in.o):hist.c:function nsinfo__mountns_enter: error: undefined reference to 'get_current_dir_name'
> > collect2: error: ld returned 1 exit status
> > Makefile.perf:534: recipe for target '/tmp/build/perf/perf' failed
> > make[2]: *** [/tmp/build/perf/perf] Error 1
> > Makefile.perf:206: recipe for target 'sub-make' failed
> > make[1]: *** [sub-make] Error 2
> > Makefile:69: recipe for target 'all' failed
> > make: *** [all] Error 2
> > make: Leaving directory '/git/linux/tools/perf'
> > [root@seventh ~]# 
> > 
> > The container builds are ongoing, its possoble that this becomes an
> > issue in uCLibc, wasn't on musl libc (Alpine Linux).
> 
> will check, thanks

I fixed this already, by adding a test for that get_current_dir_name()
function and a simple implementation based on strdup(getcwd(bf)), take a
look at my perf/urgent branch 

- Arnaldo
