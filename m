Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934459AbeEIJt2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934097AbeEIJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:49:25 -0400
Date: Wed, 9 May 2018 11:49:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 5/7] sched: loadavg: make calc_load_n() public
Message-ID: <20180509094906.GI12217@hirez.programming.kicks-ass.net>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-6-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507210135.1823-6-hannes@cmpxchg.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 05:01:33PM -0400, Johannes Weiner wrote:
> +static inline unsigned long
> +fixed_power_int(unsigned long x, unsigned int frac_bits, unsigned int n)
> +{
> +	unsigned long result = 1UL << frac_bits;
> +
> +	if (n) {
> +		for (;;) {
> +			if (n & 1) {
> +				result *= x;
> +				result += 1UL << (frac_bits - 1);
> +				result >>= frac_bits;
> +			}
> +			n >>= 1;
> +			if (!n)
> +				break;
> +			x *= x;
> +			x += 1UL << (frac_bits - 1);
> +			x >>= frac_bits;
> +		}
> +	}
> +
> +	return result;
> +}

No real objection; but that does look a wee bit fat for an inline I
suppose.
