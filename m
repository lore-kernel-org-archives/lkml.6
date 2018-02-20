Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeBTPUA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:20:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52137 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeBTPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:19:59 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: stub out cpuidle_poll_state_init() without CONFIG_CPU_IDLE
Date: Tue, 20 Feb 2018 16:18:01 +0100
Message-ID: <2227596.UD9Rb3uRxu@aspire.rjw.lan>
In-Reply-To: <20180220150559.3182304-1-arnd@arndb.de>
References: <20180220150559.3182304-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 20, 2018 4:05:44 PM CET Arnd Bergmann wrote:
> Calling cpuidle_poll_state_init() from apm_init() results in a link
> failure since that directory is never entered without CONFIG_CPU_IDLE:
> 
> arch/x86/kernel/apm_32.o: In function `apm_init':
> apm_32.c:(.init.text+0x62c): undefined reference to `cpuidle_poll_state_init'
> 
> CONFIG_ARCH_HAS_CPU_RELAX can be set without CONFIG_CPU_IDLE but has no
> effect then, so we should treat that configuration the same as
> if CONFIG_ARCH_HAS_CPU_RELAX was not set at all.
> 
> Fixes: 34c2f65b718d ("cpuidle: Move polling state initialization code to separate file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/cpuidle.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 871f9e21810c..0b3fc229086c 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -225,7 +225,7 @@ static inline void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev,
>  }
>  #endif
>  
> -#ifdef CONFIG_ARCH_HAS_CPU_RELAX
> +#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
>  void cpuidle_poll_state_init(struct cpuidle_driver *drv);
>  #else
>  static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
> 

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm-4.16-rc2&id=d7212cfb05ba802bea4dd6c90d61cfe6366ea224

is in the Linus' tree already.

Thanks,
Rafael
