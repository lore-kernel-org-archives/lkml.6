Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D0D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfAROOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:14:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfAROOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:14:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50EF1C0C5A51;
        Fri, 18 Jan 2019 14:14:48 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E1010841BB;
        Fri, 18 Jan 2019 14:14:41 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id DF7D04BFD; Fri, 18 Jan 2019 12:14:34 -0200 (BRST)
Date:   Fri, 18 Jan 2019 12:14:34 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/core: fix perf_proc_update_handler() bug
Message-ID: <20190118141434.GC3141@redhat.com>
References: <1547169436-6266-1-git-send-email-eranian@google.com>
 <CABPqkBS30_Afu3a1hycMAnB5KaqdFe=JYPoENfZG4ZtUYAE7mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBS30_Afu3a1hycMAnB5KaqdFe=JYPoENfZG4ZtUYAE7mQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 18 Jan 2019 14:14:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2019 at 01:03:20PM -0800, Stephane Eranian escreveu:
> On Thu, Jan 10, 2019 at 5:17 PM Stephane Eranian <eranian@google.com> wrote:
> >
> > The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
> > syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
> > when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
> > then no modification to sysctl_perf_event_sample_rate is allowed to prevent
> > possible hang from wrong values.
> >
> > The problem is that the test to prevent modification is made after the
> > sysctl variable is modified in perf_proc_update_handler().
> >
> > You get an error:
> >
> > $ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
> > echo: write error: invalid argument
> >
> > But the value is still modified causing all sorts of inconsistencies:
> >
> > $ cat /proc/sys/kernel/perf_event_max_sample_rate
> > 10001
> >
> > This patch fixes the problem by moving the parsing of the value after
> > the test.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> 
> Ping.

Collected the Reviewed-by from Jiri and Andi, reproduced the problem
before the patch and I'm testing it to push to Ingo via perf/urgent,
thanks for the patch.

- Arnaldo
