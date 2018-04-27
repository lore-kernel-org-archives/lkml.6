Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759265AbeD0U43 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:56:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758944AbeD0U42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:56:28 -0400
Date: Fri, 27 Apr 2018 22:56:22 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, y2038@lists.linaro.org,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        jailhouse-dev@googlegroups.com, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH] [v3] x86: Convert x86_platform_ops to timespec64
Message-ID: <20180427205621.GE23874@flask>
References: <20180427201435.3194219-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427201435.3194219-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-27 22:13+0200, Arnd Bergmann:
> The x86 platform operations are fairly isolated, so we can
> change them from using timespec to timespec64. I checked that
> All the users and callers are safe, and there is only one
> critical function that is broken beyond 2106:
> 
> pvclock_read_wallclock() uses a 32-bit number of seconds since
> the epoch to communicate the boot time between host and guest
> in a virtual environment. This will work until 2106, but we
> should ideally find a replacement anyway. I've added a comment
> about it there.
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2 changes:
> - move comment block (Boris)
> - remove unnecessary type cast (Boris)
> - fix format string (0day bot)
> - fix include order (0day bot)
> 
> v3 changes:
> - add jailhouse specific change
> - avoid include file header by relying on another
>   patch ("timekeeping: Remove timespec64 hack")
> 
> Not sure how we want to merge this (assuming the last modification
> worked, this has seen little testing). The "timekeeping: Remove
> timespec64 hack" patch should go through the timekeeping branch
> in tip, while this one is for x86. I assume the linux-tip maintainers
> can come up with a plan.
> ---
> diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
> @@ -12,7 +12,7 @@ void pvclock_set_flags(u8 flags);
>  unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src);
>  void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
>  			    struct pvclock_vcpu_time_info *vcpu,
> -			    struct timespec *ts);
> +			    struct timespec64 *ts);
>  void pvclock_resume(void);
>  
>  void pvclock_touch_watchdogs(void);
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> @@ -53,7 +53,7 @@ static struct pvclock_wall_clock *wall_clock;
>   * have elapsed since the hypervisor wrote the data. So we try to account for
>   * that with system time
>   */
> -static void kvm_get_wallclock(struct timespec *now)
> +static void kvm_get_wallclock(struct timespec64 *now)
>  {
>  	struct pvclock_vcpu_time_info *vcpu_time;
>  	int low, high;
> @@ -72,7 +72,7 @@ static void kvm_get_wallclock(struct timespec *now)
>  	put_cpu();
>  }
>  
> -static int kvm_set_wallclock(const struct timespec *now)
> +static int kvm_set_wallclock(const struct timespec64 *now)
>  {
>  	return -ENODEV;
>  }
> diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
> @@ -123,28 +123,35 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
>  
>  void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
>  			    struct pvclock_vcpu_time_info *vcpu_time,
> -			    struct timespec *ts)
> +			    struct timespec64 *ts)
>  {
>  	u32 version;
>  	u64 delta;
> -	struct timespec now;
> +	struct timespec64 now;
>  
>  	/* get wallclock at system boot */
>  	do {
>  		version = wall_clock->version;
>  		rmb();		/* fetch version before time */
> +		/*
> +		 * Note: wall_clock->sec is a u32 value, so it can
> +		 * only store dates between 1970 and 2106. To allow
> +		 * times beyond that, we need to create a new hypercall
> +		 * interface with an extended pvclock_wall_clock structure
> +		 * like ARM has.
> +		 */

(Modern TSC extensions stripped pvclock of all advantages, so we'll
 likely abandon pvclock by then.)

>  		now.tv_sec  = wall_clock->sec;
>  		now.tv_nsec = wall_clock->nsec;
>  		rmb();		/* fetch time before checking version */
>  	} while ((wall_clock->version & 1) || (version != wall_clock->version));
>  
>  	delta = pvclock_clocksource_read(vcpu_time);	/* time since system boot */
> -	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
> +	delta += now.tv_sec * NSEC_PER_SEC + now.tv_nsec;
>  
>  	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
>  	now.tv_sec = delta;
>  
> -	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
> +	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
>  }
>  
>  void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)

kvmclock and pvclock changes

Acked-by: Radim Krčmář <rkrcmar@redhat.com>
