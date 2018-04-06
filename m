Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeDFPcA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:32:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:29885 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752831AbeDFPbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:31:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="32140299"
Date: Fri, 6 Apr 2018 08:31:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1]: perf/x86: store user space frame-pointer value on a
 sample
Message-ID: <20180406153144.GA9010@tassilo.jf.intel.com>
References: <086d45fb-a099-4ae9-2854-943447e86010@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086d45fb-a099-4ae9-2854-943447e86010@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index e47b2dbbdef3..9284048cf5b0 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -157,6 +157,15 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>  	 */
>  	regs_user_copy->bx = -1;
>  	regs_user_copy->bp = -1;
> +	if (user_64bit_mode(user_regs)) {

Why is it 64bit only? Should work on 32bit too.

-Andi

> +		/*
> +		 * Store user space frame-pointer value on sample
> +		 * to facilitate stack unwinding for cases when
> +		 * user space x86_64 executable code has such
> +		 * support enabled at compile time;
> +		 */
> +		regs_user_copy->bp = user_regs->bp;
> +	}
>  	regs_user_copy->r12 = -1;
>  	regs_user_copy->r13 = -1;
>  	regs_user_copy->r14 = -1;
