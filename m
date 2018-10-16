Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147122089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147122089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJPShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7B8283F46;
        Tue, 16 Oct 2018 10:47:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FCB610018FB;
        Tue, 16 Oct 2018 10:47:23 +0000 (UTC)
Date:   Tue, 16 Oct 2018 12:47:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
Message-ID: <20181016104722.GA18450@krava>
References: <20181002111621.GA6357@krava>
 <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava>
 <20181003212052.GA32371@krava>
 <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
 <20181009100049.GF6499@krava>
 <31101407-0bcd-2fbf-361e-43cbcb81cd19@huawei.com>
 <20181015191502.GA2398@kernel.org>
 <d1cc40ee-4b09-35a8-86d2-bfc0eb78b9d5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cc40ee-4b09-35a8-86d2-bfc0eb78b9d5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 16 Oct 2018 10:47:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:10:20AM +0100, John Garry wrote:
> On 15/10/2018 20:15, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 12, 2018 at 02:25:49PM +0100, John Garry escreveu:
> > > On 09/10/2018 11:00, Jiri Olsa wrote:
> > > > On Thu, Oct 04, 2018 at 10:20:39AM +0100, John Garry wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > > We synthesize an update event that needs to touch the evsel
> > > > > > id array, which is not defined at that time. Fixing this by
> > > > > > forcing the id allocation for events with theeir own cpus.
> > > 
> > > /s/theeir/their/
> > > 
> > > > > > 
> > > > > > Reported-by: John Garry <john.garry@huawei.com>
> > > > > > Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6@git.kernel.org
> > > > > 
> > > > > Tested-by: John Garry <john.garry@huawei.com>
> > > > > 
> > > > > In terms of adding to stable, LT v4.14 is not affected, but 4.18.x is.
> > > > > 
> > > > > Thanks,
> > > > > John
> > > > 
> > > > Arnaldo, could you please pick up this one
> > > > 
> > > 
> > > Just a friendly reminder on this patch.
> > > 
> > > How about re-send with an updated commit message also?
> > 
> > I'll fix up the commit message and apply, thanks.
> > 
> 
> Much appreciated.
> 
> BTW, I think that we should add a fixes tag. But I'm not sure if this patch
> fixes the commit I bisected to earlier (bfd8f72c2778f5bd63d), or that same
> commit just exposed some latent bug.
> 
> Jirka, Andi, Do you know?

yes, that commit moved it to record, which resulted in this fault

Arnaldo, could you please add:
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")

thanks,
jirka
