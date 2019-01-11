Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADBA2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547172665;
	bh=fYVZuXIDpw7cfbcY6Adp9hw77SJtD2Wjf8YPK6E3XCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BmzflhpQ5mCKeO/aB3v6pfJ1H54Cq+L/ZjxeVEBX43tcjGUqLe5+SB/XkBRaNrEm4
	 9bq5iGmmVG9xT0t6NJXbmc/OhRGFkmR+mqumrTk1Hf94HI42hYH55aWt3sKUQmWDNc
	 rLTyMAQbRUl9JDx0YF20ouSY+vqTa+4UEBxo/5LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfAKCLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:11:04 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:60755 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728083AbfAKCLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:11:04 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 11 Jan 2019 11:11:02 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 11 Jan 2019 11:11:01 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 11 Jan 2019 11:11:01 +0900
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
Message-ID: <20190111021101.GA625@sejong>
References: <20181221034337.26663-1-f.fainelli@gmail.com>
 <20181227105539.GA4521@sejong>
 <27ac27b2-c373-2831-e7ce-4e898365d517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27ac27b2-c373-2831-e7ce-4e898365d517@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for being so late.

On Thu, Dec 27, 2018 at 05:35:17PM -0800, Florian Fainelli wrote:
> Le 12/27/18 à 2:55 AM, Namhyung Kim a écrit :
> > Hello,
> > 
> > On Thu, Dec 20, 2018 at 07:43:35PM -0800, Florian Fainelli wrote:
> >> Hi all,
> >>
> >> I just painfully learned that perf would segfault when
> >> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
> > 
> > Could you please elaborate?
> 
> Sure, I was debugging why perf was segfaulting on my systems and saw
> that the faulting address was within 0xffff_0000 (high vectors); and
> because CONFIG_KUSER_HELPERS was not enabled, nothing was mapped at that
> address so this was a legitimate crash. This was on a variety of ARMv7A
> systems, Cortex-A9, Cortex-A5 etc.
> 
> Later on, I found that in tools/arch/arm/include/asm/barrier.h the
> barriers are unconditionally defined to make use of the [vectors] page
> that the ARM kernel only sets up when CONFIG_KUSER_HELPERS is enabled
> and this is the reason for the crash.
> 
> Testing for the page itself is pretty harmless if you think we should
> make something more robust around checking for HAVE_AUXTRACE_SUPPORT
> (which appears to be the specific location making use of barriers), let
> me know.

Thanks for the explanation.

Is there anything we can do instead if CONFIG_KUSER_HELPERS is not
defined?

I think it'd be better making the barriers into functions (probably
with "static inline") and configurable depending on a result of
runtime checking of the availability (like you did).

The init routine of the auxtrace (or other future users of barriers)
should call an arch-specific function to check the availability then.

Thanks,
Namhyung
