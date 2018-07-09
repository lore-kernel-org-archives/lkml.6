Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1678C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABA620873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABA620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeGIMzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:55:54 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42087 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeGIMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:55:52 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so10267577vke.9;
        Mon, 09 Jul 2018 05:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhPJ68rgHCACTQorT8jzgCGPzpL/gR3J/ovBUjCtnn8=;
        b=PDCAtFEv0UU2L91XRgts/vwcOcvHxp3s16bAQOF03v+Pir8F/q/dfSVFtDDfOhe82n
         3Uj2foXfrehg/tsMI3aosRy4wCjnc08TQhu759mOJfGL8NrFKxBb7ZzqsNr+M1235jg7
         usBJ0/LY9qRdysTmq4AsYyL17taLNOtPSi1tJWbNQ+4UXI5x4LV+xjERf6I9+tQBUjbJ
         x47B4kuvDdBdEuU8FpJjVgTYNSUZ6Z+8KIKXnUd/jz0DhtojZ1stJWosZPCOcfC+gFRW
         n4P0/Lv9bcUjjN58tojvbj+RNOcwdcCt6wURYfY8FSRuK+SZx0o8WCo3ng9IQfNebIRu
         i8TQ==
X-Gm-Message-State: APt69E3SmGhOTi72UdsYPver9af1e2q7g3l5XnQL179Yp0riPTP3kg36
        6t4ynLdAmCBjVjFVrGCleMw+zX/Wj/EJ+drYL4w=
X-Google-Smtp-Source: AAOMgpdvJJ4gjJawaldEl6hNpipvooJC6yigiuRe7hjMSfWB9L0p8BJs5zxwIKxJ9pYcSEI8RCdGLUf+c3pofMjPa3c=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr11605951vkg.176.1531140951150;
 Mon, 09 Jul 2018 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180709124741.21037-1-abrodkin@synopsys.com>
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 14:55:38 +0200
Message-ID: <CAMuHMdV0XhDRyRLp_mPnZjg3QXMt_qY1eD-Tr=i-reOKA6x_mA@mail.gmail.com>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and alignment
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Mon, Jul 9, 2018 at 2:48 PM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> Atomic instructions require data they operate on to be aligned
> according to data size. I.e. 32-bit atomic values must be 32-bit
> aligned while 64-bit values must be 64-bit aligned.
>
> Otherwise even if CPU may handle not-aligend normal data access,
> still atomic instructions fail and typically raise an exception
> leaving us dead in the water.
>
> This came-up during lengthly discussion here:
> http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004022.html
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Thanks for your patch!

> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -13,7 +13,7 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>
>  typedef struct {
> -       long long counter;
> +       u64 __aligned(8) counter;

I think you can drop the change to this file, as this is the generic
implementation using spinlocks, for processors that don't have 64-bit atomic
instructions.

>  } atomic64_t;

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
