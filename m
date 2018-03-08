Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbeCHNSN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:18:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751355AbeCHNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:18:12 -0500
Date: Thu, 8 Mar 2018 14:18:09 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 08/19] perf tools: Add mem2node object
Message-ID: <20180308131809.GA31776@krava>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-9-jolsa@kernel.org>
 <20180307192736.GS3701@kernel.org>
 <20180308110306.GB13693@krava>
 <20180308125849.GA3701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308125849.GA3701@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 09:58:49AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > I don't think we need nentries.. AFAIK realloc works ok over single variable
> 
> So:
> 
> 1) you alloc entries with a max number of entries
> 
> 2) you go on populating it
> 
> 3) there are some left, lets shrink it:
> 
> 	entries = realloc(entries, nr_entries * sizeof(entries[0]);
> 
> Here it will probably not fail, but you check it anyway, and that is
> right, what happens if this returns NULL? entries gets set to NULL,
> we lose the reference to the allocated memory and you return -ENOMEM,
> right?
> 
> We end up leaking entries when what I'm suggesting you to do is to
> not clobber entries with the return of realloc() (doing it this way most
> of the time leads to bugs), but instead store it to a temp var
> (nentries), and if it succeeds, then you know that you can
> set nentries to entries and go ahead with your nicely shrunk block of
> memory.
> 
> If it fails, then you continue with the original block of memory, that
> continues to have what you just set up, etc.

ah that ;-) ok, will fix

thanks,
jirka
