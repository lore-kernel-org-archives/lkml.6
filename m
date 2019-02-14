Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B25218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438865AbfBNN0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:26:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388291AbfBNN0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:26:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B5F05D67E;
        Thu, 14 Feb 2019 13:26:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id C3EA36013D;
        Thu, 14 Feb 2019 13:26:39 +0000 (UTC)
Date:   Thu, 14 Feb 2019 14:26:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190214132638.GB13095@krava>
References: <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava>
 <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava>
 <20190211193202.GG3269@kernel.org>
 <20190211201831.GE5046@krava>
 <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
 <20190214113450.GC26714@krava>
 <20190214125759.GS3269@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214125759.GS3269@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 14 Feb 2019 13:26:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:57:59AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 14, 2019 at 12:34:50PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 11, 2019 at 12:43:22PM -0800, Stephane Eranian wrote:
> > > On Mon, Feb 11, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > I thought having new MMAP3 event version with buildid field in it
> > > > if available and/or enabled by bit in perf_event_attr
> 
> > > I think MMAP3 is a cleaner approach, though it adds yet another MMAP event.
>  
> > actually I realized this might not help at the end at all
>  
> > what we do now is that we scan the data (after it's recorded)
> 
> We wouldn't have to do that scan of the data at the end if we have the
> build-id in the MMAP3 records.
> 
> > to get the list of binaries that got touched during the profile
> > and store those in .debug cache based on the build ids
>  
> > we can't just store ALL of the binaries that the session comes
> > across via mmap events
> 
> We don't have to, we never did that at 'perf record' time, this is
> something for 'perf archive' to do, see below.
> 
> > I can see the build id in mmap helping to resolve the race
> > issue when some binary change during the profile session and
> > we have no idea and report on wrong one.. but I dont see
> > people complaining about this at all
> 
> But with the build id in the MMAPs we wouldn't need to scan anything at
> 'perf record' time, just at 'perf archive' time, where we would scan
> everything, and as soon as we find a hit, we add that DSO to the list of
> things we need to put in the tarball.

ok.. it might little change the expected behavour in that
you will not have .debug cache populated until you run
perf archive.. some profile data might stop report after
you reinstall the binary..

on the other hande '.debug' cache would stop growing
uncontrolably.. so I think I'd be ok with this

jirka
