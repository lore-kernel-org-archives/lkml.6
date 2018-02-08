Return-Path: <rolf.neugebauer@docker.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518098149; cv=none;
        d=google.com; s=arc-20160816;
        b=cbzdNaZu8sh9SUnRuzUH1O6DJvRG97q52QNAu7OXawQlryrKRpVbDliGYIaFcqgfi1
         IrOsL3zesi4AnYtOlBGrwhpebJvxGcPbd9RofYrbMYUsCLBNTvIpPFPF53ucIeaqJzPo
         Ny3RCbGT/qnC70auwpFKq/lyE25cEIT95CiW+ooxb7NYtf0U6BN9BKvJZB2QnkwqWuVX
         PD6+y5ZcPGBm5IQEw1Xn+NdL57S9BC/mtAZ4m0Wh+EsUAWWeOUxbNtphZd457qtYECVd
         w9YeofVjVOTnwcdLdy8mveyNGbp0O+rp9ePiwA4BXpNysLGmF1EBbYoNte/mUc+/i0WW
         hbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bIkWLUFWgD3BesJtlkwwrzFaSuvehuPadCxRfVqvDmc=;
        b=lQAOmb6S39bhjGGNA6sgiek4B2YC1W4ObTQFoVoKCsJLr6SBs25YHeU0qCPl5gHkk4
         aFt1oNYGQ0tVYyQYS5MxdV9PrC6PKHwRVEhTP7hkhhUIcUegBbF65zgjLqe4B+zs0RLi
         vGCMRvXFtxe9gaA/inDtptF90Im7018gSxbWsG9P0e40fW65O7/Jo2HGsb888bOuauA0
         tz0DfF9IDFjgOB1Ed473r/2fVK6pJjas75/0unvtU9HP3RHVP4mdKgvuOSl+ua55EH2t
         yM42/m/fbw5aO5Vjdo7DcfUlB809dDIAjEeOz2vpPcFof5I0BhntkRxFMurZdobZkhJ+
         bQCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=GvhQ+SuF;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=GvhQ+SuF;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
X-Google-Smtp-Source: AH8x224S677XevmhGYZBTyTJ1tV6oIpU3n63Ugaib9YFe4ryJBNYYEErcWBJooik715fJbNELapVV1Z/F3cpVWOPtNI=
MIME-Version: 1.0
In-Reply-To: <20180207181254.GC8698@pd.tnic>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic> <20180207143428.GA31944@kroah.com>
 <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com> <20180207181254.GC8698@pd.tnic>
From: Rolf Neugebauer <rolf.neugebauer@docker.com>
Date: Thu, 8 Feb 2018 13:55:48 +0000
Message-ID: <CA+pO-2e=nZJeAR2j8Pukb=E4aHgvDXc9Tw4poatrUcD15Wi1Jg@mail.gmail.com>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
To: Borislav Petkov <bp@alien8.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591841284970379266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 6:12 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Feb 07, 2018 at 04:31:59PM +0000, Rolf Neugebauer wrote:
>>  arch/x86/kernel/cpu/microcode/core.c | 28 +++++++++++++++++++---------
>>  1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/microcode/core.c
>> b/arch/x86/kernel/cpu/microcode/core.c
>> index b3e94ef461fd..1b3e0aa4c511 100644
>> --- a/arch/x86/kernel/cpu/microcode/core.c
>> +++ b/arch/x86/kernel/cpu/microcode/core.c
>> @@ -44,7 +44,7 @@
>>
>>  static struct microcode_ops    *microcode_ops;
>>
>> -static bool dis_ucode_ldr;
>> +static bool dis_ucode_ldr = true;
>>
>>  static int __init disable_loader(char *str)
>>  {
>> @@ -81,6 +81,7 @@ struct cpu_info_ctx {
>>
>>  static bool __init check_loader_disabled_bsp(void)
>>  {
>> +       u32 a, b, c, d;
>>  #ifdef CONFIG_X86_32
>>         const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
>>         const char *opt     = "dis_ucode_ldr";
>> @@ -93,8 +94,23 @@ static bool __init check_loader_disabled_bsp(void)
>>         bool *res = &dis_ucode_ldr;
>>  #endif
>>
>> -       if (cmdline_find_option_bool(cmdline, option))
>> -               *res = true;
>> +       if (!have_cpuid_p())
>> +               return *res;
>
> That might cause an issue, see 1f161f67a272c. Might wanna backport that
> commit too, just in case, for those old CPUID-less geodes.

On the 4.4 kernel, 1f161f67a272c ("x86/microcode: Do the family check
first") does not apply cleanly. Looks like it relies on 309aac77768c0
("x86/microcode: Decrease CPUID use") and 7a93a40be23e5
("x86/microcode: Remove local vendor variable") as well. These don't
apply cleanly either.

Should I just manually backport the functionality of 1f161f67a272c?

Rolf

>
> The rest looks ok.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
