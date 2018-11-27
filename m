Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5357FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9A220645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeK1G3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:29:06 -0500
Received: from foss.arm.com ([217.140.101.70]:46364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeK1G3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:29:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C75B53698;
        Tue, 27 Nov 2018 11:30:10 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9656B3F575;
        Tue, 27 Nov 2018 11:30:10 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 779371AE0A0D; Tue, 27 Nov 2018 19:30:28 +0000 (GMT)
Date:   Tue, 27 Nov 2018 19:30:28 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf: tests: Disable breakpoint tests on ARM (32-bit)
Message-ID: <20181127193028.GC5641@arm.com>
References: <20181127003126.25094-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127003126.25094-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:31:23PM -0800, Florian Fainelli wrote:
> breakpoint tests on the ARM 32-bit kernel are broken in several ways.
> 
> The breakpoint length requested does not necessarily match whether the
> function address has the Thumb bit (bit 0) set or not, and this does
> matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
> background.
> 
> [1]: https://lkml.org/lkml/2018/11/15/205
> 
> As Will indicated, the overflow handling would require single-stepping
> which is not supported at the moment. Just disable those tests for the
> ARM 32-bit platforms.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
> 
> - Fix comment above test per Will's feedback
> 
>  tools/perf/tests/bp_signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index a467615c5a0e..05bf06f84a3b 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -292,11 +292,11 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
>  bool test__bp_signal_is_supported(void)
>  {
>  /*
> - * The powerpc so far does not have support to even create
> + * powerpc, s390 and arm so far does not have support to even create
>   * instruction breakpoint using the perf event interface.
>   * Once it's there we can release this.

Sorry, Florian, but I still think this comment is bogus since you can
create instruction breakpoints via perf on arm. I think you need
something like:

	/*
	 * PowerPC and S390 do not support creation of instruction
	 * breakpoints using the perf_event interface.
	 *
	 * ARM requires explicit rounding down of the instruction
	 * pointer in Thumb mode, and then requires the single-step
	 * to be handled explicitly in the overflow handler to avoid
	 * stepping into the SIGIO handler and getting stuck on the
	 * breakpointed instruction.
	 *
	 * Just disable the test for these architectures until these
	 * issues are resolved.
	 */

Will
