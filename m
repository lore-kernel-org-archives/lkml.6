Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934435AbeCHNEE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755103AbeCHNED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:04:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A83205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 8 Mar 2018 10:03:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        timur@codeaurora.org
Subject: Re: [RFC V4] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
Message-ID: <20180308130358.GC3701@kernel.org>
References: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 03:35:47PM -0500, Agustin Vega-Frias escreveu:
> +++ b/tools/perf/util/parse-events.y
> @@ -8,6 +8,7 @@
> 
>  #define YYDEBUG 1
> 
> +#include <fnmatch.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
> @@ -234,6 +235,10 @@ PE_NAME opt_event_config
>  	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
> +		char *pattern;
> +
> +		if (asprintf(&pattern, "%s*", $1) < 0)
> +			YYABORT;

+               if (asprintf(&pattern, "?(uncore_)%s*", $1) < 0)

I completely overlook that you were using this and thus needed that
extension, duh, thanks for the patience 8-) and for the new patch.

- Arnaldo
