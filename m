Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AH8x227L19ePt2cctIQWTJgljcvuzGSdROAO2SK6eQ2cesq4RkfOsVjMqxPUlxpuy6GmEVS7IxVO
ARC-Seal: i=1; a=rsa-sha256; t=1518119545; cv=none;
        d=google.com; s=arc-20160816;
        b=d2qCjsaqEjte8y/vewMMyipkG2m41+YJQwVvzNQQzzb2hTysmd/O8z9LJiI+xZ8Lgv
         vg3WTFG+4J9vpxJEhkruidaxw8TiQ9It0cGkAWXr6qpvOIfxFnkC5Bk+isKXMzsZ4dB9
         B+EKwVCHeC80VwrFoJIop27b8okffdnDq5FzYJQMFIR6b5GvU13hS2ngQstft/JG8rs8
         EOW4mUcIAx+RbscW4xxXg9fLm6z0BtatXAyfUwNjg3wI3eVjCR05EpZ9ZZfEnxRNkErS
         /IUEkGw3bCYXFy9WK2zRyI+fIx682Tc4oXOugQ0/7TaijDcIzvTw5VmKmkSDasaDPmDu
         uf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JUfDU45YX/Ddn3z4TQyQ7aEln+P4N3QQG4HyBgxZofM=;
        b=0ycOllCE5r1pCS9ap8/ARKMRYZymSmCNME4aKhRjQP6eGTfSl1G42CplfHoAPA4ENg
         JSQJ3MvqOYGR4kTK8SmuJeF5dnDJR0JvsUHTJ5uezE7RcOM18o4gAnvQfFvFSahoOvft
         XMfUGib/ujMuaQfexXYT2DpP0AgHSN8Yy1CV3p6reqsInOWhlkksKQqrE2n7mXqqwDCg
         tDyg3IQnb8+iZVSNO7ZSMCV4k+j9FnVCnFFvyomX7cgxaQoFuwjWkEZ/qFqPR8QHoo3J
         YcDVl0ygW7vnpIrEUgi9BH0wiVrrJL4Lay6Do4jjj80v1A/PaHDM8Jk22THCAJR11RUU
         EDFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Thu, 8 Feb 2018 20:52:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Check if any new features are present
 after a microcode reload.
Message-ID: <20180208195204.GE577@pd.tnic>
References: <1518115986-158190-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518115986-158190-1-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591859989696630713?=
X-GMAIL-MSGID: =?utf-8?q?1591863720984887201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 10:53:06AM -0800, Ashok Raj wrote:
> When microcode is loaded later after system boot, new microcode could enumerate
> new features. It might not be possible to use these new features unless they are
> loaded during early boot via initrd or from the BIOS in some cases.
> 
> This patch attempts to simply check if there are any differences in feature set
> and warns user to use early microcode load before using the new features.
> 
> Suggested-by: Andi Kleen <andi.kleen@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index f7c55b0..0e07035 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -39,6 +39,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/setup.h>
>  #include <asm/msr.h>
> +#include "../kernel/cpu/cpu.h" /* get_cpu_cap() */
>  
>  static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
>  
> @@ -776,7 +777,7 @@ static int apply_microcode_intel(int cpu)
>  {
>  	struct microcode_intel *mc;
>  	struct ucode_cpu_info *uci;
> -	struct cpuinfo_x86 *c;
> +	struct cpuinfo_x86 *c, new_cpuinfo;
>  	static int prev_rev;
>  	u32 rev;
>  
> @@ -804,17 +805,23 @@ static int apply_microcode_intel(int cpu)
>  		return -1;
>  	}
>  
> +	c = &cpu_data(cpu);
>  	if (rev != prev_rev) {
>  		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
>  			rev,
>  			mc->hdr.date & 0xffff,
>  			mc->hdr.date >> 24,
>  			(mc->hdr.date >> 16) & 0xff);
> +		memset(&new_cpuinfo, 0, sizeof (struct cpuinfo_x86));
> +		get_cpu_cap(&new_cpuinfo);
> +		if (memcmp(&c->x86_capability, &new_cpuinfo.x86_capability,
> +			sizeof(new_cpuinfo.x86_capability))) {
> +				pr_warn_once("New features found in loaded microcode, but will be ignored\n");
> +				pr_warn_once("Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
> +		}

A bunch of notes about this:

1. this checking happens per-CPU. Instead, it should happen per CPU
until the first CPU which encounters a CPUID bit change, prints the
warning and then doesn't do it anymore. I'm going to also heavily
assume this will happen immediately on the BSP and we simply forget all
heterogeneous BSP/AP configurations which are simply bollocks.

2. the part until memcmp() needs to be a generic function in
cpu/common.c or so which gets called by the microcode loader. This will
facilitate doing 1. too.

3. (2) needs to happen in the generic microcode driver -
arch/x86/kernel/cpu/microcode/core.c - not in intel.c For that to
happen, you need a prepatch which changes the ->apply_microcode()
functions to return a new value UCODE_UPDATED when the late update
succeeds in the vendor driver.

In the UCODE_UPDATED case, you call the common.c function which checks
whether it has ran already and if not, gets caps, checks and prints. If
it has, you don't need to do anything.

And those three changes sound like three nicely separated patches to me.

Anyway, something along those lines...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
