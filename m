Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeEHLNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:13:35 -0400
Received: from foss.arm.com ([217.140.101.70]:56480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeEHLNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:13:33 -0400
Date: Tue, 8 May 2018 12:13:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 4/9] arm: Split breakpoint validation into "check" and
 "commit"
Message-ID: <20180508111323.mmjo4ky4txzi4gx4@lakrids.cambridge.arm.com>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-5-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525634395-23380-5-git-send-email-frederic@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

On Sun, May 06, 2018 at 09:19:50PM +0200, Frederic Weisbecker wrote:
> The breakpoint code mixes up attribute check and commit into a single
> code entity. Therefore the validation may return an error due to
> incorrect atributes while still leaving halfway modified architecture
> breakpoint struct.
> 
> Prepare fox fixing this misdesign and separate both logics.

Could you elaborate on what the problem is? I would have expected that
when arch_build_bp_info() returns an error code, we wouldn't
subsequently use the arch_hw_breakpoint information. Where does that
happen?

I understand that there was a problem on x86 -- I'm just having
difficulty figuring it out.

I also see that the check and commit hooks have to duplicate a
reasonable amount of logic, e.g. the switch on bp->attr.type. Can we
instead refactor the existing arch_build_bp_info() hooks to use a
temporary arch_hw_breakpoint, and then struct assign it after all the
error cases, e.g.

static int arch_build_bp_info(struct perf_event *bp)
{
	struct arch_hw_breakpoint hbp;
	
	if (some_condition(bp))
		hbp->field = 0xf00;

	switch (bp->attr.type) {
	case FOO:
		return -EINVAL;
	case BAR:
		hbp->other_field = 7;
		break;
	};

	if (failure_case(foo))
		return err;
	
	*counter_arch_bp(bp) = hbp;
}

... or is that also problematic?

