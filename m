Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B22220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfAQWJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:09:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:13718 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfAQWJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:09:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 14:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="139216808"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2019 14:09:24 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C0B64301C4E; Thu, 17 Jan 2019 14:09:24 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:09:24 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        "Liang, Kan" <kan.liang@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf/core: fix perf_proc_update_handler() bug
Message-ID: <20190117220924.GN6118@tassilo.jf.intel.com>
References: <1547169436-6266-1-git-send-email-eranian@google.com>
 <CABPqkBS30_Afu3a1hycMAnB5KaqdFe=JYPoENfZG4ZtUYAE7mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBS30_Afu3a1hycMAnB5KaqdFe=JYPoENfZG4ZtUYAE7mQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 01:03:20PM -0800, Stephane Eranian wrote:
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

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
