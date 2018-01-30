Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeA3Js4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:48:56 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33683 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeA3Jsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:48:45 -0500
X-Google-Smtp-Source: AH8x2250jpEZ9IwoXgG6p4Pb5IfrrDcFPjLAvQG+0Ubr7r4R20ZAarG3HkeZYfiv8f0ufyG9sMQGaQ==
Date: Tue, 30 Jan 2018 09:48:41 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: jason.wessel@windriver.com, mingo@kernel.org, arnd@arndb.de,
        broonie@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: use ktime_get_mono_fast_ns() instead of
 ktime_get_ts()
Message-ID: <20180130094841.x47uqbb5co3pe5zi@oak.lan>
References: <3f15868475cb4b32353885ee03c983209279fa81.1517192387.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f15868475cb4b32353885ee03c983209279fa81.1517192387.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 10:22:51AM +0800, Baolin Wang wrote:
> The kdb code will print the monotonic time by ktime_get_ts(), but
> the ktime_get_ts() will be protected by a sequence lock, that will
> introduce one deadlock risk if the lock was already held in the
> context from which we entered the debugger.
> 
> Thus we can use the ktime_get_mono_fast_ns() to get the monotonic
> time, which is NMI safe access to clock monotonic. Moreover we can
> remove the 'struct timespec', which is not y2038 safe.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes since v1:
>  - Use ktime_get_mono_fast_ns() instead of ktime_get_seconds().
> ---
>  kernel/debug/kdb/kdb_main.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 69e70f4..bf1d0e0 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2486,10 +2486,10 @@ static int kdb_kill(int argc, const char **argv)
>   */
>  static void kdb_sysinfo(struct sysinfo *val)
>  {
> -	struct timespec uptime;
> -	ktime_get_ts(&uptime);
> +	u64 uptime = ktime_get_mono_fast_ns();
> +
>  	memset(val, 0, sizeof(*val));
> -	val->uptime = uptime.tv_sec;
> +	val->uptime = div_u64(uptime, NSEC_PER_SEC);
>  	val->loads[0] = avenrun[0];
>  	val->loads[1] = avenrun[1];
>  	val->loads[2] = avenrun[2];
> -- 
> 1.7.9.5
> 
