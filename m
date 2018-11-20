Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5172C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9813320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9813320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeKTWK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:10:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbeKTWK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:10:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4232580D;
        Tue, 20 Nov 2018 03:41:43 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 126A63F575;
        Tue, 20 Nov 2018 03:41:43 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5BF4D1AE07D8; Tue, 20 Nov 2018 11:41:58 +0000 (GMT)
Date:   Tue, 20 Nov 2018 11:41:58 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: tests: Disable breakpoint tests on ARM (32-bit)
Message-ID: <20181120114157.GA25498@arm.com>
References: <20181116225309.13938-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116225309.13938-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:53:07PM -0800, Florian Fainelli wrote:
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
>  tools/perf/tests/bp_signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index a467615c5a0e..3b5471ea2331 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -296,7 +296,7 @@ bool test__bp_signal_is_supported(void)
>   * instruction breakpoint using the perf event interface.
>   * Once it's there we can release this.
>   */
> -#if defined(__powerpc__) || defined(__s390x__)
> +#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
>  	return false;
>  #else

I'm ok with disabling the test, but the comment above this #if is all about
powerpc.

Will
