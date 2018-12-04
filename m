Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02F1206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fjaXNvuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02F1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLDUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:06:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44092 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:06:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so16082096lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fi4+SGIYWWC6wVW6RjL32xj392zypfY7lB8sb2fwmyQ=;
        b=fjaXNvuK5hIOoiS4zWx8TcdFXIEkHI1vk2seKVJ4VVEG0qI6DThU+dwpU2LsLwuIuS
         L6afqK+K1RV4QvegELSu0G9kQnWTFF6uVdT42S6GXC4oDapd0nmG7YblGyYhBGIGNATv
         p3omYgn+YIydjVU1kdFH/cfqa/DJpYIftkAsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi4+SGIYWWC6wVW6RjL32xj392zypfY7lB8sb2fwmyQ=;
        b=KJx5Hm1tru/vhqP8JZzQ2yiKtk4qxHRb32TZmKpDVXp6Fstd8f1j75ZN28ZIofNW2Q
         q8TxkmNiN024hGm4O66NBAqgsQPnte+Q7ZLlhNPIbAvEIE8ABUUPCerlEYQ9g+dWAwQ+
         L1cFRZoqEJfOIEsWlsVqkG578I1F99NgGnoDJ9RlhupJn8fns1QwGwcOdbBloJC8O6Pa
         Xd6n4VAfkj1S1eSDqM1VVnhD+XfqB7tV3IVR2IaYVzxHQ1xdBKS3RtSYcXz3x8zVtHKu
         /5TXwny1Q1TOczHiPQNdyHJBC96ZDY5pX2QW7CXVmoadAy5+ysMOMX8PChIMe/oC8bYu
         lTYA==
X-Gm-Message-State: AA+aEWYYQ9yWAdy683R+eD7KMmPPvDO6ASqveWzY2uG4WDxxfPMRjco4
        t5ZKjOBy4GSgglNgnNIHhGf6vcPYBYA=
X-Google-Smtp-Source: AFSGD/WIc0XJHFUORBQqDhpVg8ReYZsOHBsaH/4DnVejBiXxBoviAiq/GZDMvdmT9e68LvwU9lcQ7Q==
X-Received: by 2002:a2e:94ce:: with SMTP id r14-v6mr13864638ljh.34.1543953963393;
        Tue, 04 Dec 2018 12:06:03 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m21sm3172622lfl.97.2018.12.04.12.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:06:02 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id v5so12925342lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:06:02 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr13339696lfc.124.1543953960739;
 Tue, 04 Dec 2018 12:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20181203123857.GS31738@dhcp22.suse.cz> <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz> <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz> <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz> <20181204093310.GE73770@gmail.com>
 <20181204095802.GF1286@dhcp22.suse.cz> <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
 <20181204181714.GR1286@dhcp22.suse.cz> <CAHk-=wh128U4GxVeHa+z_5sB52ZVXhzt0__LQq4asZgh8VtvBw@mail.gmail.com>
 <CAHk-=wg1geOzkaDUVuxW-qHxhqrtpx-iCvd+e1TxZQ_AmTtn0w@mail.gmail.com>
In-Reply-To: <CAHk-=wg1geOzkaDUVuxW-qHxhqrtpx-iCvd+e1TxZQ_AmTtn0w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Dec 2018 12:05:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMmEFfnF5if-wCsdu1C_iLSzd5M5HcWe9L9QqnY4t-LQ@mail.gmail.com>
Message-ID: <CAHk-=wiMmEFfnF5if-wCsdu1C_iLSzd5M5HcWe9L9QqnY4t-LQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
To:     mhocko@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, pavel@ucw.cz,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> because honestly, the *only* reason we hold on to that lock is for the
> insane and not really interesting case of "somebody tried to use
> ptrace to change the creds in-flight during the exec".

No, sorry, me confused. Not somebody trying to change them, it's just
ptrace_attach() trying to change _our_ state during this sequence, and
relying on it all being atomic.

So taking a ref is unnecessary and pointless. It's not the creds that
change, it's that we really want to delay ptrace_attach().

We could maybe set that "we're busy now" flag, and have
ptrace_attach() do something like

        if (task_is_busy(task)) {
                sched_yield();
                return -ERESTARTSYS;
        }

or something like that.

                  Linus
