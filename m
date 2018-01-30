Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeA3LWA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:22:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeA3LV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:21:59 -0500
Date: Tue, 30 Jan 2018 12:21:54 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 2/2] perf tools: Skip read of kernel maps once it failed
Message-ID: <20180130112154.GA29098@krava>
References: <20180119161103.15035-1-jolsa@kernel.org>
 <20180119161103.15035-3-jolsa@kernel.org>
 <20180126064830.GC22737@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126064830.GC22737@sejong>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 03:48:30PM +0900, Namhyung Kim wrote:
> On Fri, Jan 19, 2018 at 05:11:03PM +0100, Jiri Olsa wrote:
> > Current perf report is real slow on newer kernels,
> > with following commit:
> >   c0f3ea158939 ("stop using '%pK' for /proc/kallsyms pointer values")
> > 
> > which prevent pointers in /proc/kallsyms, in case
> > kernel.perf_event_paranoid=2.
> > 
> > That makes perf to fail in finding kernel map details,
> > and keep parsing it again for every kernel sample.
> > 
> > Adding and setting a new machine::vmlinux_maps_failed
> > flag after first failed parsing attempt and using it
> > to prevent new pointless parsing.
> 
> Hmm.. is it because it's called from machine__resolve() right?
> 
> 	/*
> 	 * Have we already created the kernel maps for this machine?
> 	 *
> 	 * This should have happened earlier, when we processed the kernel MMAP
> 	 * events, but for older perf.data files there was no such thing, so do
> 	 * it now.
> 	 */
> 
> It seems that it's only to be compatible with ancient versions.
> 
> Do we still need it?  I guess they are recorded many years ago (with
> the ancient version) so using addresses of current kernel is just
> meaningless.  If one still uses the ancient version, [s]he really
> needs to update it.

right, I think we can remove it.. the reason I see is
that we actualy lookup the kernel maps via the map_group
in machine::kmap, which is static.. so always there

if there were no kernel maps events for some reason,
the map group wil be empty and the search will correctly
fail..

I will send it together with some other fixes later this week

thanks,
jirka
