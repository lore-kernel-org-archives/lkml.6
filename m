Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9635C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DD22087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhsa/VCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DD22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbeKQE4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390397AbeKQE4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:56:18 -0500
Received: from jouet.infradead.org (d66-183-243-195.bchsia.telus.net [66.183.243.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842A220858;
        Fri, 16 Nov 2018 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542393765;
        bh=32E5zGbZuoZDMoQCAHxuXV1X87Z0ATdHgjXX/pknE6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yhsa/VCJD84frjOv770Ob/kcWaeCyfdKscRYMpRHNWOHmI8bLhZPca3ouakZGjirq
         JlMB+V6LNkiDGwlTEneDHCQo0v3jr9L744QneAnhjBSvGHWAIsDgfJn9zbplka1+/4
         X5lYJ4fP+5ue0/OsDTqAZvY1e3G4sRou2DPZ1GYQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4D8321443D0; Fri, 16 Nov 2018 10:42:45 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:42:45 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Restore proper cwd on return from mnt ns
Message-ID: <20181116184245.GE18319@kernel.org>
References: <20181101170001.30019-1-jolsa@kernel.org>
 <20181116183143.GD18319@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116183143.GD18319@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 16, 2018 at 10:31:43AM -0800, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 01, 2018 at 06:00:01PM +0100, Jiri Olsa escreveu:
> > When reporting on 'record' server we try to retrieve/use
> > the mnt namespace of the profiled tasks. We use following
> > API with cookie to hold the return namespace, roughly:
> > 
> >   nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc)
> >     setns(newns, 0);
> >   ...
> >   new ns related open..
> >   ...
> >   nsinfo__mountns_exit(struct nscookie *nc)
> >     setns(nc->oldns)
> > 
> > Once finished we setns to old namespace, which also sets the
> > current working directory (cwd) to "/", trashing the cwd we had.
> > 
> > This is mostly fine, because we use absolute paths almost everywhere,
> > but it screws up perf diff:
> > 
> >   # perf diff
> >   failed to open perf.data: No such file or directory  (try 'perf record' first)
> >   ...
> > 
> > Adding the current working directory to be part of the cookie
> > and restoring it in the nsinfo__mountns_exit call.
>  
> > Cc: Krister Johansen <kjlx@templeofstupid.com>
> > Fixes: 843ff37bb59e ("perf symbols: Find symbols in different mount namespace")
> > Link: http://lkml.kernel.org/n/tip-zg3vz7kjr86cco7lo91v8yhj@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/namespaces.c | 18 ++++++++++++++++--
> >  tools/perf/util/namespaces.h |  1 +
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> > index cf8bd123cf73..fb0458b7e6aa 100644
> > --- a/tools/perf/util/namespaces.c
> > +++ b/tools/perf/util/namespaces.c
> > @@ -18,6 +18,7 @@
> >  #include <stdio.h>
> >  #include <string.h>
> >  #include <unistd.h>
> > +#include <asm/bug.h>
> >  
> >  struct namespaces *namespaces__new(struct namespaces_event *event)
> >  {
> > @@ -186,6 +187,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> >  	char curpath[PATH_MAX];
> >  	int oldns = -1;
> >  	int newns = -1;
> > +	char *oldcwd = NULL;
> >  
> >  	if (nc == NULL)
> >  		return;
> > @@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> >  	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
> >  		return;
> >  
> > +	oldcwd = get_current_dir_name();
> > +	if (!oldcwd)
> > +		return;
> > +
> >  	oldns = open(curpath, O_RDONLY);
> >  	if (oldns < 0)
> > -		return;
> > +		goto errout;
> >  
> >  	newns = open(nsi->mntns_path, O_RDONLY);
> >  	if (newns < 0)
> > @@ -210,11 +216,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> >  	if (setns(newns, CLONE_NEWNS) < 0)
> >  		goto errout;
> >  
> > +	nc->oldcwd = oldcwd;
> >  	nc->oldns = oldns;
> >  	nc->newns = newns;
> >  	return;
> >  
> >  errout:
> > +	if (oldcwd)
> > +		free(oldcwd);
> 
> Applied, and while at it I removed the needless if in the above two
> lines.
> 
> >  	if (oldns > -1)
> >  		close(oldns);
> >  	if (newns > -1)
> > @@ -223,11 +232,16 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> >  
> >  void nsinfo__mountns_exit(struct nscookie *nc)
> >  {
> > -	if (nc == NULL || nc->oldns == -1 || nc->newns == -1)
> > +	if (nc == NULL || nc->oldns == -1 || nc->newns == -1 || !nc->oldcwd)
> >  		return;
> >  
> >  	setns(nc->oldns, CLONE_NEWNS);
> >  
> > +	if (nc->oldcwd) {
> > +		WARN_ON_ONCE(chdir(nc->oldcwd));
> > +		free(nc->oldcwd);
> > +	}
> > +

Also changed the above to zfree(&nc->oldcwd) as this is in a struct
member, that is not freed by the freeing caller
(nsinfo__mountns_exit()), to avoid later possible use-after-free (I
haven't checked if it _actually_ happens with the current codebase, but
it could) also to match the following block, where the resource is
released and then the handler is invalidated.

- Arnaldo

> >  	if (nc->oldns > -1) {
> >  		close(nc->oldns);
> >  		nc->oldns = -1;
