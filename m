Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2E62070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfAARje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 12:39:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfAARjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 12:39:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98CFD806A8;
        Tue,  1 Jan 2019 17:39:32 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 875405D9CA;
        Tue,  1 Jan 2019 17:39:27 +0000 (UTC)
Date:   Tue, 1 Jan 2019 18:39:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: Re: [PATCH v3 0/2] perf tests: Check for ARM [vectors] page
Message-ID: <20190101173926.GA15729@krava>
References: <20181221034337.26663-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221034337.26663-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Jan 2019 17:39:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 07:43:35PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> I just painfully learned that perf would segfault when
> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

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
