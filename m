Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA74CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE2C2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWBHDtpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE2C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPXOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeJPXOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:14:23 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475722083C;
        Tue, 16 Oct 2018 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539703405;
        bh=DwH8KqH45PiHPa8CGcwn0lTSybp6ax7F0hgAy/D28+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWBHDtpbZmIWpKvYembHi8rCcO/4t3589PmiuY6Epn4ArpMJddvt1Z3rfXh3Tzaq8
         rhp6mpPKxfQxqPFsaRKwiB7q9mi6N5t/Z5QBbGJnlGw30KNWPZTQQN3b6A8XzKciE0
         gSo78w3PZiUKgX+L1HQdqH167YHDv2c2bdqZaDhA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 77223142C5E; Tue, 16 Oct 2018 12:23:22 -0300 (-03)
Date:   Tue, 16 Oct 2018 12:23:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix tracing_path_mount proper path
Message-ID: <20181016152322.GC3849@kernel.org>
References: <20181016114818.3595-1-jolsa@kernel.org>
 <20181016151813.GB3849@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016151813.GB3849@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 16, 2018 at 12:18:13PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 16, 2018 at 01:48:18PM +0200, Jiri Olsa escreveu:
> > If there's no tracefs (RHEL7) support the tracing_path_mount
> > returns debugfs path which results in following fail:
> > 
> >   # perf probe sys_write
> >   kprobe_events file does not exist - please rebuild kernel with CONFIG_KPROBE_EVENTS.
> >   Error: Failed to add events.
> > 
> > In tracing_path_debugfs_mount function we need to return the
> > 'tracing' path instead of just the mount to make it work:
> > 
> >   # perf probe sys_write
> >   Added new event:
> >     probe:sys_write      (on sys_write)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> >           perf record -e probe:sys_write -aR sleep 1
> > 
> > Adding the 'return tracing_path;' also to tracing_path_tracefs_mount
> > function just for consistency with tracing_path_debugfs_mount.
> > 
> > Upstream keeps working, because it has the tracefs support.
> > 
> > Link: http://lkml.kernel.org/n/tip-yiwkzexq9fk1ey1xg3gnjlw4@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/api/fs/tracing_path.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
> > index 120037496f77..5afb11b30fca 100644
> > --- a/tools/lib/api/fs/tracing_path.c
> > +++ b/tools/lib/api/fs/tracing_path.c
> > @@ -36,7 +36,7 @@ static const char *tracing_path_tracefs_mount(void)
> >  
> >  	__tracing_path_set("", mnt);
> >  
> > -	return mnt;
> > +	return tracing_path;
> >  }
> >  
> >  static const char *tracing_path_debugfs_mount(void)
> > @@ -49,7 +49,7 @@ static const char *tracing_path_debugfs_mount(void)
> >  
> >  	__tracing_path_set("tracing/", mnt);
> >  
> > -	return mnt;
> > +	return tracing_path;
> 
> Humm, colour me confused, by the name of the function I expected
> tracing_path_debugfs_mount() to return the debugfs mount.
> 
> tracing_path_tracefs_mount() would return the tracefs mount point, so,
> there, returning tracing_path would be ok.
> 
> Is there some other way to figure out that tracefs isn't available and
> thus we should use debugfs_mount + "/tracing/" for the "tracefs" mount?
> 
> This may well be just the naming confusion... lemme read this a bit
> more...

Indeed, naming confusion, these are static things, used only by:

const char *tracing_path_mount(void)
{
        const char *mnt;

        mnt = tracing_path_tracefs_mount();
        if (mnt)
                return mnt;

        mnt = tracing_path_debugfs_mount();

        return mnt;
}

This one could as well just return tracing_path and the return be used
just to figure if it managed to read the mount point for tracefs or
debugfs...

Something like:

static int tracing_path_tracefs_mount(void)
{
	const char *mnt = tracefs__mount();
	if (!mnt)
		return -1;

	__tracing_path_set("", mnt);
	return 0;
}

static const char *tracing_path_debugfs_mount(void)
{
	const char *mnt = debugfs__mount();
	if (!mnt)
		return -1;

	__tracing_path_set("tracing/", mnt);
	return 0;
}

const char *tracing_path_mount(void)
{
	if (tracing_path_tracefs_mount() < 0 &&
	    tracing_path_debugfs_mount() < 0)
		return NULL;

	return tracing_path;
}

But anyway, your patch fixes things, applying...

- Arnaldo
