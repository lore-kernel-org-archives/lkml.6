Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524678787; cv=none;
        d=google.com; s=arc-20160816;
        b=t0umpQcIJV2Hbpzf4tn/VOY2oA1kC0rh794jXfKH1GqG2NciR2gitqOVF22pexJUjL
         drOVdQN38tudPD4bp+6HhveBvC/m513B45ssYNrSMHCf0bseM1+Ht9Wawmq+luTvcVdE
         66KvHA5Q76Xk/8+h5k8eOEIE0y1GmIhf+erA5uRn39JHKbwUCQdS+dTrBvnZPi5qEHxi
         G3uYvQGEao3t067y7Pxc08NG6eEjiFxqt0ZC9kaxiM0xlkkgwGH8xBxSufhTD+h6i7fU
         UQBKK1Br0Uy+sQuaEwZQWI64S+j3GlKfRbwaOC1UN4AxSbH2d/ErK25Q0ntwwwdtskjn
         rtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PnCGcqnb0TVubgoZ+Yh5F9eW1AXZY4Dpj2Rj9EEMXfc=;
        b=00IMBZkRM/KV3MRgHK3hz+FWt2KJhZ27s3JoAMkdgyt9paxHgWjYalkYFzbwt9aO6m
         WDiIhuZOaXroqGULt2JfgdZZw0wJvzsd7PMp1nw5Xm7z5QkR1mO1QCq2mSMiablg9sBF
         5yNH4Mh2rEC+WDhzrkR6uSzfE4FTRS5prFOwPWxAom/jNVT0iHoegDuWyAvMgHQsitqy
         M8EjkVLSxYV6Wx34ehf2DXk+Z8Y5hXYAvQXorR9wUXksd+jl4ZpaA8mOhd8li02QZj8S
         FQepauYTTAHoSoORwgWYqifA1kBPrsl0IdtQRlutpX4XNsnPHjKCPYsX7KahRRwmbRJI
         YzWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ug6pXJZL;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ug6pXJZL;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4/db3tDHNTENdkJLA+R6DISFxqeqDlAXInk8Mh80k/3NWV2YNCFQOOtiDSy+67pFE3EAcVUiGPCARRil7cV+IM=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180425160645.GA16732@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be> <20180425160645.GA16732@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 19:53:06 +0200
X-Google-Sender-Auth: A9QXOebFAg_a04F1zbSmM7C_18Q
Message-ID: <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1598741584604719062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
>> The driver_override implementation is susceptible to a race condition
>> when different threads are reading vs storing a different driver
>> override.  Add locking to avoid this race condition.
>>
>> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
>> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
>> condition with driver_override").
>>
>> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Todd Kjos <tkjos@google.com>
>> Cc: stable <stable@vger.kernel.org>

> As this should go to stable kernels, I've fixed it up to apply without
> patch 1 as that's not a real "fix" that anyone needs...
>
> Please try to remember to put fixes first, and then "trivial" things
> later on in a series.

I did it on purpose, as the fix is much more ugly without patch 1 applied.
Can't you just take patch 1, too? More consistency is always nice, even for
stable ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
