Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C80C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1597214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545908146;
	bh=8wUtU1s+QO0qVOPQsyPTtcCRl+754J+tD0SfNl1bmdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hHxVjLdtZpQpNDsLUiJrnfpnJfMa+qSq57j4Wa+URbB1v1uxKIs51R9NNdiwiak2q
	 3C8nJ1wAwj8dQPSjv9nD7mvJEhVVBU1zSWn8C2KVVFN4gSmpRLXtSicKWn68jT+R/V
	 V/VNQfb3SVVfq78Bz5J0xp/Dqw/yRUIV/37wikLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeL0Kzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:55:44 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:57413 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeL0Kzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:55:44 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 27 Dec 2018 19:55:40 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 27 Dec 2018 19:55:40 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Thu, 27 Dec 2018 19:55:39 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de,
        kernel-team@lge.com
Subject: Re: [PATCH v3 0/2] perf tests: Check for ARM [vectors] page
Message-ID: <20181227105539.GA4521@sejong>
References: <20181221034337.26663-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221034337.26663-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 20, 2018 at 07:43:35PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> I just painfully learned that perf would segfault when
> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of

Could you please elaborate?

Thanks,
Namhyung


> it. This patch series adds an ARM test for that by leveraging the
> existing find_vdso_map() function and making it more generic and capable
> of location any map within /proc/self/maps.
> 
> Changes in v3:
> 
> - remove find_vdso_map() call find_map() with VDSO__MAP_NAME
> 
> Changes in v2:
> 
> - use strlen() instead of sizeof() -1 since we made the page name a
>   parameter
> - use TEST_OK/TEST_FAIL in lieu of 0/-1
> - added an error message indicating CONFIG_KUSER_HELPERS might be
>   disabled
> 
> Florian Fainelli (2):
>   perf tools: Make find_vdso_map() more modular
>   perf tests: Add a test for the ARM 32-bit [vectors] page
> 
>  tools/perf/Makefile.perf                      |  4 ++--
>  tools/perf/arch/arm/tests/Build               |  1 +
>  tools/perf/arch/arm/tests/arch-tests.c        |  4 ++++
>  tools/perf/arch/arm/tests/vectors-page.c      | 24 +++++++++++++++++++
>  tools/perf/perf-read-vdso.c                   |  6 ++---
>  tools/perf/tests/tests.h                      |  5 ++++
>  .../perf/util/{find-vdso-map.c => find-map.c} |  7 +++---
>  tools/perf/util/vdso.c                        |  6 ++---
>  8 files changed, 45 insertions(+), 12 deletions(-)
>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>  rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)
> 
> -- 
> 2.17.1
> 
