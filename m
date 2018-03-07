Return-Path: <kernel-hardening-return-12206-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELska+Va5bQ4gyx/LDL3vA5bItaPQVyIiNrObeJPBvLMTOvooW4G28sW3xLtg1mYiQb9cUeY
ARC-Seal: i=1; a=rsa-sha256; t=1520450528; cv=none;
        d=google.com; s=arc-20160816;
        b=KE7P2g9XS7Bifn5LO2Qr6SrjqHsJQ9SND3tO36gEeXdwePJdJ5YMIvU2OjWjQi7seF
         fS6geGIzjXY7f4cpjYE4JHRDvcjogRQWTM+Xt25SZ5X0Fq7R135oBl9s2IaXeGQur54y
         roWF9CAPUKErN0l345YwemQoHsAS4ekM6tobnf7XgwZJjTQumJ3+yUN8tGhCFkPzdIao
         OdqWxnYwYweKC7o9izrR83Tok+Unt1aSE4UA+DceIG/fteDB/aRWBmZLYu8882saW0Hm
         tSRpUX4PrJHBWiciwmSh+ryHvrR/nEZ7vUyK7M/oohtVNjQG95rclAxwpjKRLefXNMZQ
         GVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=KyBkMmg641XWHMt4gszApjx9HR8i1NAp4sXefMF99h4=;
        b=oPT1T9nisK5phnSnoLyJaskUkoEu5riNvrUgwWs0c+/MQA10WUGpDyXhsQ88+emMXm
         FlispzNJaVnD2IrRx9zQiR2Ng04uLSIwCWnfWVrzZ1DcKZTqH8OoUfwQ7tFSm8jICGRF
         zAOnFKxRmRT+xL2bop7YhO3Fi6ldBUHhiANi50tFJchjo8fXIHBgacF4zI8HFhRGnSaI
         VTgCODKpekKlWhZL36tfc8aE0zmyFbKmtpf9uNqGGKWx/JjAtP1b5Ur4sDz6ffHTWlg/
         rtw5j/X6JRMEmwk806a2OizkO6JzPsEv4YP2zS0+JUNyRG27Jw6Bz88j5E11EzY3pDAF
         WNmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vMKHbuHB;
       dkim=pass header.i=@chromium.org header.s=google header.b=EWofWe6l;
       spf=pass (google.com: domain of kernel-hardening-return-12206-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12206-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vMKHbuHB;
       dkim=pass header.i=@chromium.org header.s=google header.b=EWofWe6l;
       spf=pass (google.com: domain of kernel-hardening-return-12206-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12206-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
References: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 11:21:46 -0800
X-Google-Sender-Auth: yOgxfo1EiPWzCl00jJKIClv3bxU
Message-ID: <CAGXu5jKOQPNuXR5At7984FSMHHrT7G6z7Tx5SdfP+62WON7JNA@mail.gmail.com>
Subject: Re: [PATCH] x86/vsyscall/64: Drop "native" vsyscalls
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bp@alien8.de>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594307354733708248?=
X-GMAIL-MSGID: =?utf-8?q?1594307933070082650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 11:12 AM, Andy Lutomirski <luto@kernel.org> wrote:
> Since Linux 3.2, vsyscalls have been deprecated and slow.  From 3.2
> on, Linux had three vsyscall modes: "native", "emulate", and "none".
>
> "emulate" is the default.  All known user programs work correctly in
> emulate mode, but vsyscalls turn into page faults and are emulated.
> This is very slow.  In "native" mode, the vsyscall page is easily
> usable as an exploit gadget, but vsyscalls are a bit faster -- they
> turn into normal syscalls.  (This is in contrast to vDSO functions,
> which can be much faster than syscalls.)  In "none" mode, there are
> no vsyscalls.
>
> For all practical purposes, "native" was really just a chicken bit
> in case something went wrong with the emulation.  It's been over six
> years, and nothing has gone wrong.  Delete it.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

I related news, I wonder how long before we can switch from EMULATE to
NONE as the default? glibc 2.15 (which stopped using vsyscall) is (not
coincidentally) 6 years old too...

-Kees

> ---
>  arch/x86/Kconfig                            | 11 +----------
>  arch/x86/entry/vsyscall/vsyscall_64.c       | 16 +++-------------
>  arch/x86/include/asm/pgtable_types.h        |  2 --
>  tools/testing/selftests/x86/test_vsyscall.c | 11 ++++++-----
>  4 files changed, 10 insertions(+), 30 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..0fa71a78ec99 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2307,7 +2307,7 @@ choice
>           it can be used to assist security vulnerability exploitation.
>
>           This setting can be changed at boot time via the kernel command
> -         line parameter vsyscall=[native|emulate|none].
> +         line parameter vsyscall=[emulate|none].
>
>           On a system with recent enough glibc (2.14 or newer) and no
>           static binaries, you can say None without a performance penalty
> @@ -2315,15 +2315,6 @@ choice
>
>           If unsure, select "Emulate".
>
> -       config LEGACY_VSYSCALL_NATIVE
> -               bool "Native"
> -               help
> -                 Actual executable code is located in the fixed vsyscall
> -                 address mapping, implementing time() efficiently. Since
> -                 this makes the mapping executable, it can be used during
> -                 security vulnerability exploitation (traditionally as
> -                 ROP gadgets). This configuration is not recommended.
> -
>         config LEGACY_VSYSCALL_EMULATE
>                 bool "Emulate"
>                 help
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 577fa8adb785..8560ef68a9d6 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -42,10 +42,8 @@
>  #define CREATE_TRACE_POINTS
>  #include "vsyscall_trace.h"
>
> -static enum { EMULATE, NATIVE, NONE } vsyscall_mode =
> -#if defined(CONFIG_LEGACY_VSYSCALL_NATIVE)
> -       NATIVE;
> -#elif defined(CONFIG_LEGACY_VSYSCALL_NONE)
> +static enum { EMULATE, NONE } vsyscall_mode =
> +#ifdef CONFIG_LEGACY_VSYSCALL_NONE
>         NONE;
>  #else
>         EMULATE;
> @@ -56,8 +54,6 @@ static int __init vsyscall_setup(char *str)
>         if (str) {
>                 if (!strcmp("emulate", str))
>                         vsyscall_mode = EMULATE;
> -               else if (!strcmp("native", str))
> -                       vsyscall_mode = NATIVE;
>                 else if (!strcmp("none", str))
>                         vsyscall_mode = NONE;
>                 else
> @@ -139,10 +135,6 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
>
>         WARN_ON_ONCE(address != regs->ip);
>
> -       /* This should be unreachable in NATIVE mode. */
> -       if (WARN_ON(vsyscall_mode == NATIVE))
> -               return false;
> -
>         if (vsyscall_mode == NONE) {
>                 warn_bad_vsyscall(KERN_INFO, regs,
>                                   "vsyscall attempted with vsyscall=none");
> @@ -370,9 +362,7 @@ void __init map_vsyscall(void)
>
>         if (vsyscall_mode != NONE) {
>                 __set_fixmap(VSYSCALL_PAGE, physaddr_vsyscall,
> -                            vsyscall_mode == NATIVE
> -                            ? PAGE_KERNEL_VSYSCALL
> -                            : PAGE_KERNEL_VVAR);
> +                            PAGE_KERNEL_VVAR);
>                 set_vsyscall_pgtable_user_bits(swapper_pg_dir);
>         }
>
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 246f15b4e64c..acfe755562a6 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -174,7 +174,6 @@ enum page_cache_mode {
>  #define __PAGE_KERNEL_RO               (__PAGE_KERNEL & ~_PAGE_RW)
>  #define __PAGE_KERNEL_RX               (__PAGE_KERNEL_EXEC & ~_PAGE_RW)
>  #define __PAGE_KERNEL_NOCACHE          (__PAGE_KERNEL | _PAGE_NOCACHE)
> -#define __PAGE_KERNEL_VSYSCALL         (__PAGE_KERNEL_RX | _PAGE_USER)
>  #define __PAGE_KERNEL_VVAR             (__PAGE_KERNEL_RO | _PAGE_USER)
>  #define __PAGE_KERNEL_LARGE            (__PAGE_KERNEL | _PAGE_PSE)
>  #define __PAGE_KERNEL_LARGE_EXEC       (__PAGE_KERNEL_EXEC | _PAGE_PSE)
> @@ -206,7 +205,6 @@ enum page_cache_mode {
>  #define PAGE_KERNEL_NOCACHE    __pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
>  #define PAGE_KERNEL_LARGE      __pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
>  #define PAGE_KERNEL_LARGE_EXEC __pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
> -#define PAGE_KERNEL_VSYSCALL   __pgprot(__PAGE_KERNEL_VSYSCALL | _PAGE_ENC)
>  #define PAGE_KERNEL_VVAR       __pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
>
>  #define PAGE_KERNEL_IO         __pgprot(__PAGE_KERNEL_IO)
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index be81621446f0..0b4f1cc2291c 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -450,7 +450,7 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
>                 num_vsyscall_traps++;
>  }
>
> -static int test_native_vsyscall(void)
> +static int test_emulation(void)
>  {
>         time_t tmp;
>         bool is_native;
> @@ -458,7 +458,7 @@ static int test_native_vsyscall(void)
>         if (!vtime)
>                 return 0;
>
> -       printf("[RUN]\tchecking for native vsyscall\n");
> +       printf("[RUN]\tchecking that vsyscalls are emulated\n");
>         sethandler(SIGTRAP, sigtrap, 0);
>         set_eflags(get_eflags() | X86_EFLAGS_TF);
>         vtime(&tmp);
> @@ -474,11 +474,12 @@ static int test_native_vsyscall(void)
>          */
>         is_native = (num_vsyscall_traps > 1);
>
> -       printf("\tvsyscalls are %s (%d instructions in vsyscall page)\n",
> +       printf("[%s]\tvsyscalls are %s (%d instructions in vsyscall page)\n",
> +              (is_native ? "FAIL" : "OK"),
>                (is_native ? "native" : "emulated"),
>                (int)num_vsyscall_traps);
>
> -       return 0;
> +       return is_native;
>  }
>  #endif
>
> @@ -498,7 +499,7 @@ int main(int argc, char **argv)
>         nerrs += test_vsys_r();
>
>  #ifdef __x86_64__
> -       nerrs += test_native_vsyscall();
> +       nerrs += test_emulation();
>  #endif
>
>         return nerrs ? 1 : 0;
> --
> 2.14.3
>



-- 
Kees Cook
Pixel Security
