Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48BANJiIlg76oIsYJsCPguvdWxGZAFppBzKJuHBciwpRpI5wMm2HZKecOuNmubq8WYT72gA
ARC-Seal: i=1; a=rsa-sha256; t=1524733928; cv=none;
        d=google.com; s=arc-20160816;
        b=nFV/9WToKQfbhvwHy9HvtQL+oGPYlUYz8UcGN3vsbYF9aVWFDbTaVlN3BoC1u+7ZFv
         8uErHsYiA4w4qvrm+sc8YHoGwEY/WUYsVPYII9BNj9tyhyS691wDPD41nqMXw3E+3C3c
         hhR1BZl7M8A2os1CyMyoIuwBEGIblNgO4ZbjWhdD+8PbKjAurP/zxt6+jjwjGZDrYzIW
         G8w9sKwc1AZS+s2KSt0udhv+uXjn6ufSrGVqE2kEMmHW3Y1+oADspiVtDW4l6ZFjG+n4
         sJdEK+KUGmzM+mYaMsh3T6pEJib7ZLFCrSiTYAbu9uMUEUdeOEsDWITxuyTkA0mgDS/o
         osYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=xhfIN79S4FoN1NLpvkLyHxoAN8OZWkxXy23J6J9k5DQ=;
        b=jf/fTobEMVOhZtDTqDPuz7Ed5lbFGkuL+sDHTr9GmVoDCc8W2JgaR/8lnO//TJ8ZpI
         ZFGa1lJq1cJeFurjmiaB8zRXxTlQZfOrr2Fo9c5mkFAPOFtIrTnMi04GToMB52jUYrDB
         FpM8iMKcttB9ibKs4XMbXc2zNfEgKA/CMJWeZVinQKrLPtc2GA3v0NFw1QcUggIvNMQL
         Xhvl+e8A00AbwqY94XHuDQoJExrg97Fsr5r2KI7cHdR8sEE1N2JY1w9ELv729/aRsqhB
         //+3zt1xxf6uAzF7q84wztrbD+yWdg84usSY4m/zfQ1BvEMFc5sEjRhijdWThpub5Pqh
         rijA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 26 Apr 2018 11:11:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Wang <davidwang@zhaoxin.com>
cc: mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
    x86@kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
    cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
    lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH v2] x86/centaur: report correct CPU/cache topology
In-Reply-To: <1524646110-4808-1-git-send-email-davidwang@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1804261059080.1584@nanos.tec.linutronix.de>
References: <1524646110-4808-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598707331736594259?=
X-GMAIL-MSGID: =?utf-8?q?1598799404437943058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, David Wang wrote:
>  
> +static void early_init_centaur_mc(struct cpuinfo_x86 *c)
> +{
> +#ifdef CONFIG_SMP
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	if (c->cpuid_level < 4)
> +		return;
> +
> +	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
> +	if (eax & 0x1f)
> +		c->x86_max_cores = (eax >> 26) + 1;
> +	else
> +		return;
> +#endif
> +}

My review comment from last time still stands:

> > This is a bad copy of intel_num_cpu_cores(). See for the subtle
> > difference. Please rename the intel function and move it to common.c

In other words:

Make a patch which moves intel_num_cpu_cores() into common.c. Rename the
function into something like detect_num_cpu_cores() and fix up the call
site in intel.c.

Then add your patch and use the very same function.

> +
>  static void early_init_centaur(struct cpuinfo_x86 *c)
>  {
> +	early_init_centaur_mc(c);
>  	switch (c->x86) {
>  #ifdef CONFIG_X86_32
>  	case 5:
> @@ -146,6 +163,7 @@ static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
>  
>  static void init_centaur(struct cpuinfo_x86 *c)
>  {
> +	unsigned int l2 = 0;
>  #ifdef CONFIG_X86_32
>  	char *name;
>  	u32  fcr_set = 0;
> @@ -161,6 +179,17 @@ static void init_centaur(struct cpuinfo_x86 *c)
>  #endif
>  	early_init_centaur(c);
>  
> +	l2 = init_intel_cacheinfo(c);
> +
> +	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
> +	if (l2 == 0) {
> +		cpu_detect_cache_sizes(c);
> +	}

Aside of the pointless parentheses, this really wants to be cleaned up as
well.

init_intel_cacheinfo() is called from the intel init code and it does the
same silly thing.

So the right thing to do is in a separate patch first

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -679,12 +679,6 @@ static void init_intel(struct cpuinfo_x8
 
 	l2 = init_intel_cacheinfo(c);
 
-	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
-	if (l2 == 0) {
-		cpu_detect_cache_sizes(c);
-		l2 = c->x86_cache_size;
-	}
-
 	if (c->cpuid_level > 9) {
 		unsigned eax = cpuid_eax(10);
 		/* Check for version and the number of counters */
--- a/arch/x86/kernel/cpu/intel_cacheinfo.c
+++ b/arch/x86/kernel/cpu/intel_cacheinfo.c
@@ -802,6 +802,11 @@ unsigned int init_intel_cacheinfo(struct
 
 	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 
+	/* Detect legacy cache sizes if the above did not work */
+	if (!l2) {
+		cpu_detect_cache_sizes(c);
+		l2 = c->x86_cache_size;
+	}
 	return l2;
 }
 
Hmm?

	tglx
