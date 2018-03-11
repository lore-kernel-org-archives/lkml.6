Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AG47ELuCrlKfCnBSafTmxBch5gz3vyCd5SO2J8zfMpnKCBwffZrYniSxnbQdcPtTap7G2gKaobWn
ARC-Seal: i=1; a=rsa-sha256; t=1520781623; cv=none;
        d=google.com; s=arc-20160816;
        b=eSJZCnvkzf/whgZirK4hHpSXuD5dVJzwLhZVzb4Ws4fkhAjXu6pMvVcd0EecSsm1xz
         BzCKUIsCkR8C792XkmsyVLKNFVN1l9ORGm14g6JitizF44JsdpSrrMCTxc4fOY0ZXCVF
         Y7knzdA0n7gGyniA/RIiuRX6pOVjgv7L98/i2MBsR3kbRgRCLOGuCeRPLx5Orvay53dE
         lcqUYvxpx/kzhfVc9X0LyEdvn+RGGI+AL/yut4rYL46HhFfPQPTd7KTSRcxGYm7i89vz
         zUXEFz7E/kxl1ieknlQcQOIHSAQ7BhYDm/Q3i9XcM8qEuFr4qHOmFuK149GL/Hi8Hfnr
         UHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=yZUrodgeybGLAXalYdFCFrowgEGzni+Yq0QroawLiCQ=;
        b=JeW5qQP7PU8P+s7PzonxaQV7ahhGAf7aJ0HYqOxaLhC0+szif8rhod/9bk6hO8O8AF
         GVfHipJ9ytHXdEOxYOVMCOUrkUPUzH0vRDj2t3sai5GT4SK7//kmmboGA4pYiYys3AIr
         fxeBa4SqLRGxGxDtkzMxbJtVrCuPsMeUMdCJETkjlY2cXjcFtDsfvVswpaqfXEJuNT+i
         UFnfRjTtnI64J8SwegYGhBIa3sEGN+0qozQoTMSERdv2Xr8mlyOQgq1bY1E8Hxr/d9sN
         0EtA+o0QX0afugm1xDsW41xJRqI373iUbY+y0OVXUQAf5Lb7wrTcRG5N4ROcuIDVxdZc
         5SPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15BE2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180311105557.20807-14-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net> <20180311105557.20807-14-linux@dominikbrodowski.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 11 Mar 2018 15:20:01 +0000
X-Gmail-Original-Message-ID: <CALCETrWHotpZ5HbaFO9Z6NimS8jqZDHprK8Vbj_=oMF9X=9feQ@mail.gmail.com>
Message-ID: <CALCETrWHotpZ5HbaFO9Z6NimS8jqZDHprK8Vbj_=oMF9X=9feQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/35] syscalls: do not call sys_ioperm() within the kernel
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594638526828393635?=
X-GMAIL-MSGID: =?utf-8?q?1594655111153692513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 10:55 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> While at it, use SYSCALL_DEFINE3() instead of a hand-crafted syscall
> definition.

Great!

>  static void complete_change_console(struct vc_data *vc);
> @@ -420,12 +420,12 @@ int vt_ioctl(struct tty_struct *tty,
>                         ret = -EINVAL;
>                         break;
>                 }
> -               ret = sys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
> +               ret = ksys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
>                 break;
>
>         case KDENABIO:
>         case KDDISABIO:
> -               ret = sys_ioperm(GPFIRST, GPNUM,
> +               ret = ksys_ioperm(GPFIRST, GPNUM,
>                                   (cmd == KDENABIO)) ? -ENXIO : 0;
>                 break;
>  #endif

I wonder if we can just delete this code.
