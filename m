Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F77C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BC020850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BC020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeH2Rqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:46:48 -0400
Received: from foss.arm.com ([217.140.101.70]:55008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbeH2Rqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:46:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FED380D;
        Wed, 29 Aug 2018 06:49:45 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A011E3F721;
        Wed, 29 Aug 2018 06:49:44 -0700 (PDT)
Date:   Wed, 29 Aug 2018 08:49:43 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Robert Walker <robert.walker@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, <mike.leach@linaro.org>,
        Kim Phillips <Kim.Phillips@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
Message-Id: <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
In-Reply-To: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
References: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 10:44:23 +0100
Robert Walker <robert.walker@arm.com> wrote:

> This patch adds support for generating instruction samples from trace of
> AArch32 programs using the A32 and T32 instruction sets.
> 
> T32 has variable 2 or 4 byte instruction size, so the conversion between
> addresses and instruction counts requires extra information from the trace
> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
> member has been added to the feature check for OpenCSD.
> 
> Signed-off-by: Robert Walker <robert.walker@arm.com>
> ---
...
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -3,6 +3,13 @@
>  
>  int main(void)
>  {
> +	/*
> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
> +	 * OpenCSD 0.9

0.9 != 0.9.1 in the above commit text: which is it?

> +	 */
> +	ocsd_generic_trace_elem elem;
> +	(void)elem.num_instr_range;
> +

This breaks building against older versions of OpenCSD, right?

>  	(void)ocsd_get_version();

Why don't we maintain building against older versions of the library,
and use the version information to make the decision on whether to use
the new feature being introduced in this patch?

Thanks,

Kim
