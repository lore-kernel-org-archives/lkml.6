Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80F54C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4070720896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4070720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965804AbeFOLZ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:25:26 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:55678 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965641AbeFOLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:25:24 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 32E54B8720
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:25:23 +0100 (IST)
Received: (qmail 17467 invoked from network); 15 Jun 2018 11:25:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 15 Jun 2018 11:25:23 -0000
Date:   Fri, 15 Jun 2018 12:25:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180615112522.3wujbq7bajof57qx@techsingularity.net>
References: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
 <20180611141113.pfuttg7npch3jtg6@techsingularity.net>
 <CAE4VaGCMS2pXfPVSnMbudexv_m5wRCTuBKA5ijh2x==11uQg9g@mail.gmail.com>
 <20180614083640.dekqhsopoefnfhb4@techsingularity.net>
 <CAE4VaGCzB99es_TpAaYvtjX8fqzFA=7HX-ezqgO6FaEB5if4zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGCzB99es_TpAaYvtjX8fqzFA=7HX-ezqgO6FaEB5if4zg@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 01:07:32AM +0200, Jirka Hladky wrote:
> >
> > In terms of the speed of migration, it may be worth checking how often the
> > mm_numa_migrate_ratelimit tracepoint is triggered with bonus points for
> > using
> > the nr_pages to calculate how many pages get throttled from migrating. If
> > it's high frequency then you could test increasing ratelimit_pages (which
> > is set at compile time despite not being a macro). It still may not work
> > for tasks that are too short-lived to have enough time to identify a
> > misplacement and migration.
> 
> 
> I have done testing on 2 NUMA and 4 NUMA servers, all equipped with the
> same CPUs ( Gold 6126) with 48 and 96 cores respectively.
> 
> I have used ft.C.x and ft.D.x tests with 20 threads on 2 NUMA box and 32
> threads on 4 NUMA box. (This is where I see the biggest perf. drop between
> 4.16 and 4.17 kernels).  While ft.C is a short-lived test (it takes few
> seconds to finish), ft.D is a long test with runtime over 3 minutes with 20
> threads and 4.5 minutes with 20 threads.
> 

Understood.

> I have used this command to run the test:
> 
> OMP_NUM_THREADS=${THREADS} trace-cmd record -e
> migrate:mm_numa_migrate_ratelimit -o
> ${DIR}/${BIN}_${THREADS}_threads_with_trace.trace.dat ./${BIN}
> 

Ok, the fact you're using OpenMP instead of MPI is an important detail.
OpenMP threads inherit the numa_preferred_nid from their parent while
MPI are usually processes and do not inherit the preferred nid. They
also inherit the page tables so even though there is a preferred nid,
they also potentially handle NUMA hinting faults. This has an important
impact on what the hints look like if there is a window before a thread
gets migrated to another socket.

> I can see that 2c83362734dad8e48ccc0710b5cd2436a0323893 has caused big
> increase in number of mm_numa_migrate_ratelimit events.
> 

That implies the threads are getting throttled and, for NAS at least,
indicate why migration is slow. It doesn't apply to stream.

> I have tested following 3 kernels: 4.16, 4.16_p1
> (2c83362734dad8e48ccc0710b5cd2436a0323893) and 4.16_p2 (4.16_p1 + 2 patched
> from Srikar Dronamra).
> 
> There is clear performance drop going from 4.16 to 4.16_p1. 4.16_p2 shows a
> small improvement over 4.16_p1 for ft.C but additional perf. drop for ft.D
> on 4 NUMA node server.
> 

Ok, so as expected a higher scan rate is not necessarily a good thing.
I've observed before that often it simply increases system CPU usage
without any improvement in locality.

> I think you have mentioned that you are using NAS benchmark but you don't
> see the regression.

Correct.

> I do wonder if you run NAS with the number of
> threads being roughly 1/3 of the available cores - this is the scenario
> where I consistently see big perf. drop caused by
> 2c83362734dad8e48ccc0710b5cd2436a0323893.
> 

It's possible. Until relatively recently, the NAS configurations used as
many CPUs as possible rounded down to a power-of-two or square number
where required if MPI was in use. Due to the fact that saturating the
machine alters how MPI behaves (and is not great for openMP either),
I added configurations that used half of the CPUs. However, that would
mean it fits too nicely within sockets. I've added another set for one
third of the CPUs and scheduled the tests. Unfortunately, they will not
complete quickly as my test grid has a massive backlog of work.

> Results are bellow:
> 

Nice one, thanks. It's fairly clear that rate limiting may be a major
component and it's worth testing with the ratelimit increased. Given that
there have been a lot of improvements on locality and corner cases since
the rate limit was first introduced, it may also be worth considering
elimintating the rate limiting entirely and see what falls out.

-- 
Mel Gorman
SUSE Labs
