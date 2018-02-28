Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519836873; cv=none;
        d=google.com; s=arc-20160816;
        b=zXKkAftX9e6ASDz1DNNCaQXUSycJa7KvO6fY8JEfoih94TlbEQkvLmI7hj71bZACBP
         QZ7HL1XcSBdA7QIiilYnTMr+4DBe4n9uK53E43Yq6o+XO/JLub3/+LK0eDZbOyowrtY8
         JdREghCMwS3GbhWeKh498ux0Zsr7rta1kcT72qRMXrV9FoILH80v28+KfqZqlz0bIIAY
         e/4EY8UVB1kzHfDAfU/e3QcALeceWZe8sN4v9/QTvmIrRMmE1nS0haIXul3AyMD/Llrl
         qkhlBLjHosMn4v4Zi+mCwED8FqYOwTXEcJDimAxtwBFrtj063DzNTQWP+tv6zpDIOBcW
         Iq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lQGQYNjMbStrTjN8r5FD6Rr7Hpoc1lOFNiAIPjronv4=;
        b=m8enE8DintcVtKo/ma9Xp9SRtWSdiFGUFHajGFriOx4Qql8kR2RyYXInRbDrkvnSp2
         TEWqQCrIIKg+1IlQ2h5ATV6zPU/6kcZdjHANSNLYpyGC2QDKWAmEdyGkLEg0fabZjY7T
         Hu8Nm2CZ61bM30E1Q2pe8T8urCIzZgUIJh6AlwrY/KY1RDir16Oy/13bkidAqYQNFgdL
         qQ9oRtDdcwCzmMedqM7oxcvd1Y+XODv5h+wqL9gu5pIJC4DuWIi+z1waSNeefHRX6AKD
         UCJYaHbzvOnzYulr7rlZg9Sn6FJqIbKyeLqC7g4KCjIHELj8H0gf6iE5QDxAP5yFgRuh
         79Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=k6+2oB/n;
       dkim=pass header.i=@chromium.org header.s=google header.b=lJ7z/wOa;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=k6+2oB/n;
       dkim=pass header.i=@chromium.org header.s=google header.b=lJ7z/wOa;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvBCq6WEGqzpLQV5s14Yf8cIlCuxx9w8RZrrQDzmZDr12xs/w9Vxbewq7UUWANe3PlHP61+fCr5AgAX9bbmj3g=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180228142951.GA3136@pjb1027-Latitude-E5410>
References: <20180228142951.GA3136@pjb1027-Latitude-E5410>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Feb 2018 08:54:31 -0800
X-Google-Sender-Auth: x_kHSa_GLbZy0dkNEY1ZOvJQxxA
Message-ID: <CAGXu5jKkHAHpzEpmHNJ6iPhXJKXoZH9Wy4mnCnE1=TEgTcHSRw@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 1/2] arm: mm: Define vdso_start,
 vdso_end as array
To: Jinbum Park <jinb.park7@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Philippe Ombredanne <pombredanne@nexb.co>, Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	Andy Lutomirski <luto@amacapital.net>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Micay <danielmicay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593655376108279325?=
X-GMAIL-MSGID: =?utf-8?q?1593664469165396147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 6:29 AM, Jinbum Park <jinb.park7@gmail.com> wrote:
> Define vdso_start, vdso_end as array to avoid compile-time analysis error
> for the case of built with CONFIG_FORTIFY_SOURCE.
>
> and, since vdso_start, vdso_end are used in vdso.c only,
> move extern-declaration from vdso.h to vdso.c.
>
> If kernel is built with CONFIG_FORTIFY_SOURCE,
> compile-time error happens at this code.
> - if (memcmp(&vdso_start, "\177ELF", 4))
>
> The size of "&vdso_start" is recognized as 1 byte, but n is 4,
> So that compile-time error is reported.
>
> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/include/asm/vdso.h |  2 --
>  arch/arm/kernel/vdso.c      | 12 +++++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
> index 9c99e81..5b85889 100644
> --- a/arch/arm/include/asm/vdso.h
> +++ b/arch/arm/include/asm/vdso.h
> @@ -12,8 +12,6 @@
>
>  void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
>
> -extern char vdso_start, vdso_end;
> -
>  extern unsigned int vdso_total_pages;
>
>  #else /* CONFIG_VDSO */
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index a4d6dc0..f4dd7f9 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -39,6 +39,8 @@
>
>  static struct page **vdso_text_pagelist;
>
> +extern char vdso_start[], vdso_end[];
> +
>  /* Total number of pages needed for the data and text portions of the VDSO. */
>  unsigned int vdso_total_pages __ro_after_init;
>
> @@ -197,13 +199,13 @@ static int __init vdso_init(void)
>         unsigned int text_pages;
>         int i;
>
> -       if (memcmp(&vdso_start, "\177ELF", 4)) {
> +       if (memcmp(vdso_start, "\177ELF", 4)) {
>                 pr_err("VDSO is not a valid ELF object!\n");
>                 return -ENOEXEC;
>         }
>
> -       text_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
> -       pr_debug("vdso: %i text pages at base %p\n", text_pages, &vdso_start);
> +       text_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
> +       pr_debug("vdso: %i text pages at base %p\n", text_pages, vdso_start);
>
>         /* Allocate the VDSO text pagelist */
>         vdso_text_pagelist = kcalloc(text_pages, sizeof(struct page *),
> @@ -218,7 +220,7 @@ static int __init vdso_init(void)
>         for (i = 0; i < text_pages; i++) {
>                 struct page *page;
>
> -               page = virt_to_page(&vdso_start + i * PAGE_SIZE);
> +               page = virt_to_page(vdso_start + i * PAGE_SIZE);
>                 vdso_text_pagelist[i] = page;
>         }
>
> @@ -229,7 +231,7 @@ static int __init vdso_init(void)
>
>         cntvct_ok = cntvct_functional();
>
> -       patch_vdso(&vdso_start);
> +       patch_vdso(vdso_start);
>
>         return 0;
>  }
> --
> 1.9.1
>



-- 
Kees Cook
Pixel Security
