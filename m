Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D0C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D0C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeK0U3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0U3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:29:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 938BA307EAA6;
        Tue, 27 Nov 2018 09:32:16 +0000 (UTC)
Received: from krava (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5105860603;
        Tue, 27 Nov 2018 09:32:12 +0000 (UTC)
Date:   Tue, 27 Nov 2018 10:32:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v2 0/2] perf tests: Check for ARM [vectors] page
Message-ID: <20181127093211.GD8908@krava>
References: <20181025175508.6967-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025175508.6967-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 27 Nov 2018 09:32:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:55:06AM -0700, Florian Fainelli wrote:
> Hi all,
> 
> I just painfully learned that perf would segfault when
> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
> it. This patch series adds an ARM test for that by leveraging the
> existing find_vdso_map() function and making it more generic and capable
> of location any map within /proc/self/maps.
> 
> Changes in v2:
> 
> - use strlen() instead of sizeof() -1 since we made the page name a
>   parameter
> - use TEST_OK/TEST_FAIL in lieu of 0/-1
> - added an error message indicating CONFIG_KUSER_HELPERS might be
>   disabled

other than the function placing I mentioned in
my previous email, this seems ok to me

jirka

> 
> Florian Fainelli (2):
>   perf tools: Make find_vdso_map() more modular
>   perf tests: Add a test for the ARM 32-bit [vectors] page
> 
>  tools/perf/arch/arm/tests/Build          |  1 +
>  tools/perf/arch/arm/tests/arch-tests.c   |  4 +++
>  tools/perf/arch/arm/tests/vectors-page.c | 24 ++++++++++++++++++
>  tools/perf/tests/tests.h                 |  5 ++++
>  tools/perf/util/find-map.c               | 31 ++++++++++++++++++++++++
>  tools/perf/util/find-vdso-map.c          | 30 +++--------------------
>  6 files changed, 68 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>  create mode 100644 tools/perf/util/find-map.c
> 
> -- 
> 2.17.1
> 
