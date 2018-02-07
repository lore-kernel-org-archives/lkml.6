Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AH8x226rxuIR4ySmVp511ZzaEXYcO8Qz3Lc67Ij6jvigEZ92MB45rR8Kgd75ebJF419Y+b6PsLP3
ARC-Seal: i=1; a=rsa-sha256; t=1518027194; cv=none;
        d=google.com; s=arc-20160816;
        b=Vgldk4I4Hxnv+aBT04rAYcHCC3m78USYZR3TDOU0MzcnVTsvhB7WUUg4WlZN5GQT25
         jaB7tldub7k/1zLubZ9wvlfXk0LCqDotytVqZnxcemhRiQDzNSs7QStRTlb1SoXf9lvu
         C7VPFkil+8yzfQXeMF0xq6etae4epK9dpe3JtCs6ieiHXIb8tvdSO0z6/rwCM8Yshowu
         RQeZ248jVhub7S7S4/l6ylWjbwKg9XG60qQ9xCv/M3dMJu6w0y83Q8+g388fFhN0/OaV
         Ll01U69MyQF932AnaEOGkBdApMM3/B9buSXyKMg7uREy3aDun4BADKFqrbvrEBoFV5Gi
         g6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LcT6kqsJpw6EbjkLkiuxb+8mEFlenUqJjcM+IgMN+pg=;
        b=TRBAYA7GaX3HBwBdzDVXt/Fc8IxNhe5kzYoyHiaS8eegErYBUHQ2dpUk6qjFoc6yo0
         mbG9XMgdfbYaAm1CKrDn8DBrUYDwccEMe7wJTreXZw5su4JGslFyCIGvgWCQYbEjwbcm
         jKjxRjpxXjhH83toTZWXg3AqJ4eYCkAzN+7LRwE8oP7vZS6CWbxbTFYEHfZy8AAO/DUe
         C0CN1vNGHQ29uj5Dc5PCuJfcZhuv0wIbNKzarDxSwnROCPSnMVxzr7Uj1Cv70NJiOo52
         /O7GKq834ra4msLwiz8BErfAoeWlBCt3cZArgV7S2SWdPUxH6eR0a8lCY4QsTthAUpgF
         c4oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Wed, 7 Feb 2018 19:12:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rolf Neugebauer <rolf.neugebauer@docker.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
Message-ID: <20180207181254.GC8698@pd.tnic>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
 <20180207143428.GA31944@kroah.com>
 <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591766882831880529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 04:31:59PM +0000, Rolf Neugebauer wrote:
>  arch/x86/kernel/cpu/microcode/core.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c
> b/arch/x86/kernel/cpu/microcode/core.c
> index b3e94ef461fd..1b3e0aa4c511 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -44,7 +44,7 @@
> 
>  static struct microcode_ops    *microcode_ops;
> 
> -static bool dis_ucode_ldr;
> +static bool dis_ucode_ldr = true;
> 
>  static int __init disable_loader(char *str)
>  {
> @@ -81,6 +81,7 @@ struct cpu_info_ctx {
> 
>  static bool __init check_loader_disabled_bsp(void)
>  {
> +       u32 a, b, c, d;
>  #ifdef CONFIG_X86_32
>         const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
>         const char *opt     = "dis_ucode_ldr";
> @@ -93,8 +94,23 @@ static bool __init check_loader_disabled_bsp(void)
>         bool *res = &dis_ucode_ldr;
>  #endif
> 
> -       if (cmdline_find_option_bool(cmdline, option))
> -               *res = true;
> +       if (!have_cpuid_p())
> +               return *res;

That might cause an issue, see 1f161f67a272c. Might wanna backport that
commit too, just in case, for those old CPUID-less geodes.

The rest looks ok.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
