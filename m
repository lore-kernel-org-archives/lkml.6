Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AG47ELte4puHs8WTuR7oQgvAQegALbdxNgpzPSfdsaK0K2cPgLAI0zTTaihcnSwBb82qkdGSzOc2
ARC-Seal: i=1; a=rsa-sha256; t=1519992879; cv=none;
        d=google.com; s=arc-20160816;
        b=qnWhVT1MAKH9CkWkgA3DYLOOZXeyDHqt7ArEIAsUXo5+MkWRh0OWYCIzl2vTRbqsL6
         spvT+i79R/C5q3MkkHfrRuRuyZQu3E+Pbf7Bx5IVe8XiRbA7X+voAYdFBTtlj1XGQ1J/
         OMD12oN2Bpr0NNnmj700KkmaCPm+dLoUhq7v6ZnJ4BFWd+NGQk9/C1SV3higf5mqfY1e
         ZR2MN+SnBpREKsojykoefjC8dubjeBNbVj3VGk3jA82QBkbhzr+isRPLJf0sY5irqYVr
         VRn+UpqcOEuUplAtUDjvcbE/bASUs90OatP8jaATYl5qkO+R1Y+kpIA/QCPcbvpNZeh5
         pFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=9UYW1Pi1zXP5Jdvc1FaCyICkEGDcXdP31MlL+svF1mE=;
        b=ea2dSH5w0OGwDwRmRPTn2rbMO4qMy0E41ghJJENmCtNurqu+tLYQJACjluZ+NXeg00
         nj4gCbdfDrx6tCKZwcawSSYV96rHlK60aurOVTgDu6WsHchsgzLePM20oxOWY3Exe+tA
         goF9pOMedZR4dQ4FWYc/ouXcqeBpHFIVKKPK3z83enBU85g1G5RSry4Lg8avE3vpFFqr
         GDxtcj82wsqyURtCP2/wM8NcVJ7gbgU/8i5IEolm8FQme4NYYnyvj/u0oLQIRXhz2qjW
         ewb0HG1CC9cxlKPHN4EYkhgdygqnitziIK6algwEtxoofgbk9PMlUCnv520LYrWAuivV
         yZnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Fri, 2 Mar 2018 13:14:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Seunghun Han <kkamagui@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] x86: mce: fix kernel panic when check_interval is
 changed
Message-ID: <20180302121433.GC7406@pd.tnic>
References: <20180228203131.3176-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228203131.3176-1-kkamagui@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593828054049315135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 05:31:31AM +0900, Seunghun Han wrote:
> Changes since v1: add mce_sysfs_mutex according to review result.

Ok, we're getting there.

>  arch/x86/kernel/cpu/mcheck/mce.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 706584681a4c..bee0795a3b8c 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -55,6 +55,7 @@
>  #include "mce-internal.h"
>  
>  static DEFINE_MUTEX(mce_log_mutex);
> +static DEFINE_MUTEX(mce_sysfs_mutex);
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/mce.h>
> @@ -2045,8 +2046,11 @@ static void mce_enable_ce(void *all)
>  		return;
>  	cmci_reenable();
>  	cmci_recheck();
> -	if (all)
> +	if (all) {
> +		mutex_lock(&mce_sysfs_mutex);
>  		__mcheck_cpu_init_timer();
> +		mutex_unlock(&mce_sysfs_mutex);
> +	}

Instead of chasing all the places which need to grab the mutex, I was
thinking of grabbing it in all those functions which modify MCA behavior
non-trivially from sysfs. And those are:

store_int_with_restart()
set_ignore_ce()
set_cmci_disabled()

And you've done that already for store_int_with_restart() and I think
doing the same in the other two will address the issue nicely and
in the simplest way possible.

All those sysfs operations should be synchronized anyway. Please reflect
that in your commit message too.

The aspect about DOS is not really important because you need to be root
to write those so if you have root, there are gazillion ways to shoot
yourself in the foot already.

>  static struct bus_type mce_subsys = {
> @@ -2132,8 +2136,14 @@ static ssize_t store_int_with_restart(struct device *s,
>  				      struct device_attribute *attr,
>  				      const char *buf, size_t size)
>  {
> +	unsigned long old_check_interval = check_interval;
>  	ssize_t ret = device_store_int(s, attr, buf, size);
> +
> +	if (check_interval == old_check_interval)
> +		return ret;

<---- newline here.

> +	mutex_lock(&mce_sysfs_mutex);
>  	mce_restart();
> +	mutex_unlock(&mce_sysfs_mutex);

<---- newline here.

>  	return ret;
>  }
>  
> -- 
> 2.16.2

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
