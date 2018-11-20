Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E8DC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D914C20684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeKUEMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:12:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKUEMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:12:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0866230832D7;
        Tue, 20 Nov 2018 17:42:17 +0000 (UTC)
Received: from krava (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id ACE2F5D75D;
        Tue, 20 Nov 2018 17:42:14 +0000 (UTC)
Date:   Tue, 20 Nov 2018 18:42:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Restore proper cwd on return from mnt ns
Message-ID: <20181120174213.GA18656@krava>
References: <20181101170001.30019-1-jolsa@kernel.org>
 <20181119161006.GA13850@kernel.org>
 <20181120105618.GD8967@krava>
 <20181120155604.GA6248@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120155604.GA6248@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 20 Nov 2018 17:42:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:56:04PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 20, 2018 at 11:56:18AM +0100, Jiri Olsa escreveu:
> > On Mon, Nov 19, 2018 at 08:10:06AM -0800, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Nov 01, 2018 at 06:00:01PM +0100, Jiri Olsa escreveu:
> > > > Adding the current working directory to be part of the cookie
> > > > and restoring it in the nsinfo__mountns_exit call.
> > >  
> > > > diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> > > > index cf8bd123cf73..fb0458b7e6aa 100644
> > > > --- a/tools/perf/util/namespaces.c
> > > > +++ b/tools/perf/util/namespaces.c
> > > 
> > > > @@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > > >  	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
> > > >  		return;
> > >   
> > > > +	oldcwd = get_current_dir_name();
> > > 
> > > Breaks the build with bionic (Android), where get_current_dir_name() is
> > > not available:
> > > 
> > > /tmp/build/perf/libperf.a(libperf-in.o):hist.c:function nsinfo__mountns_enter: error: undefined reference to 'get_current_dir_name'
> > > collect2: error: ld returned 1 exit status
> > > Makefile.perf:534: recipe for target '/tmp/build/perf/perf' failed
> > > make[2]: *** [/tmp/build/perf/perf] Error 1
> > > Makefile.perf:206: recipe for target 'sub-make' failed
> > > make[1]: *** [sub-make] Error 2
> > > Makefile:69: recipe for target 'all' failed
> > > make: *** [all] Error 2
> > > make: Leaving directory '/git/linux/tools/perf'
> > > [root@seventh ~]# 
> > > 
> > > The container builds are ongoing, its possoble that this becomes an
> > > issue in uCLibc, wasn't on musl libc (Alpine Linux).
> > 
> > will check, thanks
> 
> I fixed this already, by adding a test for that get_current_dir_name()
> function and a simple implementation based on strdup(getcwd(bf)), take a
> look at my perf/urgent branch 

ok, I saw it.. but it seems little too much for a single function to me

jirka