Thanks,
Mark.

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/arm/kernel/hw_breakpoint.c | 176 +++++++++++++++++++++++-----------------
>  1 file changed, 103 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index 629e251..1769d3a 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -515,45 +515,33 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
>  	return 0;
>  }
>  
> -/*
> - * Construct an arch_hw_breakpoint from a perf_event.
> - */
> -static int arch_build_bp_info(struct perf_event *bp)
> +static int hw_breakpoint_arch_check(struct perf_event *bp,
> +				    const struct perf_event_attr *attr)
>  {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	u32 offset, alignment_mask = 0x3;
> +
> +	/* Ensure that we are in monitor debug mode. */
> +	if (!monitor_mode_enabled())
> +		return -ENODEV;
>  
>  	/* Type */
> -	switch (bp->attr.bp_type) {
> +	switch (attr->bp_type) {
>  	case HW_BREAKPOINT_X:
> -		info->ctrl.type = ARM_BREAKPOINT_EXECUTE;
> -		break;
>  	case HW_BREAKPOINT_R:
> -		info->ctrl.type = ARM_BREAKPOINT_LOAD;
> -		break;
>  	case HW_BREAKPOINT_W:
> -		info->ctrl.type = ARM_BREAKPOINT_STORE;
> -		break;
>  	case HW_BREAKPOINT_RW:
> -		info->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
>  	/* Len */
> -	switch (bp->attr.bp_len) {
> +	switch (attr->bp_len) {
>  	case HW_BREAKPOINT_LEN_1:
> -		info->ctrl.len = ARM_BREAKPOINT_LEN_1;
> -		break;
>  	case HW_BREAKPOINT_LEN_2:
> -		info->ctrl.len = ARM_BREAKPOINT_LEN_2;
> -		break;
>  	case HW_BREAKPOINT_LEN_4:
> -		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
> -		break;
>  	case HW_BREAKPOINT_LEN_8:
> -		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
> -		if ((info->ctrl.type != ARM_BREAKPOINT_EXECUTE)
> +		if ((attr->bp_type != HW_BREAKPOINT_X)
>  			&& max_watchpoint_len >= 8)
>  			break;
>  	default:
> @@ -566,50 +554,17 @@ static int arch_build_bp_info(struct perf_event *bp)
>  	 * by the hardware and must be aligned to the appropriate number of
>  	 * bytes.
>  	 */
> -	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE &&
> -	    info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
> -	    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
> +	if (attr->bp_type == HW_BREAKPOINT_X &&
> +	    attr->bp_len != HW_BREAKPOINT_LEN_2 &&
> +	    attr->bp_len != HW_BREAKPOINT_LEN_4)
>  		return -EINVAL;
>  
> -	/* Address */
> -	info->address = bp->attr.bp_addr;
> -
> -	/* Privilege */
> -	info->ctrl.privilege = ARM_BREAKPOINT_USER;
> -	if (arch_check_bp_in_kernelspace(bp))
> -		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
> -
> -	/* Enabled? */
> -	info->ctrl.enabled = !bp->attr.disabled;
> -
> -	/* Mismatch */
> -	info->ctrl.mismatch = 0;
> -
> -	return 0;
> -}
> -
> -/*
> - * Validate the arch-specific HW Breakpoint register settings.
> - */
> -int arch_validate_hwbkpt_settings(struct perf_event *bp)
> -{
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	int ret = 0;
> -	u32 offset, alignment_mask = 0x3;
> -
> -	/* Ensure that we are in monitor debug mode. */
> -	if (!monitor_mode_enabled())
> -		return -ENODEV;
> -
> -	/* Build the arch_hw_breakpoint. */
> -	ret = arch_build_bp_info(bp);
> -	if (ret)
> -		goto out;
> -
>  	/* Check address alignment. */
> -	if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
> +	if (attr->bp_len == HW_BREAKPOINT_LEN_8)
>  		alignment_mask = 0x7;
> -	offset = info->address & alignment_mask;
> +
> +	offset = attr->bp_addr & alignment_mask;
> +
>  	switch (offset) {
>  	case 0:
>  		/* Aligned */
> @@ -617,20 +572,16 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
>  	case 1:
>  	case 2:
>  		/* Allow halfword watchpoints and breakpoints. */
> -		if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
> +		if (attr->bp_len == HW_BREAKPOINT_LEN_2)
>  			break;
>  	case 3:
>  		/* Allow single byte watchpoint. */
> -		if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
> +		if (attr->bp_len == HW_BREAKPOINT_LEN_1)
>  			break;
>  	default:
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
> -	info->address &= ~alignment_mask;
> -	info->ctrl.len <<= offset;
> -
>  	if (is_default_overflow_handler(bp)) {
>  		/*
>  		 * Mismatch breakpoints are required for single-stepping
> @@ -655,13 +606,92 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
>  		 * reports them.
>  		 */
>  		if (!debug_exception_updates_fsr() &&
> -		    (info->ctrl.type == ARM_BREAKPOINT_LOAD ||
> -		     info->ctrl.type == ARM_BREAKPOINT_STORE))
> +		    (attr->bp_type == HW_BREAKPOINT_R ||
> +		     attr->bp_type == HW_BREAKPOINT_W))
>  			return -EINVAL;
>  	}
>  
> -out:
> -	return ret;
> +	return 0;
> +}
> +
> +static void hw_breakpoint_arch_commit(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	struct perf_event_attr *attr = &bp->attr;
> +	u32 offset, alignment_mask = 0x3;
> +
> +	/* Type */
> +	switch (attr->bp_type) {
> +	case HW_BREAKPOINT_X:
> +		info->ctrl.type = ARM_BREAKPOINT_EXECUTE;
> +		break;
> +	case HW_BREAKPOINT_R:
> +		info->ctrl.type = ARM_BREAKPOINT_LOAD;
> +		break;
> +	case HW_BREAKPOINT_W:
> +		info->ctrl.type = ARM_BREAKPOINT_STORE;
> +		break;
> +	case HW_BREAKPOINT_RW:
> +		info->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +
> +	/* Len */
> +	switch (attr->bp_len) {
> +	case HW_BREAKPOINT_LEN_1:
> +		info->ctrl.len = ARM_BREAKPOINT_LEN_1;
> +		break;
> +	case HW_BREAKPOINT_LEN_2:
> +		info->ctrl.len = ARM_BREAKPOINT_LEN_2;
> +		break;
> +	case HW_BREAKPOINT_LEN_4:
> +		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
> +		break;
> +	case HW_BREAKPOINT_LEN_8:
> +		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +
> +	/* Address */
> +	info->address = attr->bp_addr;
> +
> +	/* Privilege */
> +	info->ctrl.privilege = ARM_BREAKPOINT_USER;
> +	if (arch_check_bp_in_kernelspace(bp))
> +		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
> +
> +	/* Enabled? */
> +	info->ctrl.enabled = !attr->disabled;
> +
> +	/* Mismatch */
> +	info->ctrl.mismatch = 0;
> +
> +	if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
> +		alignment_mask = 0x7;
> +
> +	offset = info->address & alignment_mask;
> +	info->address &= ~alignment_mask;
> +	info->ctrl.len <<= offset;
> +}
> +
> +/*
> + * Validate the arch-specific HW Breakpoint register settings.
> + */
> +int arch_validate_hwbkpt_settings(struct perf_event *bp)
> +{
> +	int err;
> +
> +	err = hw_breakpoint_arch_check(bp, &bp->attr);
> +	if (err)
> +		return err;
> +
> +	hw_breakpoint_arch_commit(bp);
> +
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.7.4
> 
