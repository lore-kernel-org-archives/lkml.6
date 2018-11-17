Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FB7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E866C2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E866C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeKQTQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 14:16:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbeKQTQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 14:16:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E567083F3F;
        Sat, 17 Nov 2018 09:00:16 +0000 (UTC)
Received: from krava (ovpn-204-61.brq.redhat.com [10.40.204.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4E8C17AD2;
        Sat, 17 Nov 2018 09:00:14 +0000 (UTC)
Date:   Sat, 17 Nov 2018 10:00:10 +0100
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
Message-ID: <20181117090010.GP9600@krava>
References: <20181101170001.30019-1-jolsa@kernel.org>
 <20181116183143.GD18319@kernel.org>
 <20181116184245.GE18319@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116184245.GE18319@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 17 Nov 2018 09:00:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:42:45AM -0800, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 16, 2018 at 10:31:43AM -0800, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Nov 01, 2018 at 06:00:01PM +0100, Jiri Olsa escreveu:
> > > When reporting on 'record' server we try to retrieve/use
> > > the mnt namespace of the profiled tasks. We use following
> > > API with cookie to hold the return namespace, roughly:
> > > 
> > >   nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc)
> > >     setns(newns, 0);
> > >   ...
> > >   new ns related open..
> > >   ...
> > >   nsinfo__mountns_exit(struct nscookie *nc)
> > >     setns(nc->oldns)
> > > 
> > > Once finished we setns to old namespace, which also sets the
> > > current working directory (cwd) to "/", trashing the cwd we had.
> > > 
> > > This is mostly fine, because we use absolute paths almost everywhere,
> > > but it screws up perf diff:
> > > 
> > >   # perf diff
> > >   failed to open perf.data: No such file or directory  (try 'perf record' first)
> > >   ...
> > > 
> > > Adding the current working directory to be part of the cookie
> > > and restoring it in the nsinfo__mountns_exit call.
> >  
> > > Cc: Krister Johansen <kjlx@templeofstupid.com>
> > > Fixes: 843ff37bb59e ("perf symbols: Find symbols in different mount namespace")
> > > Link: http://lkml.kernel.org/n/tip-zg3vz7kjr86cco7lo91v8yhj@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/namespaces.c | 18 ++++++++++++++++--
> > >  tools/perf/util/namespaces.h |  1 +
> > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> > > index cf8bd123cf73..fb0458b7e6aa 100644
> > > --- a/tools/perf/util/namespaces.c
> > > +++ b/tools/perf/util/namespaces.c
> > > @@ -18,6 +18,7 @@
> > >  #include <stdio.h>
> > >  #include <string.h>
> > >  #include <unistd.h>
> > > +#include <asm/bug.h>
> > >  
> > >  struct namespaces *namespaces__new(struct namespaces_event *event)
> > >  {
> > > @@ -186,6 +187,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > >  	char curpath[PATH_MAX];
> > >  	int oldns = -1;
> > >  	int newns = -1;
> > > +	char *oldcwd = NULL;
> > >  
> > >  	if (nc == NULL)
> > >  		return;
> > > @@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > >  	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
> > >  		return;
> > >  
> > > +	oldcwd = get_current_dir_name();
> > > +	if (!oldcwd)
> > > +		return;
> > > +
> > >  	oldns = open(curpath, O_RDONLY);
> > >  	if (oldns < 0)
> > > -		return;
> > > +		goto errout;
> > >  
> > >  	newns = open(nsi->mntns_path, O_RDONLY);
> > >  	if (newns < 0)
> > > @@ -210,11 +216,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > >  	if (setns(newns, CLONE_NEWNS) < 0)
> > >  		goto errout;
> > >  
> > > +	nc->oldcwd = oldcwd;
> > >  	nc->oldns = oldns;
> > >  	nc->newns = newns;
> > >  	return;
> > >  
> > >  errout:
> > > +	if (oldcwd)
> > > +		free(oldcwd);

right, ok

> > 
> > Applied, and while at it I removed the needless if in the above two
> > lines.
> > 
> > >  	if (oldns > -1)
> > >  		close(oldns);
> > >  	if (newns > -1)
> > > @@ -223,11 +232,16 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > >  
> > >  void nsinfo__mountns_exit(struct nscookie *nc)
> > >  {
> > > -	if (nc == NULL || nc->oldns == -1 || nc->newns == -1)
> > > +	if (nc == NULL || nc->oldns == -1 || nc->newns == -1 || !nc->oldcwd)
> > >  		return;
> > >  
> > >  	setns(nc->oldns, CLONE_NEWNS);
> > >  
> > > +	if (nc->oldcwd) {
> > > +		WARN_ON_ONCE(chdir(nc->oldcwd));
> > > +		free(nc->oldcwd);
> > > +	}
> > > +
> 
> Also changed the above to zfree(&nc->oldcwd) as this is in a struct
> member, that is not freed by the freeing caller
> (nsinfo__mountns_exit()), to avoid later possible use-after-free (I
> haven't checked if it _actually_ happens with the current codebase, but
> it could) also to match the following block, where the resource is
> released and then the handler is invalidated.

great, thanks

jirka
